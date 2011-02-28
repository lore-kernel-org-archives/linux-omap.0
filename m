From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5 v3] usb: musb: Power management support
Date: Mon, 28 Feb 2011 14:19:31 +0530
Message-ID: <1298882976-4997-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch series supports the retention and offmode support in the 
idle path for musb driver using runtime pm APIs.

This is restricted to support offmode and retention only when device not
connected.When device/cable connected with gadget driver loaded, configured
to no idle/standby which will not allow the core transition to retention
or off.

There is no context save/restore done by hardware for musb in OMAP3
and OMAP4,driver has to take care of saving and restoring the context
during offmode.

Musb has a requirement of configuring sysconfig register to force
idle/standby mode and set the ENABLE_FORCE bit in module STANDBY register
for retention and offmode support.

Runtime pm and hwmod frameworks will take care of configuring to force
idle/standby when pm_runtime_put_sync is called and back to no
idle/standby when pm_runeime_get_sync is called.

Compile, boot tested and also tested the retention in the idle path on
OMAP3630Zoom3. And tested the global suspend/resume with offmode enabled.
Usb basic functionality tested on OMAP4430SDP.

There is some problem with idle path offmode in mainline, I could not test
with offmode. But I have tested this patch with resetting the controller
in the idle path when wakeup from retention just to make sure that the
context is lost, and restore path is working fine.

V3 Vesion:

Fixed some minor comments from Felipe.

V2 version:
----------
Rebased patches on Felipe's musb-hwmod-pm-runtime branch.
Fixed comments from Felipe.

Hema HK (5):
  usb: otg: TWL4030: Update the last_event variable.
  usb: musb: Remove platform context save/restore APIs
  usb: musb: Idle path retention and offmode support for OMAP3
  usb: musb: OMAP4430: Power down the PHY during board init
  usb: otg: OMAP4430: Save/restore the context

 arch/arm/mach-omap2/omap_phy_internal.c |    7 ++++
 arch/arm/mach-omap2/usb-musb.c          |    4 ++
 drivers/usb/musb/musb_core.c            |   40 +++++++++++++++++++++++
 drivers/usb/musb/musb_core.h            |    4 --
 drivers/usb/musb/musb_gadget.c          |   11 ++++++
 drivers/usb/musb/omap2430.c             |   54 ++++++++++++++----------------
 drivers/usb/otg/twl4030-usb.c           |    2 +
 7 files changed, 89 insertions(+), 33 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
