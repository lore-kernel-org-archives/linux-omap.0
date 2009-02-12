From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH] OMAP3: SDTI: Prevent access to sdti writing if module is not initialized.
Date: Thu, 12 Feb 2009 13:39:28 +0200
Message-ID: <1234438768-20697-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27154 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbZBLLke (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 06:40:34 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1CBeE4c005173
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 13:40:31 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>

The function sti_channel_write_trace can be run from process and interrupt
context. It has to be completed before other sti_channel_write_trace calls.

Prevent sdti writing when SDTI module is not initialized.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 drivers/misc/sti/sdti.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/sti/sdti.c b/drivers/misc/sti/sdti.c
index 8c27504..31780de 100644
--- a/drivers/misc/sti/sdti.c
+++ b/drivers/misc/sti/sdti.c
@@ -37,20 +37,25 @@
 static struct clk *sdti_fck, *sdti_ick;
 void __iomem *sti_base, *sti_channel_base;
 static DEFINE_SPINLOCK(sdti_lock);
+static int sdti_initialized;
 
 void sti_channel_write_trace(int len, int id, void *data,
 				unsigned int channel)
 {
 	const u8 *tpntr = data;
+	unsigned long flags;
 
-	spin_lock_irq(&sdti_lock);
+	spin_lock_irqsave(&sdti_lock, flags);
+
+	if (unlikely(!sdti_initialized))
+		goto skip;
 
 	sti_channel_writeb(id, channel);
 	while (len--)
 		sti_channel_writeb(*tpntr++, channel);
 	sti_channel_flush(channel);
-
-	spin_unlock_irq(&sdti_lock);
+ skip:
+	spin_unlock_irqrestore(&sdti_lock, flags);
 }
 EXPORT_SYMBOL(sti_channel_write_trace);
 
@@ -117,6 +122,10 @@ static int __init omap_sdti_init(void)
 	/* Enable SDTI */
 	sti_writel((1 << 31) | (i & 0x3FFFFFFF), SDTI_WINCTRL);
 
+	spin_lock_irq(&sdti_lock);
+	sdti_initialized = 1;
+	spin_unlock_irq(&sdti_lock);
+
 	i = sti_readl(SDTI_REVISION);
 	snprintf(buf, sizeof(buf), "OMAP SDTI support loaded (HW v%u.%u)\n",
 		(i >> 4) & 0x0f, i & 0x0f);
-- 
1.5.5.1

