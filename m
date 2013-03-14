From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/4] usb: musb/otg: cleanup and fixes
Date: Thu, 14 Mar 2013 11:53:55 +0530
Message-ID: <1363242239-1061-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series has some misc cleanup and fixes. The fix solves the cold
plug issue in omap3 which some have reported. Developed these patches on
fixes-for-v3.9-rc3 after applying 
http://www.spinics.net/lists/linux-usb/msg81563.html
(Grazvydas Ignotas patch series)

Tested for g_zero enumeration in pandaboard and beagleboard in both
cold plug and hot plug case. Any kind of testing for this series is welcome.

Changes from v1:
* removed *usb: musb: omap: remove the check before calling otg_set_vbus*
a similar patch is already merged.

Kishon Vijay Abraham I (4):
  usb: musb: omap: remove the check before calling otg_set_vbus
  usb: otg: twl4030: use devres API for regulator get and request irq
  usb: musb: omap: add usb_phy_init in omap2430_musb_init
  usb: otg: twl4030: fix cold plug on OMAP3

 drivers/usb/musb/omap2430.c   |   11 +++++------
 drivers/usb/otg/twl4030-usb.c |   35 ++++++++++++-----------------------
 2 files changed, 17 insertions(+), 29 deletions(-)

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
