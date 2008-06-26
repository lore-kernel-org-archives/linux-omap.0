From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/4] OMAP3 pwrdm: add CORE SAR handling (for USBTLL module)
Date: Wed, 25 Jun 2008 18:09:40 -0600
Message-ID: <20080626000939.18779.63224.stgit@localhost.localdomain>
References: <20080626000415.18779.25924.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36923 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbYFZAQm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 20:16:42 -0400
In-Reply-To: <20080626000415.18779.25924.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com, r-woodruff2@ti.com

34xx TRM Delta G->H notes that the CORE powerdomain has a hardware
save-and-restore (SAR) control bit for the USBTLL module, similar to
the USBHOST powerdomain SAR bit.  Split the existing core_34xx struct
powerdomain into two structs, one for ES1 and one for ES2, and add the
PWRDM_HAS_HDWR_SAR flag to the ES2 powerdomain.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/powerdomains.h     |    3 ++-
 arch/arm/mach-omap2/powerdomains34xx.h |   23 +++++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
index 5ad9cb0..3152811 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -171,7 +171,8 @@ static struct powerdomain *powerdomains_omap[] __initdata = {
 	&iva2_pwrdm,
 	&mpu_34xx_pwrdm,
 	&neon_pwrdm,
-	&core_34xx_pwrdm,
+	&core_34xx_es1_pwrdm,
+	&core_34xx_es2_pwrdm,
 	&cam_pwrdm,
 	&dss_pwrdm,
 	&per_pwrdm,
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 88f85ea..0c07bf7 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -200,12 +200,31 @@ static struct powerdomain mpu_34xx_pwrdm = {
 };
 
 /* No wkdeps or sleepdeps for 34xx core apparently */
-static struct powerdomain core_34xx_pwrdm = {
+static struct powerdomain core_34xx_es1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
+	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
+	.banks		  = 2,
+	.pwrsts_mem_ret	  = {
+		[0] = PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
+		[1] = PWRSTS_OFF_RET,	 /* MEM2RETSTATE */
+	},
+	.pwrsts_mem_on	  = {
+		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
+		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
+	},
+};
+
+/* No wkdeps or sleepdeps for 34xx core apparently */
+static struct powerdomain core_34xx_es2_pwrdm = {
+	.name		  = "core_pwrdm",
+	.prcm_offs	  = CORE_MOD,
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
+	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
 	.banks		  = 2,
 	.pwrsts_mem_ret	  = {
 		[0] = PWRSTS_OFF_RET,	 /* MEM1RETSTATE */


