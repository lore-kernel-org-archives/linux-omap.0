From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] input: ti_am335x_tsc: Remove DT wire-config parameter
Date: Thu,  4 Sep 2014 16:39:14 +0200
Message-ID: <1409841555-11336-2-git-send-email-bigeasy@linutronix.de>
References: <1409841555-11336-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1409841555-11336-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, Jeff Lance <j-lance1@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

=46rom: Jeff Lance <j-lance1@ti.com>

With the touschscreen in am335x, you do not have the option to mux the
analog input lines. You must connect the analog input to the correspond=
ing
touchscreen terminal.
This patch removes the code that is parsing the ti,wire-config and uses
the "default" parameters instead.
In short,
	inp_xp =3D> STEPCONFIG_INP(0)
	inp_xn =3D> STEPCONFIG_INP(1)
	inp_yp =3D> STEPCONFIG_INP(2)
	inp_yn =3D> STEPCONFIG_INP(3)
	bit_xp =3D> STEPCONFIG_XPP
	bit_xn =3D> STEPCONFIG_XNN
	bit_yp =3D> STEPCONFIG_YPP
	bit_yn =3D> STEPCONFIG_YNN

Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Jeff Lance <j-lance1@ti.com>
[bigeasy: refresh, drop AIN defines.]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 109 +++++-----------------=
--------
 1 file changed, 16 insertions(+), 93 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/=
touchscreen/ti_am335x_tsc.c
index 092fa8b31c67..92fb473621b0 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -33,13 +33,6 @@
 #define SEQ_SETTLE		275
 #define MAX_12BIT		((1 << 12) - 1)
=20
-static const int config_pins[] =3D {
-	STEPCONFIG_XPP,
-	STEPCONFIG_XNN,
-	STEPCONFIG_YPP,
-	STEPCONFIG_YNN,
-};
-
 struct titsc {
 	struct input_dev	*input;
 	struct ti_tscadc_dev	*mfd_tscadc;
@@ -48,9 +41,6 @@ struct titsc {
 	unsigned int		x_plate_resistance;
 	bool			pen_down;
 	int			coordinate_readouts;
-	u32			config_inp[4];
-	u32			bit_xp, bit_xn, bit_yp, bit_yn;
-	u32			inp_xp, inp_xn, inp_yp, inp_yn;
 	u32			step_mask;
 };
=20
@@ -65,58 +55,6 @@ static void titsc_writel(struct titsc *tsc, unsigned=
 int reg,
 	writel(val, tsc->mfd_tscadc->tscadc_base + reg);
 }
=20
-static int titsc_config_wires(struct titsc *ts_dev)
-{
-	u32 analog_line[4];
-	u32 wire_order[4];
-	int i, bit_cfg;
-
-	for (i =3D 0; i < 4; i++) {
-		/*
-		 * Get the order in which TSC wires are attached
-		 * w.r.t. each of the analog input lines on the EVM.
-		 */
-		analog_line[i] =3D (ts_dev->config_inp[i] & 0xF0) >> 4;
-		wire_order[i] =3D ts_dev->config_inp[i] & 0x0F;
-		if (WARN_ON(analog_line[i] > 7))
-			return -EINVAL;
-		if (WARN_ON(wire_order[i] > ARRAY_SIZE(config_pins)))
-			return -EINVAL;
-	}
-
-	for (i =3D 0; i < 4; i++) {
-		int an_line;
-		int wi_order;
-
-		an_line =3D analog_line[i];
-		wi_order =3D wire_order[i];
-		bit_cfg =3D config_pins[wi_order];
-		if (bit_cfg =3D=3D 0)
-			return -EINVAL;
-		switch (wi_order) {
-		case 0:
-			ts_dev->bit_xp =3D bit_cfg;
-			ts_dev->inp_xp =3D an_line;
-			break;
-
-		case 1:
-			ts_dev->bit_xn =3D bit_cfg;
-			ts_dev->inp_xn =3D an_line;
-			break;
-
-		case 2:
-			ts_dev->bit_yp =3D bit_cfg;
-			ts_dev->inp_yp =3D an_line;
-			break;
-		case 3:
-			ts_dev->bit_yn =3D bit_cfg;
-			ts_dev->inp_yn =3D an_line;
-			break;
-		}
-	}
-	return 0;
-}
-
 static void titsc_step_config(struct titsc *ts_dev)
 {
 	unsigned int	config;
@@ -124,19 +62,17 @@ static void titsc_step_config(struct titsc *ts_dev=
)
 	int end_step;
 	u32 stepenable;
=20
-	config =3D STEPCONFIG_MODE_HWSYNC |
-			STEPCONFIG_AVG_16 | ts_dev->bit_xp;
+	config =3D STEPCONFIG_MODE_HWSYNC | STEPCONFIG_AVG_16 | STEPCONFIG_XP=
P;
 	switch (ts_dev->wires) {
 	case 4:
-		config |=3D STEPCONFIG_INP(ts_dev->inp_yp) | ts_dev->bit_xn;
+		config |=3D STEPCONFIG_INP(2) | STEPCONFIG_XNN;
 		break;
 	case 5:
-		config |=3D ts_dev->bit_yn |
-				STEPCONFIG_INP_AN4 | ts_dev->bit_xn |
-				ts_dev->bit_yp;
+		config |=3D STEPCONFIG_YNN | STEPCONFIG_INP_AN4 | STEPCONFIG_XNN |
+				STEPCONFIG_YPP;
 		break;
 	case 8:
-		config |=3D STEPCONFIG_INP(ts_dev->inp_yp) | ts_dev->bit_xn;
+		config |=3D STEPCONFIG_INP(2) | STEPCONFIG_XNN;
 		break;
 	}
=20
@@ -147,20 +83,18 @@ static void titsc_step_config(struct titsc *ts_dev=
)
 		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
 	}
=20
-	config =3D 0;
-	config =3D STEPCONFIG_MODE_HWSYNC |
-			STEPCONFIG_AVG_16 | ts_dev->bit_yn |
+	config =3D STEPCONFIG_MODE_HWSYNC | STEPCONFIG_AVG_16 | STEPCONFIG_YN=
N |
 			STEPCONFIG_INM_ADCREFM;
 	switch (ts_dev->wires) {
 	case 4:
-		config |=3D ts_dev->bit_yp | STEPCONFIG_INP(ts_dev->inp_xp);
+		config |=3D STEPCONFIG_YPP | STEPCONFIG_INP(0);
 		break;
 	case 5:
-		config |=3D ts_dev->bit_xp | STEPCONFIG_INP_AN4 |
+		config |=3D STEPCONFIG_XPP | STEPCONFIG_INP_AN4 |
 				STEPCONFIG_XNP | STEPCONFIG_YPN;
 		break;
 	case 8:
-		config |=3D ts_dev->bit_yp | STEPCONFIG_INP(ts_dev->inp_xp);
+		config |=3D STEPCONFIG_YPP | STEPCONFIG_INP(0);
 		break;
 	}
=20
@@ -172,24 +106,23 @@ static void titsc_step_config(struct titsc *ts_de=
v)
 	}
=20
 	/* Charge step configuration */
-	config =3D ts_dev->bit_xp | ts_dev->bit_yn |
-			STEPCHARGE_RFP_XPUL | STEPCHARGE_RFM_XNUR |
-			STEPCHARGE_INM_AN1 | STEPCHARGE_INP(ts_dev->inp_yp);
+	config =3D STEPCONFIG_XPP | STEPCONFIG_YNN | STEPCHARGE_RFP_XPUL |
+		STEPCHARGE_RFM_XNUR | STEPCHARGE_INM_AN1 | STEPCHARGE_INP(2);
=20
 	titsc_writel(ts_dev, REG_CHARGECONFIG, config);
 	titsc_writel(ts_dev, REG_CHARGEDELAY, CHARGEDLY_OPENDLY);
=20
 	/* coordinate_readouts * 2 =E2=80=A6 coordinate_readouts * 2 + 2 is f=
or Z */
 	config =3D STEPCONFIG_MODE_HWSYNC |
-			STEPCONFIG_AVG_16 | ts_dev->bit_yp |
-			ts_dev->bit_xn | STEPCONFIG_INM_ADCREFM |
-			STEPCONFIG_INP(ts_dev->inp_xp);
+			STEPCONFIG_AVG_16 | STEPCONFIG_YPP |
+			STEPCONFIG_XNN | STEPCONFIG_INM_ADCREFM |
+			STEPCONFIG_INP(0);
 	titsc_writel(ts_dev, REG_STEPCONFIG(end_step), config);
 	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
 			STEPCONFIG_OPENDLY);
=20
 	end_step++;
-	config |=3D STEPCONFIG_INP(ts_dev->inp_yn);
+	config |=3D STEPCONFIG_INP(3);
 	titsc_writel(ts_dev, REG_STEPCONFIG(end_step), config);
 	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
 			STEPCONFIG_OPENDLY);
@@ -364,12 +297,7 @@ static int titsc_parse_dt(struct platform_device *=
pdev,
 		err =3D of_property_read_u32(node, "ti,coordiante-readouts",
 				&ts_dev->coordinate_readouts);
 	}
-
-	if (err < 0)
-		return err;
-
-	return of_property_read_u32_array(node, "ti,wire-config",
-			ts_dev->config_inp, ARRAY_SIZE(ts_dev->config_inp));
+	return err;
 }
=20
 /*
@@ -411,11 +339,6 @@ static int titsc_probe(struct platform_device *pde=
v)
 	}
=20
 	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
-	err =3D titsc_config_wires(ts_dev);
-	if (err) {
-		dev_err(&pdev->dev, "wrong i/p wire configuration\n");
-		goto err_free_irq;
-	}
 	titsc_step_config(ts_dev);
 	titsc_writel(ts_dev, REG_FIFO0THR,
 			ts_dev->coordinate_readouts * 2 + 2 - 1);
--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
