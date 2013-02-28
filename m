From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] arm/omap2: Fix build failures
Date: Thu, 28 Feb 2013 10:53:03 -0800
Message-ID: <1362077583-11184-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:62940 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab3B1TSA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Feb 2013 14:18:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Guenter Roeck <linux@roeck-us.net>

Commit c1d1cd59 (omap_device: remove obsolete pm_lats and early_device code)
changed the number of parameters to omap_device_build(), but did not fix all
calling code correctly. This causes build failures with some configurations.

arch/arm/mach-omap2/devices.c: In function 'omap_init_hdmi_audio':
arch/arm/mach-omap2/devices.c:429:2: error: too many arguments to function 'omap_device_build'
arch/arm/mach-omap2/omap_device.h:74:25: note: declared here
make[2]: [arch/arm/mach-omap2/devices.o] Error 1 (ignored)
arch/arm/mach-omap2/sr_device.c: In function 'sr_dev_init':
arch/arm/mach-omap2/sr_device.c:155:2: error: too many arguments to function 'omap_device_build'
arch/arm/mach-omap2/omap_device.h:74:25: note: declared here
make[2]: [arch/arm/mach-omap2/sr_device.o] Error 1 (ignored)
arch/arm/mach-omap2/am35xx-emac.c: In function 'omap_davinci_emac_dev_init':
arch/arm/mach-omap2/am35xx-emac.c:66:6: error: too many arguments to function 'omap_device_build'
arch/arm/mach-omap2/omap_device.h:74:25: note: declared here

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/mach-omap2/am35xx-emac.c |    3 +--
 arch/arm/mach-omap2/devices.c     |    2 +-
 arch/arm/mach-omap2/sr_device.c   |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
index a00d391..25b79a2 100644
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ b/arch/arm/mach-omap2/am35xx-emac.c
@@ -62,8 +62,7 @@ static int __init omap_davinci_emac_dev_init(struct omap_hwmod *oh,
 {
 	struct platform_device *pdev;
 
-	pdev = omap_device_build(oh->class->name, 0, oh, pdata, pdata_len,
-				 false);
+	pdev = omap_device_build(oh->class->name, 0, oh, pdata, pdata_len);
 	if (IS_ERR(pdev)) {
 		WARN(1, "Can't build omap_device for %s:%s.\n",
 		     oh->class->name, oh->name);
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 142d9c6..1ec7f05 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -426,7 +426,7 @@ static void __init omap_init_hdmi_audio(void)
 		return;
 	}
 
-	pdev = omap_device_build("omap-hdmi-audio-dai", -1, oh, NULL, 0, 0);
+	pdev = omap_device_build("omap-hdmi-audio-dai", -1, oh, NULL, 0);
 	WARN(IS_ERR(pdev),
 	     "Can't build omap_device for omap-hdmi-audio-dai.\n");
 
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index bb829e0..d7bc33f 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -152,7 +152,7 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 
 	sr_data->enable_on_init = sr_enable_on_init;
 
-	pdev = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data), 0);
+	pdev = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data));
 	if (IS_ERR(pdev))
 		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
 			__func__, name, oh->name);
-- 
1.7.9.7

