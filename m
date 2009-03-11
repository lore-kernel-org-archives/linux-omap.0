From: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
Subject: [PATCH 0/6]  OMAP: omap_wdt: clocks and NOWAYOUT fixes.
Date: Wed, 11 Mar 2009 17:29:32 +0200
Message-ID: <1236785378-14640-1-git-send-email-ext-atal.shargorodsky@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45605 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbZCKPa6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 11:30:58 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Felipe Balbi <felipe.balbi@nokia.com>

This patchset reorganizes slightly the code of omap_wdt driver,
introduces proper management of clocks and
CONFIG_WATCHDOG_NOWAYOUT + PM support, which was broken.
Also, inspired by numerous watchdog drivers using this technique, 
this patchset makes the NOWAYOUT behavior not to be restricted by kernel
configuration, but to be controlled by a module parameter.


It's not expected to be applied as is, as it's not utilizing the clkdev,
so part of it is obsolete. So I'm posting it because of the other changes
it introduced to be discussed.

Also the first patch in the patch set cannot apply because of the
current driver in linux-omap git tree being broken.
It will apply after applying the inlined patch provided by Felipe Balbi:


Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/watchdog/omap_wdt.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 7bcbb7f..0fb9fd7 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -294,7 +294,7 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
                goto err_busy;
        }
 
-       wdev = kzalloc(sizeof(struct omap_wdt_dev), GFP_KERNEL);
+       wdev = kzalloc(sizeof(*wdev), GFP_KERNEL);
        if (!wdev) {
                ret = -ENOMEM;
                goto err_kzalloc;
@@ -347,8 +347,18 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
                goto err_ioremap;
        }
 
+       spin_lock_init(&wdt_lock);
        platform_set_drvdata(pdev, wdev);
 
+       /* enable clocks for register access */
+       if (cpu_is_omap16xx())
+               clk_enable(wdev->armwdt_ck);    /* Enable the clock */
+
+       if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+               clk_enable(wdev->mpu_wdt_ick);    /* Enable the interface clock */
+               clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
+       }
+
        omap_wdt_disable(wdev);
        omap_wdt_adjust_timeout(timer_margin);
 
@@ -368,6 +378,15 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
        /* autogate OCP interface clock */
        __raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
 
+       /* disable clocks since we don't need them now */
+       if (cpu_is_omap16xx())
+               clk_disable(wdev->armwdt_ck);   /* Disable the clock */
+
+       if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+               clk_disable(wdev->mpu_wdt_ick); /* Disable the clock */
+               clk_disable(wdev->mpu_wdt_fck); /* Disable the clock */
+       }
+
        omap_wdt_dev = pdev;
 
        return 0;
@@ -488,7 +507,6 @@ static struct platform_driver omap_wdt_driver = {
 
 static int __init omap_wdt_init(void)
 {
-       spin_lock_init(&wdt_lock);
        return platform_driver_register(&omap_wdt_driver);
 }
 
-- 



And another thing to be noted: Imre Deak proposed to stay with
cpu_is_* macros for a better optimization.
Or to use a (!cpu_class_is_omap1()) instead of 
        (cpu_is_omap24xx() || cpu_is_omap34xx()).
I think it's the right thing to do, but it's not included in the patchset,
as this patchset is not expected to be applied as is anyway, 
but rather to be discussed.



