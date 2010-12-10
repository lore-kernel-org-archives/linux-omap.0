From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: Subject: [PATCH 0/5 v4]usb: musb: hwmod and runtime pm support for musb
Date: Fri, 10 Dec 2010 18:21:48 +0530
Message-ID: <1291985508-26955-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch series makes OMAP2PLUS musb module implemented
in HWMOD FW way. It also implements musb driver to
use the runtime pm apis.

As per the OMAP usbotg specification[1] musb sysconfig register
has to be set to force idle and force standby when not used
and set smart idle/standby or no idle/standby during operation.
otherwise core-off will be prevented by musb.

[1]: http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf

This patch series is based on V2.6.37-rc4 + [2]+[3]+[4]

[2] http://www.listware.net/201011/linux-usb/
65625-patch-resend-v3-usb-musb-do-not-use-dma-for-control-transfers.html

[3] Felipe's musb-reorg patch series.
	http://gitorious.org/usb/usb/commits/musb-hw
	
[4] usb: otg: TWL6030: OMAP4430: musb & transceiver driver support
	for OMAP4 posted by me.

with this patch series tested musb functionality like testusb, masstorage
OMAP4430SDP, OMAP3630 zoom3, OMAP3430 SDP

Power management tests like retention and offmode validation tests are not
done with these patches.
There will be another set of patches submitted with PM on musb.

Version History:
---------------
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

Cousson, Benoit (1):
   OMAP4430: hwmod data: Adding USBOTG

Hema HK (4):
  OMAP2430: hwmod data: Add USBOTG
  OMAP3xxx: hwmod data: Add USBOTG
  OMAP2+: musb: HWMOD adaptation for musb.
  usb: musb: Using runtime pm APIs for musb.

  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   97 +++++++++++++++++++++++++++
  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  100 ++++++++++++++++++++++++++++
  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   94 ++++++++++++++++++++++++++
  arch/arm/mach-omap2/usb-musb.c             |   66 ++++++++++++++----
  drivers/usb/musb/musb_core.h               |    2 +-
  drivers/usb/musb/omap2430.c                |   77 +++++----------------
  6 files changed, 362 insertions(+), 74 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
