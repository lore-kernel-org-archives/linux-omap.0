From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 2/2] OMAP2+: mailbox: fix lookups for multiple mailboxes
Date: Fri, 11 Feb 2011 11:56:43 -0800
Message-ID: <1297454203-28298-2-git-send-email-khilman@ti.com>
References: <1297454203-28298-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:33067 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756811Ab1BKT6I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 14:58:08 -0500
Received: by mail-yw0-f51.google.com with SMTP id 5so1212879ywl.10
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 11:58:07 -0800 (PST)
In-Reply-To: <1297454203-28298-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org

The pointer math in omap_mbox_get() is not quite right, and leads to
passing NULL to strcmp() when searching for an mbox that is not first
in the list.

Convert to using array indexing as is done in all the other functions
which walk the mbox list.

Tested on OMAP2420/n810, OMAP3630/zoom3, OMAP4430/Blaze

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/mailbox.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 459b319..49d3208 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -322,15 +322,18 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 
 struct omap_mbox *omap_mbox_get(const char *name, struct notifier_block *nb)
 {
-	struct omap_mbox *mbox;
-	int ret;
+	struct omap_mbox *_mbox, *mbox = NULL;
+	int i, ret;
 
 	if (!mboxes)
 		return ERR_PTR(-EINVAL);
 
-	for (mbox = *mboxes; mbox; mbox++)
-		if (!strcmp(mbox->name, name))
+	for (i = 0; (_mbox = mboxes[i]); i++) {
+		if (!strcmp(_mbox->name, name)) {
+			mbox = _mbox;
 			break;
+		}
+	}
 
 	if (!mbox)
 		return ERR_PTR(-ENOENT);
-- 
1.7.4

