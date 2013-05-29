From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5] USB: PHY: Improve PHY selection logic
Date: Wed, 29 May 2013 14:43:26 +0300
Message-ID: <1369827811-534-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, adrienverge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Improve Kconfig so that the relevant PHY driver can be explicitely
selected by the controller driver instead of relying on the user
to do so.

Detailed description in patch 1.

cheers,
-roger

Roger Quadros (5):
  USB: PHY: Make PHY driver selection possible by controller drivers
  USB: ehci-omap: select NOP_USB_XCEIV PHY driver
  USB: ehci-msm: USB_EHCI_MSM need not depend on USB_PHY
  USB: lpc32xx: USB_LPC32XX need not depend on USB_PHY
  USB: OMAP: USB_OMAP need not depend USB_PHY

 drivers/usb/Makefile       |    3 +--
 drivers/usb/gadget/Kconfig |    2 --
 drivers/usb/host/Kconfig   |    5 +----
 drivers/usb/phy/Kconfig    |   31 +++++++++++++++++++++----------
 4 files changed, 23 insertions(+), 18 deletions(-)

-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
