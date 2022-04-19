struct K {
    static let appName = "⚡️BlackStoneEit"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let senderId = "senderId"
        static let receiverId = "receiverId"
        static let bodyField = "body"
        static let createdDateField = "createdDate"
        static let timeStampField = "timeStamp"
    }
}
