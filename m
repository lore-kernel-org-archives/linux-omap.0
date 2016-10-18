From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 4/7] ARM: DRA7: hwmod: Add data for RNG IP
Date: Tue, 18 Oct 2016 10:55:24 +0300
Message-ID: <1476777327-700-5-git-send-email-t-kristo@ti.com>
References: <1476777327-700-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476777327-700-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Joel Fernandes <joelf@ti.com>

DRA7 SoC contains hardware random number generator. Add hwmod data for
this IP so that it can be utilized.

Signed-off-by: Joel Fernandes <joelf@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
[t-kristo@ti.com: squashed the RNG hwmod IP flag fixes from Lokesh,
                  squashed the HS chip fix from Daniel Allred]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 87e9293..2804f06 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2641,6 +2641,34 @@ static int dra7xx_pciess_reset(struct omap_hwmod *oh)
 	},
 };
 
+/* rng */
+static struct omap_hwmod_class_sysconfig dra7xx_rng_sysc = {
+	.rev_offs       = 0x1fe0,
+	.sysc_offs      = 0x1fe4,
+	.sysc_flags     = SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE,
+	.idlemodes      = SIDLE_FORCE | SIDLE_NO,
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class dra7xx_rng_hwmod_class = {
+	.name           = "rng",
+	.sysc           = &dra7xx_rng_sysc,
+};
+
+static struct omap_hwmod dra7xx_rng_hwmod = {
+	.name           = "rng",
+	.class          = &dra7xx_rng_hwmod_class,
+	.flags		= HWMOD_SWSUP_SIDLE,
+	.clkdm_name     = "l4sec_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4SEC_RNG_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4SEC_RNG_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
 /*
  * 'usb_otg_ss' class
  *
@@ -3798,6 +3826,13 @@ static int dra7xx_pciess_reset(struct omap_hwmod *oh)
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_per1 -> rng */
+static struct omap_hwmod_ocp_if dra7xx_l4_per1__rng = {
+	.master         = &dra7xx_l4_per1_hwmod,
+	.slave          = &dra7xx_rng_hwmod,
+	.user           = OCP_USER_MPU,
+};
+
 /* l4_per3 -> usb_otg_ss1 */
 static struct omap_hwmod_ocp_if dra7xx_l4_per3__usb_otg_ss1 = {
 	.master		= &dra7xx_l4_per3_hwmod,
@@ -4028,6 +4063,7 @@ static int dra7xx_pciess_reset(struct omap_hwmod *oh)
 /* GP-only hwmod links */
 static struct omap_hwmod_ocp_if *dra7xx_gp_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_wkup__timer12,
+	&dra7xx_l4_per1__rng,
 	NULL,
 };
 
-- 
1.9.1
