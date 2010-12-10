From: Hema HK <hemahk@ti.com>
Subject: Subject: [PATCH 0/5 v5]usb: musb: hwmod and runtime pm support for musb
Date: Fri, 10 Dec 2010 20:05:34 +0530
Message-ID: <1291991739-21705-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34275 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab0LJOfw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 09:35:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

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
Version V5:

Fixed review comments from Felipe.


Version V4:

Rebased the changes based on the re-orgnized patches submitted by Felipe.
Fixed review comments received for V3.
Dropped the idlepath  power management patch with this series.

Some of the links for V3 review comments:

https://patchwork.kernel.org/patch/199482/
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35488.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg33201.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35387.html

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
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34068.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32024.html
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
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32973.html

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---

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
