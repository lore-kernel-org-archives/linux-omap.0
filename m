From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv2 00/15] Get MUSB PM runtime working again
Date: Wed, 11 May 2016 17:53:01 -0700
Message-ID: <1463014396-4095-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's the whole series reposted with a bunch of additional changes.
It seems to now properly work with with multiple phy cable status
events, and should work for Ivaylo on n900 too.

Please re-review and re-test.

Regards,

Tony

Tony Lindgren (15):
  usb: musb: Fix idling after host mode by increasing autosuspend delay
  usb: musb: Remove unnecessary shutdown function
  usb: musb: Update to use PM runtime autosuspend
  usb: musb: Split PM runtime between wrapper IP and musb core
  usb: musb: Remove conditional PM runtime calls for musb_gadget
  usb: musb: Use delayed for musb_gadget_pullup
  usb: musb: Handle cable status better for 2430 glue layer
  usb: musb: Improve PM runtime and phy handling for 2430 glue layer
  usb: musb: Remove try_idle for 2430 glue layer
  usb: musb: Don't set d+ high before enable for 2430 glue layer
  usb: musb: Return error value from musb_mailbox
  usb: musb: Remove extra PM runtime calls from 2430 glue layer
  usb: musb: Remove pm_runtime_set_irq_safe
  usb: musb: Use normal module_init for 2430 glue
  usb: phy: Check initial state for twl6030

 drivers/phy/phy-twl4030-usb.c     |  14 +-
 drivers/usb/musb/musb_core.c      |  82 +++++-------
 drivers/usb/musb/musb_core.h      |   3 +-
 drivers/usb/musb/musb_gadget.c    |  34 +++--
 drivers/usb/musb/omap2430.c       | 260 ++++++++++++++------------------------
 drivers/usb/phy/phy-twl6030-usb.c |  29 ++++-
 include/linux/usb/musb.h          |   5 +-
 7 files changed, 189 insertions(+), 238 deletions(-)

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
