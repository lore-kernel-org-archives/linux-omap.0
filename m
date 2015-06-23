From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2] usb: dwc3: pci: make better use of gpiod API
Date: Tue, 23 Jun 2015 14:25:06 +0200
Message-ID: <1435062306-2591-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150623100116.GB1296@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150623100116.GB1296-FZxXFokcWpatqXYlAKuG4QC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Changes since (implicit) v1, sent with Message-Id:
1434093019-14009-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org:

 - don't use devm_ and keep the gpiod_put

As with v1: This usage without flags was introduced by commit a89d977cc=
04c
(usb: dwc3: pci: add quirk for Baytrails) that is currently in next.

Note I plan to make the flags parameter mandatory for 4.3. So unless
this change gets into 4.2, would it be ok to let it go in via the gpio
tree?

Best regards
Uwe

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
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
