From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] OMAPDSS: panel-sharp-ls037v7dw01: update to use gpiod
Date: Thu, 8 May 2014 16:25:57 -0700
Message-ID: <20140508232556.GH2198@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-3-git-send-email-tony@atomide.com>
 <5369EB90.8060007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47969 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932080AbaEHX0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 19:26:05 -0400
Content-Disposition: inline
In-Reply-To: <5369EB90.8060007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140507 01:15]:
> On 30/04/14 02:52, Tony Lindgren wrote:
> > +static struct gpio_desc *
> > +sharp_ls_get_gpio(struct device *dev, int gpio, unsigned long flags,
> > +		  char *desc)
> > +{
> > +	int r;
> > +
> > +	r = devm_gpio_request_one(dev, gpio, flags, desc);
> > +	if (r) {
> > +		dev_err(dev, "no %s gpio\n", desc);
> 
> As it's fine to not have a gpio, I guess this error print should be removed.

OK I made it a dev_dbg, it may help somebody while
configuring the panel.
 
> Also, if the error is EPROBE_DEFER, the driver should fail and return
> that. The same goes for the DT version in the next patch.

Good catch. It's a bit unfortunate that all drivers have to
sprinkle EPROBE_DEFER handling all over the place, that issue
is really caused by a missing resource management layer at
the bus level :(

Below is the updated patch, please feel free to pick if OK.

Regards,

Tony

8<---------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 28 Apr 2014 20:22:20 -0700
Subject: [PATCH] OMAPDSS: panel-sharp-ls037v7dw01: update to use gpiod

Using gpiod will make it easier to add device tree support
for this panel in the following patches.

Note that all the GPIOs for this panel are optional, any
of the the GPIOs could be configured with external pulls
instead of GPIOs, so let's not error out if GPIOs are not
found to make the panel more generic.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
@@ -26,11 +26,11 @@ struct panel_drv_data {
 
 	struct omap_video_timings videomode;
 
-	int resb_gpio;
-	int ini_gpio;
-	int mo_gpio;
-	int lr_gpio;
-	int ud_gpio;
+	struct gpio_desc *resb_gpio;	/* low = reset active min 20 us */
+	struct gpio_desc *ini_gpio;	/* high = power on */
+	struct gpio_desc *mo_gpio;	/* low = 480x640, high = 240x320 */
+	struct gpio_desc *lr_gpio;	/* high = conventional horizontal scanning */
+	struct gpio_desc *ud_gpio;	/* high = conventional vertical scanning */
 };
 
 static const struct omap_video_timings sharp_ls_timings = {
@@ -105,11 +105,11 @@ static int sharp_ls_enable(struct omap_dss_device *dssdev)
 	/* wait couple of vsyncs until enabling the LCD */
 	msleep(50);
 
-	if (gpio_is_valid(ddata->resb_gpio))
-		gpio_set_value_cansleep(ddata->resb_gpio, 1);
+	if (!IS_ERR(ddata->resb_gpio))
+		gpiod_set_value_cansleep(ddata->resb_gpio, 1);
 
-	if (gpio_is_valid(ddata->ini_gpio))
-		gpio_set_value_cansleep(ddata->ini_gpio, 1);
+	if (!IS_ERR(ddata->ini_gpio))
+		gpiod_set_value_cansleep(ddata->ini_gpio, 1);
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
@@ -124,11 +124,11 @@ static void sharp_ls_disable(struct omap_dss_device *dssdev)
 	if (!omapdss_device_is_enabled(dssdev))
 		return;
 
-	if (gpio_is_valid(ddata->ini_gpio))
-		gpio_set_value_cansleep(ddata->ini_gpio, 0);
+	if (!IS_ERR(ddata->ini_gpio))
+		gpiod_set_value_cansleep(ddata->ini_gpio, 0);
 
-	if (gpio_is_valid(ddata->resb_gpio))
-		gpio_set_value_cansleep(ddata->resb_gpio, 0);
+	if (!IS_ERR(ddata->resb_gpio))
+		gpiod_set_value_cansleep(ddata->resb_gpio, 0);
 
 	/* wait at least 5 vsyncs after disabling the LCD */
 
@@ -182,6 +182,21 @@ static struct omap_dss_driver sharp_ls_ops = {
 	.get_resolution	= omapdss_default_get_resolution,
 };
 
+static struct gpio_desc *
+sharp_ls_get_gpio(struct device *dev, int gpio, unsigned long flags,
+		  char *desc)
+{
+	int r;
+
+	r = devm_gpio_request_one(dev, gpio, flags, desc);
+	if (r) {
+		dev_dbg(dev, "no %s gpio\n", desc);
+		return ERR_PTR(r);
+	}
+
+	return gpio_to_desc(gpio);
+}
+
 static int sharp_ls_probe_pdata(struct platform_device *pdev)
 {
 	const struct panel_sharp_ls037v7dw01_platform_data *pdata;
@@ -204,11 +219,26 @@ static int sharp_ls_probe_pdata(struct platform_device *pdev)
 	dssdev = &ddata->dssdev;
 	dssdev->name = pdata->name;
 
-	ddata->resb_gpio = pdata->resb_gpio;
-	ddata->ini_gpio = pdata->ini_gpio;
-	ddata->mo_gpio = pdata->mo_gpio;
-	ddata->lr_gpio = pdata->lr_gpio;
-	ddata->ud_gpio = pdata->ud_gpio;
+	ddata->mo_gpio = sharp_ls_get_gpio(&pdev->dev, pdata->mo_gpio,
+					   GPIOF_OUT_INIT_LOW, "lcd MO");
+	if (PTR_ERR(ddata->mo_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	ddata->lr_gpio = sharp_ls_get_gpio(&pdev->dev, pdata->lr_gpio,
+					   GPIOF_OUT_INIT_HIGH, "lcd LR");
+	if (PTR_ERR(ddata->lr_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	ddata->ud_gpio = sharp_ls_get_gpio(&pdev->dev, pdata->ud_gpio,
+					   GPIOF_OUT_INIT_HIGH, "lcd UD");
+	if (PTR_ERR(ddata->ud_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	ddata->resb_gpio = sharp_ls_get_gpio(&pdev->dev, pdata->resb_gpio,
+					     GPIOF_OUT_INIT_LOW, "lcd RESB");
+	if (PTR_ERR(ddata->resb_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	ddata->ini_gpio = sharp_ls_get_gpio(&pdev->dev, pdata->ini_gpio,
+					    GPIOF_OUT_INIT_LOW, "lcd INI");
+	if (PTR_ERR(ddata->ini_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 
 	return 0;
 }
@@ -233,41 +263,6 @@ static int sharp_ls_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (gpio_is_valid(ddata->mo_gpio)) {
-		r = devm_gpio_request_one(&pdev->dev, ddata->mo_gpio,
-				GPIOF_OUT_INIT_LOW, "lcd MO");
-		if (r)
-			goto err_gpio;
-	}
-
-	if (gpio_is_valid(ddata->lr_gpio)) {
-		r = devm_gpio_request_one(&pdev->dev, ddata->lr_gpio,
-				GPIOF_OUT_INIT_HIGH, "lcd LR");
-		if (r)
-			goto err_gpio;
-	}
-
-	if (gpio_is_valid(ddata->ud_gpio)) {
-		r = devm_gpio_request_one(&pdev->dev, ddata->ud_gpio,
-				GPIOF_OUT_INIT_HIGH, "lcd UD");
-		if (r)
-			goto err_gpio;
-	}
-
-	if (gpio_is_valid(ddata->resb_gpio)) {
-		r = devm_gpio_request_one(&pdev->dev, ddata->resb_gpio,
-				GPIOF_OUT_INIT_LOW, "lcd RESB");
-		if (r)
-			goto err_gpio;
-	}
-
-	if (gpio_is_valid(ddata->ini_gpio)) {
-		r = devm_gpio_request_one(&pdev->dev, ddata->ini_gpio,
-				GPIOF_OUT_INIT_LOW, "lcd INI");
-		if (r)
-			goto err_gpio;
-	}
-
 	ddata->videomode = sharp_ls_timings;
 
 	dssdev = &ddata->dssdev;
@@ -287,7 +282,6 @@ static int sharp_ls_probe(struct platform_device *pdev)
 	return 0;
 
 err_reg:
-err_gpio:
 	omap_dss_put_device(ddata->in);
 	return r;
 }
