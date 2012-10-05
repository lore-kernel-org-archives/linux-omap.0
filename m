From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] ocp2scp: add non-dt support
Date: Fri, 5 Oct 2012 15:37:05 +0530
Message-ID: <1349431628-2819-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch series allows ocp2scp driver to create its child devices
from the platform data.

In omap platforms, usb phy is connected to ocp2scp and usb phy is needed
for MUSB to be functional. When ocp2scp driver was added, it had only dt
support which means it wont create usb phy devices for non-dt boot.

This patch series adds non-dt support to ocp2scp and this series is needed
for getting MUSB functioanl in non-dt boot.

This patch series is rebased on linux-next. Let me know if it had to be
based on some other tree.

Did a quick testing for g_zero enumeration in panda board.

Kishon Vijay Abraham I (3):
  drivers: bus: ocp2scp: add pdata support
  ARM: OMAP4: add _dev_attr_ to ocp2scp for representing usb_phy
  ARM: OMAP: ocp2scp: create omap device for ocp2scp

 arch/arm/mach-omap2/devices.c              |   72 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28 +++++++++++
 drivers/bus/omap-ocp2scp.c                 |   67 ++++++++++++++++++++++++--
 include/linux/platform_data/omap_ocp2scp.h |   31 ++++++++++++
 4 files changed, 195 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/platform_data/omap_ocp2scp.h

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
