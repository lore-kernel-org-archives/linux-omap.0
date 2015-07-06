From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH gpio-for-next 08/10] usb: dwc3: pci: make better use of gpiod API
Date: Mon,  6 Jul 2015 11:09:48 +0200
Message-ID: <1436173790-29963-8-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150706090759.GS11824@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150706090759.GS11824@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, kernel@pengutronix.de, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additiona=
l
parameter that allows to specify direction and initial value for output=
=2E

Use this additional parameter and the _optional variant to simplify the
driver and improve error handling. Also expand the comment to explain
why it's not sensible to switch to devm_gpiod_get and why the gpiod_put
is also necessary.

=46urthermore this is one caller less that stops us making the flags
argument to gpiod_get*() mandatory.

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/usb/dwc3/dwc3-pci.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 27e4fc896e9d..f62617999f3c 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -83,17 +83,23 @@ static int dwc3_pci_quirks(struct pci_dev *pdev)
 		acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
 					  acpi_dwc3_byt_gpios);
=20
-		/* These GPIOs will turn on the USB2 PHY */
-		gpio =3D gpiod_get(&pdev->dev, "cs");
-		if (!IS_ERR(gpio)) {
-			gpiod_direction_output(gpio, 0);
-			gpiod_set_value_cansleep(gpio, 1);
-			gpiod_put(gpio);
-		}
+		/*
+		 * These GPIOs will turn on the USB2 PHY. Note that we have to
+		 * put the gpio descriptors again here because the phy driver
+		 * might want to grab them, too.
+		 */
+		gpio =3D gpiod_get_optional(&pdev->dev, "cs", GPIOD_OUT_LOW);
+		if (IS_ERR(gpio))
+			return PTR_ERR(gpio);
+
+		gpiod_set_value_cansleep(gpio, 1);
+		gpiod_put(gpio);
+
+		gpio =3D gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
+		if (IS_ERR(gpio))
+			return PTR_ERR(gpio);
=20
-		gpio =3D gpiod_get(&pdev->dev, "reset");
-		if (!IS_ERR(gpio)) {
-			gpiod_direction_output(gpio, 0);
+		if (gpio) {
 			gpiod_set_value_cansleep(gpio, 1);
 			gpiod_put(gpio);
 			usleep_range(10000, 11000);
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
