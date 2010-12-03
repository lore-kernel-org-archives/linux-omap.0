From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH -next] omap2430: hwmod: remove stray declaration
Date: Sat,  4 Dec 2010 00:45:30 +0530
Message-ID: <1291403730-3165-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52800 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab0LCTPk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 14:15:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Patch "OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430"
in linux-next as of 20101203 introduced the following build
warning - fix this by removing the stray i2c_dev_attr.

arch/arm/mach-omap2/omap_hwmod_2430_data.c:483: warning: 'i2c_dev_attr' defined but not used

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 --
 1 file changed, 2 deletions(-)

Index: mainline/arch/arm/mach-omap2/omap_hwmod_2430_data.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ mainline/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -480,8 +480,6 @@ static struct omap_hwmod_class i2c_class
 	.sysc		= &i2c_sysc,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr;
-
 /* I2C1 */
 
 static struct omap_i2c_dev_attr i2c1_dev_attr = {
