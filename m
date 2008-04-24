From: Seth Forshee <seth.forshee@gmail.com>
Subject: [PATCH] ARM: OMAP: Fix MMC2 device configuration for OMAP2430
Date: Thu, 24 Apr 2008 14:25:27 -0500
Message-ID: <20080424192526.GA28609@ubuntu-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:20276 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762484AbYDXTZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 15:25:57 -0400
Received: by py-out-1112.google.com with SMTP id u52so5211551pyb.10
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2008 12:25:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Currently the MMC2 device configuration is defined for OMAP2430
when CONFIG_ARCH_OMAP243X is defined.  This should be
CONFIG_ARCH_OMAP2430.

Signed-off-by: Seth Forshee <seth.forshee@gmail.com>
---
 arch/arm/plat-omap/devices.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 6f07451..099182b 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -202,7 +202,7 @@ static struct platform_device mmc_omap_device1 = {
 	.resource	= mmc1_resources,
 };
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP243X) || \
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || \
 	defined(CONFIG_ARCH_OMAP34XX)
 
 static struct omap_mmc_platform_data mmc2_data;
@@ -251,7 +251,7 @@ static void __init omap_init_mmc(void)
 		if (mmc->enabled)
 			(void) platform_device_register(&mmc_omap_device1);
 
-#if defined(CONFIG_ARCH_OMAP243X) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
 		mmc = &mmc_conf->mmc[1];
 		if (mmc->enabled)
 			(void) platform_device_register(&mmc_omap_device2);
@@ -349,7 +349,7 @@ void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info)
 	case 1:
 		mmc1_data = *info;
 		break;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP243X) || \
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || \
 	defined(CONFIG_ARCH_OMAP34XX)
 	case 2:
 		mmc2_data = *info;
