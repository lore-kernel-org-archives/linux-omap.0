From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 09/25] i2c: move twl4030-madc to new registration style
Date: Tue, 30 Sep 2008 21:42:53 +0300
Message-ID: <1222800189-29737-10-git-send-email-me@felipebalbi.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
 <1222800189-29737-2-git-send-email-me@felipebalbi.com>
 <1222800189-29737-3-git-send-email-me@felipebalbi.com>
 <1222800189-29737-4-git-send-email-me@felipebalbi.com>
 <1222800189-29737-5-git-send-email-me@felipebalbi.com>
 <1222800189-29737-6-git-send-email-me@felipebalbi.com>
 <1222800189-29737-7-git-send-email-me@felipebalbi.com>
 <1222800189-29737-8-git-send-email-me@felipebalbi.com>
 <1222800189-29737-9-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51276 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbYI3Snp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 14:43:45 -0400
In-Reply-To: <1222800189-29737-9-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>, Mikko Ylinen <mikko.k.ylinen@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Moving twl4030-madc to new style registration just like
the other twl4030 children.

Cc: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp.c  |    5 +
 arch/arm/mach-omap2/board-3430sdp.c  |    5 +
 arch/arm/mach-omap2/board-ldp.c      |    5 +
 arch/arm/mach-omap2/board-omap2evm.c |    5 +
 arch/arm/mach-omap2/board-omap3evm.c |    5 +
 drivers/i2c/chips/twl4030-core.c     |   27 ++++
 drivers/i2c/chips/twl4030-madc.c     |  243 +++++++++++++++++++++-------------
 include/linux/i2c/twl4030.h          |    5 +
 8 files changed, 209 insertions(+), 91 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 7842110..cea2540 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -355,12 +355,17 @@ static struct twl4030_usb_data sdp2430_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
+static struct twl4030_madc_platform_data sdp2430_madc_data = {
+	.irq_line	= 1,
+};
+
 static struct twl4030_platform_data sdp2430_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.gpio		= &sdp2430_gpio_data,
+	.madc		= &sdp2430_madc_data,
 	.keypad		= &sdp2430_kp_data,
 	.usb		= &sdp2430_usb_data,
 };
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 66f0f98..661d5d0 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -310,12 +310,17 @@ static struct twl4030_usb_data sdp3430_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
+static struct twl4030_madc_platform_data sdp3430_madc_data = {
+	.irq_line	= 1,
+};
+
 static struct twl4030_platform_data sdp3430_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.gpio		= &sdp3430_gpio_data,
+	.madc		= &sdp3430_madc_data,
 	.keypad		= &sdp3430_kp_data,
 	.usb		= &sdp3430_usb_data,
 };
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 48342f4..a0e2c7a 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -193,11 +193,16 @@ static struct twl4030_gpio_platform_data ldp_gpio_data = {
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 };
 
+static struct twl4030_madc_platform_data ldp_madc_data = {
+	.irq_line	= 1,
+};
+
 static struct twl4030_platform_data ldp_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
+	.madc		= &ldp_madc_data,
 	.usb		= &ldp_usb_data,
 	.gpio		= &ldp_gpio_data,
 };
diff --git a/arch/arm/mach-omap2/board-omap2evm.c b/arch/arm/mach-omap2/board-omap2evm.c
index a921cf1..9f19c34 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -236,12 +236,17 @@ static struct twl4030_usb_data omap2evm_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
+static struct twl4030_madc_platform_data omap2evm_madc_data = {
+	.irq_line	= 1,
+};
+
 static struct twl4030_platform_data omap2evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.keypad		= &omap2evm_kp_data,
+	.madc		= &omap2evm_madc_data,
 	.usb		= &omap2evm_usb_data,
 	.gpio		= &omap2evm_gpio_data,
 };
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 2c1d76f..a9ff8d1 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -128,12 +128,17 @@ static struct twl4030_keypad_data omap3evm_kp_data = {
 	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
+static struct twl4030_madc_platform_data omap3evm_madc_data = {
+	.irq_line	= 1,
+};
+
 static struct twl4030_platform_data omap3evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.keypad		= &omap3evm_kp_data,
+	.madc		= &omap3evm_madc_data,
 	.usb		= &omap3evm_usb_data,
 	.gpio		= &omap3evm_gpio_data,
 };
diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index c9460f7..79d4d82 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -69,6 +69,12 @@
 #define twl_has_gpio()	false
 #endif
 
+#if defined(CONFIG_TWL4030_MADC) || defined(CONFIG_TWL4030_MADC_MODULE)
+#define twl_has_madc()	true
+#else
+#define twl_has_madc()	false
+#endif
+
 /* Primary Interrupt Handler on TWL4030 Registers */
 
 /* Register Definitions */
@@ -772,6 +778,27 @@ static int add_children(struct twl4030_platform_data *pdata)
 		}
 	}
 
+	if (twl_has_madc() && pdata->madc) {
+		pdev = platform_device_alloc("twl4030_madc", -1);
+		if (pdev) {
+			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM2];
+			pdev->dev.parent = &twl->client->dev;
+			device_init_wakeup(&pdev->dev, 1);
+			status = platform_device_add_data(pdev, pdata->madc,
+					sizeof(*pdata->madc));
+			if (status < 0) {
+				platform_device_put(pdev);
+				goto err;
+			}
+			status = platform_device_add(pdev);
+			if (status < 0)
+				platform_device_put(pdev);
+		} else {
+			status = -ENOMEM;
+			goto err;
+		}
+	}
+
 err:
 	pr_err("failed to add twl4030's children\n");
 	return status;
diff --git a/drivers/i2c/chips/twl4030-madc.c b/drivers/i2c/chips/twl4030-madc.c
index 743db74..bff2554 100644
--- a/drivers/i2c/chips/twl4030-madc.c
+++ b/drivers/i2c/chips/twl4030-madc.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/platform_device.h>
 #include <linux/miscdevice.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/i2c/twl4030-madc.h>
@@ -37,13 +38,16 @@
 
 #define TWL4030_MADC_PFX	"twl4030-madc: "
 
-static struct twl4030_madc_data {
+struct twl4030_madc_data {
+	struct device		*dev;
 	struct mutex		lock;
 	struct work_struct	ws;
 	struct twl4030_madc_request	requests[TWL4030_MADC_NUM_METHODS];
-} twl4030_madc;
+	int imr;
+	int isr;
+};
 
-static const char irq_pin = 1; /* XXX Read from platfrom data */
+static struct twl4030_madc_data *the_madc;
 
 static
 const struct twl4030_madc_conversion_method twl4030_conversion_methods[] = {
@@ -66,35 +70,43 @@ const struct twl4030_madc_conversion_method twl4030_conversion_methods[] = {
 	},
 };
 
-static void twl4030_madc_read(u8 reg, u8 *val)
+static int twl4030_madc_read(struct twl4030_madc_data *madc, u8 reg)
 {
-	int ret = twl4030_i2c_read_u8(TWL4030_MODULE_MADC, val, reg);
-	if (ret)
-		printk(KERN_ERR TWL4030_MADC_PFX
-		       "unable to read register 0x%X\n", reg);
+	int ret;
+	u8 val;
+
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_MADC, &val, reg);
+	if (ret) {
+		dev_dbg(madc->dev, "unable to read register 0x%X\n", reg);
+		return ret;
+	}
+
+	return val;
 }
 
-static void twl4030_madc_write(u8 reg, u8 val)
+static void twl4030_madc_write(struct twl4030_madc_data *madc, u8 reg, u8 val)
 {
-	int ret = twl4030_i2c_write_u8(TWL4030_MODULE_MADC, val, reg);
+	int ret;
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_MADC, val, reg);
 	if (ret)
-		printk(KERN_ERR TWL4030_MADC_PFX
-		       "unable to write register 0x%X\n", reg);
+		dev_err(madc->dev, "unable to write register 0x%X\n", reg);
 }
 
-static int twl4030_madc_channel_raw_read(u8 reg)
+static int twl4030_madc_channel_raw_read(struct twl4030_madc_data *madc, u8 reg)
 {
 	u8 msb, lsb;
 
 	/* For each ADC channel, we have MSB and LSB register pair. MSB address
 	 * is always LSB address+1. reg parameter is the addr of LSB register */
-	twl4030_madc_read(reg+1, &msb);
-	twl4030_madc_read(reg, &lsb);
+	msb = twl4030_madc_read(madc, reg + 1);
+	lsb = twl4030_madc_read(madc, reg);
 
 	return (int)(((msb << 8) | lsb) >> 6);
 }
 
-static int twl4030_madc_read_channels(u8 reg_base, u16 channels, int *buf)
+static int twl4030_madc_read_channels(struct twl4030_madc_data *madc,
+		u8 reg_base, u16 channels, int *buf)
 {
 	int count = 0;
 	u8 reg, i;
@@ -105,47 +117,40 @@ static int twl4030_madc_read_channels(u8 reg_base, u16 channels, int *buf)
 	for (i = 0; i < TWL4030_MADC_MAX_CHANNELS; i++) {
 		if (channels & (1<<i)) {
 			reg = reg_base + 2*i;
-			buf[i] = twl4030_madc_channel_raw_read(reg);
+			buf[i] = twl4030_madc_channel_raw_read(madc, reg);
 			count++;
 		}
 	}
 	return count;
 }
 
-static void twl4030_madc_enable_irq(int id)
+static void twl4030_madc_enable_irq(struct twl4030_madc_data *madc, int id)
 {
 	u8 val;
 
-	static u8 imr = (irq_pin == 1) ? TWL4030_MADC_IMR1 : TWL4030_MADC_IMR2;
-
-	twl4030_madc_read(imr, &val);
+	val = twl4030_madc_read(madc, madc->imr);
 	val &= ~(1 << id);
-	twl4030_madc_write(imr, val);
+	twl4030_madc_write(madc, madc->imr, val);
 }
 
-static void twl4030_madc_disable_irq(int id)
+static void twl4030_madc_disable_irq(struct twl4030_madc_data *madc, int id)
 {
 	u8 val;
 
-	static u8 imr = (irq_pin == 1) ? TWL4030_MADC_IMR1 : TWL4030_MADC_IMR2;
-
-	twl4030_madc_read(imr, &val);
+	val = twl4030_madc_read(madc, madc->imr);
 	val |= (1 << id);
-	twl4030_madc_write(imr, val);
+	twl4030_madc_write(madc, madc->imr, val);
 }
 
-static irqreturn_t twl4030_madc_irq_handler(int irq, void *madc_dev)
+static irqreturn_t twl4030_madc_irq_handler(int irq, void *_madc)
 {
+	struct twl4030_madc_data *madc = _madc;
 	u8 isr_val, imr_val;
-	static u8 isr, imr;
 	int i;
 
-	imr = (irq_pin == 1) ? TWL4030_MADC_IMR1 : TWL4030_MADC_IMR2;
-	isr = (irq_pin == 1) ? TWL4030_MADC_ISR1 : TWL4030_MADC_ISR2;
-
 	/* Use COR to ack interrupts since we have no shared IRQs in ISRx */
-	twl4030_madc_read(isr, &isr_val);
-	twl4030_madc_read(imr, &imr_val);
+	isr_val = twl4030_madc_read(madc, madc->isr);
+	imr_val = twl4030_madc_read(madc, madc->imr);
 
 	isr_val &= ~imr_val;
 
@@ -154,11 +159,11 @@ static irqreturn_t twl4030_madc_irq_handler(int irq, void *madc_dev)
 		if (!(isr_val & (1<<i)))
 			continue;
 
-		twl4030_madc_disable_irq(i);
-		twl4030_madc.requests[i].result_pending = 1;
+		twl4030_madc_disable_irq(madc, i);
+		madc->requests[i].result_pending = 1;
 	}
 
-	schedule_work(&twl4030_madc.ws);
+	schedule_work(&madc->ws);
 
 	return IRQ_HANDLED;
 }
@@ -166,14 +171,16 @@ static irqreturn_t twl4030_madc_irq_handler(int irq, void *madc_dev)
 static void twl4030_madc_work(struct work_struct *ws)
 {
 	const struct twl4030_madc_conversion_method *method;
+	struct twl4030_madc_data *madc;
 	struct twl4030_madc_request *r;
 	int len, i;
 
-	mutex_lock(&twl4030_madc.lock);
+	madc = container_of(ws, struct twl4030_madc_data, ws);
+	mutex_lock(&madc->lock);
 
 	for (i = 0; i < TWL4030_MADC_NUM_METHODS; i++) {
 
-		r = &twl4030_madc.requests[i];
+		r = &madc->requests[i];
 
 		/* No pending results for this method, move to next one */
 		if (!r->result_pending)
@@ -182,7 +189,7 @@ static void twl4030_madc_work(struct work_struct *ws)
 		method = &twl4030_conversion_methods[r->method];
 
 		/* Read results */
-		len = twl4030_madc_read_channels(method->rbase,
+		len = twl4030_madc_read_channels(madc, method->rbase,
 						 r->channels, r->rbuf);
 
 		/* Return results to caller */
@@ -196,23 +203,25 @@ static void twl4030_madc_work(struct work_struct *ws)
 		r->active	  = 0;
 	}
 
-	mutex_unlock(&twl4030_madc.lock);
+	mutex_unlock(&madc->lock);
 }
 
-static int twl4030_madc_set_irq(struct twl4030_madc_request *req)
+static int twl4030_madc_set_irq(struct twl4030_madc_data *madc,
+		struct twl4030_madc_request *req)
 {
 	struct twl4030_madc_request *p;
 
-	p = &twl4030_madc.requests[req->method];
+	p = &madc->requests[req->method];
 
 	memcpy(p, req, sizeof *req);
 
-	twl4030_madc_enable_irq(req->method);
+	twl4030_madc_enable_irq(madc, req->method);
 
 	return 0;
 }
 
-static inline void twl4030_madc_start_conversion(int conv_method)
+static inline void twl4030_madc_start_conversion(struct twl4030_madc_data *madc,
+		int conv_method)
 {
 	const struct twl4030_madc_conversion_method *method;
 
@@ -221,7 +230,7 @@ static inline void twl4030_madc_start_conversion(int conv_method)
 	switch (conv_method) {
 	case TWL4030_MADC_SW1:
 	case TWL4030_MADC_SW2:
-		twl4030_madc_write(method->ctrl, TWL4030_MADC_SW_START);
+		twl4030_madc_write(madc, method->ctrl, TWL4030_MADC_SW_START);
 		break;
 	case TWL4030_MADC_RT:
 	default:
@@ -229,14 +238,16 @@ static inline void twl4030_madc_start_conversion(int conv_method)
 	}
 }
 
-static void twl4030_madc_wait_conversion_ready_ms(u8 *time, u8 status_reg)
+static void twl4030_madc_wait_conversion_ready_ms(
+		struct twl4030_madc_data *madc,
+		u8 *time, u8 status_reg)
 {
 	u8 reg = 0;
 
 	do {
 		msleep(1);
 		(*time)--;
-		twl4030_madc_read(status_reg, &reg);
+		reg = twl4030_madc_read(madc, status_reg);
 	} while (((reg & TWL4030_MADC_BUSY) && !(reg & TWL4030_MADC_EOC_SW)) &&
 		  (*time != 0));
 }
@@ -251,7 +262,7 @@ int twl4030_madc_conversion(struct twl4030_madc_request *req)
 		return -EINVAL;
 
 	/* Do we have a conversion request ongoing */
-	if (twl4030_madc.requests[req->method].active)
+	if (the_madc->requests[req->method].active)
 		return -EBUSY;
 
 	ch_msb = (req->channels >> 8) & 0xff;
@@ -259,22 +270,22 @@ int twl4030_madc_conversion(struct twl4030_madc_request *req)
 
 	method = &twl4030_conversion_methods[req->method];
 
-	mutex_lock(&twl4030_madc.lock);
+	mutex_lock(&the_madc->lock);
 
 	/* Select channels to be converted */
-	twl4030_madc_write(method->sel + 1, ch_msb);
-	twl4030_madc_write(method->sel, ch_lsb);
+	twl4030_madc_write(the_madc, method->sel + 1, ch_msb);
+	twl4030_madc_write(the_madc, method->sel, ch_lsb);
 
 	/* Select averaging for all channels if do_avg is set */
 	if (req->do_avg) {
-		twl4030_madc_write(method->avg + 1, ch_msb);
-		twl4030_madc_write(method->avg, ch_lsb);
+		twl4030_madc_write(the_madc, method->avg + 1, ch_msb);
+		twl4030_madc_write(the_madc, method->avg, ch_lsb);
 	}
 
 	if ((req->type == TWL4030_MADC_IRQ_ONESHOT) && (req->func_cb != NULL)) {
-		twl4030_madc_set_irq(req);
-		twl4030_madc_start_conversion(req->method);
-		twl4030_madc.requests[req->method].active = 1;
+		twl4030_madc_set_irq(the_madc, req);
+		twl4030_madc_start_conversion(the_madc, req->method);
+		the_madc->requests[req->method].active = 1;
 		ret = 0;
 		goto out;
 	}
@@ -285,32 +296,33 @@ int twl4030_madc_conversion(struct twl4030_madc_request *req)
 		goto out;
 	}
 
-	twl4030_madc_start_conversion(req->method);
-	twl4030_madc.requests[req->method].active = 1;
+	twl4030_madc_start_conversion(the_madc, req->method);
+	the_madc->requests[req->method].active = 1;
 
 	/* Wait until conversion is ready (ctrl register returns EOC) */
 	wait_time = 50;
-	twl4030_madc_wait_conversion_ready_ms(&wait_time, method->ctrl);
+	twl4030_madc_wait_conversion_ready_ms(the_madc,
+			&wait_time, method->ctrl);
 	if (wait_time == 0) {
-		printk(KERN_ERR TWL4030_MADC_PFX "conversion timeout!\n");
+		dev_dbg(the_madc->dev, "conversion timeout!\n");
 		ret = -EAGAIN;
 		goto out;
 	}
 
-	ret = twl4030_madc_read_channels(method->rbase, req->channels,
+	ret = twl4030_madc_read_channels(the_madc, method->rbase, req->channels,
 					 req->rbuf);
 
-	twl4030_madc.requests[req->method].active = 0;
+	the_madc->requests[req->method].active = 0;
 
 out:
-	mutex_unlock(&twl4030_madc.lock);
+	mutex_unlock(&the_madc->lock);
 
 	return ret;
 }
-
 EXPORT_SYMBOL(twl4030_madc_conversion);
 
-static int twl4030_madc_set_current_generator(int chan, int on)
+static int twl4030_madc_set_current_generator(struct twl4030_madc_data *madc,
+		int chan, int on)
 {
 	int ret;
 	u8 regval;
@@ -332,16 +344,16 @@ static int twl4030_madc_set_current_generator(int chan, int on)
 	return ret;
 }
 
-static int twl4030_madc_set_power(int on)
+static int twl4030_madc_set_power(struct twl4030_madc_data *madc, int on)
 {
 	u8 regval;
 
-	twl4030_madc_read(TWL4030_MADC_CTRL1, &regval);
+	regval = twl4030_madc_read(madc, TWL4030_MADC_CTRL1);
 	if (on)
 		regval |= TWL4030_MADC_MADCON;
 	else
 		regval &= ~TWL4030_MADC_MADCON;
-	twl4030_madc_write(TWL4030_MADC_CTRL1, regval);
+	twl4030_madc_write(madc, TWL4030_MADC_CTRL1, regval);
 
 	return 0;
 }
@@ -354,7 +366,7 @@ static int twl4030_madc_ioctl(struct inode *inode, struct file *filp,
 
 	ret = copy_from_user(&par, (void __user *) arg, sizeof(par));
 	if (ret) {
-		printk(KERN_ERR TWL4030_MADC_PFX "copy_from_user: %d\n", ret);
+		dev_dbg(the_madc->dev, "copy_from_user: %d\n", ret);
 		return -EACCES;
 	}
 
@@ -364,7 +376,7 @@ static int twl4030_madc_ioctl(struct inode *inode, struct file *filp,
 		if (par.channel >= TWL4030_MADC_MAX_CHANNELS)
 			return -EINVAL;
 
-		req.channels = (1<<par.channel);
+		req.channels = (1 << par.channel);
 		req.do_avg	= par.average;
 		req.method	= TWL4030_MADC_SW1;
 		req.func_cb	= NULL;
@@ -384,7 +396,7 @@ static int twl4030_madc_ioctl(struct inode *inode, struct file *filp,
 
 	ret = copy_to_user((void __user *) arg, &par, sizeof(par));
 	if (ret) {
-		printk(KERN_ERR TWL4030_MADC_PFX "copy_to_user: %d\n", ret);
+		dev_dbg(the_madc->dev, "copy_to_user: %d\n", ret);
 		return -EACCES;
 	}
 
@@ -398,22 +410,37 @@ static struct file_operations twl4030_madc_fileops = {
 
 static struct miscdevice twl4030_madc_device = {
 	.minor = MISC_DYNAMIC_MINOR,
-	.name = "twl4030-adc",
+	.name = "twl4030-madc",
 	.fops = &twl4030_madc_fileops
 };
 
-static int __init twl4030_madc_init(void)
+static int __init twl4030_madc_probe(struct platform_device *pdev)
 {
+	struct twl4030_madc_data *madc;
+	struct twl4030_madc_platform_data *pdata = pdev->dev.platform_data;
 	int ret;
 	u8 regval;
 
+	madc = kzalloc(sizeof *madc, GFP_KERNEL);
+	if (!madc)
+		return -ENOMEM;
+
+	if (!pdata) {
+		dev_dbg(&pdev->dev, "platform_data not available\n");
+		ret = -EINVAL;
+		goto err_pdata;
+	}
+
+	madc->imr = (pdata->irq_line == 1) ? TWL4030_MADC_IMR1 : TWL4030_MADC_IMR2;
+	madc->isr = (pdata->irq_line == 1) ? TWL4030_MADC_ISR1 : TWL4030_MADC_ISR2;
+
 	ret = misc_register(&twl4030_madc_device);
-	if (ret == -1) {
-		printk(KERN_ERR TWL4030_MADC_PFX "misc_register() failed!\n");
-		return ret;
+	if (ret) {
+		dev_dbg(&pdev->dev, "could not register misc_device\n");
+		goto err_misc;
 	}
-	twl4030_madc_set_power(1);
-	twl4030_madc_set_current_generator(0, 1);
+	twl4030_madc_set_power(madc, 1);
+	twl4030_madc_set_current_generator(madc, 0, 1);
 
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
 				  &regval, TWL4030_BCI_BCICTL1);
@@ -424,32 +451,66 @@ static int __init twl4030_madc_init(void)
 				   regval, TWL4030_BCI_BCICTL1);
 
 	ret = request_irq(TWL4030_MODIRQ_MADC, twl4030_madc_irq_handler,
-			  IRQF_DISABLED, "twl4030_madc", &twl4030_madc);
-	if (ret)
-		printk(KERN_ERR TWL4030_MADC_PFX "request_irq: %d\n", ret);
+			  IRQF_DISABLED, "twl4030_madc", madc);
+	if (ret) {
+		dev_dbg(&pdev->dev, "could not request irq\n");
+		goto err_irq;
+	}
 
-	mutex_init(&twl4030_madc.lock);
+	platform_set_drvdata(pdev, madc);
+	mutex_init(&madc->lock);
+	INIT_WORK(&madc->ws, twl4030_madc_work);
 
-	INIT_WORK(&twl4030_madc.ws, twl4030_madc_work);
+	the_madc = madc;
 
-	printk(KERN_INFO TWL4030_MADC_PFX "initialised\n");
+	return 0;
+
+err_irq:
+	misc_deregister(&twl4030_madc_device);
+
+err_misc:
+err_pdata:
+	kfree(madc);
 
 	return ret;
 }
 
-static void __exit twl4030_madc_exit(void)
+static int __exit twl4030_madc_remove(struct platform_device *pdev)
 {
-	twl4030_madc_set_power(0);
-	twl4030_madc_set_current_generator(0, 0);
-	free_irq(TWL4030_MODIRQ_MADC, &twl4030_madc);
-	cancel_work_sync(&twl4030_madc.ws);
+	struct twl4030_madc_data *madc = platform_get_drvdata(pdev);
+
+	twl4030_madc_set_power(madc, 0);
+	twl4030_madc_set_current_generator(madc, 0, 0);
+	free_irq(TWL4030_MODIRQ_MADC, madc);
+	cancel_work_sync(&madc->ws);
 	misc_deregister(&twl4030_madc_device);
+
+	return 0;
 }
 
+static struct platform_driver twl4030_madc_driver = {
+	.probe		= twl4030_madc_probe,
+	.remove		= __exit_p(twl4030_madc_remove),
+	.driver		= {
+		.name	= "twl4030_madc",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init twl4030_madc_init(void)
+{
+	return platform_driver_register(&twl4030_madc_driver);
+}
 module_init(twl4030_madc_init);
+
+static void __exit twl4030_madc_exit(void)
+{
+	platform_driver_unregister(&twl4030_madc_driver);
+}
 module_exit(twl4030_madc_exit);
 
-MODULE_ALIAS("i2c:twl4030-adc");
+MODULE_ALIAS("platform:twl4030-madc");
 MODULE_AUTHOR("Nokia Corporation");
 MODULE_DESCRIPTION("twl4030 ADC driver");
 MODULE_LICENSE("GPL");
+
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index b80e8b6..404300c 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -67,6 +67,10 @@ struct twl4030_gpio_platform_data {
 				unsigned gpio, unsigned ngpio);
 };
 
+struct twl4030_madc_platform_data {
+	int		irq_line;
+};
+
 struct twl4030_keypad_data {
 	int rows;
 	int cols;
@@ -88,6 +92,7 @@ struct twl4030_usb_data {
 struct twl4030_platform_data {
 	unsigned				irq_base, irq_end;
 	struct twl4030_gpio_platform_data	*gpio;
+	struct twl4030_madc_platform_data	*madc;
 	struct twl4030_keypad_data		*keypad;
 	struct twl4030_usb_data			*usb;
 
-- 
1.6.0.1.196.g01914

