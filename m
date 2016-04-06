From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 4/4] mailbox/omap: add blank lines after declarations
Date: Wed, 6 Apr 2016 12:37:40 -0500
Message-ID: <1459964260-43054-5-git-send-email-s-anna@ti.com>
References: <1459964260-43054-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459964260-43054-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Fix couple of checkpatch warnings of the type,
"WARNING: Missing a blank line after declarations"

Also, fixed a warning about a space after a typecast
while at this.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 3ffdc7dbb09e..84cafc02e761 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -154,24 +154,28 @@ void mbox_write_reg(struct omap_mbox_device *mdev, u32 val, size_t ofs)
 static mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
 {
 	struct omap_mbox_fifo *fifo = &mbox->rx_fifo;
-	return (mbox_msg_t) mbox_read_reg(mbox->parent, fifo->msg);
+
+	return (mbox_msg_t)mbox_read_reg(mbox->parent, fifo->msg);
 }
 
 static void mbox_fifo_write(struct omap_mbox *mbox, mbox_msg_t msg)
 {
 	struct omap_mbox_fifo *fifo = &mbox->tx_fifo;
+
 	mbox_write_reg(mbox->parent, msg, fifo->msg);
 }
 
 static int mbox_fifo_empty(struct omap_mbox *mbox)
 {
 	struct omap_mbox_fifo *fifo = &mbox->rx_fifo;
+
 	return (mbox_read_reg(mbox->parent, fifo->msg_stat) == 0);
 }
 
 static int mbox_fifo_full(struct omap_mbox *mbox)
 {
 	struct omap_mbox_fifo *fifo = &mbox->tx_fifo;
+
 	return mbox_read_reg(mbox->parent, fifo->fifo_stat);
 }
 
@@ -522,6 +526,7 @@ static int omap_mbox_register(struct omap_mbox_device *mdev)
 	mboxes = mdev->mboxes;
 	for (i = 0; mboxes[i]; i++) {
 		struct omap_mbox *mbox = mboxes[i];
+
 		mbox->dev = device_create(&omap_mbox_class, mdev->dev,
 					0, mbox, "%s", mbox->name);
 		if (IS_ERR(mbox->dev)) {
-- 
2.7.4
