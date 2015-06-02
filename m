From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Please revert 3eea8b5d68c801fec788b411582b803463834752 as it
 breaks touchscreen on n900.
Date: Tue, 2 Jun 2015 11:08:55 -0700
Message-ID: <20150602180855.GC11297@dtor-ws>
References: <20150529203456.GC22083@amd>
 <20150601095556.GH17267@lukather>
 <20150601140605.GA26908@amd>
 <20150601145825.GA20557@lukather>
 <20150601152111.GA14015@amd>
 <20150601174730.GA30024@dtor-ws>
 <20150601212226.GH23777@lukather>
 <20150601213213.GB14395@dtor-ws>
 <20150602094447.GW23777@lukather>
 <20150602175845.GB11297@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34717 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbbFBSJB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 14:09:01 -0400
Content-Disposition: inline
In-Reply-To: <20150602175845.GB11297@dtor-ws>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

On Tue, Jun 02, 2015 at 10:58:45AM -0700, Dmitry Torokhov wrote:
> On Tue, Jun 02, 2015 at 11:44:47AM +0200, Maxime Ripard wrote:
> > On Mon, Jun 01, 2015 at 02:32:13PM -0700, Dmitry Torokhov wrote:
> > > On Mon, Jun 01, 2015 at 11:22:26PM +0200, Maxime Ripard wrote:
> > > > Hi Dmitry,
> > > > 
> > > > On Mon, Jun 01, 2015 at 10:47:30AM -0700, Dmitry Torokhov wrote:
> > > > > -static u32 of_get_optional_u32(struct device_node *np,
> > > > > -			       const char *property)
> > > > > +static bool touchscreen_get_property_u32(struct device_node *np,
> > > > > +					 const char *property,
> > > > > +					 unsigned int default_value,
> > > > > +					 unsigned int *value)
> > > > >  {
> > > > >  	u32 val = 0;
> > > > > +	int error;
> > > > >  
> > > > > -	of_property_read_u32(np, property, &val);
> > > > > +	error = of_property_read_u32(np, property, &val);
> > > > > +	if (error) {
> > > > > +		*value = default_value;
> > > > > +		return false;
> > > > > +	}
> > > > >  
> > > > > -	return val;
> > > > > +	*value = val;
> > > > > +	return true;
> > > > 
> > > > This looks good.
> > > > 
> > > > However, of_property_read_u32 already does the right thing here by not
> > > > update val if the property is not found.
> > > 
> > > I know but it is not documented anywhere (as far as I know) so I'd
> > > rather not rely on the implementation detail that might change in the
> > > future. This is not a hot path so extra assignment should not hurt.
> > 
> > It is actually: http://lxr.free-electrons.com/source/drivers/of/base.c#L1231
> 
> OK, fair enough. But not for ACPI properties (and I think we should
> convert the parser to device_property_read_xxx() so it is usable
> everywhere).

By the way, the previous version was busted, this one should compile.

-- 
Dmitry


Input: improve parsing OF parameters for touchscreens

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

When applying touchscreen parameters specified in device tree let's make
sure we keep whatever setup was done by the driver and not reset the
missing values to zero.

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c     |    2 -
 drivers/input/touchscreen/of_touchscreen.c |   69 ++++++++++++++++++----------
 drivers/input/touchscreen/tsc2005.c        |    2 -
 include/linux/input/touchscreen.h          |    5 +-
 4 files changed, 49 insertions(+), 29 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 29d179a..394b1de 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1041,7 +1041,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 			     0, tsdata->num_y * 64 - 1, 0, 0);
 
 	if (!pdata)
-		touchscreen_parse_of_params(input);
+		touchscreen_parse_of_params(input, true);
 
 	error = input_mt_init_slots(input, MAX_SUPPORT_POINTS, INPUT_MT_DIRECT);
 	if (error) {
diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
index b82b520..806cd0a 100644
--- a/drivers/input/touchscreen/of_touchscreen.c
+++ b/drivers/input/touchscreen/of_touchscreen.c
@@ -14,14 +14,22 @@
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
 
-static u32 of_get_optional_u32(struct device_node *np,
-			       const char *property)
+static bool touchscreen_get_prop_u32(struct device_node *np,
+				     const char *property,
+				     unsigned int default_value,
+				     unsigned int *value)
 {
-	u32 val = 0;
+	u32 val;
+	int error;
 
-	of_property_read_u32(np, property, &val);
+	error = of_property_read_u32(np, property, &val);
+	if (error) {
+		*value = default_value;
+		return false;
+	}
 
-	return val;
+	*value = val;
+	return true;
 }
 
 static void touchscreen_set_params(struct input_dev *dev,
@@ -54,34 +62,45 @@ static void touchscreen_set_params(struct input_dev *dev,
  * input device accordingly. The function keeps previously setuped default
  * values if no value is specified via DT.
  */
-void touchscreen_parse_of_params(struct input_dev *dev)
+void touchscreen_parse_of_params(struct input_dev *dev, bool multitouch)
 {
 	struct device_node *np = dev->dev.parent->of_node;
-	u32 maximum, fuzz;
+	unsigned int axis;
+	unsigned int maximum, fuzz;
+	bool data_present;
 
 	input_alloc_absinfo(dev);
 	if (!dev->absinfo)
 		return;
 
-	maximum = of_get_optional_u32(np, "touchscreen-size-x");
-	fuzz = of_get_optional_u32(np, "touchscreen-fuzz-x");
-	if (maximum || fuzz) {
-		touchscreen_set_params(dev, ABS_X, maximum, fuzz);
-		touchscreen_set_params(dev, ABS_MT_POSITION_X, maximum, fuzz);
-	}
+	axis = multitouch ? ABS_MT_POSITION_X : ABS_X;
+	data_present = touchscreen_get_prop_u32(np, "touchscreen-size-x",
+						input_abs_get_max(dev, axis),
+						&maximum) |
+		       touchscreen_get_prop_u32(np, "touchscreen-fuzz-x",
+						input_abs_get_fuzz(dev, axis),
+						&fuzz);
+	if (data_present)
+		touchscreen_set_params(dev, axis, maximum, fuzz);
 
-	maximum = of_get_optional_u32(np, "touchscreen-size-y");
-	fuzz = of_get_optional_u32(np, "touchscreen-fuzz-y");
-	if (maximum || fuzz) {
-		touchscreen_set_params(dev, ABS_Y, maximum, fuzz);
-		touchscreen_set_params(dev, ABS_MT_POSITION_Y, maximum, fuzz);
-	}
+	axis = multitouch ? ABS_MT_POSITION_Y : ABS_Y;
+	data_present = touchscreen_get_prop_u32(np, "touchscreen-size-y",
+						input_abs_get_max(dev, axis),
+						&maximum) |
+		       touchscreen_get_prop_u32(np, "touchscreen-fuzz-y",
+						input_abs_get_fuzz(dev, axis),
+						&fuzz);
+	if (data_present)
+		touchscreen_set_params(dev, axis, maximum, fuzz);
 
-	maximum = of_get_optional_u32(np, "touchscreen-max-pressure");
-	fuzz = of_get_optional_u32(np, "touchscreen-fuzz-pressure");
-	if (maximum || fuzz) {
-		touchscreen_set_params(dev, ABS_PRESSURE, maximum, fuzz);
-		touchscreen_set_params(dev, ABS_MT_PRESSURE, maximum, fuzz);
-	}
+	axis = multitouch ? ABS_MT_PRESSURE : ABS_PRESSURE;
+	data_present = touchscreen_get_prop_u32(np, "touchscreen-max-pressure",
+						input_abs_get_max(dev, axis),
+						&maximum) |
+		       touchscreen_get_prop_u32(np, "touchscreen-fuzz-pressure",
+						input_abs_get_fuzz(dev, axis),
+						&fuzz);
+	if (data_present)
+		touchscreen_set_params(dev, axis, maximum, fuzz);
 }
 EXPORT_SYMBOL(touchscreen_parse_of_params);
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 72657c5..d8c025b 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -709,7 +709,7 @@ static int tsc2005_probe(struct spi_device *spi)
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, max_p, fudge_p, 0);
 
 	if (np)
-		touchscreen_parse_of_params(input_dev);
+		touchscreen_parse_of_params(input_dev, false);
 
 	input_dev->open = tsc2005_open;
 	input_dev->close = tsc2005_close;
diff --git a/include/linux/input/touchscreen.h b/include/linux/input/touchscreen.h
index 08a5ef6..eecc9ea 100644
--- a/include/linux/input/touchscreen.h
+++ b/include/linux/input/touchscreen.h
@@ -12,9 +12,10 @@
 #include <linux/input.h>
 
 #ifdef CONFIG_OF
-void touchscreen_parse_of_params(struct input_dev *dev);
+void touchscreen_parse_of_params(struct input_dev *dev, bool multitouch);
 #else
-static inline void touchscreen_parse_of_params(struct input_dev *dev)
+static inline void touchscreen_parse_of_params(struct input_dev *dev,
+					       bool multitouch)
 {
 }
 #endif
