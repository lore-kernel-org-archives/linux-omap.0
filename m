From: <grygorii.strashko@linaro.org>
Subject: [PATCH] ARM: omap-device: add missed callback for suspend-to-disk
Date: Wed, 25 Feb 2015 16:13:50 +0200
Message-ID: <1424873630-6054-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:40902 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbbBYON4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 09:13:56 -0500
Received: by lbdu10 with SMTP id u10so4076966lbd.7
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2015 06:13:54 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, nm@ti.com
Cc: sumit.semwal@linaro.org, linux-omap@vger.kernel.org, kishon@ti.com, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <Grygorii.Strashko@linaro.org>

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Add missed callback needed for supporting suspend-to-disk (hibernation) mode.

Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 arch/arm/mach-omap2/omap_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index fcd2c9e..345e18e 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -739,6 +739,9 @@ struct dev_pm_domain omap_device_pm_domain = {
 		USE_PLATFORM_PM_SLEEP_OPS
 		.suspend_noirq = _od_suspend_noirq,
 		.resume_noirq = _od_resume_noirq,
+		.freeze_noirq = _od_suspend_noirq,
+		.thaw_noirq = _od_resume_noirq,
+		.restore_noirq = _od_resume_noirq,
 	}
 };
 
-- 
1.9.1

