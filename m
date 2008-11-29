From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/12] i2c-omap: Don't compile in OMAP15xx I2C ISR for
	non-OMAP15xx builds
Date: Fri, 28 Nov 2008 17:28:56 -0800
Message-ID: <20081129012856.13042.22028.stgit@localhost>
References: <20081129012612.13042.12283.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54067 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbYK2B2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:28:55 -0500
In-Reply-To: <20081129012612.13042.12283.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c-linux@vger.kernel.org, ben-linux@fluff.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Skip compiling OMAP15xx I2C ISR for non-OMAP15xx builds.  Saves 400 bytes
of text for most OMAP builds.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 61d2e5a..195c3d1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -503,6 +503,9 @@ omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
 	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
 }
 
+/* rev1 devices are apparently only on some 15xx */
+#ifdef CONFIG_ARCH_OMAP15XX
+
 static irqreturn_t
 omap_i2c_rev1_isr(int this_irq, void *dev_id)
 {
@@ -557,6 +560,9 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#else
+#define omap_i2c_rev1_isr		0
+#endif
 
 static irqreturn_t
 omap_i2c_isr(int this_irq, void *dev_id)

