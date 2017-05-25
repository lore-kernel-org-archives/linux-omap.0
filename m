From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv3 0/3] Make ohci-platform usable for omap3/4/5
Date: Thu, 25 May 2017 09:13:30 -0700
Message-ID: <20170525161333.32639-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here's v3 of this series.

Regards,

Tony

Changes since v2:

- Ignore pm_runtime_get_sync for remove(), not much we can do there
  as noted by Alan Stern

- Add acks

Changes since v1:                                                                                                                                                                                         - Update runtime PM support for ohci based on Alan's comments and
  more testing                                                                                                                                                                                            - Just remove ohci-omap3 as it needs LS/FS USB PHY not available
  on most hardware

Tony Lindgren (3):
  usb: host: ohci-platform: Add basic runtime PM support
  usb: host: ohci-platform: Add support for omap3 and later
  usb: host: ohci-omap3: Remove driver in favor of ohci-platform

 Documentation/devicetree/bindings/usb/usb-ohci.txt |   1 +
 drivers/usb/host/Kconfig                           |   6 +-
 drivers/usb/host/Makefile                          |   1 -
 drivers/usb/host/ohci-omap3.c                      | 211 ---------------------
 drivers/usb/host/ohci-platform.c                   |  13 ++
 5 files changed, 19 insertions(+), 213 deletions(-)
 delete mode 100644 drivers/usb/host/ohci-omap3.c

-- 
2.13.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
