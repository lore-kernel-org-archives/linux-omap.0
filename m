From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] usb: dwc3: Use ASCII space in Kconfig
Date: Fri, 12 Jun 2015 15:16:21 +0200
Message-ID: <1434114981-2296-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=46rom: Thierry Reding <treding@nvidia.com>

The USB_DWC3_ULPI Kconfig entry uses a UTF-8 non-breaking space (0xca20=
)
instead of a regular ASCII space (0x20). Commit 2e0d737fc76f ("kconfig:
don't silently ignore unhandled characters") exposes this by warning
about unhandled characters.

Signed-off-by: Thierry Reding <treding@nvidia.com>
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
2.4.1
