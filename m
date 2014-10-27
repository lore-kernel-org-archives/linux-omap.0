From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 4/4] input: touchscreen: ti_am335x_tsc: Use charge delay DT parameter
Date: Mon, 27 Oct 2014 16:38:31 +0530
Message-ID: <1414408111-2631-5-git-send-email-vigneshr@ti.com>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jan Kardell <jan.kardell@telliq.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Brad Griffis <bgriffis@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch reads charge delay from tsc DT node and writes to
REG_CHARGEDELAY register. If the charge delay is not specified in DT
then default value of 0xB000(CHARGEDLY_OPENDLY) is used.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 483fd97c0e0c..20ce76b1b6e7 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -52,6 +52,7 @@ struct titsc {
 	u32			bit_xp, bit_xn, bit_yp, bit_yn;
 	u32			inp_xp, inp_xn, inp_yp, inp_yn;
 	u32			step_mask;
+	u32			charge_delay;
 };
 
 static unsigned int titsc_readl(struct titsc *ts, unsigned int reg)
@@ -177,7 +178,7 @@ static void titsc_step_config(struct titsc *ts_dev)
 
 	config = titsc_readl(ts_dev, REG_IDLECONFIG);
 	titsc_writel(ts_dev, REG_CHARGECONFIG, config);
-	titsc_writel(ts_dev, REG_CHARGEDELAY, CHARGEDLY_OPENDLY);
+	titsc_writel(ts_dev, REG_CHARGEDELAY, ts_dev->charge_delay);
 
 	/* coordinate_readouts + 1 ... coordinate_readouts + 2 is for Z */
 	config = STEPCONFIG_MODE_HWSYNC |
@@ -361,6 +362,11 @@ static int titsc_parse_dt(struct platform_device *pdev,
 	if (err < 0)
 		return err;
 
+	err = of_property_read_u32(node, "ti,charge-delay",
+				   &ts_dev->charge_delay);
+	if (err < 0)
+		ts_dev->charge_delay = CHARGEDLY_OPENDLY;
+
 	return of_property_read_u32_array(node, "ti,wire-config",
 			ts_dev->config_inp, ARRAY_SIZE(ts_dev->config_inp));
 }
-- 
1.9.1
