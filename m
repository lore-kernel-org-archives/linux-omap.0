From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 1/8] input: ti_am335x_tsc: Step enable bits made
 configurable
Date: Thu, 24 Jan 2013 09:15:05 +0530
Message-ID: <1358999112-31192-2-git-send-email-rachna@ti.com>
References: <1358999112-31192-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1358999112-31192-1-git-send-email-rachna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, gururaja.hebbar-l0cyMroinI0@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>

Current code has hard coded value written to
step enable bits. Now the bits are updated based
on how many steps are needed to be configured got
from platform data.

The user needs to take care not to exceed
the count more than 16. While using ADC and TSC
one should take care to set this parameter correctly.

Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   10 ++++++++--
 include/linux/mfd/ti_am335x_tscadc.h      |    1 -
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 51e7b87..da652e0 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -39,6 +39,7 @@ struct titsc {
 	unsigned int		irq;
 	unsigned int		wires;
 	unsigned int		x_plate_resistance;
+	unsigned int		enable_bits;
 	bool			pen_down;
 	int			steps_to_configure;
 };
@@ -57,6 +58,7 @@ static void titsc_writel(struct titsc *tsc, unsigned int reg,
 static void titsc_step_config(struct titsc *ts_dev)
 {
 	unsigned int	config;
+	unsigned int	stepenable = 0;
 	int i, total_steps;
 
 	/* Configure the Step registers */
@@ -128,7 +130,11 @@ static void titsc_step_config(struct titsc *ts_dev)
 	titsc_writel(ts_dev, REG_STEPDELAY(total_steps + 2),
 			STEPCONFIG_OPENDLY);
 
-	titsc_writel(ts_dev, REG_SE, STPENB_STEPENB_TC);
+	for (i = 0; i <= (total_steps + 2); i++)
+		stepenable |= 1 << i;
+	ts_dev->enable_bits = stepenable;
+
+	titsc_writel(ts_dev, REG_SE, ts_dev->enable_bits);
 }
 
 static void titsc_read_coordinates(struct titsc *ts_dev,
@@ -250,7 +256,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 
 	titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
 
-	titsc_writel(ts_dev, REG_SE, STPENB_STEPENB_TC);
+	titsc_writel(ts_dev, REG_SE, ts_dev->enable_bits);
 	return IRQ_HANDLED;
 }
 
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index c79ad5d..23e4f33 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -47,7 +47,6 @@
 #define STEPENB_MASK		(0x1FFFF << 0)
 #define STEPENB(val)		((val) << 0)
 #define STPENB_STEPENB		STEPENB(0x1FFFF)
-#define STPENB_STEPENB_TC	STEPENB(0x1FFF)
 
 /* IRQ enable */
 #define IRQENB_HW_PEN		BIT(0)
-- 
1.7.9.5
