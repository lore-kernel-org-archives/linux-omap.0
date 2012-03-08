From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix section warnings for hsmmc_init_one
Date: Wed, 7 Mar 2012 19:37:04 -0800
Message-ID: <20120308033703.GS12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:26386 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212Ab2CHDhF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 22:37:05 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 7 Mar 2012 18:54:24 -0800
Subject: [PATCH] ARM: OMAP2+: Fix section warnings for hsmmc_init_one

Otherwise we can get the following error depending on
the compiler:

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xafe0):
Section mismatch in reference from the function omap_hsmmc_init_one()
to the function .init.text:omap_hsmmc_pdata_init()
The function omap_hsmmc_init_one() references
the function __init omap_hsmmc_pdata_init().
This is often because omap_hsmmc_init_one lacks a __init
annotation or the annotation of omap_hsmmc_pdata_init is wrong.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -466,7 +466,7 @@ void omap_hsmmc_late_init(struct omap2_hsmmc_info *c)
 
 #define MAX_OMAP_MMC_HWMOD_NAME_LEN		16
 
-static void omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
+static void __init omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
 					int ctrl_nr)
 {
 	struct omap_hwmod *oh;
