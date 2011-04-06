From: Jarkko Nikula <jhnikula@gmail.com>
Subject: What is missing from musb - linux-omap merge?
Date: Wed, 6 Apr 2011 16:23:34 +0300
Message-ID: <20110406162334.8dcb5a7d.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__6_Apr_2011_16_23_34_+0300_E7DDlwNy8vfP.TG_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55670 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab1DFNWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Apr 2011 09:22:21 -0400
Received: by eyx24 with SMTP id 24so440097eyx.19
        for <linux-omap@vger.kernel.org>; Wed, 06 Apr 2011 06:22:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP Linux discussion <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Hema HK <hemahk@ti.com>

This is a multi-part message in MIME format.

--Multipart=_Wed__6_Apr_2011_16_23_34_+0300_E7DDlwNy8vfP.TG_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi

I've been trying to hunt why the OMAP3 retention on Nokia N900 went
broken in 2.6.39-rc and reason is somewhere around musb code merge with
linux-omap code or vise versa.

I bisected this into:

commit 0df0914d414a504b975f3cc66ace0c16ef55b7f3
Merge: 6899608 05f6894
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Mar 17 19:28:15 2011 -0700

    Merge branch 'omap-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6

Yep, there were conflicts resolved by Linus but those didn't look that
they explain the problem.

So then I went to check the linux-omap branch omap-for-linus that got
pulled to vanilla. Top commit was:

commit 05f689400ea5fa3d71af82f910c8b140f87ad1f3
Merge: 17fe12c 02b7b94
Author: Tony Lindgren <tony@atomide.com>
Date:   Mon Mar 14 11:22:22 2011 -0700

    Merge branches 'devel-mux' and 'devel-misc' into omap-for-linus

Here retention and usb networking are working so all were fine in
linux-omap in 2.6.38-rc7.

Then back to vanilla and checking the usb pull.

commit 971f115a50afbe409825c9f3399d5a3b9aca4381
Merge: 2e270d8 500132a
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Mar 16 15:04:26 2011 -0700

    Merge branch 'usb-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6

Yes, musb doesn't compile here... trivial build fix attached as it's
not our interest now (but will bother all bisecters). Here retention
works but usb networking doesn't.

Then I went testing patches from linux-omap/omap-for-linus on top of
vanilla commit that precedes the omap-for-linus pull:

commit 6899608533410557e6698cb9d4ff6df553916e98
Merge: 411f5c7 92c260f
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Mar 17 19:13:18 2011 -0700

    Merge branch 'for-linus' of
git://codeaurora.org/quic/kernel/davidb/linux-ms

Some amount of conflict resolving, mostly trivial, some testing and
came around these commits (note local commit ids):

commit 5cd15f0ba7594e4cd1dd01a100dc94013930a6a9
Author: Hema HK <hemahk@ti.com>
Date:   Thu Feb 17 12:07:17 2011 +0530

    OMAP2430: hwmod data: Add USBOTG

-> Retention ok

commit 2d982bb2593ab64151c4a01758735e67d7db5d36
Author: Hema HK <hemahk@ti.com>
Date:   Thu Feb 17 12:07:18 2011 +0530

    OMAP3xxx: hwmod data: Add USBOTG

commit 6dc0c8ee8bdaac3ad11c4313431d8d7b3c886ede
Author: Hema HK <hemahk@ti.com>
Date:   Thu Feb 17 12:07:19 2011 +0530

    AM35xx: hwmod data: Add USBOTG
 
-> These don't boot

commit 4bd3924ed10bef872e1fbfbb590fb7132df7dd4c
Author: Hema HK <hemahk@ti.com>
Date:   Thu Feb 17 12:07:21 2011 +0530

    OMAP2+: musb: hwmod adaptation for musb registration

-> Boots, usb networking works and but no retention


Then arch/arm/mach-omap2 diff between

vanilla 0df0914d414a504b975f3cc66ace0c16ef55b7f3 (l-o pull)
and
l-o 05f689400ea5fa3d71af82f910c8b140f87ad1f3 (for linus)

doesn't show any suspicious to me. E.g. no differences in
omap_hwmod_3xxx_data.c and clock3xxx_data.c changes are just those
clock name changes that Linus complained. Rest seems to be unrelated.

 Kconfig                        |    1 
 Makefile                       |    2 
 board-3430sdp.c                |   10 
 board-3630sdp.c                |   10 
 board-4430sdp.c                |    1 
 board-am3517crane.c            |   10 
 board-am3517evm.c              |   12 
 board-cm-t35.c                 |   10 
 board-cm-t3517.c               |   10 
 board-devkit8000.c             |   10 
 board-igep0020.c               |   10 
 board-igep0030.c               |   10 
 board-omap3beagle.c            |   10 
 board-omap3evm.c               |   14 -
 board-omap3pandora.c           |   10 
 board-omap3stalker.c           |   10 
 board-omap3touchbook.c         |   10 
 board-omap4panda.c             |   11 
 board-overo.c                  |   10 
 board-zoom.c                   |   10 
 clock3xxx_data.c               |   19 +
 clock44xx_data.c               |   10 
 include/mach/board-zoom.h.orig |   11 
 include/mach/debug-macro.S     |   13 
 omap4-common.c                 |    7 
 omap_phy_internal.c            |   29 +-
 pm.h                           |    2 
 sleep24xx.S                    |    2 
 sleep34xx.S                    |    2 
 sram242x.S                     |    3 
 sram243x.S                     |    3 
 sram34xx.S                     |    1 
 usb-ehci.c                     |  522 -------------------------------------
 usb-host.c                     |  574 +++++++++++++++++++++++++++++++++++++++++
 usb-musb.c                     |    3 
 35 files changed, 737 insertions(+), 645 deletions(-)

These findings made me thinking are there some patch or patchset
missing for musb as there are these musb build breakages and usb
networking not working in mainline issues, retention breaks only when
applying patches from linux-omap/omap-for-linus but what are ok in
linux-omap 2.6.38-rc7?

-- 
Jarkko

--Multipart=_Wed__6_Apr_2011_16_23_34_+0300_E7DDlwNy8vfP.TG_
Content-Type: text/x-diff;
 name="musb.diff"
Content-Disposition: attachment;
 filename="musb.diff"
Content-Transfer-Encoding: 7bit

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 241fc94..5298949 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -214,10 +214,6 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 
 	if (platform_device_register(&musb_device) < 0)
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
-
-	if (cpu_is_omap44xx())
-		omap4430_phy_init(dev);
-
 }
 
 #else

--Multipart=_Wed__6_Apr_2011_16_23_34_+0300_E7DDlwNy8vfP.TG_--
