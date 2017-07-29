//
//  IssueSummaryType.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

class IssueSummaryType: ListDiffable {
    
    let id: String
    let title: NSAttributedStringSizing
    let number: Int
    let createdAt: Date?
    let state: IssueState
    let author: String?
    
    init(issue: RepoIssuesAndPullRequestsQuery.Data.Repository.Issue.Node, containerWidth: CGFloat) {
        self.id = issue.id
        
        let attributes = [
            NSFontAttributeName: Styles.Fonts.title,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color
        ]
        
        self.title = NSAttributedStringSizing(
            containerWidth: containerWidth,
            attributedText: NSAttributedString(string: issue.title, attributes: attributes),
            inset: RepositorySummaryCell.labelInset
        )
        
        self.number = issue.number
        self.createdAt = GithubAPIDateFormatter().date(from: issue.createdAt)
        self.state = issue.state
        self.author = issue.author?.login
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueSummaryType else { return false }
        return id == object.id &&
               title == object.title &&
               number == object.number &&
               state.rawValue == object.state.rawValue
    }
}
