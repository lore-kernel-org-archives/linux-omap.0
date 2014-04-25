From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 02/10] ARM: DRA7xx: hwmod: Add hwmod data for DES IP
Date: Fri, 25 Apr 2014 18:02:40 -0500
Message-ID: <1398466968-29506-3-git-send-email-joelf@ti.com>
References: <1398466968-29506-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398466968-29506-1-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

dra7xx SoC has a DES module. Add the required data to hwmod.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   39 +++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 810c205..24ab160 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -561,6 +561,23 @@ static struct omap_hwmod_class dra7xx_gpio_hwmod_class = {
 	.rev	= 2,
 };
 
+static struct omap_hwmod_class_sysconfig dra7xx_des_sysc = {
+	.rev_offs	= 0x0030,
+	.sysc_offs	= 0x0034,
+	.syss_offs	= 0x0038,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),
+	.sysc_fields	= &omap_hwmod_sysc_type4,
+};
+
+static struct omap_hwmod_class dra7xx_des_hwmod_class = {
+	.name	= "des",
+	.sysc	= &dra7xx_des_sysc,
+	.rev	= 2,
+};
+
 /* gpio dev_attr */
 static struct omap_gpio_dev_attr gpio_dev_attr = {
 	.bank_width	= 32,
@@ -750,6 +767,19 @@ static struct omap_hwmod dra7xx_gpio8_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 };
 
+static struct omap_hwmod dra7xx_des_hwmod = {
+	.name		= "des",
+	.class		= &dra7xx_des_hwmod_class,
+	.clkdm_name	= "l4sec_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4SEC_DES3DES_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4SEC_DES3DES_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
 /*
  * 'gpmc' class
  *
@@ -2170,6 +2200,14 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio8 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_per1 -> des */
+static struct omap_hwmod_ocp_if dra7xx_l4_per1__des = {
+	.master		= &dra7xx_l4_per1_hwmod,
+	.slave		= &dra7xx_des_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space dra7xx_gpmc_addrs[] = {
 	{
 		.pa_start	= 0x50000000,
@@ -2704,6 +2742,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per1__uart4,
 	&dra7xx_l4_per1__uart5,
 	&dra7xx_l4_per1__uart6,
+	&dra7xx_l4_per1__des,
 	&dra7xx_l4_per3__usb_otg_ss1,
 	&dra7xx_l4_per3__usb_otg_ss2,
 	&dra7xx_l4_per3__usb_otg_ss3,
-- 
1.7.9.5
