From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/4] Make ohci-platform usable for omap3/4/5
Date: Wed, 17 May 2017 15:59:18 -0700
Message-ID: <20170517225922.17723-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are patches I promised several months ago so we can eventually
get rid of ohci-omap3 in favor of ohci-platform as suggested by
Alan Stern.

I think we need to wait a while before removing ohci-omap3, so
I just added a warning for now to urge people to move to use
ohci-platform instead.

Regards,

Tony

Tony Lindgren (4):
  usb: host: ohci-platform: Add basic runtime PM support
  usb: host: ohci-platform: Add support for omap3 and later
  usb: host: ohci-omap3: Print warning to get people to use
    ohci-platform
  ARM: dts: Add remote-wakeup-connected for omap OHCI

 Documentation/devicetree/bindings/usb/usb-ohci.txt |  1 +
 arch/arm/boot/dts/omap3.dtsi                       |  1 +
 arch/arm/boot/dts/omap4.dtsi                       |  1 +
 arch/arm/boot/dts/omap5.dtsi                       |  1 +
 drivers/usb/host/ohci-omap3.c                      |  3 +++
 drivers/usb/host/ohci-platform.c                   | 16 ++++++++++++++++
 6 files changed, 23 insertions(+)

-- 
2.13.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
