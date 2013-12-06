From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/2] usb: fix controller-PHY binding for OMAP3 platform
Date: Fri, 6 Dec 2013 17:36:09 +0530
Message-ID: <1386331571-30903-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

After the platform devices are created using PLATFORM_DEVID_AUTO, the
device names given in usb_bind_phy (in board file) does not match with
the actual device name causing the USB PHY library not to return the
PHY reference when the MUSB controller request for the PHY in the non-dt boot
case.
So removed creating platform devices using PLATFORM_DEVID_AUTO in omap2430.c.

Changes from v1:
* refreshed to the latested mainline kernel
* added musb_put_id from omap2430 remove.

Kishon Vijay Abraham I (2):
  usb: musb: omap: remove using PLATFORM_DEVID_AUTO in omap2430.c
  arm: omap: remove *.auto* from device names given in usb_bind_phy

 arch/arm/mach-omap2/board-2430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c         |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c     |    2 +-
 arch/arm/mach-omap2/board-ldp.c            |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c     |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c   |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
 arch/arm/mach-omap2/board-overo.c          |    2 +-
 arch/arm/mach-omap2/board-rx51.c           |    2 +-
 drivers/usb/musb/musb_core.c               |   31 +++++++++++++++++++++++++++-
 drivers/usb/musb/musb_core.h               |    2 ++
 drivers/usb/musb/omap2430.c                |   19 +++++++++++++++--
 15 files changed, 61 insertions(+), 15 deletions(-)

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
