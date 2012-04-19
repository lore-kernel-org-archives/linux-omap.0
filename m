From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH] arm: omap3: Remove superfluous commas from gfx_sgx_3xxx_wkdeps[]
Date: Thu, 19 Apr 2012 13:11:39 -0700
Message-ID: <1334866299-8198-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:50504 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab2DSUMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 16:12:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, khilman@ti.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Clean up clockdomains3xxx_data.c a bit by removing the
superfluous commas in gfx_sgx_3xxx_wkdeps[].

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/clockdomains3xxx_data.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index b84e138..6038adb 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -53,9 +53,9 @@
  * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
  */
 static struct clkdm_dep gfx_sgx_3xxx_wkdeps[] = {
-	{ .clkdm_name = "iva2_clkdm", },
-	{ .clkdm_name = "mpu_clkdm", },
-	{ .clkdm_name = "wkup_clkdm", },
+	{ .clkdm_name = "iva2_clkdm" },
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
 	{ NULL },
 };
 
-- 
1.7.9.4

