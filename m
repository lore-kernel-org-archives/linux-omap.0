From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH -next] usb: dwc3: Remove unprintable characters from Kconfig
Date: Sun, 14 Jun 2015 11:20:53 -0700
Message-ID: <1434306053-21510-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58366 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbbFNSU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Jun 2015 14:20:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>

=46ix:

drivers/usb/dwc3/Kconfig:16:warning: ignoring unsupported character '=EF=
=BF=BD'
drivers/usb/dwc3/Kconfig:16:warning: ignoring unsupported character '=EF=
=BF=BD'

=46ixes: 88bc9d194ff6 ("usb: dwc3: add ULPI interface support")
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/dwc3/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 473bfaa96c30..dede32e809b6 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -13,7 +13,7 @@ if USB_DWC3
=20
 config USB_DWC3_ULPI
 	bool "Register ULPI PHY Interface"
-	depends on USB_ULPI_BUS=3Dy ||=C2=A0USB_ULPI_BUS=3DUSB_DWC3
+	depends on USB_ULPI_BUS=3Dy || USB_ULPI_BUS=3DUSB_DWC3
 	help
 	  Select this if you have ULPI type PHY attached to your DWC3
 	  controller.
--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
