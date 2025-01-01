import UIKit


class ImagePickerHelper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    static let shared = ImagePickerHelper()
    var viewController: UIViewController?
    var completion: ((String?, String?) -> Void)?  // Base64 String and Image Name

    private override init() {
        super.init()
    }

    // Main function to pick image and return Base64 string and Image Name
    func pickImage(from viewController: UIViewController, completion: @escaping (String?, String?) -> Void) {
        self.viewController = viewController
        self.completion = completion
        
        let actionSheet = UIAlertController(title: "Select Image", message: "Choose an image from library or capture using camera", preferredStyle: .actionSheet)

        // Camera Option
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera()
            }))
        }

        // Photo Library Option
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
                self.openPhotoLibrary()
            }))
        }

        // Cancel Option
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // iPad के लिए आवश्यक
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = viewController.view
            popoverController.sourceRect = viewController.view.bounds
        }

        viewController.present(actionSheet, animated: true, completion: nil)
    }

    // Camera ओपन करने का फ़ंक्शन
    private func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        viewController?.present(imagePicker, animated: true, completion: nil)
    }

    // Photo Library ओपन करने का फ़ंक्शन
    private func openPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        viewController?.present(imagePicker, animated: true, completion: nil)
    }

    // UIImagePickerControllerDelegate method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            // Convert image to Base64 string
            if let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
                
                // Get image name
                var imageName: String? = nil
                if let assetPath = info[.imageURL] as? URL {
                    imageName = assetPath.lastPathComponent
                } else {
                    imageName = "camera_image.jpg"  // Default name for camera image
                }

                completion?(base64String, imageName)
            } else {
                completion?(nil, nil)
            }
        } else {
            completion?(nil, nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        completion?(nil, nil)
        picker.dismiss(animated: true, completion: nil)
    }
}
