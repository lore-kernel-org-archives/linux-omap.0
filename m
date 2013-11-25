From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 3/7] ARM: DRA7xx: hwmod: Add hwmod data for AES IP
Date: Mon, 25 Nov 2013 15:44:32 -0600
Message-ID: <1385415876-12387-4-git-send-email-joelf@ti.com>
References: <1385415876-12387-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1385415876-12387-1-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joel Fernandes <joelf@ti.com>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

DRA7xx SoC has an AES IP found also on OMAP4. Add hwmod data for the same.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index efae736..5831ac6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -561,6 +561,17 @@ static struct omap_hwmod_class dra7xx_gpio_hwmod_class = {
 	.rev	= 2,
 };
 
+static struct omap_hwmod_class_sysconfig dra7xx_aes_sysc = {
+	.rev_offs	= 0x0080,
+	.sysc_offs	= 0x0084,
+	.syss_offs	= 0x0088,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type4,
+};
+
 static struct omap_hwmod_class_sysconfig dra7xx_des_sysc = {
 	.rev_offs	= 0x0030,
 	.sysc_offs	= 0x0034,
@@ -572,6 +583,12 @@ static struct omap_hwmod_class_sysconfig dra7xx_des_sysc = {
 	.sysc_fields	= &omap_hwmod_sysc_type4,
 };
 
+static struct omap_hwmod_class dra7xx_aes_hwmod_class = {
+	.name	= "aes",
+	.sysc	= &dra7xx_aes_sysc,
+	.rev	= 2,
+};
+
 static struct omap_hwmod_class dra7xx_des_hwmod_class = {
 	.name	= "des",
 	.sysc	= &dra7xx_des_sysc,
@@ -767,6 +784,19 @@ static struct omap_hwmod dra7xx_gpio8_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 };
 
+static struct omap_hwmod dra7xx_aes_hwmod = {
+	.name		= "aes",
+	.class		= &dra7xx_aes_hwmod_class,
+	.clkdm_name	= "l4sec_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4SEC_AES1_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4SEC_AES1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
 static struct omap_hwmod dra7xx_des_hwmod = {
 	.name		= "des",
 	.class		= &dra7xx_des_hwmod_class,
@@ -2119,6 +2149,14 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__hdmi = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l3_main_1 -> aes */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__aes = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_aes_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space dra7xx_elm_addrs[] = {
 	{
 		.pa_start	= 0x48078000,
@@ -2695,6 +2733,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__dss,
 	&dra7xx_l3_main_1__dispc,
 	&dra7xx_l3_main_1__hdmi,
+	&dra7xx_l3_main_1__aes,
 	&dra7xx_l4_per1__elm,
 	&dra7xx_l4_wkup__gpio1,
 	&dra7xx_l4_per1__gpio2,
-- 
1.8.1.2
