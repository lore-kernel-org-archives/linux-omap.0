From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [RFC PATCH 09/11] ARM: OMAP4+: thermal: introduce bandgap temperature
 sensor
Date: Fri, 25 May 2012 20:39:09 +0400
Message-ID: <4FBFB5AD.6000005@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-10-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:53046 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754249Ab2EYQjL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 12:39:11 -0400
In-Reply-To: <1337934361-1606-10-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Keerthy <j-keerthy@ti.com>, Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

  Hi.
On 05/25/2012 12:25 PM, Eduardo Valentin wrote:
> In the System Control Module, OMAP supplies a voltage reference
> and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
>
> This patch provides a platform driver which expose this feature.
> It is moduled as a MFD child of the System Control Module core
> MFD driver.
>
> This driver provides only APIs to access the device properties,
> like temperature, thresholds and update rate.
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../devicetree/bindings/thermal/omap_bandgap.txt   |   27 +
>  drivers/thermal/Kconfig                            |   13 +
>  drivers/thermal/Makefile                           |    4 +-
>  drivers/thermal/omap-bandgap.c                     | 1601 ++++++++++++++++++++
>  drivers/thermal/omap-bandgap.h                     |   63 +
>  5 files changed, 1707 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/omap_bandgap.txt
>  create mode 100644 drivers/thermal/omap-bandgap.c
>  create mode 100644 drivers/thermal/omap-bandgap.h
>
>
Add private spin lock in omap-bandgap driver to prevent blocking of
control module general registers access.
I wasn't able to test - I have panda 4430 board.

TODO:
Prevent over-usage of spin_lock/spin_unlock for sequential calls of
bg_writel().

Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

Index: omap-thermal/drivers/mfd/omap-control-core.c
===================================================================
--- omap-thermal.orig/drivers/mfd/omap-control-core.c
+++ omap-thermal/drivers/mfd/omap-control-core.c
@@ -67,6 +67,19 @@ EXPORT_SYMBOL_GPL(omap_control_readl);
 int omap_control_writel(struct device *dev, u32 val, u32 reg)
 {
 	struct omap_control *omap_control = dev_get_drvdata(dev);
+
+	if (!omap_control)
+		return -EINVAL;
+
+	writel(val, omap_control->base + reg);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(omap_control_writel);
+
+int omap_control_lock_writel(struct device *dev, u32 val, u32 reg)
+{
+	struct omap_control *omap_control = dev_get_drvdata(dev);
 	unsigned long flags;
 
 	if (!omap_control)
@@ -78,7 +91,7 @@ int omap_control_writel(struct device *d
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_control_writel);
+EXPORT_SYMBOL_GPL(omap_control_lock_writel);
 
 /**
  * omap_control_get: returns the control module device pinter
@@ -136,6 +149,9 @@ static int __devinit omap_control_probe(
 	struct device_node *np = dev->of_node;
 	struct omap_control *omap_control;
 
+	printk("\n\t\t **** omap_control_probe(): enter ");
+	dump_stack();
+
 	omap_control = devm_kzalloc(dev, sizeof(*omap_control), GFP_KERNEL);
 	if (!omap_control) {
 		dev_err(dev, "not enough memory for omap_control\n");
Index: omap-thermal/drivers/thermal/omap-bandgap.c
===================================================================
--- omap-thermal.orig/drivers/thermal/omap-bandgap.c
+++ omap-thermal/drivers/thermal/omap-bandgap.c
@@ -154,6 +154,7 @@ struct temp_sensor_registers {
 	u32	status_cold_mask;
 
 	u32	bgap_efuse;
+	spinlock_t	bg_reg_lock;
 };
 
 /**
@@ -579,6 +580,17 @@ omap5430_adc_to_temp[OMAP5430_ADC_END_VA
 	124600, 124900, 125000, 125000, 125000, 125000,
 };
 
+static int bg_writel(struct device *dev, u32 val, u32 reg, spinlock_t *lock)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(lock, flags);
+	ret = omap_control_writel(dev, val, reg);
+	spin_unlock_irqrestore(lock, flags);
+	return ret;
+}
+
 static irqreturn_t talert_irq_handler(int irq, void *data)
 {
 	struct omap_bandgap *bg_ptr = data;
@@ -615,7 +627,7 @@ static irqreturn_t talert_irq_handler(in
 			ctrl |= tsr->mask_hot_mask;
 		}
 
-		r |= omap_control_writel(cdev, ctrl, tsr->bgap_mask_ctrl);
+		r |= bg_writel(cdev, ctrl, tsr->bgap_mask_ctrl, &tsr->bg_reg_lock);
 
 		if (r) {
 			dev_err(bg_ptr->dev, "failed to ack talert interrupt\n");
@@ -705,7 +717,7 @@ static int temp_sensor_unmask_interrupts
 		reg_val |= tsr->mask_cold_mask;
 	else
 		reg_val &= ~tsr->mask_cold_mask;
-	err |= omap_control_writel(cdev, reg_val, tsr->bgap_mask_ctrl);
+	err |= bg_writel(cdev, reg_val, tsr->bgap_mask_ctrl, &tsr->bg_reg_lock);
 
 	if (err) {
 		dev_err(bg_ptr->dev, "failed to unmask interrupts\n");
@@ -751,14 +763,14 @@ int temp_sensor_configure_thot(struct om
 		/* write the new t_cold value */
 		reg_val = thresh_val & (~tsr->threshold_tcold_mask);
 		reg_val |= cold << __ffs(tsr->threshold_tcold_mask);
-		err |= omap_control_writel(cdev, reg_val, tsr->bgap_threshold);
+		err |= bg_writel(cdev, reg_val, tsr->bgap_threshold, &tsr->bg_reg_lock);
 		thresh_val = reg_val;
 	}
 
 	/* write the new t_hot value */
 	reg_val = thresh_val & ~tsr->threshold_thot_mask;
 	reg_val |= (t_hot << __ffs(tsr->threshold_thot_mask));
-	err |= omap_control_writel(cdev, reg_val, tsr->bgap_threshold);
+	err |= bg_writel(cdev, reg_val, tsr->bgap_threshold, &tsr->bg_reg_lock);
 	if (err) {
 		dev_err(bg_ptr->dev, "failed to reprogram thot threshold\n");
 		return -EIO;
@@ -782,7 +794,7 @@ int temp_sensor_init_talert_thresholds(s
 	/* write the new t_cold value */
 	reg_val = thresh_val & ~tsr->threshold_tcold_mask;
 	reg_val |= (t_cold << __ffs(tsr->threshold_tcold_mask));
-	err |= omap_control_writel(cdev, reg_val, tsr->bgap_threshold);
+	err |= bg_writel(cdev, reg_val, tsr->bgap_threshold, &tsr->bg_reg_lock);
 	if (err) {
 		dev_err(bg_ptr->dev, "failed to reprogram tcold threshold\n");
 		return -EIO;
@@ -793,7 +805,7 @@ int temp_sensor_init_talert_thresholds(s
 	/* write the new t_hot value */
 	reg_val = thresh_val & ~tsr->threshold_thot_mask;
 	reg_val |= (t_hot << __ffs(tsr->threshold_thot_mask));
-	err |= omap_control_writel(cdev, reg_val, tsr->bgap_threshold);
+	err |= bg_writel(cdev, reg_val, tsr->bgap_threshold, &tsr->bg_reg_lock);
 	if (err) {
 		dev_err(bg_ptr->dev, "failed to reprogram thot threshold\n");
 		return -EIO;
@@ -802,7 +814,7 @@ int temp_sensor_init_talert_thresholds(s
 	err = omap_control_readl(cdev, tsr->bgap_mask_ctrl, &reg_val);
 	reg_val |= tsr->mask_hot_mask;
 	reg_val |= tsr->mask_cold_mask;
-	err |= omap_control_writel(cdev, reg_val, tsr->bgap_mask_ctrl);
+	err |= bg_writel(cdev, reg_val, tsr->bgap_mask_ctrl, &tsr->bg_reg_lock);
 	if (err) {
 		dev_err(bg_ptr->dev, "failed to reprogram thot threshold\n");
 		return -EIO;
@@ -833,14 +845,14 @@ int temp_sensor_configure_tcold(struct o
 		/* write the new t_hot value */
 		reg_val = thresh_val & (~tsr->threshold_thot_mask);
 		reg_val |= hot << __ffs(tsr->threshold_thot_mask);
-		err |= omap_control_writel(cdev, reg_val, tsr->bgap_threshold);
+		err |= bg_writel(cdev, reg_val, tsr->bgap_threshold, &tsr->bg_reg_lock);
 		thresh_val = reg_val;
 	}
 
 	/* write the new t_cold value */
 	reg_val = thresh_val & ~tsr->threshold_tcold_mask;
 	reg_val |= (t_cold << __ffs(tsr->threshold_tcold_mask));
-	err |= omap_control_writel(cdev, reg_val, tsr->bgap_threshold);
+	err |= bg_writel(cdev, reg_val, tsr->bgap_threshold, &tsr->bg_reg_lock);
 	if (err) {
 		dev_err(bg_ptr->dev, "failed to reprogram tcold threshold\n");
 		return -EIO;
@@ -861,7 +873,7 @@ static int temp_sensor_configure_tshut_h
 	err = omap_control_readl(cdev, tsr->tshut_threshold, &reg_val);
 	reg_val &= ~tsr->tshut_hot_mask;
 	reg_val |= tshut_hot << __ffs(tsr->tshut_hot_mask);
-	err |= omap_control_writel(cdev, reg_val, tsr->tshut_threshold);
+	err |= bg_writel(cdev, reg_val, tsr->tshut_threshold, &tsr->bg_reg_lock);
 	if (err) {
 		dev_err(bg_ptr->dev, "failed to reprogram tshut thot\n");
 		return -EIO;
@@ -882,7 +894,7 @@ static int temp_sensor_configure_tshut_c
 	err = omap_control_readl(cdev, tsr->tshut_threshold, &reg_val);
 	reg_val &= ~tsr->tshut_cold_mask;
 	reg_val |= tshut_cold << __ffs(tsr->tshut_cold_mask);
-	err |= omap_control_writel(cdev, reg_val, tsr->tshut_threshold);
+	err |= bg_writel(cdev, reg_val, tsr->tshut_threshold, &tsr->bg_reg_lock);
 	if (err) {
 		dev_err(bg_ptr->dev, "failed to reprogram tshut tcold\n");
 		return -EIO;
@@ -903,7 +915,7 @@ static int configure_temp_sensor_counter
 	err = omap_control_readl(cdev, tsr->bgap_counter, &val);
 	val &= ~tsr->counter_mask;
 	val |= counter << __ffs(tsr->counter_mask);
-	err |= omap_control_writel(cdev, val, tsr->bgap_counter);
+	err |= bg_writel(cdev, val, tsr->bgap_counter, &tsr->bg_reg_lock);
 	if (err) {
 		dev_err(bg_ptr->dev, "failed to reprogram tshut tcold\n");
 		return -EIO;
@@ -1124,7 +1136,7 @@ static int enable_continuous_mode(struct
 		tsr = bg_ptr->pdata->sensors[i].registers;
 		r = omap_control_readl(cdev, tsr->bgap_mode_ctrl, &val);
 		val |= 1 << __ffs(tsr->mode_ctrl_mask);
-		r |= omap_control_writel(cdev, val, tsr->bgap_mode_ctrl);
+		r |= bg_writel(cdev, val, tsr->bgap_mode_ctrl, &tsr->bg_reg_lock);
 		if (r)
 			dev_err(bg_ptr->dev, "could not save sensor %d\n", i);
 	}
@@ -1342,6 +1354,9 @@ int __devinit omap_bandgap_probe(struct
 		u32 val;
 
 		tsr = bg_ptr->pdata->sensors[i].registers;
+		/* Initialize register lock */
+		spin_lock_init(&tsr->bg_reg_lock);
+
 		/*
 		 * check if the efuse has a non-zero value if not
 		 * it is an untrimmed sample and the temperatures
@@ -1482,12 +1497,12 @@ omap_bandgap_force_single_read(struct om
 	/* Select single conversion mode */
 	err = omap_control_readl(cdev, tsr->bgap_mode_ctrl, &temp);
 	temp &= ~(1 << __ffs(tsr->mode_ctrl_mask));
-	omap_control_writel(cdev, temp, tsr->bgap_mode_ctrl);
+	bg_writel(cdev, temp, tsr->bgap_mode_ctrl, &tsr->bg_reg_lock);
 
 	/* Start of Conversion = 1 */
 	err |= omap_control_readl(cdev, tsr->temp_sensor_ctrl, &temp);
 	temp |= 1 << __ffs(tsr->bgap_soc_mask);
-	omap_control_writel(cdev, temp, tsr->temp_sensor_ctrl);
+	bg_writel(cdev, temp, tsr->temp_sensor_ctrl, &tsr->bg_reg_lock);
 	/* Wait until DTEMP is updated */
 	err |= omap_control_readl(cdev, tsr->temp_sensor_ctrl, &temp);
 	temp &= (tsr->bgap_dtemp_mask);
@@ -1498,7 +1513,7 @@ omap_bandgap_force_single_read(struct om
 	/* Start of Conversion = 0 */
 	err |= omap_control_readl(cdev, tsr->temp_sensor_ctrl, &temp);
 	temp &= ~(1 << __ffs(tsr->bgap_soc_mask));
-	err |= omap_control_writel(cdev, temp, tsr->temp_sensor_ctrl);
+	err |= bg_writel(cdev, temp, tsr->temp_sensor_ctrl, &tsr->bg_reg_lock);
 
 	return err ? -EIO : 0;
 }
@@ -1519,20 +1534,20 @@ static int omap_bandgap_restore_ctxt(str
 
 		err = omap_control_readl(cdev, tsr->bgap_counter, &val);
 		if (val == 0) {
-			err |= omap_control_writel(cdev, rval->bg_threshold,
-						   tsr->bgap_threshold);
-			err |= omap_control_writel(cdev, rval->tshut_threshold,
-						   tsr->tshut_threshold);
+			err |= bg_writel(cdev, rval->bg_threshold,
+						   tsr->bgap_threshold, &tsr->bg_reg_lock);
+			err |= bg_writel(cdev, rval->tshut_threshold,
+						   tsr->tshut_threshold, &tsr->bg_reg_lock);
 			/* Force immediate temperature measurement and update
 			 * of the DTEMP field
 			 */
 			omap_bandgap_force_single_read(bg_ptr, i);
-			err |= omap_control_writel(cdev, rval->bg_counter,
-						   tsr->bgap_counter);
-			err |= omap_control_writel(cdev, rval->bg_mode_ctrl,
-						   tsr->bgap_mode_ctrl);
-			err |= omap_control_writel(cdev, rval->bg_ctrl,
-						   tsr->bgap_mask_ctrl);
+			err |= bg_writel(cdev, rval->bg_counter,
+						   tsr->bgap_counter, &tsr->bg_reg_lock);
+			err |= bg_writel(cdev, rval->bg_mode_ctrl,
+						   tsr->bgap_mode_ctrl, &tsr->bg_reg_lock);
+			err |= bg_writel(cdev, rval->bg_ctrl,
+						   tsr->bgap_mask_ctrl, &tsr->bg_reg_lock);
 		} else {
 			err |= omap_control_readl(cdev, tsr->temp_sensor_ctrl,
 						 &temp);
@@ -1543,8 +1558,8 @@ static int omap_bandgap_restore_ctxt(str
 							  tsr->bgap_mask_ctrl,
 							  &temp);
 				temp |= 1 << __ffs(tsr->mode_ctrl_mask);
-				err |= omap_control_writel(cdev, temp,
-							   tsr->bgap_mask_ctrl);
+				err |= bg_writel(cdev, temp,
+							   tsr->bgap_mask_ctrl, &tsr->bg_reg_lock);
 			}
 		}
 		if (err)
Index: omap-thermal/drivers/usb/otg/omap4-usb-phy.c
===================================================================
--- omap-thermal.orig/drivers/usb/otg/omap4-usb-phy.c
+++ omap-thermal/drivers/usb/otg/omap4-usb-phy.c
@@ -46,13 +46,13 @@ int omap4_usb_phy_power(struct device *d
 	if (on) {
 		ret = omap_control_readl(dev, CONTROL_DEV_CONF, &val);
 		if (!ret && (val & PHY_PD)) {
-			ret = omap_control_writel(dev, ~PHY_PD,
+			ret = omap_control_lock_writel(dev, ~PHY_PD,
 						  CONTROL_DEV_CONF);
 			/* XXX: add proper documentation for this delay */
 			mdelay(200);
 		}
 	} else {
-		ret = omap_control_writel(dev, PHY_PD, CONTROL_DEV_CONF);
+		ret = omap_control_lock_writel(dev, PHY_PD, CONTROL_DEV_CONF);
 	}
 
 	return ret;
@@ -74,7 +74,7 @@ EXPORT_SYMBOL_GPL(omap4_usb_phy_power);
  */
 int omap4_usb_phy_mailbox(struct device *dev, u32 val)
 {
-	return omap_control_writel(dev, val, CONTROL_USBOTGHS_CONTROL);
+	return omap_control_lock_writel(dev, val, CONTROL_USBOTGHS_CONTROL);
 }
 EXPORT_SYMBOL_GPL(omap4_usb_phy_mailbox);
 
Index: omap-thermal/include/linux/mfd/omap_control.h
===================================================================
--- omap-thermal.orig/include/linux/mfd/omap_control.h
+++ omap-thermal/include/linux/mfd/omap_control.h
@@ -43,6 +43,7 @@ struct omap_control {
 #ifdef CONFIG_MFD_OMAP_CONTROL
 extern int omap_control_readl(struct device *dev, u32 reg, u32 *val);
 extern int omap_control_writel(struct device *dev, u32 val, u32 reg);
+extern int omap_control_lock_writel(struct device *dev, u32 val, u32 reg);
 extern struct device *omap_control_get(void);
 extern void omap_control_put(struct device *dev);
 #else
@@ -55,6 +56,11 @@ static inline int omap_control_writel(st
 {
 	return 0;
 }
+
+static inline int omap_control_lock_writel(struct device *dev, u32 val, u32 reg)
+{
+	return 0;
+}
 
 static inline struct device *omap_control_get(void)
 {


