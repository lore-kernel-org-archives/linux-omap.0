From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 02/15] ARM: mark const init data with __initconst instead of __initdata
Date: Fri, 30 Mar 2012 22:04:52 +0200
Message-ID: <1333137905-13809-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120330200358.GV15647@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120330200358.GV15647@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: kernel@pengutronix.de, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Russell King <linux@arm.linux.org.uk>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Kukjin Kim <kgene.kim@samsung.com>Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lennert Buytenhek <kernel@wantstofly.org>, Nicolas Pitre <nico@fluxnic.net>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Barry Song <baohua.song@csr.com>, Andrew Lunn <andrew@lunn.ch>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-sam
List-Id: linux-omap@vger.kernel.org

As long as there is no other non-const variable marked __initdata in th=
e
same compilation unit it doesn't hurt. If there were one however
compilation would fail with

	error: $variablename causes a section type conflict

because a section containing const variables is marked read only and so
cannot contain non-const variables.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Barry Song <baohua.song@csr.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-arm-kernel@lists.infradead.org
Cc: davinci-linux-open-source@linux.davincidsp.com
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-omap@vger.kernel.org
---
changes since (implicit) v1:
 - drop changes to several files that were wrong:
   - arch/arm/mach-at91/board-dt.c
   - arch/arm/mach-exynos/*
   - arch/arm/mach-imx/*
   - arch/arm/mach-mmp/mmp-dt.c
   - arch/arm/mach-msm/board-msm8x60.c
   - arch/arm/mach-omap2/board-generic.c
   - arch/arm/mach-omap2/voltagedomains{3x,44}xx_data.c
   - arch/arm/mach-prima2
 - fix position of __initconst
   - arch/arm/mach-kirkwood/addr-map.c
   - arch/arm/mach-orion5x/addr-map.c

 arch/arm/mach-at91/clock.c                  |    2 +-
 arch/arm/mach-davinci/board-tnetv107x-evm.c |    6 ++--
 arch/arm/mach-davinci/da830.c               |   48 +++++++++++++------=
--------
 arch/arm/mach-davinci/da850.c               |    6 ++--
 arch/arm/mach-dove/addr-map.c               |    2 +-
 arch/arm/mach-kirkwood/addr-map.c           |    2 +-
 arch/arm/mach-msm/board-qsd8x50.c           |    4 +--
 arch/arm/mach-omap2/display.c               |    6 ++--
 arch/arm/mach-orion5x/addr-map.c            |    2 +-
 9 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index a0f4d74..e4a255d 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -613,7 +613,7 @@ fail:
 	return 0;
 }
=20
-static struct clk *const standard_pmc_clocks[] __initdata =3D {
+static struct clk *const standard_pmc_clocks[] __initconst =3D {
 	/* four primary clocks */
 	&clk32k,
 	&main_clk,
diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mac=
h-davinci/board-tnetv107x-evm.c
index 5f14e30..645a587 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -88,7 +88,7 @@ static struct davinci_mmc_config mmc_config =3D {
 	.version	=3D MMC_CTLR_VERSION_1,
 };
=20
-static const short sdio1_pins[] __initdata =3D {
+static const short sdio1_pins[] __initconst =3D {
 	TNETV107X_SDIO1_CLK_1,		TNETV107X_SDIO1_CMD_1,
 	TNETV107X_SDIO1_DATA0_1,	TNETV107X_SDIO1_DATA1_1,
 	TNETV107X_SDIO1_DATA2_1,	TNETV107X_SDIO1_DATA3_1,
@@ -96,12 +96,12 @@ static const short sdio1_pins[] __initdata =3D {
 	-1
 };
=20
-static const short uart1_pins[] __initdata =3D {
+static const short uart1_pins[] __initconst =3D {
 	TNETV107X_UART1_RD,		TNETV107X_UART1_TD,
 	-1
 };
=20
-static const short ssp_pins[] __initdata =3D {
+static const short ssp_pins[] __initconst =3D {
 	TNETV107X_SSP0_0, TNETV107X_SSP0_1, TNETV107X_SSP0_2,
 	TNETV107X_SSP1_0, TNETV107X_SSP1_1, TNETV107X_SSP1_2,
 	TNETV107X_SSP1_3, -1
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da83=
0.c
index deee5c2..510648e 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -838,7 +838,7 @@ static const struct mux_config da830_pins[] =3D {
 #endif
 };
=20
-const short da830_emif25_pins[] __initdata =3D {
+const short da830_emif25_pins[] __initconst =3D {
 	DA830_EMA_D_0, DA830_EMA_D_1, DA830_EMA_D_2, DA830_EMA_D_3,
 	DA830_EMA_D_4, DA830_EMA_D_5, DA830_EMA_D_6, DA830_EMA_D_7,
 	DA830_EMA_D_8, DA830_EMA_D_9, DA830_EMA_D_10, DA830_EMA_D_11,
@@ -853,19 +853,19 @@ const short da830_emif25_pins[] __initdata =3D {
 	-1
 };
=20
-const short da830_spi0_pins[] __initdata =3D {
+const short da830_spi0_pins[] __initconst =3D {
 	DA830_SPI0_SOMI_0, DA830_SPI0_SIMO_0, DA830_SPI0_CLK, DA830_NSPI0_ENA=
,
 	DA830_NSPI0_SCS_0,
 	-1
 };
=20
-const short da830_spi1_pins[] __initdata =3D {
+const short da830_spi1_pins[] __initconst =3D {
 	DA830_SPI1_SOMI_0, DA830_SPI1_SIMO_0, DA830_SPI1_CLK, DA830_NSPI1_ENA=
,
 	DA830_NSPI1_SCS_0,
 	-1
 };
=20
-const short da830_mmc_sd_pins[] __initdata =3D {
+const short da830_mmc_sd_pins[] __initconst =3D {
 	DA830_MMCSD_DAT_0, DA830_MMCSD_DAT_1, DA830_MMCSD_DAT_2,
 	DA830_MMCSD_DAT_3, DA830_MMCSD_DAT_4, DA830_MMCSD_DAT_5,
 	DA830_MMCSD_DAT_6, DA830_MMCSD_DAT_7, DA830_MMCSD_CLK,
@@ -873,32 +873,32 @@ const short da830_mmc_sd_pins[] __initdata =3D {
 	-1
 };
=20
-const short da830_uart0_pins[] __initdata =3D {
+const short da830_uart0_pins[] __initconst =3D {
 	DA830_NUART0_CTS, DA830_NUART0_RTS, DA830_UART0_RXD, DA830_UART0_TXD,
 	-1
 };
=20
-const short da830_uart1_pins[] __initdata =3D {
+const short da830_uart1_pins[] __initconst =3D {
 	DA830_UART1_RXD, DA830_UART1_TXD,
 	-1
 };
=20
-const short da830_uart2_pins[] __initdata =3D {
+const short da830_uart2_pins[] __initconst =3D {
 	DA830_UART2_RXD, DA830_UART2_TXD,
 	-1
 };
=20
-const short da830_usb20_pins[] __initdata =3D {
+const short da830_usb20_pins[] __initconst =3D {
 	DA830_USB0_DRVVBUS, DA830_USB_REFCLKIN,
 	-1
 };
=20
-const short da830_usb11_pins[] __initdata =3D {
+const short da830_usb11_pins[] __initconst =3D {
 	DA830_USB_REFCLKIN,
 	-1
 };
=20
-const short da830_uhpi_pins[] __initdata =3D {
+const short da830_uhpi_pins[] __initconst =3D {
 	DA830_UHPI_HD_0, DA830_UHPI_HD_1, DA830_UHPI_HD_2, DA830_UHPI_HD_3,
 	DA830_UHPI_HD_4, DA830_UHPI_HD_5, DA830_UHPI_HD_6, DA830_UHPI_HD_7,
 	DA830_UHPI_HD_8, DA830_UHPI_HD_9, DA830_UHPI_HD_10, DA830_UHPI_HD_11,
@@ -909,14 +909,14 @@ const short da830_uhpi_pins[] __initdata =3D {
 	-1
 };
=20
-const short da830_cpgmac_pins[] __initdata =3D {
+const short da830_cpgmac_pins[] __initconst =3D {
 	DA830_RMII_TXD_0, DA830_RMII_TXD_1, DA830_RMII_TXEN, DA830_RMII_CRS_D=
V,
 	DA830_RMII_RXD_0, DA830_RMII_RXD_1, DA830_RMII_RXER, DA830_MDIO_CLK,
 	DA830_MDIO_D,
 	-1
 };
=20
-const short da830_emif3c_pins[] __initdata =3D {
+const short da830_emif3c_pins[] __initconst =3D {
 	DA830_EMB_SDCKE, DA830_EMB_CLK_GLUE, DA830_EMB_CLK, DA830_NEMB_CS_0,
 	DA830_NEMB_CAS, DA830_NEMB_RAS, DA830_NEMB_WE, DA830_EMB_BA_1,
 	DA830_EMB_BA_0, DA830_EMB_A_0, DA830_EMB_A_1, DA830_EMB_A_2,
@@ -935,7 +935,7 @@ const short da830_emif3c_pins[] __initdata =3D {
 	-1
 };
=20
-const short da830_mcasp0_pins[] __initdata =3D {
+const short da830_mcasp0_pins[] __initconst =3D {
 	DA830_AHCLKX0, DA830_ACLKX0, DA830_AFSX0,
 	DA830_AHCLKR0, DA830_ACLKR0, DA830_AFSR0, DA830_AMUTE0,
 	DA830_AXR0_0, DA830_AXR0_1, DA830_AXR0_2, DA830_AXR0_3,
@@ -945,7 +945,7 @@ const short da830_mcasp0_pins[] __initdata =3D {
 	-1
 };
=20
-const short da830_mcasp1_pins[] __initdata =3D {
+const short da830_mcasp1_pins[] __initconst =3D {
 	DA830_AHCLKX1, DA830_ACLKX1, DA830_AFSX1,
 	DA830_AHCLKR1, DA830_ACLKR1, DA830_AFSR1, DA830_AMUTE1,
 	DA830_AXR1_0, DA830_AXR1_1, DA830_AXR1_2, DA830_AXR1_3,
@@ -954,24 +954,24 @@ const short da830_mcasp1_pins[] __initdata =3D {
 	-1
 };
=20
-const short da830_mcasp2_pins[] __initdata =3D {
+const short da830_mcasp2_pins[] __initconst =3D {
 	DA830_AHCLKX2, DA830_ACLKX2, DA830_AFSX2,
 	DA830_AHCLKR2, DA830_ACLKR2, DA830_AFSR2, DA830_AMUTE2,
 	DA830_AXR2_0, DA830_AXR2_1, DA830_AXR2_2, DA830_AXR2_3,
 	-1
 };
=20
-const short da830_i2c0_pins[] __initdata =3D {
+const short da830_i2c0_pins[] __initconst =3D {
 	DA830_I2C0_SDA, DA830_I2C0_SCL,
 	-1
 };
=20
-const short da830_i2c1_pins[] __initdata =3D {
+const short da830_i2c1_pins[] __initconst =3D {
 	DA830_I2C1_SCL, DA830_I2C1_SDA,
 	-1
 };
=20
-const short da830_lcdcntl_pins[] __initdata =3D {
+const short da830_lcdcntl_pins[] __initconst =3D {
 	DA830_LCD_D_0, DA830_LCD_D_1, DA830_LCD_D_2, DA830_LCD_D_3,
 	DA830_LCD_D_4, DA830_LCD_D_5, DA830_LCD_D_6, DA830_LCD_D_7,
 	DA830_LCD_D_8, DA830_LCD_D_9, DA830_LCD_D_10, DA830_LCD_D_11,
@@ -981,34 +981,34 @@ const short da830_lcdcntl_pins[] __initdata =3D {
 	-1
 };
=20
-const short da830_pwm_pins[] __initdata =3D {
+const short da830_pwm_pins[] __initconst =3D {
 	DA830_ECAP0_APWM0, DA830_ECAP1_APWM1, DA830_EPWM0B, DA830_EPWM0A,
 	DA830_EPWMSYNCI, DA830_EPWMSYNC0, DA830_ECAP2_APWM2, DA830_EHRPWMGLUE=
TZ,
 	DA830_EPWM2B, DA830_EPWM2A, DA830_EPWM1B, DA830_EPWM1A,
 	-1
 };
=20
-const short da830_ecap0_pins[] __initdata =3D {
+const short da830_ecap0_pins[] __initconst =3D {
 	DA830_ECAP0_APWM0,
 	-1
 };
=20
-const short da830_ecap1_pins[] __initdata =3D {
+const short da830_ecap1_pins[] __initconst =3D {
 	DA830_ECAP1_APWM1,
 	-1
 };
=20
-const short da830_ecap2_pins[] __initdata =3D {
+const short da830_ecap2_pins[] __initconst =3D {
 	DA830_ECAP2_APWM2,
 	-1
 };
=20
-const short da830_eqep0_pins[] __initdata =3D {
+const short da830_eqep0_pins[] __initconst =3D {
 	DA830_EQEP0I, DA830_EQEP0S, DA830_EQEP0A, DA830_EQEP0B,
 	-1
 };
=20
-const short da830_eqep1_pins[] __initdata =3D {
+const short da830_eqep1_pins[] __initconst =3D {
 	DA830_EQEP1I, DA830_EQEP1S, DA830_EQEP1A, DA830_EQEP1B,
 	-1
 };
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da85=
0.c
index b44dc84..6676dee 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -576,17 +576,17 @@ static const struct mux_config da850_pins[] =3D {
 #endif
 };
=20
-const short da850_i2c0_pins[] __initdata =3D {
+const short da850_i2c0_pins[] __initconst =3D {
 	DA850_I2C0_SDA, DA850_I2C0_SCL,
 	-1
 };
=20
-const short da850_i2c1_pins[] __initdata =3D {
+const short da850_i2c1_pins[] __initconst =3D {
 	DA850_I2C1_SCL, DA850_I2C1_SDA,
 	-1
 };
=20
-const short da850_lcdcntl_pins[] __initdata =3D {
+const short da850_lcdcntl_pins[] __initconst =3D {
 	DA850_LCD_D_0, DA850_LCD_D_1, DA850_LCD_D_2, DA850_LCD_D_3,
 	DA850_LCD_D_4, DA850_LCD_D_5, DA850_LCD_D_6, DA850_LCD_D_7,
 	DA850_LCD_D_8, DA850_LCD_D_9, DA850_LCD_D_10, DA850_LCD_D_11,
diff --git a/arch/arm/mach-dove/addr-map.c b/arch/arm/mach-dove/addr-ma=
p.c
index 98b8c83b..93ea37d 100644
--- a/arch/arm/mach-dove/addr-map.c
+++ b/arch/arm/mach-dove/addr-map.c
@@ -49,7 +49,7 @@ static struct __initdata orion_addr_map_cfg addr_map_=
cfg =3D {
 	.bridge_virt_base =3D BRIDGE_VIRT_BASE,
 };
=20
-static const struct __initdata orion_addr_map_info addr_map_info[] =3D=
 {
+static const struct orion_addr_map_info addr_map_info[] __initconst =3D=
 {
 	/*
 	 * Windows for PCIe IO+MEM space.
 	 */
diff --git a/arch/arm/mach-kirkwood/addr-map.c b/arch/arm/mach-kirkwood=
/addr-map.c
index e9a7180..b2c0dee 100644
--- a/arch/arm/mach-kirkwood/addr-map.c
+++ b/arch/arm/mach-kirkwood/addr-map.c
@@ -44,7 +44,7 @@ static struct __initdata orion_addr_map_cfg addr_map_=
cfg =3D {
 	.bridge_virt_base =3D BRIDGE_VIRT_BASE,
 };
=20
-static const struct __initdata orion_addr_map_info addr_map_info[] =3D=
 {
+static const struct orion_addr_map_info addr_map_info[] __initconst =3D=
 {
 	/*
 	 * Windows for PCIe IO+MEM space.
 	 */
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/boar=
d-qsd8x50.c
index 7e8909c..11de242 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -39,8 +39,8 @@
=20
 extern struct sys_timer msm_timer;
=20
-static const resource_size_t qsd8x50_surf_smc91x_base __initdata =3D 0=
x70000300;
-static const unsigned        qsd8x50_surf_smc91x_gpio __initdata =3D 1=
56;
+static const resource_size_t qsd8x50_surf_smc91x_base __initconst =3D =
0x70000300;
+static const unsigned        qsd8x50_surf_smc91x_gpio __initconst =3D =
156;
=20
 /* Leave smc91x resources empty here, as we'll fill them in
  * at run-time: they vary from board to board, and the true
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/displa=
y.c
index 9706c64..df2ef11 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -74,14 +74,14 @@ struct omap_dss_hwmod_data {
 	const int id;
 };
=20
-static const struct omap_dss_hwmod_data omap2_dss_hwmod_data[] __initd=
ata =3D {
+static const struct omap_dss_hwmod_data omap2_dss_hwmod_data[] __initc=
onst =3D {
 	{ "dss_core", "omapdss_dss", -1 },
 	{ "dss_dispc", "omapdss_dispc", -1 },
 	{ "dss_rfbi", "omapdss_rfbi", -1 },
 	{ "dss_venc", "omapdss_venc", -1 },
 };
=20
-static const struct omap_dss_hwmod_data omap3_dss_hwmod_data[] __initd=
ata =3D {
+static const struct omap_dss_hwmod_data omap3_dss_hwmod_data[] __initc=
onst =3D {
 	{ "dss_core", "omapdss_dss", -1 },
 	{ "dss_dispc", "omapdss_dispc", -1 },
 	{ "dss_rfbi", "omapdss_rfbi", -1 },
@@ -89,7 +89,7 @@ static const struct omap_dss_hwmod_data omap3_dss_hwm=
od_data[] __initdata =3D {
 	{ "dss_dsi1", "omapdss_dsi", 0 },
 };
=20
-static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initd=
ata =3D {
+static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initc=
onst =3D {
 	{ "dss_core", "omapdss_dss", -1 },
 	{ "dss_dispc", "omapdss_dispc", -1 },
 	{ "dss_rfbi", "omapdss_rfbi", -1 },
diff --git a/arch/arm/mach-orion5x/addr-map.c b/arch/arm/mach-orion5x/a=
ddr-map.c
index 3638e5c..277fcf4 100644
--- a/arch/arm/mach-orion5x/addr-map.c
+++ b/arch/arm/mach-orion5x/addr-map.c
@@ -82,7 +82,7 @@ static struct __initdata orion_addr_map_cfg addr_map_=
cfg =3D {
 	.bridge_virt_base =3D ORION5X_BRIDGE_VIRT_BASE,
 };
=20
-static const struct __initdata orion_addr_map_info addr_map_info[] =3D=
 {
+static const struct orion_addr_map_info addr_map_info[] __initconst =3D=
 {
 	/*
 	 * Setup windows for PCI+PCIe IO+MEM space.
 	 */
--=20
1.7.9.5
