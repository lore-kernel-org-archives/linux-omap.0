From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH / RFC] Resubmitting : Basic OMAP2430 High speed I2C & Speed
	handling
Date: Mon, 23 Apr 2007 19:51:28 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47BC80EA@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Resubmitting after incorporating review comments

This patch moves I2C speed parameter (from module) to platform data.
Also added basic High Speed support based on I2C bus speed.=20

This patch is tested for high speed I2C (with TWL4030 Keypad) and works =
as
expected.

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 drivers/i2c/busses/i2c-omap.c
 arch/arm/mach-omap2/clock.h
 arch/arm/mach-omap2/devices.c
 arch/arm/plat-omap/devices.c=20
 arch/arm/mach-omap2/board-2430sdp.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
--- linux-omap/arch/arm/mach-omap2/board-2430sdp.c	2007-03-02 =
17:12:25.000000000 -0600
+++ lin_for_hsi2c/arch/arm/mach-omap2/board-2430sdp.c	2007-04-23 =
18:54:23.000000000 -0500
@@ -192,6 +192,78 @@ static struct omap_board_config_kernel s
 	{OMAP_TAG_UART, &sdp2430_uart_config},
 };
=20
+#if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
+
+#define OMAP2_I2C_BASE1		0x48070000
+#define OMAP2_I2C_BASE2		0x48072000
+#define OMAP2_I2C_INT1		56
+#define OMAP2_I2C_INT2		57
+
+static u32 omap2_i2c1_clkrate	=3D 400;
+static u32 omap2_i2c2_clkrate	=3D 2600;
+
+static struct resource i2c_resources1[] =3D {
+	{
+		.start	=3D OMAP2_I2C_BASE1,
+		.end	=3D OMAP2_I2C_BASE1 + 0x3f,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	{
+		.start	=3D OMAP2_I2C_INT1,
+		.flags	=3D IORESOURCE_IRQ,
+	},
+};
+
+static struct resource i2c_resources2[] =3D {
+	{
+		.start	=3D OMAP2_I2C_BASE2,
+		.end	=3D OMAP2_I2C_BASE2 + 0x3f,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	{
+		.start	=3D OMAP2_I2C_INT2,
+		.flags	=3D IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap_i2c_device1 =3D {
+	.name		=3D "i2c_omap",
+	.id		=3D 1,
+	.num_resources	=3D ARRAY_SIZE(i2c_resources1),
+	.resource	=3D i2c_resources1,
+	.dev		=3D {
+		.platform_data	=3D &omap2_i2c1_clkrate,
+	},
+};
+
+static struct platform_device omap_i2c_device2 =3D {
+	.name		=3D "i2c_omap",
+	.id		=3D 2,
+	.num_resources	=3D ARRAY_SIZE(i2c_resources2),
+	.resource	=3D i2c_resources2,
+	.dev		=3D {
+		.platform_data	=3D &omap2_i2c2_clkrate,
+	},
+};
+
+static void omap_init_i2c(void)
+{
+	(void) platform_device_register(&omap_i2c_device2);
+	(void) platform_device_register(&omap_i2c_device1);
+}
+
+#else
+
+static void omap_init_i2c(void) {}
+
+#endif
+
+static int __init omap2430_i2c_init(void)
+{
+	omap_init_i2c();
+	return 0;
+}
+
 static void __init omap_2430sdp_init(void)
 {
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
@@ -205,6 +277,8 @@ static void __init omap_2430sdp_map_io(v
 	omap2_map_common_io();
 }
=20
+arch_initcall(omap2430_i2c_init);
+
 MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
 	.phys_io	=3D 0x48000000,

--- linux-omap/arch/arm/mach-omap2/devices.c	2007-04-02 =
02:29:57.000000000 -0500
+++ lin_for_hsi2c/arch/arm/mach-omap2/devices.c	2007-04-23 =
17:16:27.000000000 -0500
@@ -25,11 +25,13 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/eac.h>
=20
+#if	!defined(CONFIG_ARCH_OMAP243X)
 #if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
=20
 #define OMAP2_I2C_BASE2		0x48072000
 #define OMAP2_I2C_INT2		57
=20
+static u32 omap2_i2c2_clkrate	=3D 100;
 static struct resource i2c_resources2[] =3D {
 	{
 		.start		=3D OMAP2_I2C_BASE2,
@@ -47,6 +49,9 @@ static struct platform_device omap_i2c_d
 	.id             =3D 2,
 	.num_resources	=3D ARRAY_SIZE(i2c_resources2),
 	.resource	=3D i2c_resources2,
+	.dev		=3D {
+		.platform_data	=3D &omap2_i2c2_clkrate,
+	},
 };
=20
 /* See also arch/arm/plat-omap/devices.c for first I2C on 24xx */
@@ -55,11 +60,10 @@ static void omap_init_i2c(void)
 	/* REVISIT: Second I2C not in use on H4? */
 	if (machine_is_omap_h4())
 		return;
+
+	omap_cfg_reg(J15_24XX_I2C2_SCL);
+	omap_cfg_reg(H19_24XX_I2C2_SDA);
=20
-	if (!cpu_is_omap2430()) {
-		omap_cfg_reg(J15_24XX_I2C2_SCL);
-		omap_cfg_reg(H19_24XX_I2C2_SDA);
-	}
 	(void) platform_device_register(&omap_i2c_device2);
 }
=20
@@ -68,6 +72,7 @@ static void omap_init_i2c(void)
 static void omap_init_i2c(void) {}
=20
 #endif
+#endif
=20
 #if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 #define OMAP2_MBOX_BASE		IO_ADDRESS(OMAP24XX_MAILBOX_BASE)
@@ -241,7 +246,9 @@ static int __init omap2_init_devices(voi
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
-	omap_init_i2c();
+	if (!cpu_is_omap2430()) {
+		omap_init_i2c();
+	}
 	omap_init_mbox();
 	omap_init_mcspi();
 	omap_init_sti();

--- linux-omap/arch/arm/plat-omap/devices.c	2007-04-04 =
18:13:49.000000000 -0500
+++ lin_for_hsi2c/arch/arm/plat-omap/devices.c	2007-04-23 =
18:38:08.000000000 -0500
@@ -89,6 +89,7 @@ static inline void omap_init_dsp(void) {
 #endif	/* CONFIG_OMAP_DSP */
=20
 =
/*-----------------------------------------------------------------------=
--*/
+#if	!defined(CONFIG_ARCH_OMAP243X)
 #if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
=20
 #define	OMAP1_I2C_BASE		0xfffb3800
@@ -97,6 +98,8 @@ static inline void omap_init_dsp(void) {
 #define OMAP1_I2C_INT		INT_I2C
 #define OMAP2_I2C_INT1		56
=20
+static u32 omap2_i2c1_clkrate	=3D 100;
+
 static struct resource i2c_resources1[] =3D {
 	{
 		.start		=3D 0,
@@ -116,12 +119,15 @@ static struct platform_device omap_i2c_d
 	.id             =3D 1,
 	.num_resources	=3D ARRAY_SIZE(i2c_resources1),
 	.resource	=3D i2c_resources1,
+	.dev		=3D {
+		.platform_data	=3D &omap2_i2c1_clkrate,
+	},
 };
=20
 /* See also arch/arm/mach-omap2/devices.c for second I2C on 24xx */
 static void omap_init_i2c(void)
 {
-	if (cpu_is_omap24xx()) {
+	if (cpu_is_omap242x()) {
 		i2c_resources1[0].start =3D OMAP2_I2C_BASE1;
 		i2c_resources1[0].end =3D OMAP2_I2C_BASE1 + OMAP_I2C_SIZE;
 		i2c_resources1[1].start =3D OMAP2_I2C_INT1;
@@ -151,7 +157,7 @@ static void omap_init_i2c(void)
 #else
 static inline void omap_init_i2c(void) {}
 #endif
-
+#endif
 =
/*-----------------------------------------------------------------------=
--*/
 #if	defined(CONFIG_KEYBOARD_OMAP) || =
defined(CONFIG_KEYBOARD_OMAP_MODULE)
=20
@@ -258,6 +264,7 @@ static struct omap_mmc_conf mmc2_conf;
=20
 static u64 mmc2_dmamask =3D 0xffffffff;
=20
+
 static struct resource mmc2_resources[] =3D {
 	{
 		.start		=3D OMAP_MMC2_BASE,
@@ -512,7 +519,9 @@ static int __init omap_init_devices(void
 	omap_init_uwire();
 	omap_init_wdt();
 	omap_init_rng();
-	omap_init_i2c();
+	if (!cpu_is_omap2430()) {
+		omap_init_i2c();
+	}
 	return 0;
 }
 arch_initcall(omap_init_devices);

--- linux-omap/arch/arm/mach-omap2/clock.h	2007-03-13 13:03:43.000000000 =
-0600
+++ lin_for_hsi2c/arch/arm/mach-omap2/clock.h	2007-04-10 =
11:02:37.000000000 -0500
@@ -1761,7 +1761,8 @@ static struct clk i2c2_fck =3D {
 };
=20
 static struct clk i2chs2_fck =3D {
-	.name		=3D "i2chs2_fck",
+	.name		=3D "i2chs_fck",
+	.id		=3D 2,
 	.parent		=3D &func_96m_ck,
 	.flags		=3D CLOCK_IN_OMAP243X,
 	.enable_reg	=3D (void __iomem *)&CM_FCLKEN2_CORE,
@@ -1790,7 +1791,8 @@ static struct clk i2c1_fck =3D {
 };
=20
 static struct clk i2chs1_fck =3D {
-	.name		=3D "i2chs1_fck",
+	.name		=3D "i2chs_fck",
+	.id		=3D 1,
 	.parent		=3D &func_96m_ck,
 	.flags		=3D CLOCK_IN_OMAP243X,
 	.enable_reg	=3D (void __iomem *)&CM_FCLKEN2_CORE,

--- linux-omap/drivers/i2c/busses/i2c-omap.c	2007-04-23 =
19:17:32.000000000 -0500
+++ lin_for_hsi2c/drivers/i2c/busses/i2c-omap.c	2007-04-23 =
19:33:49.000000000 -0500
@@ -89,6 +89,7 @@
 /* I2C Configuration Register (OMAP_I2C_CON): */
 #define OMAP_I2C_CON_EN		(1 << 15)	/* I2C module enable */
 #define OMAP_I2C_CON_BE		(1 << 14)	/* Big endian mode */
+#define OMAP_I2C_CON_OPMODE	(1 << 12)	/* High Speed support */
 #define OMAP_I2C_CON_STB	(1 << 11)	/* Start byte mode (master) */
 #define OMAP_I2C_CON_MST	(1 << 10)	/* Master/slave mode */
 #define OMAP_I2C_CON_TRX	(1 << 9)	/* TX/RX mode (master only) */
@@ -97,6 +98,10 @@
 #define OMAP_I2C_CON_STP	(1 << 1)	/* Stop cond (master only) */
 #define OMAP_I2C_CON_STT	(1 << 0)	/* Start condition (master) */
=20
+/* I2C SCL time value when Master */
+#define OMAP_I2C_SCLL_HSSCLL	8
+#define OMAP_I2C_SCLH_HSSCLH	8
+
 /* I2C System Test Register (OMAP_I2C_SYSTEST): */
 #ifdef DEBUG
 #define OMAP_I2C_SYSTEST_ST_EN		(1 << 15)	/* System test enable */
@@ -115,12 +120,6 @@
 /* I2C System Configuration Register (OMAP_I2C_SYSC): */
 #define OMAP_I2C_SYSC_SRST		(1 << 1)	/* Soft Reset */
=20
-/* REVISIT: Use platform_data instead of module parameters */
-/* Fast Mode =3D 400 kHz, Standard =3D 100 kHz */
-static int clock =3D 100; /* Default: 100 kHz */
-module_param(clock, int, 0);
-MODULE_PARM_DESC(clock, "Set I2C clock in kHz: 400=3Dfast mode (default =
=3D=3D 100)");
-
 struct omap_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
@@ -129,6 +128,7 @@ struct omap_i2c_dev {
 	struct clk		*fclk;		/* Functional clock */
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
+	u32			speed;		/* Speed of bus in Khz */
 	u16			cmd_err;
 	u8			*buf;
 	size_t			buf_len;
@@ -156,17 +156,28 @@ static int omap_i2c_get_clocks(struct om
 			return -ENODEV;
 		}
 	}
-
-	dev->fclk =3D clk_get(dev->dev, "i2c_fck");
-	if (IS_ERR(dev->fclk)) {
-		if (dev->iclk !=3D NULL) {
-			clk_put(dev->iclk);
-			dev->iclk =3D NULL;
+	/* For I2C operations on 2430 we need 96Mhz clock */
+	if (cpu_is_omap2430()) {
+		dev->fclk =3D clk_get(dev->dev, "i2chs_fck");
+		if (IS_ERR(dev->fclk)) {
+			if (dev->iclk !=3D NULL) {
+				clk_put(dev->iclk);
+				dev->iclk =3D NULL;
+			}
+			dev->fclk =3D NULL;
+			return -ENODEV;
+		}
+	} else {
+		dev->fclk =3D clk_get(dev->dev, "i2c_fck");
+		if (IS_ERR(dev->fclk)) {
+			if (dev->iclk !=3D NULL) {
+				clk_put(dev->iclk);
+				dev->iclk =3D NULL;
+			}
+			dev->fclk =3D NULL;
+			return -ENODEV;
 		}
-		dev->fclk =3D NULL;
-		return -ENODEV;
 	}
-
 	return 0;
 }
=20
@@ -196,9 +207,11 @@ static void omap_i2c_disable_clocks(stru
=20
 static int omap_i2c_init(struct omap_i2c_dev *dev)
 {
-	u16 psc =3D 0;
+	u16 psc =3D 0, scll =3D 0, sclh =3D 0;
+	u16 fsscll =3D 0, fssclh =3D 0, hsscll =3D 0, hssclh =3D 0;
 	unsigned long fclk_rate =3D 12000000;
 	unsigned long timeout;
+	unsigned long internal_clk =3D 0;
=20
 	if (!dev->rev1) {
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SRST);
@@ -240,19 +253,48 @@ static int omap_i2c_init(struct omap_i2c
 		if (fclk_rate > 12000000)
 			psc =3D fclk_rate / 12000000;
 	}
+
+	if (cpu_is_omap2430()) {
+
+		/* HSI2C controller internal clk rate should be 19.2 Mhz */
+		internal_clk =3D 19200;
+		fclk_rate =3D clk_get_rate(dev->fclk) / 1000;
+
+		/* Compute prescaler divisor */
+		psc =3D fclk_rate / internal_clk;
+		psc =3D psc - 1;
+
+		/* If configured for High Speed */
+		if (dev->speed > 400) {
+			/* For first phase of HS mode */
+			fsscll =3D internal_clk / (400 * 2) - 6;
+			fssclh =3D internal_clk / (400 * 2) - 6;
+
+			/* For second phase of HS mode */
+			hsscll =3D fclk_rate / (dev->speed * 2) - 6;
+			hssclh =3D fclk_rate / (dev->speed * 2) - 6;
+		} else {
+			/* To handle F/S modes */
+			fsscll =3D internal_clk / (dev->speed * 2) - 6;
+			fssclh =3D internal_clk / (dev->speed * 2) - 6;
+		}
+		scll =3D (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
+		sclh =3D (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
+	} else {
+		/* Program desired operating rate */
+		fclk_rate /=3D (psc + 1) * 1000;
+		if (psc > 2)
+			psc =3D 2;
+		scll =3D fclk_rate / (dev->speed * 2) - 7 + psc;
+		sclh =3D fclk_rate / (dev->speed * 2) - 7 + psc;
+	}
=20
 	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
 	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, psc);
=20
-	/* Program desired operating rate */
-	fclk_rate /=3D (psc + 1) * 1000;
-	if (psc > 2)
-		psc =3D 2;
-
-	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG,
-			   fclk_rate / (clock * 2) - 7 + psc);
-	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG,
-			   fclk_rate / (clock * 2) - 7 + psc);
+	/* SCL low and high time values */
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
=20
 	/* Take the I2C module out of reset: */
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
@@ -337,6 +379,11 @@ static int omap_i2c_xfer_msg(struct i2c_
 	dev->cmd_err =3D 0;
=20
 	w =3D OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
+
+	/* High speed configuration */
+	if (dev->speed > 400)
+		w |=3D OMAP_I2C_CON_OPMODE;
+
 	if (msg->flags & I2C_M_TEN)
 		w |=3D OMAP_I2C_CON_XA;
 	if (!(msg->flags & I2C_M_RD))
@@ -583,6 +630,7 @@ omap_i2c_probe(struct platform_device *p
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
 	int r;
+	u32 *speed =3D NULL;
=20
 	/* NOTE: driver uses the static register mapping */
 	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -603,17 +651,18 @@ omap_i2c_probe(struct platform_device *p
 		return -EBUSY;
 	}
=20
-	if (clock > 200)
-		clock =3D 400;	/* Fast mode */
-	else
-		clock =3D 100;	/* Standard mode */
-
 	dev =3D kzalloc(sizeof(struct omap_i2c_dev), GFP_KERNEL);
 	if (!dev) {
 		r =3D -ENOMEM;
 		goto err_release_region;
 	}
-
+
+	if (pdev->dev.platform_data !=3D NULL)
+		speed =3D (u32 *) pdev->dev.platform_data;
+	else
+		*speed =3D 100; /* Defualt speed */
+
+	dev->speed =3D *speed;
 	dev->dev =3D &pdev->dev;
 	dev->irq =3D irq->start;
 	dev->base =3D (void __iomem *) IO_ADDRESS(mem->start);
@@ -639,7 +688,7 @@ omap_i2c_probe(struct platform_device *p
 	}
 	r =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n",
-		 pdev->id, r >> 4, r & 0xf, clock);
+		 pdev->id, r >> 4, r & 0xf, dev->speed);
=20
 	adap =3D &dev->adapter;
 	i2c_set_adapdata(adap, dev);
