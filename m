From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC/PATCH 3/4] rtc: twl4030: move to request_threaded_irq
Date: Mon, 14 Dec 2009 12:30:53 +0200
Message-ID: <1260786654-13294-4-git-send-email-felipe.balbi@nokia.com>
References: <20091212183410.GF3092@sirena.org.uk>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756077AbZLNKcg@vger.kernel.org>
In-Reply-To: <20091212183410.GF3092@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, David Brownell <david-b@pacbell.net>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@openedhand.com>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

move to request_threaded_irq() on twl4030 children.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/rtc/rtc-twl4030.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
index 9c8c70c..46bc9c1 100644
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -325,14 +325,6 @@ static irqreturn_t twl4030_rtc_interrupt(int irq, void *rtc)
 	int res;
 	u8 rd_reg;
 
-#ifdef CONFIG_LOCKDEP
-	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
-	 * we don't want and can't tolerate.  Although it might be
-	 * friendlier not to borrow this thread context...
-	 */
-	local_irq_enable();
-#endif
-
 	res = twl4030_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
 	if (res)
 		goto out;
@@ -424,7 +416,7 @@ static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out1;
 
-	ret = request_irq(irq, twl4030_rtc_interrupt,
+	ret = request_threaded_irq(irq, NULL, twl4030_rtc_interrupt,
 				IRQF_TRIGGER_RISING,
 				dev_name(&rtc->dev), rtc);
 	if (ret < 0) {
-- 
1.6.6.rc0
