From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Request for OMAPDSS testing
Date: Mon, 17 Jun 2013 11:40:11 +0300
Message-ID: <51BECB6B.7010409@compulab.co.il>
References: <51AD99F5.7060506@ti.com> <51B9EA7B.8070906@compulab.co.il> <51B9ECBE.3010401@ti.com> <51BDAF6A.1020102@compulab.co.il> <51BEB5DD.4000605@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020108060702020107040809"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:55097 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932463Ab3FQIkT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jun 2013 04:40:19 -0400
In-Reply-To: <51BEB5DD.4000605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Thomas Weber <weber@corscience.de>, Mike Rapoport <mike@compulab.co.il>, Steve Sakoman <steve@sakoman.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020108060702020107040809
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 06/17/13 10:08, Tomi Valkeinen wrote:
> On 16/06/13 15:28, Igor Grinberg wrote:
> 
>>>> Although one thing is missing from the tfp410 driver is
>>>> the PD GPIO polarity. I had to adjust it locally to get the DVI working.
>>>> The original polarity was high = disabled, low = enabled.
>>
>>> Hmm, but this is missing from the old driver also, isn't it? At least
>>> with a quick glance the old and new tfp410 drivers do the same thing
>>> with the PD gpio.
>>
>> Well, we were driving the PD GPIO from the board file...
> 
> Ah, I see. That was inverted PD handling was removed in 3.5, by accident
> as far as I see. So DVI on cm-t35 has been broken since?

Well, we have applied the below patches since then (the patches are against 3.7),
but haven't had time to send it upstream...

> 
> I wonder how that should be fixed... The tfp410 driver handles it
> correctly, as the PD gpio is active low (i.e. high == tfp410 enabled),
> so having it inverted is a board specific thing. Do you know what is the
> reason to have it inverted?

Yes, the reason for this is the sb-t35 (the baseboard) which has the TFP410
in 3.3V domain, but the cm-t3530/3730 are in 1.8V domain.
This means that the line must be shifted.
Now for some reason hardware guys used an inverter as the level shifter
instead of a simple buffer. So now it is shifted and inverted...

> 
> There seems to be OF_GPIO_ACTIVE_LOW, but I'm not sure how it should be
> used, as I don't see anyone setting that flag... And supporting that
> would mean, in principle, that every driver should support inverting the
> gpio with every gpio they have.

Might be worth to consider adding this functionality to the GPIOLIB?
Meanwhile, I think the simplest way would be to add a boolean
like OF_GPIO_ACTIVE_LOW, as we have hardware that needs it.

If you think the patches are conceptually fine,
I can rebase them on top of your tree with the new drivers and
submit properly.

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAEBAgAGBQJRvstaAAoJEBDE8YO64EfatIMQAJbAO7rkQNTlTwL4qkANZV7h
v1msnUbjuiGr5hb34UX07b3lBoIXkI9Uqt6rC25vbIDZPW8EaKmMwLle87aXpAVI
QsA8wujQx7p1S9oLjVSdu1AZeQZv4vHBZPU5R/xlOGocbs2TgJ1/Pn4eYVKDHW9Q
Sv3wHwiZgkwOT+7nAe7mAmuLsWl62rxF94Psw4imC9M35wpxat9hXWaIJPu6WwRS
DdaySlfxasG9aMg/CMCxf8Cjcmk4cKjJ8vRVhmW0J1ISuUofSfxiL6K611bTjaqb
oCO8qTxThLebTlvW6LrVZ8Etcr4HAp2zG6o0ZZmdYxMROJ9feMhJgZ7dIwUSOlK5
OSwAyfGsG1m4EqnfokgRx6Eg+ur2VirqZ6NcXEt5ljHHfnu4VeY/glHpSnfuwsN8
e27tSlJXv15EXEcASFqaujDUzV7qPYYcLYy5Wssjg9V/RTZoT3kHhouNnE5/doP+
d7qC/nheG6O3iT2cT4OMcnBi9nywaOR7ogMgauGZjDCB9pLrvTe4iBJFgfa2CkC3
QlB8lD8+tUXC6kGhlYv9RaZy/MP8CQWAYCel0k4vbjAB/KvY0KNHMpwmTzfGALhB
LI2/swhSpE6+0q3M3tylds15HQCmNSmO/1AVRdvgrJQXZbGz8PBCuxH7QqInS/ob
JXjx9lUaw9tRsVQKcqPp
=5nPt
-----END PGP SIGNATURE-----

--------------020108060702020107040809
Content-Type: text/x-patch;
 name="0001-OMAPDSS-TFP410-support-edge-select-pin-strap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-OMAPDSS-TFP410-support-edge-select-pin-strap.patch"

>From 4eaa3d23ba484370c6b709ff21ca764a47033f34 Mon Sep 17 00:00:00 2001
From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Date: Wed, 9 Jan 2013 14:04:08 +0200
Subject: [PATCH] OMAPDSS: TFP410: support edge select pin strap

Pin 9 (EDGE/HTPLG) of tfp410 DVI transmitter is used (when I2C is
disabled) to control the data sampling on the rising or falling
edge of the pixel clock.

OMAP DSS timings for tfp410 should be adjusted according to
the chip pin strap to avoid various visual artifacts in the DVI output.

Enhance the tfp410 driver platform data with the flag to modify
default tfp410 timing settings according to the chip pin strap.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 drivers/video/omap2/displays/panel-tfp410.c |    8 ++++++++
 include/video/omap-panel-tfp410.h           |    3 +++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index e611ebd..77ce139 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -115,6 +115,14 @@ static int tfp410_probe(struct omap_dss_device *dssdev)
 		ddata->pd_gpio = pdata->power_down_gpio;
 		ddata->invert_pd_gpio = pdata->invert_pd_gpio;
 		i2c_bus_num = pdata->i2c_bus_num;
+
+		/*
+		 * If the data latch occur on the rising edge of the pixel
+		 * clock, then the data strobe should be on the falling edge.
+		 */
+		if (pdata->latch_on_rising_edge)
+			dssdev->panel.timings.data_pclk_edge =
+					OMAPDSS_DRIVE_SIG_FALLING_EDGE;
 	} else {
 		ddata->pd_gpio = -EINVAL;
 		i2c_bus_num = -1;
diff --git a/include/video/omap-panel-tfp410.h b/include/video/omap-panel-tfp410.h
index cd1061e..f5424aa 100644
--- a/include/video/omap-panel-tfp410.h
+++ b/include/video/omap-panel-tfp410.h
@@ -27,11 +27,14 @@ struct omap_dss_device;
  * @i2c_bus_num: i2c bus id for the panel
  * @power_down_gpio: gpio number for PD pin (or -EINVAL if not available)
  * @invert_pd_gpio: invert PD pin logic level (0 - is a power on state)
+ * @latch_on_rising_edge : select the edge (0 - falling, 1 - rising) of the input clock
+ *                         when the primary latch occur.
  */
 struct tfp410_platform_data {
 	int i2c_bus_num;
 	int power_down_gpio;
 	bool invert_pd_gpio;
+	bool latch_on_rising_edge;
 };
 
 #endif /* __OMAP_PANEL_TFP410_H */
-- 
1.7.3.4


--------------020108060702020107040809
Content-Type: text/x-patch;
 name="0001-OMAPDSS-TFP410-use-EINVAL-for-invalid-PD-GPIO.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-OMAPDSS-TFP410-use-EINVAL-for-invalid-PD-GPIO.patch"

>From ed3da0d17f659889a1cc020e53cd0e4d2950dbae Mon Sep 17 00:00:00 2001
From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Date: Wed, 26 Dec 2012 10:08:55 +0200
Subject: [PATCH 1/2] OMAPDSS: TFP410: use -EINVAL for invalid PD GPIO

power_down_gpio field of tfp410_platform_data structure
can have -1 value in case power down GPIO is not available.
Although the gpiolib does not define strictly which negative number
should be used to specify invalid GPIO, we should follow the common
practice and use -EINVAL.

This patch changes platform data comments and the driver to
work with -EINVAL and propagates the change through the relevant board
files.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-3430sdp.c         |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c       |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c      |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c     |    2 +-
 arch/arm/mach-omap2/board-overo.c           |    2 +-
 drivers/video/omap2/displays/panel-tfp410.c |    2 +-
 include/video/omap-panel-tfp410.h           |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 09e1790..f33a6e4 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -156,7 +156,7 @@ static struct omap_dss_device sdp3430_lcd_device = {
 };
 
 static struct tfp410_platform_data dvi_panel = {
-	.power_down_gpio	= -1,
+	.power_down_gpio	= -EINVAL,
 	.i2c_bus_num		= -1,
 };
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 370c54d..6aa182f 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -207,7 +207,7 @@ static struct omap_dss_device am3517_evm_tv_device = {
 };
 
 static struct tfp410_platform_data dvi_panel = {
-	.power_down_gpio	= -1,
+	.power_down_gpio	= -EINVAL,
 	.i2c_bus_num		= -1,
 };
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 6f04f0f..e655b07 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -138,7 +138,7 @@ static struct omap_dss_device devkit8000_lcd_device = {
 };
 
 static struct tfp410_platform_data dvi_panel = {
-	.power_down_gpio	= -1,
+	.power_down_gpio	= -EINVAL,
 	.i2c_bus_num		= 1,
 };
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index d41ab98..2aef549 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -194,7 +194,7 @@ static struct mtd_partition omap3beagle_nand_partitions[] = {
 
 static struct tfp410_platform_data dvi_panel = {
 	.i2c_bus_num = 3,
-	.power_down_gpio = -1,
+	.power_down_gpio = -EINVAL,
 };
 
 static struct omap_dss_device beagle_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index b700685..73e8349 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -167,7 +167,7 @@ static void __init overo_display_init(void)
 
 static struct tfp410_platform_data dvi_panel = {
 	.i2c_bus_num		= 3,
-	.power_down_gpio	= -1,
+	.power_down_gpio	= -EINVAL,
 };
 
 static struct omap_dss_device overo_dvi_device = {
diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index 383811c..2ddb7e1 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -114,7 +114,7 @@ static int tfp410_probe(struct omap_dss_device *dssdev)
 		ddata->pd_gpio = pdata->power_down_gpio;
 		i2c_bus_num = pdata->i2c_bus_num;
 	} else {
-		ddata->pd_gpio = -1;
+		ddata->pd_gpio = -EINVAL;
 		i2c_bus_num = -1;
 	}
 
diff --git a/include/video/omap-panel-tfp410.h b/include/video/omap-panel-tfp410.h
index aef35e4..4431c37 100644
--- a/include/video/omap-panel-tfp410.h
+++ b/include/video/omap-panel-tfp410.h
@@ -25,7 +25,7 @@ struct omap_dss_device;
 /**
  * struct tfp410_platform_data - panel driver configuration data
  * @i2c_bus_num: i2c bus id for the panel
- * @power_down_gpio: gpio number for PD pin (or -1 if not available)
+ * @power_down_gpio: gpio number for PD pin (or -EINVAL if not available)
  */
 struct tfp410_platform_data {
 	int i2c_bus_num;
-- 
1.7.3.4


--------------020108060702020107040809
Content-Type: text/x-patch;
 name="0002-OMAPDSS-TFP410-support-inverted-power-down-GPIO.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-OMAPDSS-TFP410-support-inverted-power-down-GPIO.patch"

>From ee916068b7874fe4cd8614466afeb60a401505d1 Mon Sep 17 00:00:00 2001
From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Date: Wed, 26 Dec 2012 11:30:29 +0200
Subject: [PATCH 2/2] OMAPDSS: TFP410: support inverted power down GPIO

tfp410 chip integration on a specific board may require inverted
logic of the power down GPIO.
Enhance tfp410 driver platform data with flag to invert power down GPIO
logic level.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 drivers/video/omap2/displays/panel-tfp410.c |    6 ++++--
 include/video/omap-panel-tfp410.h           |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index 2ddb7e1..e611ebd 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -53,6 +53,7 @@ struct panel_drv_data {
 	struct mutex lock;
 
 	int pd_gpio;
+	bool invert_pd_gpio;
 
 	struct i2c_adapter *i2c_adapter;
 };
@@ -73,7 +74,7 @@ static int tfp410_power_on(struct omap_dss_device *dssdev)
 		goto err0;
 
 	if (gpio_is_valid(ddata->pd_gpio))
-		gpio_set_value_cansleep(ddata->pd_gpio, 1);
+		gpio_set_value_cansleep(ddata->pd_gpio, !ddata->invert_pd_gpio);
 
 	return 0;
 err0:
@@ -88,7 +89,7 @@ static void tfp410_power_off(struct omap_dss_device *dssdev)
 		return;
 
 	if (gpio_is_valid(ddata->pd_gpio))
-		gpio_set_value_cansleep(ddata->pd_gpio, 0);
+		gpio_set_value_cansleep(ddata->pd_gpio, ddata->invert_pd_gpio);
 
 	omapdss_dpi_display_disable(dssdev);
 }
@@ -112,6 +113,7 @@ static int tfp410_probe(struct omap_dss_device *dssdev)
 		struct tfp410_platform_data *pdata = dssdev->data;
 
 		ddata->pd_gpio = pdata->power_down_gpio;
+		ddata->invert_pd_gpio = pdata->invert_pd_gpio;
 		i2c_bus_num = pdata->i2c_bus_num;
 	} else {
 		ddata->pd_gpio = -EINVAL;
diff --git a/include/video/omap-panel-tfp410.h b/include/video/omap-panel-tfp410.h
index 4431c37..cd1061e 100644
--- a/include/video/omap-panel-tfp410.h
+++ b/include/video/omap-panel-tfp410.h
@@ -26,10 +26,12 @@ struct omap_dss_device;
  * struct tfp410_platform_data - panel driver configuration data
  * @i2c_bus_num: i2c bus id for the panel
  * @power_down_gpio: gpio number for PD pin (or -EINVAL if not available)
+ * @invert_pd_gpio: invert PD pin logic level (0 - is a power on state)
  */
 struct tfp410_platform_data {
 	int i2c_bus_num;
 	int power_down_gpio;
+	bool invert_pd_gpio;
 };
 
 #endif /* __OMAP_PANEL_TFP410_H */
-- 
1.7.3.4


--------------020108060702020107040809
Content-Type: application/pgp-signature;
 name="0001-OMAPDSS-TFP410-support-edge-select-pin-strap.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-OMAPDSS-TFP410-support-edge-select-pin-strap.patch.sig"

iQIcBAABAgAGBQJRvstjAAoJEBDE8YO64EfajmkP/0tt4P9jymlWFB807zueZcA23/K5U+h1
n5wrwoHL8JiZa+wNC+S22vP+oIlhC2tVkqmDMEB6SBWlfPwHp98txGCg9Lu9udcEeXTfMz0A
rRhDM6YE57MiDpAxzxJraPAJeKHeMVptVijmN2+Xw070cZI/O+WpSr+4GQy2+2WsJxCBWOsz
XpIFWFBP32IdXyDmPJUQIy1FOPCtd7uYsAKwOLTder8MYJpq2hQhKp4hsO58HqOkQI08oa+1
dyozSDi7Ez1z2S9GUrtkbiyL+PQBWUKOB9iSz2/spz/PKvoG+Cq5691CN10JWPb1lgFL+SeM
zZS63boL+1bxMvzB3fg+GshJSM8anG7FPUiua/e38yvz+iGCR/3T7mhOXiTevL+12oNhrlKK
yv/MUgq69oE5dY55E9uzwhWbBlts67k9TWulN5dhkUJEbnCS7kfDQccJaHdWfVjdOyS7QLqP
NIMdXsHQzA46akB538/xOR9ESgQvDY6C9Vk2DksaIY5TymyT6UsfOpqAlQNY3zbUABv6iNTs
IGhCXFKHh4Weq8stLYCjaz2XZWj+BVF/68swZHp4H7ClKIE94p3TNp7Wbp6/NA2AsXev30OQ
S42y+DNfbvfQgqZ8SRd4tqfzgzNSTN883FRtRPrKVUxBAJQQw/oljVNSwHDrAsbk8VXPRWVw
Yok2
--------------020108060702020107040809
Content-Type: application/pgp-signature;
 name="0001-OMAPDSS-TFP410-use-EINVAL-for-invalid-PD-GPIO.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-OMAPDSS-TFP410-use-EINVAL-for-invalid-PD-GPIO.patch.sig"

iQIcBAABAgAGBQJRvstnAAoJEBDE8YO64EfaSE0P/2OoOR+P1g6CUMRblu0Dh0uLk7JOVVYV
4GGTDlD6FXpAhxtdS6X9KVXnK7kSW7ytXe3sDuyGz+bzrjAZqhteJlgC+Q+blVIcincwIALw
e5MkgsNTGnZ534CeKbdZ6xeojmvogPSFBMG6IjurzW6DKf4eT5OForxEmzxGjWPKg/T9D9A2
en05ARqN3ZF/NFB6oDLXahHsS9qd4HTuI/EgxwbO/6brpmAmJhPksZE1ePBprbflArUP1yz8
7b600gLY2bD1mYZzjVvk26iHXA4k2gXVhPauQUj1kcw6EL41kpysKUb9MHe/27BN9UOaXwVl
yoDMWnHQYSGF2dvvXNQctAfse/dQn2e9w/QW9HM0NexyZFVHh7gU6thdddQSQJ4fETmGv34n
Zur1pw9YwlA6dtiVZJytJCNbXuM4KmubmlmWAUz++E5aIj1SyLHHejTENiAXjrFjorlJSttI
42K9wbEHt8s70qxc84Hh/e481nRugttXSqsuV5EhKH026YnIGkRvepzUEDMxc8KCOKXJwrpn
qGDNMoGvityYA8SCMBRwOXBeeDXUq6zjelXZxnYNyhD3sLOQVSfoGZYgnrW0G9yphvB1MYzS
OJ05bthnjSVpF3qGHr80j/p+V3On4mC3q8b0nJW5PDzXMYn6YJtzHToQShaJghAfx/adYsXa
F4vD
--------------020108060702020107040809
Content-Type: application/pgp-signature;
 name="0002-OMAPDSS-TFP410-support-inverted-power-down-GPIO.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0002-OMAPDSS-TFP410-support-inverted-power-down-GPIO.patch.s";
 filename*1="ig"

iQIcBAABAgAGBQJRvstrAAoJEBDE8YO64EfaHT8P/ArMINFDI9Q+1hoP+NG2ckGY6ziwo54x
tQHbKZYPCQBzd7IzRvEjZXg5yTjjvJJ1ncKxSXEXp4pGEsd6vfk1p4Cmc/JLS6+KplwDbPUX
9X6R2sg4C4P63noQRaYrAJ3mALZHm+BbZPp8wnJGZYWsPKssaD2NCkiZgw+LkXGDeCBxe6kV
Gm6kbpy1lXOx+eupyg4Tjee68fwJqyntGHgbeo7XrZAjwNcucpcEP5KHQuy80inUgpN50eoR
UGM+Y/RYBrlAuwsUPhn1CkMYoIcxfIzqPuY/DuIdflO8w+ymYyHKrQtYzmd/8Sf/TCfP43aw
xcddksN8ydavxJ0hPjGP+USH3BknJJ3yozoj3EykZrkn529rWmT9gvFTTEynhb/Lj3xRELKV
R20Svt4B43XpcpQfwcxErDmTaX/xO0tWYwZo5EWBgVLUYi/D98dXzENgYmtFTsRcES+DOqUw
glqwzq4QJstVwcSaqBTVPh7agtuGXR4o/2yNZ3TAGNE2tY7WNuC2v8bSb1bCl2t8Eju/zKdX
IzqCei/3USjtuBkMfpwjUFWKL2j+7d8bKiKcWIfGIw8THFpfgfgp2WO8KI4prgE2fCGbLZbC
NxMbqpMWngfs+fULwne29z/OQiCEwev5fa5/YzYqvfRBoemAiY85pKbbPRfiTQwaGqcdm5wM
g9Q9
--------------020108060702020107040809--
