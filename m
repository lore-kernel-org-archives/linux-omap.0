From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 31/59] omap: namespace cleanup to drivers/input/keyboard/omap-keypad.c
Date: Wed, 12 Nov 2008 00:56:50 +0200
Message-ID: <1226444238-14614-32-git-send-email-me@felipebalbi.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56614 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbYKKXFQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:05:16 -0500
In-Reply-To: <1226444238-14614-31-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/input/keyboard/omap-keypad.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 0f95046..cbb0c83 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -116,7 +116,7 @@ static irqreturn_t omap_kp_interrupt(int irq, void *dev_id)
 			disable_irq(OMAP_GPIO_IRQ(row_gpios[i]));
 	} else
 		/* disable keyboard interrupt and schedule for handling */
-		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		__raw_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 	tasklet_schedule(&kp_tasklet);
 
@@ -143,20 +143,20 @@ static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char *state)
 
 	} else {
 		/* disable keyboard interrupt and schedule for handling */
-		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		__raw_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 		/* read the keypad status */
-		omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
+		__raw_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
 		for (col = 0; col < omap_kp->cols; col++) {
-			omap_writew(~(1 << col) & 0xff,
+			__raw_writew(~(1 << col) & 0xff,
 				    OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
 
 			udelay(omap_kp->delay);
 
-			state[col] = ~omap_readw(OMAP_MPUIO_BASE +
+			state[col] = ~__raw_readw(OMAP_MPUIO_BASE +
 						 OMAP_MPUIO_KBR_LATCH) & 0xff;
 		}
-		omap_writew(0x00, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
+		__raw_writew(0x00, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
 		udelay(2);
 	}
 }
@@ -234,7 +234,7 @@ static void omap_kp_tasklet(unsigned long data)
 			for (i = 0; i < omap_kp_data->rows; i++)
 				enable_irq(OMAP_GPIO_IRQ(row_gpios[i]));
 		} else {
-			omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+			__raw_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 			kp_cur_group = -1;
 		}
 	}
@@ -285,7 +285,7 @@ static int omap_kp_suspend(struct platform_device *dev, pm_message_t state)
 	 * to wake us up from suspended.
 	 */
 	if (cpu_class_is_omap1())
-		omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		__raw_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 	omap_kp->suspended = 1;
 
@@ -333,7 +333,7 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 
 	/* Disable the interrupt for the MPUIO keyboard */
 	if (!cpu_is_omap24xx())
-		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		__raw_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 	keymap = pdata->keymap;
 
@@ -407,7 +407,7 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->dbounce)
-		omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_GPIO_DEBOUNCING);
+		__raw_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_GPIO_DEBOUNCING);
 
 	/* scan current status and enable interrupt */
 	omap_kp_scan_keypad(omap_kp, keypad_state);
@@ -418,7 +418,7 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 					"omap-keypad", omap_kp) < 0)
 				goto err4;
 		}
-		omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		__raw_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 	} else {
 		for (irq_idx = 0; irq_idx < omap_kp->rows; irq_idx++) {
 			if (request_irq(OMAP_GPIO_IRQ(row_gpios[irq_idx]),
@@ -465,7 +465,7 @@ static int omap_kp_remove(struct platform_device *pdev)
 			free_irq(OMAP_GPIO_IRQ(row_gpios[i]), 0);
 		}
 	} else {
-		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		__raw_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 		free_irq(omap_kp->irq, 0);
 	}
 
-- 
1.6.0.2.307.gc427

