From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix GPMC errors when CONFIG_MTD_NAND_OMAP2 is
 a module
Date: Wed, 29 Feb 2012 09:31:59 -0800
Message-ID: <20120229173159.GM18901@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52698 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab2B2RcD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 12:32:03 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Otherwise we can get:

ERROR: "gpmc_calculate_ecc" [drivers/mtd/nand/omap2.ko] undefined!
ERROR: "gpmc_enable_hwecc" [drivers/mtd/nand/omap2.ko] undefined!

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -888,6 +888,7 @@ int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size)
 	gpmc_write_reg(GPMC_ECC_CONFIG, val);
 	return 0;
 }
+EXPORT_SYMBOL(gpmc_enable_hwecc);
 
 /**
  * gpmc_calculate_ecc - generate non-inverted ecc bytes
@@ -918,3 +919,4 @@ int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
 	gpmc_ecc_used = -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL(gpmc_calculate_ecc);
