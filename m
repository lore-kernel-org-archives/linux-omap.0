From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 09/10] omap mailbox: convert sequence bit checking to module paramter
Date: Tue, 25 Nov 2008 11:39:57 +0200
Message-ID: <1227605998-13531-10-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1227605998-13531-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-3-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-4-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-5-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-6-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-7-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-8-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-9-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34886 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbYKYJkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 04:40:25 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAP9eLDX029860
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:40:23 +0200
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAP9dxtD016089
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:39:59 +0200
In-Reply-To: <1227605998-13531-9-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |   35 ++++++++++++++++-------------------
 1 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 43c0ce3..5b00fc5 100644
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
-- 
1.6.0.3.613.g9f8f13

