From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 01/15] cbus: retu: drop retu_get_status
Date: Tue, 15 Feb 2011 10:45:48 +0200
Message-ID: <1297759562-25682-2-git-send-email-balbi@ti.com>
References: <1297759562-25682-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:55587 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751178Ab1BOIqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:46:20 -0500
Received: by gwaa12 with SMTP id a12so2674804gwa.20
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 00:46:19 -0800 (PST)
In-Reply-To: <1297759562-25682-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

children are allocated after retu core probes,
so by the time children start to probe, parent
is initialized for sure.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu-rtc.c |    6 ------
 drivers/cbus/retu-wdt.c |    8 --------
 drivers/cbus/retu.c     |    6 ------
 drivers/cbus/retu.h     |    1 -
 4 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 5f52edf..303a4a6 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -215,12 +215,6 @@ static int __init retu_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtc);
 	mutex_init(&rtc->mutex);
 
-	r = retu_get_status();
-	if (!r) {
-		dev_err(&pdev->dev, "retu not initialized\n");
-		goto err1;
-	}
-
 	rtc->alarm_expired = retu_read_reg(RETU_REG_IDR) &
 		(0x1 << RETU_INT_RTCA);
 
diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 8b87ae9..423216c 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -230,10 +230,6 @@ static int __devinit retu_wdt_ping(void)
 {
 	int r;
 
-	r = retu_get_status();
-	if (!r)
-		return -ENODEV;
-
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 	retu_modify_counter(RETU_WDT_MAX_TIMER);
 #else
@@ -258,10 +254,6 @@ static int __init retu_wdt_probe(struct platform_device *pdev)
 	struct retu_wdt_dev *wdev;
 	int ret;
 
-	ret = retu_get_status();
-	if (!ret)
-		return -ENODEV;
-
 	wdev = kzalloc(sizeof(struct retu_wdt_dev), GFP_KERNEL);
 	if (!wdev)
 		return -ENOMEM;
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 6134781..5886b00 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -74,12 +74,6 @@ struct retu {
 
 static struct retu *the_retu;
 
-int retu_get_status(void)
-{
-	return the_retu ? 1 : 0;
-}
-EXPORT_SYMBOL(retu_get_status);
-
 /**
  * retu_read_reg - Read a value from a register in Retu
  * @reg: the register to read from
diff --git a/drivers/cbus/retu.h b/drivers/cbus/retu.h
index 1b05f3e..f2357a9 100644
--- a/drivers/cbus/retu.h
+++ b/drivers/cbus/retu.h
@@ -57,7 +57,6 @@
 
 #define	MAX_RETU_IRQ_HANDLERS	16
 
-int retu_get_status(void);
 int retu_read_reg(unsigned reg);
 void retu_write_reg(unsigned reg, u16 val);
 void retu_set_clear_reg_bits(unsigned reg, u16 set, u16 clear);
-- 
1.7.4.rc2

