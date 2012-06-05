From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5] usb: musb: cleanup
Date: Tue, 5 Jun 2012 15:08:33 +0530
Message-ID: <1338889118-10032-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Most part of this patch series was obtained by splitting
[RFC PATCH 2/3] usb: musb: omap glue: use omap-usb2 as the phy driver.

TO DO:
* dt adaptation of musb omap glue, twl4030, twl6030.
* Use control module driver API to write to control module registers
 (mailbox and power control of phy)
* send usb2 phy driver
* make musb omap glue make use of usb2 phy driver and make twl630
 as a comparator driver.

Patch series depends on
[PATCH v4 0/3] usb: multi-phy support

Performed device mode testing in omap4 panda and omap3 beagle

Kishon Vijay Abraham I (5):
  usb: musb: move work_struct(otg_notifier_work) from core to omap glue
  usb: musb: twl: use mailbox API to send VBUS or ID events
  drivers: usb: musb: move otg specific initializations from twl to
    glue
  usb: musb: omap: use devres API to allocate resources
  drivers: usb: otg: twl: use devres API to allocate resources

 drivers/usb/musb/musb_core.h  |    2 -
 drivers/usb/musb/omap2430.c   |  118 +++++++++++++++++++++++++---------------
 drivers/usb/otg/twl4030-usb.c |   63 ++++++++--------------
 drivers/usb/otg/twl6030-usb.c |   69 ++++++++----------------
 include/linux/usb/musb-omap.h |   30 ++++++++++
 5 files changed, 150 insertions(+), 132 deletions(-)
 create mode 100644 include/linux/usb/musb-omap.h

-- 
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
