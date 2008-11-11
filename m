From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 54/59] omap: namespace cleanup to fs/xfs/xfs_iomap.h
Date: Wed, 12 Nov 2008 00:57:13 +0200
Message-ID: <1226444238-14614-55-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
 <1226444238-14614-29-git-send-email-me@felipebalbi.com>
 <1226444238-14614-30-git-send-email-me@felipebalbi.com>
 <1226444238-14614-31-git-send-email-me@felipebalbi.com>
 <1226444238-14614-32-git-send-email-me@felipebalbi.com>
 <1226444238-14614-33-git-send-email-me@felipebalbi.com>
 <1226444238-14614-34-git-send-email-me@felipebalbi.com>
 <1226444238-14614-35-git-send-email-me@felipebalbi.com>
 <1226444238-14614-36-git-send-email-me@felipebalbi.com>
 <1226444238-14614-37-git-send-email-me@felipebalbi.com>
 <1226444238-14614-38-git-send-email-me@felipebalbi.com>
 <1226444238-14614-39-git-send-email-me@felipebalbi.com>
 <1226444238-14614-40-git-send-email-me@felipebalbi.com>
 <1226444238-14614-41-git-send-email-me@felipebalbi.com>
 <1226444238-14614-42-git-send-email-me@felipebalbi.com>
 <1226444238-14614-43-git-send-email-me@felipebalbi.com>
 <1226444238-14614-44-git-send-email-me@felipebalbi.com>
 <1226444238-14614-45-git-send-email-me@felipebalbi.com>
 <1226444238-14614-46-git-send-email-me@felipebalbi.com>
 <1226444238-14614-47-git-send-email-me@felipebalbi.com>
 <1226444238-14614-48-git-send-email-me@felipebalbi.com>
 <1226444238-14614-49-git-send-email-me@felipebalbi.com>
 <1226444238-14614-50-git-send-email-me@felipebalbi.com>
 <1226444238-14614-51-git-send-email-me@felipebalbi.com>
 <1226444238-14614-52-git-send-email-me@felipebalbi.com>
 <1226444238-14614-53-git-send-email-me@felipebalbi.com>
 <1226444238-14614-54-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43308 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbYKKXQC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:16:02 -0500
In-Reply-To: <1226444238-14614-54-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 fs/xfs/xfs_iomap.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index ee1a0c1..e2bfe91 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -76,12 +76,12 @@ struct xfs_bmbt_irec;
 
 extern int xfs_iomap(struct xfs_inode *, xfs_off_t, ssize_t, int,
 		     struct xfs_iomap *, int *);
-extern int xfs_iomap_write_direct(struct xfs_inode *, xfs_off_t, size_t,
+extern int xfs_i__raw_write_direct(struct xfs_inode *, xfs_off_t, size_t,
 				  int, struct xfs_bmbt_irec *, int *, int);
-extern int xfs_iomap_write_delay(struct xfs_inode *, xfs_off_t, size_t, int,
+extern int xfs_i__raw_write_delay(struct xfs_inode *, xfs_off_t, size_t, int,
 				 struct xfs_bmbt_irec *, int *);
-extern int xfs_iomap_write_allocate(struct xfs_inode *, xfs_off_t, size_t,
+extern int xfs_i__raw_write_allocate(struct xfs_inode *, xfs_off_t, size_t,
 				struct xfs_bmbt_irec *, int *);
-extern int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, size_t);
+extern int xfs_i__raw_write_unwritten(struct xfs_inode *, xfs_off_t, size_t);
 
 #endif /* __XFS_IOMAP_H__*/
-- 
1.6.0.2.307.gc427

