From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/10] i2c-omap: Don't compile in OMAP15xx I2C ISR for non-OMAP15xx builds
Date: Thu, 30 Oct 2008 19:29:46 -0700
Message-ID: <1225420189-630-8-git-send-email-tony@atomide.com>
References: <1225420189-630-1-git-send-email-tony@atomide.com>
 <1225420189-630-2-git-send-email-tony@atomide.com>
 <1225420189-630-3-git-send-email-tony@atomide.com>
 <1225420189-630-4-git-send-email-tony@atomide.com>
 <1225420189-630-5-git-send-email-tony@atomide.com>
 <1225420189-630-6-git-send-email-tony@atomide.com>
 <1225420189-630-7-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64857 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbYJaCaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:30:10 -0400
In-Reply-To: <1225420189-630-7-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

Skip compiling OMAP15xx I2C ISR for non-OMAP15xx builds.  Saves 400 bytes
of text for most OMAP builds.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 22e8481..a675bf3 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -507,6 +507,9 @@ omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
 	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
 }
 
+/* rev1 devices are apparently only on some 15xx */
+#ifdef CONFIG_ARCH_OMAP15XX
+
 static irqreturn_t
 omap_i2c_rev1_isr(int this_irq, void *dev_id)
 {
@@ -561,6 +564,9 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#else
+#define omap_i2c_rev1_isr		0
+#endif
 
 static irqreturn_t
 omap_i2c_isr(int this_irq, void *dev_id)
-- 
1.5.6.rc3.21.g8c6b5

