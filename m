From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] AM437x: USB DWC3: save power during system sleep
Date: Mon, 31 Aug 2015 21:09:07 +0530
Message-ID: <cover.1441029572.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This series add support to DWC3 core to conserve
power during system sleep by setting the USB
DRVVBUS line to a lower power consuming state.

Tested to make sure USB host and device works on
AM437x with v4.2. Tested for power savings on v4.1
kernel where there is an implementation of suspend-
to-RAM for AM437x available.

Dave Gerlach (1):
  ARM: dts: am437x-gp-evm: Add pinctrl states for usb

Sekhar Nori (1):
  usb: dwc3: support for pinctrl state change during system sleep

 arch/arm/boot/dts/am437x-gp-evm.dts | 30 ++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.c             |  4 ++++
 2 files changed, 34 insertions(+)

-- 
2.4.4.408.g16da57c

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
