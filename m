From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 09/10] omap mailbox: convert sequence bit checking to module
	paramter
Date: Fri, 16 Jan 2009 10:27:47 +0200
Message-ID: <20090116082747.17571.40394.stgit@oreo.research.nokia.com>
References: <20090116081919.17571.34378.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41568 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730AbZAPI2K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 03:28:10 -0500
In-Reply-To: <20090116081919.17571.34378.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---

 arch/arm/plat-omap/mailbox.c |   35 ++++++++++++++++-------------------
 1 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index db5a0c2..79f5fb7 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -32,30 +32,34 @@
 #include <linux/io.h>
 #include <mach/mailbox.h>
 
+static int enable_seq_bit;
+module_param(enable_seq_bit, bool, 0);
+MODULE_PARM_DESC(enable_seq_bit, "Enable sequence bit checking.");
+
 static struct omap_mbox *mboxes;
 static DEFINE_RWLOCK(mboxes_lock);
 
 /*
  * Mailbox sequence bit API
  */
-#if defined(CONFIG_ARCH_OMAP1)
-#  define MBOX_USE_SEQ_BIT
-#elif defined(CONFIG_ARCH_OMAP2)
-#  define MBOX_USE_SEQ_BIT
-#endif
 
-#ifdef MBOX_USE_SEQ_BIT
 /* seq_rcv should be initialized with any value other than
  * 0 and 1 << 31, to allow either value for the first
  * message.  */
 static inline void mbox_seq_init(struct omap_mbox *mbox)
 {
+	if (!enable_seq_bit)
+		return;
+
 	/* any value other than 0 and 1 << 31 */
 	mbox->seq_rcv = 0xffffffff;
 }
 
 static inline void mbox_seq_toggle(struct omap_mbox *mbox, mbox_msg_t * msg)
 {
+	if (!enable_seq_bit)
+		return;
+
 	/* add seq_snd to msg */
 	*msg = (*msg & 0x7fffffff) | mbox->seq_snd;
 	/* flip seq_snd */
@@ -64,24 +68,17 @@ static inline void mbox_seq_toggle(struct omap_mbox *mbox, mbox_msg_t * msg)
 
 static inline int mbox_seq_test(struct omap_mbox *mbox, mbox_msg_t msg)
 {
-	mbox_msg_t seq = msg & (1 << 31);
+	mbox_msg_t seq;
+
+	if (!enable_seq_bit)
+		return 0;
+
+	seq = msg & (1 << 31);
 	if (seq == mbox->seq_rcv)
 		return -1;
 	mbox->seq_rcv = seq;
 	return 0;
 }
-#else
-static inline void mbox_seq_init(struct omap_mbox *mbox)
-{
-}
-static inline void mbox_seq_toggle(struct omap_mbox *mbox, mbox_msg_t * msg)
-{
-}
-static inline int mbox_seq_test(struct omap_mbox *mbox, mbox_msg_t msg)
-{
-	return 0;
-}
-#endif
 
 /* Mailbox FIFO handle functions */
 static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)

