From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2 v2] gpio: omap: make gpio numbering deterministical by using of aliases
Date: Tue, 14 Jun 2016 20:57:11 +0200
Message-ID: <1465930632-18941-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1465930632-18941-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1465930632-18941-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Traditionally the n-th gpio device probed by the omap gpio driver got
the gpio number range [n*32 .. n*32+31].
When order of the devices probed by the driver changes (which can happe=
n
already now when some devices have a pinctrl and so the first probe
attempt returns -ENODEV) the numbering changes.

To ensure a deterministical numbering use of_alias_get_id to determine
the base for a given device. If no respective alias exists fall back to
the traditional numbering.

=46or the unusual case where only a part of the gpio devices have a
matching alias some of them might fail to probe. But if none of them ha=
s
an alias or all, there is no conflict which should be good enough to
maintain backward compatibility.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-omap.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index b98ede78c9d8..4d91792e7266 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1053,9 +1053,26 @@ static int omap_gpio_chip_init(struct gpio_bank =
*bank, struct irq_chip *irqc)
 			bank->chip.parent =3D &omap_mpuio_device.dev;
 		bank->chip.base =3D OMAP_MPUIO(0);
 	} else {
+		int gpio_alias_id __maybe_unused;
+
 		bank->chip.label =3D "gpio";
-		bank->chip.base =3D gpio;
+
+#if defined(CONFIG_OF_GPIO)
+		/*
+		 * Traditionally the base is given out in first-come-first-serve
+		 * order.  This might shuffle the numbering of gpios if the
+		 * probe order changes.  So make the base deterministical if the
+		 * device tree specifies alias ids.
+		 */
+		gpio_alias_id =3D of_alias_get_id(bank->chip.of_node, "gpio");
+		if (gpio_alias_id >=3D 0)
+			bank->chip.base =3D bank->width * gpio_alias_id;
+		else
+#endif
+			bank->chip.base =3D gpio;
 	}
+
+
 	bank->chip.ngpio =3D bank->width;
=20
 	ret =3D gpiochip_add_data(&bank->chip, bank);
--=20
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
