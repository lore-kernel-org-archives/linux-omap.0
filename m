From: David Brownell <david-b@pacbell.net>
Subject: Re: leds-gpio broken with current git?
Date: Mon, 23 Feb 2009 14:08:14 -0800
Message-ID: <200902231408.14387.david-b@pacbell.net>
References: <7088542D-28A0-4BCA-9583-6BCDDF9E960A@student.utwente.nl> <8F7AF80515AF0D4D93307E594F3CB40E210F49EC@dlee03.ent.ti.com> <200902231304.22137.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:35635 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753234AbZBWWIR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2009 17:08:17 -0500
In-Reply-To: <200902231304.22137.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kridner, Jason" <jdk@ti.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Monday 23 February 2009, David Brownell wrote:
>=20
> > Perhaps something broke with Tony's RC1 merge?
> > The LEDs are broken for me as well.=20
>=20
> Still works for me. =A0Did you maybe not enable the twl4030
> GPIO support in Kconfig?

Oh, and if you did *not*, please give this patch a try.
I've been meaning to test it.

- Dave


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Sometimes it's awkward to make sure that the array in the
platform_data handed to the leds-gpio driver has only valid
data ... some leds may not be always available, and coping
with that currently requires patching or rebuilding the array.

This patch fixes that by making it be OK to pass an invalid
GPIO (such as "-EINVAL") ... such table entries are skipped.

---
 drivers/leds/leds-gpio.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -90,13 +90,19 @@ static int gpio_led_probe(struct platfor
 		cur_led =3D &pdata->leds[i];
 		led_dat =3D &leds_data[i];
=20
+		/* skip leds that aren't available */
+		led_dat->gpio =3D cur_led->gpio;
+		if (!gpio_is_valid(led_dat->gpio)) {
+			dev_dbg(&pdev->dev, "skipping %s\n", cur_led->name);
+			continue;
+		}
+
 		ret =3D gpio_request(cur_led->gpio, cur_led->name);
 		if (ret < 0)
 			goto err;
=20
 		led_dat->cdev.name =3D cur_led->name;
 		led_dat->cdev.default_trigger =3D cur_led->default_trigger;
-		led_dat->gpio =3D cur_led->gpio;
 		led_dat->can_sleep =3D gpio_cansleep(cur_led->gpio);
 		led_dat->active_low =3D cur_led->active_low;
 		if (pdata->gpio_blink_set) {
@@ -125,6 +131,8 @@ static int gpio_led_probe(struct platfor
 err:
 	if (i > 0) {
 		for (i =3D i - 1; i >=3D 0; i--) {
+			if (!gpio_is_valid(leds_data[i].gpio))
+				continue;
 			led_classdev_unregister(&leds_data[i].cdev);
 			cancel_work_sync(&leds_data[i].work);
 			gpio_free(leds_data[i].gpio);
@@ -145,6 +153,8 @@ static int __devexit gpio_led_remove(str
 	leds_data =3D platform_get_drvdata(pdev);
=20
 	for (i =3D 0; i < pdata->num_leds; i++) {
+		if (!gpio_is_valid(leds_data[i].gpio))
+			continue;
 		led_classdev_unregister(&leds_data[i].cdev);
 		cancel_work_sync(&leds_data[i].work);
 		gpio_free(leds_data[i].gpio);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
