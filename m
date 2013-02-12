From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP2+: fix some omap_device_build() calls that aren't
 compiled by default
Date: Tue, 12 Feb 2013 03:58:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302120358130.14983@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37217 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab3BLD6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 22:58:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Commit c1d1cd597fc77af3086470f8627d77f52f7f8b6c ("ARM: OMAP2+:
omap_device: remove obsolete pm_lats and early_device code") missed a
few omap_device_build() calls that aren't included as part of the default
OMAP2+ Kconfig, omap2plus_defconfig.

Ideally, all devices that are present on the SoC should be created by
default, and only the corresponding device driver should be configured
or deconfigured in Kconfig.  This allows drivers to be built as
modules and loaded later, even if they weren't part of the original
kernel build.  Unfortunately, we're not quite there yet.

Thanks to Tony Lindgren for reporting this, found during his
randconfig tests.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
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
index d8a0cc3..6ecc89a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -382,7 +382,7 @@ static void __init omap_init_hdmi_audio(void)
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
1.7.10.4

