From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/4] mailbox/omap: use variable name for sizeof() operator
Date: Wed, 6 Apr 2016 12:37:38 -0500
Message-ID: <1459964260-43054-3-git-send-email-s-anna@ti.com>
References: <1459964260-43054-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459964260-43054-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Fix the code formatting to use the kernel preferred style
of using the actual variables to determize the size using
the sizeof() operator. This fixes the corresponding checkpatch
warning as well.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index ea06072c7322..274db62ccbbe 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -384,7 +384,7 @@ static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
 	if (!work)
 		return NULL;
 
-	mq = kzalloc(sizeof(struct omap_mbox_queue), GFP_KERNEL);
+	mq = kzalloc(sizeof(*mq), GFP_KERNEL);
 	if (!mq)
 		return NULL;
 
-- 
2.7.4
