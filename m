From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH / RFC] Basic OMAP2430 High speed I2C & Speed handling
	(resending)
Date: Wed, 11 Apr 2007 13:46:47 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47A95612@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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

Hi,

This patch moves I2C speed parameter (from module) to platform data.
This is part of a discussion that Nishanth and I were discussing (also
on lmsensors).=20

I have also added basic High Speed support based on I2C bus speed. This
patch is tested for high speed I2C (with TWL4030 Keypad) and works as
expected.=20

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 drivers/i2c/busses/i2c-omap.c
 arch/arm/mach-omap2/clock.h
 arch/arm/mach-omap2/devices.c
 arch/arm/plat-omap/devices.c=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/drivers/i2c/busses/i2c-omap.c	2007-01-08
18:56:31.000000000 -0600
+++ lin_for_hsi2c/drivers/i2c/busses/i2c-omap.c	2007-04-11
11:47:54.000000000 -0500
@@ -3,7 +3,10 @@
  *
  * Copyright (C) 2003 MontaVista Software, Inc.
  * Copyright (C) 2004 Texas Instruments.
- *
+ *
+ * Updated to support High Speed I2C mode by
+ * Syed Mohammed Khasim <x0khasim@ti.com>
+ *
  * Updated to work with multiple I2C interfaces on 24xx by
  * Tony Lindgren <tony@atomide.com> and Imre Deak <imre.deak@nokia.com>
  * Copyright (C) 2005 Nokia Corporation
@@ -87,6 +90,7 @@
 /* I2C Configuration Register (OMAP_I2C_CON): */
 #define OMAP_I2C_CON_EN		(1 << 15)	/* I2C module
enable */
 #define OMAP_I2C_CON_BE		(1 << 14)	/* Big endian
mode */
+#define OMAP_I2C_CON_OPMODE	(1 << 12)	/* High Speed support */
 #define OMAP_I2C_CON_STB	(1 << 11)	/* Start byte mode
(master) */
 #define OMAP_I2C_CON_MST	(1 << 10)	/* Master/slave mode */
 #define OMAP_I2C_CON_TRX	(1 << 9)	/* TX/RX mode (master
only) */
@@ -95,6 +99,10 @@
 #define OMAP_I2C_CON_STP	(1 << 1)	/* Stop cond (master
only) */
 #define OMAP_I2C_CON_STT	(1 << 0)	/* Start condition
(master) */
=20
+/* I2C SCL time value when Master */
+#define OMAP_I2C_SCLL_HSSCLL	8
+#define OMAP_I2C_SCLH_HSSCLH	8
+
 /* I2C System Test Register (OMAP_I2C_SYSTEST): */
 #ifdef DEBUG
 #define OMAP_I2C_SYSTEST_ST_EN		(1 << 15)	/* System test
enable */
@@ -113,12 +121,6 @@
 /* I2C System Configuration Register (OMAP_I2C_SYSC): */
 #define OMAP_I2C_SYSC_SRST		(1 << 1)	/* Soft Reset */
=20
-/* REVISIT: Use platform_data instead of module parameters */
-/* Fast Mode =3D 400 kHz, Standard =3D 100 kHz */
-static int clock =3D 100; /* Default: 100 kHz */
-module_param(clock, int, 0);
-MODULE_PARM_DESC(clock, "Set I2C clock in kHz: 400=3Dfast mode (default
=3D=3D 100)");
-
 struct omap_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
@@ -127,6 +129,7 @@ struct omap_i2c_dev {
 	struct clk		*fclk;		/* Functional clock */
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
+	u32			speed;		/* Speed of bus in Khz
*/
 	u16			cmd_err;
 	u8			*buf;
 	size_t			buf_len;
@@ -154,17 +157,30 @@ static int omap_i2c_get_clocks(struct om
 			return -ENODEV;
 		}
 	}
-
-	dev->fclk =3D clk_get(dev->dev, "i2c_fck");
-	if (IS_ERR(dev->fclk)) {
-		if (dev->iclk !=3D NULL) {
-			clk_put(dev->iclk);
-			dev->iclk =3D NULL;
+
+	if (cpu_is_omap2430()) {
+		dev->fclk =3D clk_get(dev->dev, "i2chs_fck");
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
+	else {
+		dev->fclk =3D clk_get(dev->dev, "i2c_fck");
+		if (IS_ERR(dev->fclk)) {
+			if (dev->iclk !=3D NULL) {
+				clk_put(dev->iclk);
+				dev->iclk =3D NULL;
+			}
+			dev->fclk =3D NULL;
+			return -ENODEV;
+		}
+	}
+
 	return 0;
 }
=20
@@ -194,9 +210,11 @@ static void omap_i2c_disable_clocks(stru
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
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
OMAP_I2C_SYSC_SRST);
@@ -238,28 +256,59 @@ static int omap_i2c_init(struct omap_i2c
 		if (fclk_rate > 12000000)
 			psc =3D fclk_rate / 12000000;
 	}
+
+	if (cpu_is_omap2430()) {
+
+		/* HS I2C controller should be operated at 19.2 Mhz */
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
+		}
+		else {
+			/* To handle F/S modes */
+			fsscll =3D internal_clk / (dev->speed * 2) - 6;
+			fssclh =3D internal_clk / (dev->speed * 2) - 6;
+		}
+		scll =3D (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
+		sclh =3D (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
+	}
+	else {
+		/* Program desired operating rate */
+		fclk_rate /=3D (psc + 1) * 1000;
+		if (psc > 2)
+			psc =3D 2;
+		scll =3D fclk_rate / (dev->speed * 2) - 7 + psc;
+		sclh =3D fclk_rate / (dev->speed * 2) - 7 + psc;
+	}
=20
 	/* Setup clock prescaler to obtain approx 12MHz I2C module
clock: */
 	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, psc);
-
-	/* Program desired operating rate */
-	fclk_rate /=3D (psc + 1) * 1000;
-	if (psc > 2)
-		psc =3D 2;
-
-	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG,
-			   fclk_rate / (clock * 2) - 7 + psc);
-	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG,
-			   fclk_rate / (clock * 2) - 7 + psc);
-
+
+	/* SCL low and high time values */
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
+
 	/* Take the I2C module out of reset: */
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
=20
 	/* Enable interrupts */
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
-			   (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
-			    OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
-			    OMAP_I2C_IE_AL));
+				(OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
+				OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
+				OMAP_I2C_IE_AL));
 	return 0;
 }
=20
@@ -335,6 +384,11 @@ static int omap_i2c_xfer_msg(struct i2c_
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
@@ -581,7 +635,8 @@ omap_i2c_probe(struct platform_device *p
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
 	int r;
-
+	u32 *speed =3D NULL;
+
 	/* NOTE: driver uses the static register mapping */
 	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -601,17 +656,18 @@ omap_i2c_probe(struct platform_device *p
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
@@ -637,7 +693,7 @@ omap_i2c_probe(struct platform_device *p
 	}
 	r =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n",
-		 pdev->id, r >> 4, r & 0xf, clock);
+		 pdev->id, r >> 4, r & 0xf, dev->speed);
=20
 	adap =3D &dev->adapter;
 	i2c_set_adapdata(adap, dev);

--- linux-omap/arch/arm/mach-omap2/clock.h	2007-03-13
13:03:43.000000000 -0600
+++ lin_for_hsi2c/arch/arm/mach-omap2/clock.h	2007-04-10
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

--- linux-omap/arch/arm/mach-omap2/devices.c	2007-04-02
02:29:57.000000000 -0500
+++ lin_for_hsi2c/arch/arm/mach-omap2/devices.c	2007-04-11
12:01:30.000000000 -0500
@@ -30,6 +30,12 @@
 #define OMAP2_I2C_BASE2		0x48072000
 #define OMAP2_I2C_INT2		57
=20
+#if defined(CONFIG_MACH_OMAP_2430SDP)
+static u32 omap2_i2c2_clkrate	=3D 2600;
+#else
+static u32 omap2_i2c2_clkrate	=3D 100;
+#endif
+
 static struct resource i2c_resources2[] =3D {
 	{
 		.start		=3D OMAP2_I2C_BASE2,
@@ -47,6 +53,9 @@ static struct platform_device omap_i2c_d
 	.id             =3D 2,
 	.num_resources	=3D ARRAY_SIZE(i2c_resources2),
 	.resource	=3D i2c_resources2,
+	.dev		=3D {
+		.platform_data	=3D &omap2_i2c2_clkrate,
+	},
 };
=20
 /* See also arch/arm/plat-omap/devices.c for first I2C on 24xx */

--- linux-omap/arch/arm/plat-omap/devices.c	2007-04-04
18:13:49.000000000 -0500
+++ lin_for_hsi2c/arch/arm/plat-omap/devices.c	2007-04-11
12:02:19.000000000 -0500
@@ -97,6 +97,12 @@ static inline void omap_init_dsp(void) {
 #define OMAP1_I2C_INT		INT_I2C
 #define OMAP2_I2C_INT1		56
=20
+#if defined(CONFIG_MACH_OMAP_2430SDP)
+	static u32 omap2_i2c1_clkrate	=3D 400;
+#else
+	static u32 omap2_i2c1_clkrate	=3D 100;
+#endif
+
 static struct resource i2c_resources1[] =3D {
 	{
 		.start		=3D 0,
@@ -116,6 +122,9 @@ static struct platform_device omap_i2c_d
 	.id             =3D 1,
 	.num_resources	=3D ARRAY_SIZE(i2c_resources1),
 	.resource	=3D i2c_resources1,
+	.dev		=3D {
+		.platform_data	=3D &omap2_i2c1_clkrate,
+	},
 };
=20
 /* See also arch/arm/mach-omap2/devices.c for second I2C on 24xx */
