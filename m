From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] ARM: OMAP2+: am43xx: Add lcdc clockdomain
Date: Wed, 11 Dec 2019 14:25:58 -0600
Message-ID: <20191211202558.5988-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

As described in AM437x TRM, spruhl7h, Revised January 2018, there is
an LCDC clockdomain present in the PER power domain. Although it is
entirely unused on AM437x, it should be defined along with the other
clockdomains so it can be shut off by Linux as there are no users.

Reported-by: Munan Xu <munan@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/clockdomains43xx_data.c | 10 ++++++++++
 arch/arm/mach-omap2/prcm43xx.h              |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/clockdomains43xx_data.c b/arch/arm/mach-omap2/clockdomains43xx_data.c
index 751708d727af..c96a2b1efbad 100644
--- a/arch/arm/mach-omap2/clockdomains43xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains43xx_data.c
@@ -84,6 +84,15 @@ static struct clockdomain l3s_tsc_43xx_clkdm = {
 	.flags		  = CLKDM_CAN_SWSUP,
 };
 
+static struct clockdomain lcdc_43xx_clkdm = {
+	.name		  = "lcdc_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_LCDC_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
 static struct clockdomain dss_43xx_clkdm = {
 	.name		  = "dss_clkdm",
 	.pwrdm		  = { .name = "per_pwrdm" },
@@ -173,6 +182,7 @@ static struct clockdomain *clockdomains_am43xx[] __initdata = {
 	&pruss_ocp_43xx_clkdm,
 	&ocpwp_l3_43xx_clkdm,
 	&l3s_tsc_43xx_clkdm,
+	&lcdc_43xx_clkdm,
 	&dss_43xx_clkdm,
 	&l3_aon_43xx_clkdm,
 	&emif_43xx_clkdm,
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index e2ad14e77064..7078a61c1d3f 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -68,6 +68,7 @@
 #define AM43XX_CM_PER_ICSS_CDOFFS			0x0300
 #define AM43XX_CM_PER_L4LS_CDOFFS			0x0400
 #define AM43XX_CM_PER_EMIF_CDOFFS			0x0700
+#define AM43XX_CM_PER_LCDC_CDOFFS			0x0800
 #define AM43XX_CM_PER_DSS_CDOFFS			0x0a00
 #define AM43XX_CM_PER_CPSW_CDOFFS			0x0b00
 #define AM43XX_CM_PER_OCPWP_L3_CDOFFS			0x0c00
-- 
2.20.1
