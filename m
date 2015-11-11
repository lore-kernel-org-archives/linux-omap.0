From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] ARM: OMAP: DRA7: hwmod: Add data for McASP3
Date: Wed, 11 Nov 2015 11:07:11 -0600
Message-ID: <1447261631-26362-1-git-send-email-balbi@ti.com>
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
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

McASP3 is used by default on DRA7x based boards for audio.

This fixes following error with Beagle x15:

[    0.402190] platform 48468000.mcasp: Cannot lookup hwmod 'mcasp3'

which is followed by a splat:

[   11.207663] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
[   11.207670] ------------[ cut here ]------------
[   11.207683] WARNING: CPU: 0 PID: 272 at /home/balbi/workspace/linux/drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x220/0x34c()
[   11.207688] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER2_P3 (Read): Data Access in User mode during Functional access
[   11.207742] Modules linked in: snd_soc_simple_card(+) omapdss leds_gpio led_class gpio_fan extcon_usb_gpio cpufreq_dt omap_wdt phy_omap_usb2 snd_soc_davinci_mcasp snd_soc_edma snd_soc_omap snd_soc_tlv320aic3x rtc_omap snd_soc_core ti_soc_thermal dwc3_omap snd_pcm_dmaengine snd_pcm extcon_palmas snd_timer extcon snd rtc_palmas rtc_ds1307 tmp102 palmas_pwrbutton thermal_sys soundcore hwmon autofs4
[   11.207748] CPU: 0 PID: 272 Comm: systemd-udevd Not tainted 4.3.0-11482-g3d26f1f5fc82-dirty #27
[   11.207751] Hardware name: Generic DRA74X (Flattened Device Tree)
[   11.207765] [<c0017c3c>] (unwind_backtrace) from [<c0013f80>] (show_stack+0x10/0x14)
[   11.207772] [<c0013f80>] (show_stack) from [<c034d444>] (dump_stack+0x84/0x9c)
[   11.207783] [<c034d444>] (dump_stack) from [<c003cc24>] (warn_slowpath_common+0x78/0xb4)
[   11.207790] [<c003cc24>] (warn_slowpath_common) from [<c003cc90>] (warn_slowpath_fmt+0x30/0x40)
[   11.207798] [<c003cc90>] (warn_slowpath_fmt) from [<c0379ce0>] (l3_interrupt_handler+0x220/0x34c)
[   11.207805] [<c0379ce0>] (l3_interrupt_handler) from [<c009d9c0>] (handle_irq_event_percpu+0x44/0x1f0)
[   11.207811] [<c009d9c0>] (handle_irq_event_percpu) from [<c009dba4>] (handle_irq_event+0x38/0x5c)
[   11.207818] [<c009dba4>] (handle_irq_event) from [<c00a0d68>] (handle_fasteoi_irq+0xcc/0x1b0)
[   11.207824] [<c00a0d68>] (handle_fasteoi_irq) from [<c009d070>] (generic_handle_irq+0x20/0x34)
[   11.207829] [<c009d070>] (generic_handle_irq) from [<c009d350>] (__handle_domain_irq+0x64/0xe0)
[   11.207835] [<c009d350>] (__handle_domain_irq) from [<c0009520>] (gic_handle_irq+0x40/0x8c)
[   11.207842] [<c0009520>] (gic_handle_irq) from [<c06521b4>] (__irq_usr+0x54/0x80)
[   11.207846] Exception stack(0xed143fb0 to 0xed143ff8)
[   11.207851] 3fa0:                                     7f69b370 7f69b368 00000370 00000000
[   11.207857] 3fc0: b6ddb4e0 7f69b370 00000016 7f69b308 be8db278 be8db2a0 7f68b024 00000001
[   11.207863] 3fe0: b6ddb4e0 be8db180 b6d46a47 b6d46a50 60000030 ffffffff
[   11.207866] ---[ end trace 7d8de48d1bc8fbac ]---

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 51d1ecb384bd..b730c582a1f7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1298,6 +1298,38 @@ static struct omap_hwmod dra7xx_mcspi4_hwmod = {
 };
 
 /*
+ * 'mcasp' class
+ *
+ */
+static struct omap_hwmod_class_sysconfig dra7xx_mcasp_sysc = {
+	.sysc_offs	= 0x0004,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type3,
+};
+
+static struct omap_hwmod_class dra7xx_mcasp_hwmod_class = {
+	.name	= "mcasp",
+	.sysc	= &dra7xx_mcasp_sysc,
+};
+
+/* mcasp3 */
+static struct omap_hwmod dra7xx_mcasp3_hwmod = {
+	.name		= "mcasp3",
+	.class		= &dra7xx_mcasp_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "mcasp3_ahclkx_mux",
+	.flags		= HWMOD_SWSUP_SIDLE,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER2_MCASP3_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER2_MCASP3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'mmc' class
  *
  */
@@ -2566,6 +2598,14 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__hdmi = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_per2 -> mcasp3 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_mcasp3_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_per1 -> elm */
 static struct omap_hwmod_ocp_if dra7xx_l4_per1__elm = {
 	.master		= &dra7xx_l4_per1_hwmod,
@@ -3308,6 +3348,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_wkup__dcan1,
 	&dra7xx_l4_per2__dcan2,
 	&dra7xx_l4_per2__cpgmac0,
+	&dra7xx_l4_per2__mcasp3,
 	&dra7xx_gmac__mdio,
 	&dra7xx_l4_cfg__dma_system,
 	&dra7xx_l3_main_1__dss,
-- 
2.6.2
