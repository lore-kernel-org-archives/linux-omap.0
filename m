From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 1/2] ARM: OMAP: Add support for OMAP24xx Enhanced Audio
 Controller
Date: Fri, 2 Mar 2007 13:00:01 +0200
Message-ID: <20070302130001.c3edfdd3.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/devices.c |   33 ++
 sound/arm/Kconfig             |   15 +
 sound/arm/omap/Makefile       |    3 +
 sound/arm/omap/eac.c          |  795 +++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 846 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index b603bc5..767140c 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -23,6 +23,7 @@
 #include <asm/arch/board.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
+#include <asm/arch/eac.h>
=20
 #if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
=20
@@ -201,6 +202,38 @@ static void omap_init_mcspi(void)
 static inline void omap_init_mcspi(void) {}
 #endif
=20
+#ifdef CONFIG_SND_OMAP24XX_EAC
+
+#define OMAP2_EAC_BASE			0x48090000
+
+static struct resource omap2_eac_resources[] =3D {
+	{
+		.start		=3D OMAP2_EAC_BASE,
+		.end		=3D OMAP2_EAC_BASE + 0x109,
+		.flags		=3D IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap2_eac_device =3D {
+	.name		=3D "omap24xx-eac",
+	.id		=3D -1,
+	.num_resources	=3D ARRAY_SIZE(omap2_eac_resources),
+	.resource	=3D omap2_eac_resources,
+	.dev =3D {
+		.platform_data =3D NULL,
+	},
+};
+
+void omap_init_eac(struct eac_platform_data *pdata)
+{
+	omap2_eac_device.dev.platform_data =3D pdata;
+	platform_device_register(&omap2_eac_device);
+}
+
+#else
+void omap_init_eac(struct eac_platform_data *pdata) {}
+#endif
+
 /*------------------------------------------------------------------------=
-*/
=20
 static int __init omap2_init_devices(void)
diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 4dc323f..e4cf1e0 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -86,4 +86,19 @@ config SND_OMAP_TSC2102
  	  To compile this driver as a module, choose M here: the module
  	  will be called snd-omap-tsc2102.
=20
+config SND_OMAP24XX_EAC
+	tristate "Audio driver for OMAP24xx EAC"
+	depends on SND
+	help
+	  Audio driver for Enhanced Audio Controller found in TI's OMAP24xx
+	  processors.
+
+	  Currently contains only low-level support functions for
+	  initializing EAC HW, creating ALSA sound card instance for it
+	  and registering mixer controls implemented by a codec driver.
+	  PCM stream is expected to be under DSP co-processor control.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-omap24xx-eac.
+
 endmenu
diff --git a/sound/arm/omap/Makefile b/sound/arm/omap/Makefile
index c6bebac..2f004d7 100644
--- a/sound/arm/omap/Makefile
+++ b/sound/arm/omap/Makefile
@@ -13,3 +13,6 @@ snd-omap-alsa-tsc2102-objs :=3D omap-alsa.o omap-alsa-dma=
.o omap-alsa-tsc2102.o om
=20
 obj-$(CONFIG_SND_SX1) +=3D snd-omap-alsa-sx1.o
 snd-omap-alsa-sx1-objs :=3D omap-alsa.o omap-alsa-dma.o omap-alsa-sx1.o om=
ap-alsa-sx1-mixer.o
+
+obj-$(CONFIG_SND_OMAP24XX_EAC) +=3D snd-omap24xx-eac.o
+snd-omap24xx-eac-objs :=3D eac.o
diff --git a/sound/arm/omap/eac.c b/sound/arm/omap/eac.c
new file mode 100644
index 0000000..629b113
--- /dev/null
+++ b/sound/arm/omap/eac.c
@@ -0,0 +1,795 @@
+/*
+ * linux/sound/arm/omap/omap-alsa-eac.c
+ *
+ * OMAP24xx Enhanced Audio Controller sound driver
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ *
+ * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
+ *          Juha Yrj=F6l=E4
+ *
+ * Definitions:
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#define DEBUG
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <asm/io.h>
+#include <asm/arch/eac.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+
+
+#define EAC_CPCFR1		0x0000
+#define EAC_CPCFR2		0x0004
+#define EAC_CPCFR3		0x0008
+#define EAC_CPCFR4		0x000C
+#define EAC_CPTCTL		0x0010
+#define EAC_CPTTADR		0x0014
+#define EAC_CPTDATL		0x0018
+#define EAC_CPTDATH		0x001C
+#define EAC_CPTVSLL		0x0020
+#define EAC_CPTVSLH		0x0024
+#define EAC_MPCTR		0x0040
+#define EAC_MPMCCFR		0x0044
+#define EAC_BPCTR		0x0060
+#define EAC_BPMCCFR		0x0064
+#define EAC_AMSCFR		0x0080
+#define EAC_AMVCTR		0x0084
+#define EAC_AM1VCTR		0x0088
+#define EAC_AM2VCTR		0x008C
+#define EAC_AM3VCTR		0x0090
+#define EAC_ASTCTR		0x0094
+#define EAC_APD1LCR		0x0098
+#define EAC_APD1RCR		0x009C
+#define EAC_APD2LCR		0x00A0
+#define EAC_APD2RCR		0x00A4
+#define EAC_APD3LCR		0x00A8
+#define EAC_APD3RCR		0x00AC
+#define EAC_APD4R		0x00B0
+#define EAC_ADWR		0x00B4
+#define EAC_ADRDR		0x00B8
+#define EAC_AGCFR		0x00BC
+#define EAC_AGCTR		0x00C0
+#define EAC_AGCFR2		0x00C4
+#define EAC_AGCFR3		0x00C8
+#define EAC_MBPDMACTR		0x00CC
+#define EAC_MPDDMARR		0x00D0
+#define EAC_MPDDMAWR		0x00D4
+#define EAC_MPUDMARR		0x00D8
+#define EAC_MPUDMAWR		0x00E0
+#define EAC_BPDDMARR		0x00E4
+#define EAC_BPDDMAWR		0x00E8
+#define EAC_BPUDMARR		0x00EC
+#define EAC_BPUDMAWR		0x00F0
+#define EAC_VERSION		0x0100
+#define EAC_SYSCONFIG		0x0104
+#define EAC_SYSSTATUS		0x0108
+
+/* CPTCTL */
+#define CPTCTL_RXF		(1 << 7)
+#define CPTCTL_RXIE		(1 << 6)
+#define CPTCTL_TXE		(1 << 5)
+#define CPTCTL_TXIE		(1 << 4)
+#define CPTCTL_CPEN		(1 << 3)
+#define CPTCTL_CRST		(1 << 0)
+
+/* CPCFR1 */
+#define CPCFR1_MTSL(val)	((val & 0x1f) << 3)
+#define CPCFR1_MTSL_BITS	(0x1f << 3)
+#define CPCFR1_MODE(val)	((val & 0x7) << 0)
+#define CPCFR1_MODE_BITS	(0x7 << 0)
+
+/* CPCFR2 */
+#define CPCFR2_TSLOL(val)	((val & 0x3) << 6)
+#define CPCFR2_TSLOL_BITS	(0x3 << 6)
+#define CPCFR2_BPTSL(val)	((val & 0x7) << 3)
+#define CPCFR2_BPTSL_BITS	(0x7 << 3)
+#define CPCFR2_TSLL(val)	((val & 0x7) << 0)
+#define CPCFR2_TSLL_BITS	(0x7 << 0)
+
+/* CPCFR3 */
+#define CPCFR3_DDLY		(1 << 7)
+#define CPCFR3_TRSEN		(1 << 6)
+#define CPCFR3_CLKBP		(1 << 5)
+#define CPCFR3_CSYNCP		(1 << 4)
+#define CPCFR3_CSYNCL		(1 << 3)
+/* bit 2 reserved */
+#define CPCFR3_CSCLKD		(1 << 1)
+#define CPCFR3_CSYNCD		(1 << 0)
+
+/* CPCFR4 */
+#define CPCFR4_ATSL(val)	((val & 0xf) << 4)
+#define CPCFR4_ATSL_BITS	(0xf << 4)
+#define CPCFR4_CLKS		(1 << 3)
+#define CPCFR4_DIVB(val)	((val & 0x7) << 0)
+#define CPCFR4_DIVB_BITS	(0x7 << 0)
+
+/* AGCFR */
+#define AGCFR_MN_ST		(1 << 10)
+#define AGCFR_B8_16		(1 << 9)
+#define AGCFR_LI_BI		(1 << 8)
+#define AGCFR_FSINT(val)	((val & 0x3) << 6)
+#define AGCFR_FINST_BITS	(0x3 << 6)
+
+#define AGCFR_FSINT_8000	(0)
+#define AGCFR_FSINT_11025	(1)
+#define AGCFR_FSINT_22050	(2)
+#define AGCFR_FSINT_44100	(3)
+
+#define AGCFR_AUD_CKSRC(val)((val & 0x3) << 4)
+#define AGCFR_AUD_CKSRC_BITS	(0x3 << 4)
+#define AGCFR_M_CKSRC		(1 << 3)
+#define AGCFR_MCLK_OUT		(1 << 1)
+#define AGCFR_MCLK		(1 << 0)
+
+
+/* AGCTR */
+#define AGCTR_AUDRD		(1 << 15)
+#define AGCTR_AUDRDI		(1 << 14)
+#define AGCTR_AUDRDIEN		(1 << 13)
+#define AGCTR_DMAREN		(1 << 12)
+#define AGCTR_DMAWEN		(1 << 11)
+/* bits 10:4 reserved */
+#define AGCTR_MCLK_EN		(1 << 3)
+#define AGCTR_OSCMCLK_EN	(1 << 2)
+#define AGCTR_AUDEN		(1 << 1)
+#define AGCTR_EACPWD		(1 << 0)
+
+/* AGCFR2 */
+#define AGCFR2_BT_MD_WIDEBAND	(1 << 5)
+#define AGCFR2_MCLK_I2S_N11M_12M (1 << 4)
+#define AGCFR2_I2S_N44K_48K	(1 << 3)
+#define AGCFR2_FSINT2(val)	((val & 0x7) << 0)
+#define AGCFR2_FSINT2_BITS	(0x7 << 0)
+
+#define AGCFR2_FSINT2_8000	(0)
+#define AGCFR2_FSINT2_11025	(1)
+#define AGCFR2_FSINT2_22050	(2)
+#define AGCFR2_FSINT2_44100	(3)
+#define AGCFR2_FSINT2_48000	(4)
+#define AGCFR2_FSINT2_FSINT	(7)
+
+
+/* AGCFR3 */
+#define AGCFR3_CP_TR_DMA	(1 << 15)
+#define AGCFR3_BT_TR_DMA	(1 << 14)
+#define AGCFR3_MD_TR_DMA	(1 << 13)
+#define AGCFR3_FSINT(val)	((val & 0xf) << 9)
+#define AGCFR3_FSINT_BITS	(0xf << 9)
+
+#define AGCFR3_FSINT_8000	(0)
+#define AGCFR3_FSINT_11025	(1)
+#define AGCFR3_FSINT_16000	(2)
+#define AGCFR3_FSINT_22050	(3)
+#define AGCFR3_FSINT_24000	(4)
+#define AGCFR3_FSINT_32000	(5)
+#define AGCFR3_FSINT_44100	(6)
+#define AGCFR3_FSINT_48000	(7)
+#define AGCFR3_FSINT_FSINT	(15)
+
+
+#define AGCFR3_BT_CKSRC(val)	((val & 0x3) << 7)
+#define AGCFR3_BT_CKSRC_BITS	(0x3 << 7)
+#define AGCFR3_MD_CKSRC(val)	((val & 0x3) << 5)
+#define AGCFR3_MD_CKSRC_BITS	(0x3 << 5)
+#define AGCFR3_AUD_CKSRC(val)	((val & 0x7) << 2)
+#define AGCFR3_AUD_CKSRC_BITS	(0x7 << 2)
+#define AGCFR3_CLK12MINT_SEL	(1 << 1)
+#define AGCFR3_MCLKINT_SEL	(1 << 0)
+
+/* AMSCFR */
+#define AMSCFR_K12		(1 << 11)
+#define AMSCFR_K11		(1 << 10)
+#define AMSCFR_K10		(1 << 9)
+#define AMSCFR_K9		(1 << 8)
+#define AMSCFR_K8		(1 << 7)
+#define AMSCFR_K7		(1 << 6)
+#define AMSCFR_K6		(1 << 5)
+#define AMSCFR_K5		(1 << 4)
+#define AMSCFR_K4		(1 << 3)
+#define AMSCFR_K3		(1 << 2)
+#define AMSCFR_K2		(1 << 1)
+#define AMSCFR_K1		(1 << 0)
+
+/* AMVCTR */
+#define AMVCTR_GWO_BITS		(0xff << 8)
+#define AMVCTR_GWO(val)		((val & 0xff) << 8)
+#define AMVCTR_GRO_BITS		(0xff << 0)
+#define AMVCTR_GRO(val)		((val & 0xff) << 0)
+
+/* AM1VCTR */
+#define AM1VCTR_MUTE		(1 << 15)
+#define AM1VCTR_GINB(val)	((val & 0x7f) << 8)
+#define AM1VCTR_GINB_BITS	(0x7f << 8)
+#define AM1VCTR_GINA(val)	((val & 0x7f) << 0)
+#define AM1VCTR_GINA_BITS	(0x7f << 0)
+
+/* AM2VCTR */
+#define AM2VCTR_MUTE		(1 << 15)
+#define AM2VCTR_GINB(val)	((val & 0x7f) << 8)
+#define AM2VCTR_GINB_BITS	(0x7f << 8)
+#define AM2VCTR_GINA(val)	((val & 0x7f) << 0)
+#define AM2VCTR_GINA_BITS	(0x7f << 0)
+
+/* AM3VCTR */
+#define AM3VCTR_MUTE		(1 << 15)
+#define AM3VCTR_GINB(val)	((val & 0x7f) << 8)
+#define AM3VCTR_GINB_BITS	(0x7f << 8)
+#define AM3VCTR_GINA(val)	((val & 0x7f) << 0)
+#define AM3VCTR_GINA_BITS	(0x7f << 0)
+
+/* ASTCTR */
+#define ASTCTR_ATT(val)		((val & 0x7f) << 1)
+#define ASTCTR_ATT_BITS		(0x7f << 1)
+#define ASTCTR_ATTEN		(1 << 0)
+
+
+/* internal structure of the EAC driver */
+struct omap_eac {
+	struct mutex			mutex;
+	void __iomem *			base;
+	struct platform_device *	pdev;
+	struct eac_platform_data *	pdata;
+	struct snd_card *		card;
+	struct clk *			fck;
+	struct clk *			ick;
+	struct eac_codec *		codec;
+
+	unsigned			clocks_enabled:1;
+};
+
+static char *id =3D SNDRV_DEFAULT_STR1;
+module_param(id, charp, 0444);
+MODULE_PARM_DESC(id, "ID string for OMAP24xx EAC");
+
+
+#define MOD_REG_BIT(val, mask, set) do { \
+	if (set) \
+		val |=3D mask; \
+	else \
+		val &=3D ~mask; \
+} while(0)
+
+static inline void eac_write_reg(struct omap_eac *eac, int idx, u16 val)
+{
+	__raw_writew(val, eac->base + idx);
+}
+
+static inline u16 eac_read_reg(struct omap_eac *eac, int idx)
+{
+	return __raw_readw(eac->base + idx);
+}
+
+static int eac_get_clocks(struct omap_eac *eac)
+{
+	eac->ick =3D clk_get(NULL, "eac_ick");
+	if (IS_ERR(eac->ick)) {
+		dev_err(&eac->pdev->dev, "Could not get eac_ick");
+		return -ENODEV;
+	}
+
+	eac->fck =3D clk_get(NULL, "eac_fck");
+	if (IS_ERR(eac->fck)) {
+		dev_err(&eac->pdev->dev, "Could not get eac_fck");
+		clk_put(eac->ick);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void eac_put_clocks(struct omap_eac *eac)
+{
+	clk_put(eac->fck);
+	clk_put(eac->ick);
+}
+
+static int eac_enable_clocks(struct omap_eac *eac)
+{
+	int err =3D 0;
+
+	if (eac->clocks_enabled)
+		return 0;
+
+	if (eac->pdata !=3D NULL && eac->pdata->enable_ext_clocks !=3D NULL) {
+		if ((err =3D eac->pdata->enable_ext_clocks(&eac->pdev->dev)) !=3D 0)
+			return err;
+	}
+	clk_enable(eac->ick);
+	clk_enable(eac->fck);
+	eac->clocks_enabled =3D 1;
+
+	return 0;
+}
+
+static void eac_disable_clocks(struct omap_eac *eac)
+{
+	if (!eac->clocks_enabled)
+		return;
+	eac->clocks_enabled =3D 0;
+
+	clk_disable(eac->fck);
+	clk_disable(eac->ick);
+	if (eac->pdata !=3D NULL && eac->pdata->disable_ext_clocks !=3D NULL)
+		eac->pdata->disable_ext_clocks(&eac->pdev->dev);
+}
+
+static int eac_reset(struct omap_eac *eac)
+{
+	int i;
+
+	/* step 1 (see TRM) */
+	/* first, let's reset the EAC */
+	eac_write_reg(eac, EAC_SYSCONFIG, 0x2);
+	/* step 2 (see TRM) */
+	eac_write_reg(eac, EAC_AGCTR, AGCTR_MCLK_EN | AGCTR_AUDEN);
+	/* step 3 (see TRM) */
+	/* wait until reset done */
+	i =3D 10000;
+	while (!(eac_read_reg(eac, EAC_SYSSTATUS) & 1)) {
+		if (--i =3D=3D 0)
+			return -ENODEV;
+		udelay(1);
+	}
+
+	return 0;
+}
+
+static int eac_calc_agcfr3_fsint(int rate)
+{
+	int fsint;
+
+	if (rate >=3D 48000)
+		fsint =3D AGCFR3_FSINT_48000;
+	else if (rate >=3D 44100)
+		fsint =3D AGCFR3_FSINT_44100;
+	else if (rate >=3D 32000)
+		fsint =3D AGCFR3_FSINT_32000;
+	else if (rate >=3D 24000)
+		fsint =3D AGCFR3_FSINT_24000;
+	else if (rate >=3D 22050)
+		fsint =3D AGCFR3_FSINT_22050;
+	else if (rate >=3D 16000)
+		fsint =3D AGCFR3_FSINT_16000;
+	else if (rate >=3D 11025)
+		fsint =3D AGCFR3_FSINT_11025;
+	else
+		fsint =3D AGCFR3_FSINT_8000;
+
+	return fsint;
+}
+
+static int eac_configure_pcm(struct omap_eac *eac, struct eac_codec *conf)
+{
+	dev_err(&eac->pdev->dev,
+		"EAC codec port configuration for PCM not implemented\n");
+
+	return -ENODEV;
+}
+
+static int eac_configure_ac97(struct omap_eac *eac, struct eac_codec *conf)
+{
+	dev_err(&eac->pdev->dev,
+		"EAC codec port configuration for AC97 not implemented\n");
+
+	return -ENODEV;
+}
+
+static int eac_configure_i2s(struct omap_eac *eac, struct eac_codec *conf)
+{
+	u16 cpcfr1, cpcfr2, cpcfr3, cpcfr4;
+
+	cpcfr1 =3D eac_read_reg(eac, EAC_CPCFR1);
+	cpcfr2 =3D eac_read_reg(eac, EAC_CPCFR2);
+	cpcfr3 =3D eac_read_reg(eac, EAC_CPCFR3);
+	cpcfr4 =3D eac_read_reg(eac, EAC_CPCFR4);
+
+	cpcfr1 &=3D ~(CPCFR1_MODE_BITS | CPCFR1_MTSL_BITS);
+	cpcfr1 |=3D CPCFR1_MTSL(1); /* 2 timeslots per frame (I2S default) */
+
+	/* audio time slot configuration for I2S mode */
+	cpcfr2 &=3D ~(CPCFR2_TSLL_BITS | CPCFR2_BPTSL_BITS | CPCFR2_TSLOL_BITS);
+	cpcfr2 |=3D CPCFR2_TSLOL(0); /* time slot 0 length same as TSLL */
+	cpcfr2 |=3D CPCFR2_BPTSL(1); /* 16 data bits per time slot */
+	cpcfr2 |=3D CPCFR2_TSLL(1); /* time slot length 16 serial clock cycles */
+
+	/* I2S link configuration */
+	MOD_REG_BIT(cpcfr3, CPCFR3_DDLY,
+		conf->codec_conf.i2s.sync_delay_enable); /* 0/1 clk delay */
+	/* data serial output enabled during nonvalid audio frames, clock
+	 * polarity =3D falling edge, CSYNC lenght equal to time slot0 length */
+	MOD_REG_BIT(cpcfr3, CPCFR3_TRSEN, 1);
+	MOD_REG_BIT(cpcfr3, CPCFR3_CLKBP, 1);
+	MOD_REG_BIT(cpcfr3, CPCFR3_CSYNCL, 1);
+
+	cpcfr4 &=3D ~(CPCFR4_DIVB_BITS | CPCFR4_ATSL_BITS);
+	cpcfr4 |=3D CPCFR4_DIVB(7); /* CP_SCLK =3D MCLK / 8 */
+
+	/* configuration for normal I2S or polarity-changed I2S */
+	if (!conf->codec_conf.i2s.polarity_changed_mode) {
+		/* I2S */
+		cpcfr1 |=3D CPCFR1_MODE(4); /* I2S mode */
+		MOD_REG_BIT(cpcfr3, CPCFR3_CSCLKD, 0); /* CP_SCLK output */
+		MOD_REG_BIT(cpcfr3, CPCFR3_CSYNCD, 0); /* CP_SYNC output */
+		MOD_REG_BIT(cpcfr3, CPCFR3_CSYNCP, 0); /* CP_SYNC active low */
+		/* audio time slots configuration for I2S */
+		cpcfr4 |=3D CPCFR4_ATSL(0);
+	} else {
+		/* polarity changed I2S mode */
+		cpcfr1 |=3D CPCFR1_MODE(1); /* polarity changed I2S mode */
+		MOD_REG_BIT(cpcfr3, CPCFR3_CSCLKD, 1); /* CP_SCLK input */
+		MOD_REG_BIT(cpcfr3, CPCFR3_CSYNCD, 1); /* CP_SYNC input */
+		MOD_REG_BIT(cpcfr3, CPCFR3_CSYNCP, 1); /* CP_SYNC active
+							  high */
+		/* audio time slots configuration for polarity-changed I2S */
+		cpcfr4 |=3D CPCFR4_ATSL(0xf);
+	};
+
+	eac_write_reg(eac, EAC_CPCFR1, cpcfr1);
+	eac_write_reg(eac, EAC_CPCFR2, cpcfr2);
+	eac_write_reg(eac, EAC_CPCFR3, cpcfr3);
+	eac_write_reg(eac, EAC_CPCFR4, cpcfr4);
+
+	return 0;
+}
+
+static int eac_codec_port_init(struct omap_eac *eac, struct eac_codec *con=
f)
+{
+	u16 agcfr, agcfr2, agcfr3, agctr;
+	u16 cpctl, reg;
+	int err =3D 0, i;
+
+	/* use internal MCLK gating before doing full configuration for it.
+	 * Partial or misconfigured MCLK will cause that access to some of the
+	 * EAC registers causes "external abort on linefetch". Same happens
+	 * also when using external clock as a MCLK source and if that clock is
+	 * either missing or not having a right rate (e.g. half of it) */
+	agcfr3 =3D eac_read_reg(eac, EAC_AGCFR3);
+	MOD_REG_BIT(agcfr3, AGCFR3_MCLKINT_SEL, 1); /* 96 Mhz / 8.5 */
+	eac_write_reg(eac, EAC_AGCFR3, agcfr3);
+
+	/* disable codec port, enable access to config registers */
+	cpctl =3D eac_read_reg(eac, EAC_CPTCTL);
+	MOD_REG_BIT(cpctl, CPTCTL_CPEN, 0);
+	eac_write_reg(eac, EAC_CPTCTL, cpctl);
+
+	agcfr =3D eac_read_reg(eac, EAC_AGCFR);
+	agctr =3D eac_read_reg(eac, EAC_AGCTR);
+	agcfr2 =3D eac_read_reg(eac, EAC_AGCFR2);
+
+	/* MCLK source and frequency configuration */
+	MOD_REG_BIT(agcfr, AGCFR_MCLK, 0);
+	switch (conf->mclk_src) {
+	case EAC_MCLK_EXT_2x11289600:
+		MOD_REG_BIT(agcfr, AGCFR_MCLK, 1); /* div by 2 path */
+		MOD_REG_BIT(agcfr, AGCFR_MCLK_OUT, 1); /* div by 2 */
+	case EAC_MCLK_EXT_11289600:
+		MOD_REG_BIT(agcfr, AGCFR_MCLK, 1);
+		MOD_REG_BIT(agcfr2, AGCFR2_I2S_N44K_48K, 0); /* 44.1 kHz */
+		MOD_REG_BIT(agcfr2, AGCFR2_MCLK_I2S_N11M_12M, 0); /* 11.2896 */
+		MOD_REG_BIT(agcfr3, AGCFR3_MCLKINT_SEL, 0);
+		break;
+
+	case EAC_MCLK_EXT_2x12288000:
+		MOD_REG_BIT(agcfr, AGCFR_MCLK, 1); /* div by 2 path */
+		MOD_REG_BIT(agcfr, AGCFR_MCLK_OUT, 1); /* div by 2 */
+	case EAC_MCLK_EXT_12288000:
+		MOD_REG_BIT(agcfr2, AGCFR2_I2S_N44K_48K, 1); /* 48 kHz */
+		MOD_REG_BIT(agcfr2, AGCFR2_MCLK_I2S_N11M_12M, 1); /* 12.288 */
+		MOD_REG_BIT(agcfr3, AGCFR3_MCLKINT_SEL, 0);
+		break;
+
+	default:
+		/* internal MCLK gating */
+		break;
+	}
+	MOD_REG_BIT(agctr, AGCTR_MCLK_EN, 1);
+	MOD_REG_BIT(agctr, AGCTR_OSCMCLK_EN, 1); /* oscillator enabled? */
+	/* use MCLK just configured above as audio & codec port clock source */
+	agcfr3 &=3D ~AGCFR3_AUD_CKSRC_BITS;
+	agcfr3 |=3D AGCFR3_AUD_CKSRC(0);
+
+	/* audio data format */
+	MOD_REG_BIT(agcfr, AGCFR_MN_ST, 1);	/* stereo file */
+	MOD_REG_BIT(agcfr, AGCFR_B8_16, 1);	/* 16 bit audio file */
+	MOD_REG_BIT(agcfr, AGCFR_LI_BI, 0);	/* little endian stream */
+
+	/* there are FSINT configuration bits in AGCFR, AGCFR2 and AGCFR3
+	 * registers but it seems that it is just enough to set in AGCFR3
+	 * only */
+	agcfr3 &=3D ~AGCFR3_FSINT_BITS;
+	agcfr3 |=3D AGCFR3_FSINT(eac_calc_agcfr3_fsint(conf->default_rate));
+
+	/* transparent DMA enable/disable bits
+	 * TODO: Are these needed? */
+	MOD_REG_BIT(agcfr3, AGCFR3_MD_TR_DMA, 1); /* modem */
+	MOD_REG_BIT(agcfr3, AGCFR3_BT_TR_DMA, 1); /* BT */
+	MOD_REG_BIT(agcfr3, AGCFR3_CP_TR_DMA, 0); /* codec port */
+
+	/* step 4 (see TRM) */
+	eac_write_reg(eac, EAC_AGCFR3, agcfr3);
+	/* pre-write AGCTR now (finally in step 10) in order to get MCLK
+	 * settings effective (especially when using external MCLK) */
+	eac_write_reg(eac, EAC_AGCTR, agctr);
+	eac_write_reg(eac, EAC_AGCFR2, agcfr2);
+
+	/* step 5 (see TRM) */
+	eac_write_reg(eac, EAC_AGCFR, agcfr);
+
+	/* step 6 (see TRM) */
+	/* wait until audio reset done */
+	i =3D 10000;
+	while (!(eac_read_reg(eac, EAC_SYSSTATUS) & (1 << 3))) {
+		if (--i =3D=3D 0)
+			return -ETIMEDOUT;
+		udelay(1);
+	}
+
+	/* step 7 (see TRM) */
+	reg =3D eac_read_reg(eac, EAC_AMSCFR);
+	MOD_REG_BIT(reg, AMSCFR_K1, 1);		/* K1 switch closed */
+	MOD_REG_BIT(reg, AMSCFR_K5, 1);		/* K5 switch closed */
+	MOD_REG_BIT(reg, AMSCFR_K2, 0);		/* K2 switch open */
+	MOD_REG_BIT(reg, AMSCFR_K6, 0);		/* K6 switch open */
+	eac_write_reg(eac, EAC_AMSCFR, reg);
+
+	/* step 8 (see TRM) */
+	switch (conf->codec_mode) {
+	case EAC_CODEC_PCM:
+		err =3D eac_configure_pcm(eac, conf);
+		break;
+	case EAC_CODEC_AC97:
+		err =3D eac_configure_ac97(eac, conf);
+		break;
+	default:
+		err =3D eac_configure_i2s(eac, conf);
+		break;
+	}
+
+	/* step 9 (see TRM) */
+	MOD_REG_BIT(cpctl, CPTCTL_CPEN, 1);	/* codec port enable */
+	MOD_REG_BIT(cpctl, CPTCTL_RXIE, 1);	/* receive int enable */
+	MOD_REG_BIT(cpctl, CPTCTL_TXIE, 1);	/* transmit int enable */
+	eac_write_reg(eac, EAC_CPTCTL, cpctl);
+
+	/* step 10 (see TRM) */
+	/* enable playing & recording */
+	MOD_REG_BIT(agctr, AGCTR_DMAREN, 1);	/* playing enabled (DMA R) */
+	MOD_REG_BIT(agctr, AGCTR_DMAWEN, 1);	/* recording enabled (DMA W) */
+	MOD_REG_BIT(agctr, AGCTR_AUDEN, 1);	/* audio processing enabled */
+	eac_write_reg(eac, EAC_AGCTR, agctr);
+
+	/* audio mixer1, no mute on mixer output, gain =3D 0 dB */
+	reg =3D eac_read_reg(eac, EAC_AM1VCTR);
+	MOD_REG_BIT(reg, AM1VCTR_MUTE, 0);
+	reg =3D ((reg & ~AM1VCTR_GINB_BITS) | (AM1VCTR_GINB(0x67)));
+	eac_write_reg(eac, EAC_AM1VCTR, reg);
+
+	/* audio mixer3, no mute on mixer output, gain =3D 0 dB */
+	reg =3D eac_read_reg(eac, EAC_AM3VCTR);
+	MOD_REG_BIT(reg, AM3VCTR_MUTE, 0);
+	reg =3D ((reg & ~AM3VCTR_GINB_BITS) | (AM3VCTR_GINB(0x67)));
+	eac_write_reg(eac, EAC_AM3VCTR, reg);
+
+	/* audio side tone disabled */
+	eac_write_reg(eac, EAC_ASTCTR, 0x0);
+
+	return 0;
+}
+
+int eac_set_mode(struct device *dev, int play, int rec)
+{
+	struct omap_eac *eac =3D dev_get_drvdata(dev);
+
+#ifdef DEBUG
+	printk(KERN_DEBUG "EAC mode: play %s, rec %s\n",
+	       play ? "enabled" : "disabled",
+	       rec  ? "enabled" : "disabled");
+#endif
+	BUG_ON(eac =3D=3D NULL);
+	mutex_lock(&eac->mutex);
+	if (play || rec) {
+		/* activate clocks */
+		eac_enable_clocks(eac);
+
+		/* power-up codec */
+		if (eac->codec !=3D NULL && eac->codec->set_power !=3D NULL)
+			eac->codec->set_power(eac->codec->private_data,
+ 				play, rec);
+ 	} else {
+		/* shutdown codec */
+		if (eac->codec !=3D NULL && eac->codec->set_power !=3D NULL)
+			eac->codec->set_power(eac->codec->private_data, 0, 0);
+
+		/* de-activate clocks */
+		eac_disable_clocks(eac);
+	}
+	mutex_unlock(&eac->mutex);
+
+	return 0;
+}
+
+int eac_register_codec(struct device *dev, struct eac_codec *codec)
+{
+	struct omap_eac *eac =3D dev_get_drvdata(dev);
+	struct snd_card *card =3D eac->card;
+	int err;
+
+	BUG_ON(eac->codec !=3D NULL);
+
+	mutex_lock(&eac->mutex);
+	eac->codec =3D codec;
+	eac_enable_clocks(eac);
+	err =3D eac_codec_port_init(eac, codec);
+	eac_disable_clocks(eac);
+	mutex_unlock(&eac->mutex);
+	if (err)
+		return err;
+
+	/* register mixer controls implemented by a codec driver */
+	if (codec->register_controls !=3D NULL) {
+		err =3D codec->register_controls(codec->private_data, card);
+		if (err)
+			return err;
+	}
+
+	if (codec->short_name !=3D NULL) {
+		sprintf(card->longname, "%s with codec %s", card->shortname,
+			codec->short_name);
+		strcpy(card->mixername, codec->short_name);
+	}
+
+	err =3D snd_card_register(card);
+	return err;
+}
+
+void eac_unregister_codec(struct device *dev)
+{
+	struct omap_eac *eac =3D dev_get_drvdata(dev);
+
+	BUG_ON(eac->codec =3D=3D NULL);
+	eac_set_mode(dev, 0, 0);
+	snd_card_disconnect(eac->card);
+	eac->codec =3D NULL;
+}
+
+static int __devinit eac_probe(struct platform_device *pdev)
+{
+	struct eac_platform_data *pdata =3D pdev->dev.platform_data;
+	struct snd_card *card;
+	struct omap_eac *eac;
+	struct resource *res;
+	int err;
+
+	eac =3D kzalloc(sizeof(*eac), GFP_KERNEL);
+	if (!eac)
+		return -ENOMEM;
+
+	mutex_init(&eac->mutex);
+	eac->pdev =3D pdev;
+	platform_set_drvdata(pdev, eac);
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res =3D=3D NULL) {
+		err =3D -ENODEV;
+		goto err1;
+	}
+	eac->base =3D (void __iomem *)io_p2v(res->start);
+	eac->pdata =3D pdata;
+
+	/* pre-initialize EAC hw */
+	err =3D eac_get_clocks(eac);
+	if (err)
+		goto err1;
+	err =3D eac_enable_clocks(eac);
+	if (err)
+		goto err2;
+
+	err =3D eac_reset(eac);
+	if (err)
+		goto err3;
+
+	dev_info(&pdev->dev, "EAC version: %d.%d\n",
+		 eac_read_reg(eac, EAC_VERSION) >> 4,
+		 eac_read_reg(eac, EAC_VERSION) & 0x0f);
+	eac_disable_clocks(eac);
+
+	/* create soundcard instance */
+	card =3D snd_card_new(-1, id, THIS_MODULE, 0);
+	if (card =3D=3D NULL) {
+		err =3D -ENOMEM;
+		goto err3;
+	}
+	eac->card =3D card;
+	strcpy(card->driver, "EAC");
+	strcpy(card->shortname, "OMAP24xx EAC");
+
+	sprintf(card->longname, "%s", card->shortname);
+	strcpy(card->mixername, "EAC Mixer");
+
+	if (eac->pdata->init) {
+		err =3D eac->pdata->init(&pdev->dev);
+		if (err < 0) {
+			printk("init %d\n", err);
+			goto err4;
+		}
+	}
+
+	return 0;
+
+err4:
+	snd_card_free(card);
+err3:
+	eac_disable_clocks(eac);
+err2:
+	eac_put_clocks(eac);
+err1:
+	kfree(eac);
+	return err;
+}
+
+static int __devexit eac_remove(struct platform_device *pdev)
+{
+	struct omap_eac *eac =3D platform_get_drvdata(pdev);
+	struct snd_card *card =3D eac->card;
+
+	snd_card_free(card);
+
+	eac_disable_clocks(eac);
+	eac_put_clocks(eac);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver eac_driver =3D {
+	.driver =3D {
+		.name		=3D "omap24xx-eac",
+		.bus		=3D &platform_bus_type,
+	},
+	.probe		=3D eac_probe,
+	.remove		=3D eac_remove,
+};
+
+int __init eac_init(void)
+{
+	return platform_driver_register(&eac_driver);
+}
+
+void __exit eac_exit(void)
+{
+	platform_driver_unregister(&eac_driver);
+}
+
+module_init(eac_init);
+module_exit(eac_exit);
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
+MODULE_LICENSE("GPL");
--=20
1.4.4.4
