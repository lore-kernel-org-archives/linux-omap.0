From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/6 v7]usb: musb: hwmod and runtime pm support for musb
Date: Wed, 16 Feb 2011 17:58:12 +0530
Message-ID: <1297859298-27861-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch series makes OMAP2PLUS musb module implemented
in HWMOD FW way. It also implements musb driver to
use the runtime pm apis.

As per the OMAP usbotg specification[1] musb sysconfig register
has to be set to force idle and force standby when not used
and set smart idle/standby or no idle/standby during operation.
otherwise core-off will be prevented by musb.

[1]: http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf

This patch series is based on V2.6.38-rc4 + [1] +[2] + [3]

[1] https://patchwork.kernel.org/patch/513461
[2] http://www.spinics.net/lists/linux-usb/msg40575.html
[3] 

With this patch series tested musb functionality like testusb, masstorage
OMAP4430SDP, OMAP3430SDP, and OMAP3630 zoom3.
Boot and basic usb tested on AM35x.

Tested global suspend resume for offmode and retention on OMAP3630Zoom3.
Idle path retention and offmode validation is not done with these patch series.


Version History:
---------------

Version V7

Added the hwmod for AM35x.
Fixed the comments from Felipe and Kevin.

Version V6

Calling runtime_pm_suspend in the pm_ops function was not effective.
So using the bus runtime methods directly in the pm_ops suspend/resume
functions.

Version V5:

Fixed review comments from Felipe.


Version V4:

Rebased the changes based on the re-orgnized patches submitted by Felipe.
Fixed review comments received for V3.
Dropped the idlepath  power management patch with this series.

Some of the links for V3 review comments:

https://patchwork.kernel.org/patch/199482/
http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg35488.html
http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg33201.html
http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg35387.html

Version V3

Added the patch for adding the hwmod database for OMAP2430.
Re-arranged the patches in such a way that first migrate the musb driver
to use the runtime PM apis and then added a patch to support offmode in idle path.
Calling the runtime PM apis before disbaling the interupts in the idle path.
Added the #ifdef CONFIG_PM_RUNTIME  check in the musb core driver for calling 
the runtime PM APIs as non-omap platforms may not have the runtime pm enabled
and clk_enable/disable should be called for them.

Optimized the context save restore of musb registers only if the next state is
going to offmode and previous state was offmode.

Some of the links for V2 review comments
----------------------------------------
http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg34068.html
http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg32024.html
http://www.spinics.net/lists/linux-usb/msg35562.html
http://www.spinics.net/lists/linux-usb/msg35720.html

Vesrion v2:

Fixed review comments.
Removed the omap_hwmod.h inclusion from musb.h file which was 
breaking the non-omap platform build.
Using the runtime pm apis in the idle path(interrupts disabled).
Added the omap4 hwmod data base.

Version v1:
initial version of the patch series.

Some of the links for v1
------------------------

http://www.spinics.net/lists/linux-usb/msg34570.html
http://www.spinics.net/lists/linux-omap/msg34568.html
http://www.spinics.net/lists/linux-usb/msg34544.html
http://www.spinics.net/lists/linux-usb/msg34540.html
http://www.spinics.net/lists/linux-usb/msg34589.html
http://www.spinics.net/lists/linux-usb/msg34554.html
http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg32973.html

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---

Cousson, Benoit (1):
   OMAP4430: hwmod data: Adding USBOTG

Hema HK (5):
  OMAP2430: hwmod data: Add USBOTG
  OMAP3xxx: hwmod data: Add USBOTG
  AM35xx: hwmod data: Add USBOTG
  OMAP2+: musb: hwmod adaptation for musb.
  usb: musb: Using runtime pm APIs for musb.
  

 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   98 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  101 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   93 +++++++++++++++++++++++++
 arch/arm/mach-omap2/usb-musb.c             |   76 +++++++++++++++------
 drivers/usb/musb/musb_core.h               |    2 +-
 drivers/usb/musb/omap2430.c                |   79 ++++++----------------
 6 files changed, 369 insertions(+), 80 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
