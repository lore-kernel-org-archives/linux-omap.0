From: David Lambert <dlambert@ti.com>
Subject: [PATCH v3 2/4] OMAP4: hwmod: add entries for DMIC
	driver
Date: Tue, 25 Jan 2011 16:01:00 -0600
Message-ID: <1295992862-6154-3-git-send-email-dlambert@ti.com>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1295992862-6154-1-git-send-email-dlambert@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, David Lambert <dlambert@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

From: Benoit Cousson <b-cousson@ti.com>

Adds HWMOD entries for the OMAP DMIC driver and creates
a platform device.  The HWMOD entires define the system
resource requirements for the drvier such as DMA addresses, channels,
and IRQ's.  Placing this information in the HWMOD database allows
for more generic drivers to be written and having the specific
implementation details defined in HWMOD.

Signed-off-by: David Lambert <dlambert@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   91 ++++++++++++++++++++++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7274db4..f9b2ad3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -383,6 +383,95 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
 };
 
 /*
+ * 'dmic' class
+ * digital microphone controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_dmic_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_RESET_STATUS |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_dmic_hwmod_class = {
+	.name = "omap-dmic",
+	.sysc = &omap44xx_dmic_sysc,
+};
+
+/* dmic */
+static struct omap_hwmod omap44xx_dmic_hwmod;
+static struct omap_hwmod_irq_info omap44xx_dmic_irqs[] = {
+	{ .irq = 114 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_dmic_sdma_reqs[] = {
+	{ .dma_req = 66 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_dmic_addrs[] = {
+	{
+		.pa_start	= 0x4012e000,
+		.pa_end		= 0x4012e07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> dmic */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_dmic_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_dmic_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_dmic_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_dmic_dma_addrs[] = {
+	{
+		.pa_start	= 0x4902e000,
+		.pa_end		= 0x4902e07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> dmic (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_dmic_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_dmic_dma_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_dmic_dma_addrs),
+	.user		= OCP_USER_SDMA,
+};
+
+/* dmic slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_dmic_slaves[] = {
+	&omap44xx_l4_abe__dmic,
+	&omap44xx_l4_abe__dmic_dma,
+};
+
+static struct omap_hwmod omap44xx_dmic_hwmod = {
+	.name		= "omap-dmic",
+	.class		= &omap44xx_dmic_hwmod_class,
+	.mpu_irqs	= omap44xx_dmic_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dmic_irqs),
+	.sdma_reqs	= omap44xx_dmic_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dmic_sdma_reqs),
+	.main_clk	= "dmic_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_DMIC_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_dmic_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_dmic_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'mpu_bus' class
  * instance(s): mpu_private
  */
@@ -826,6 +915,8 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_l4_cfg_hwmod,
 	&omap44xx_l4_per_hwmod,
 	&omap44xx_l4_wkup_hwmod,
+	/* dmic class */
+	&omap44xx_dmic_hwmod,
 	/* mpu_bus class */
 	&omap44xx_mpu_private_hwmod,
 
-- 
1.7.0.4
