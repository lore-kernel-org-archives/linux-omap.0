From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] gpio: omap: make gpio numbering deterministical by using of aliases
Date: Tue, 14 Jun 2016 12:03:24 +0200
Message-ID: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
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
the number base for a given device. If no respective alias exists fall
back to the traditional numbering.

=46or the unusual case where only a part of the gpio devices have a
matching alias some of them might fail to probe. But if none of them ha=
s
an alias or all, there is no conflict which should be good enough to
maintain backward compatibility.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

if you're happy with this patch I can follow up and add the respective
aliases to the device trees.

Best regards
Uwe

 drivers/gpio/gpio-omap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index b98ede78c9d8..6814245a54aa 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1034,6 +1034,7 @@ static int omap_gpio_chip_init(struct gpio_bank *=
bank, struct irq_chip *irqc)
 	static int gpio;
 	int irq_base =3D 0;
 	int ret;
+	int gpio_alias_id;
=20
 	/*
 	 * REVISIT eventually switch from OMAP-specific gpio structs
@@ -1056,6 +1057,17 @@ static int omap_gpio_chip_init(struct gpio_bank =
*bank, struct irq_chip *irqc)
 		bank->chip.label =3D "gpio";
 		bank->chip.base =3D gpio;
 	}
+
+	/*
+	 * Traditionally the base is given out in first-come-first-serve orde=
r.
+	 * This might shuffle the numbering of gpios if the probe order chang=
es.
+	 * So make the base deterministical if the device tree specifies alia=
s
+	 * ids.
+	 */
+	gpio_alias_id =3D of_alias_get_id(bank->chip.of_node, "gpio");
+	if (gpio_alias_id >=3D 0)
+		bank->chip.base =3D bank->width * gpio_alias_id;
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
