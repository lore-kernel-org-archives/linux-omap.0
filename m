From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [Resending - PATCH 1/3] Triton BCI driver board/device setup
	for OMAP3430
Date: Tue, 5 Aug 2008 17:05:51 +0300
Message-ID: <20080805140551.GC30539@gandalf.research.nokia.com>
References: <38309.192.168.10.89.1216727733.squirrel@dbdmail.itg.ti.com> <1473aac0380c8c62329714e83f6ca795@felipebalbi.com> <002301c8ec7f$1405df30$37f6180a@ent.ti.com> <3db54da6fc6e74db523cc8e6bd2cf69d@felipebalbi.com> <20080805133550.GJ7193@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21808 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbYHEOG2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 10:06:28 -0400
Content-Disposition: inline
In-Reply-To: <20080805133550.GJ7193@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Mikko.K.Ylinen@nokia.com

On Tue, Aug 05, 2008 at 04:35:51PM +0300, Tony Lindgren wrote:
> * Felipe Balbi <me@felipebalbi.com> [080723 10:32]:
> > 
> > 
> > On Wed, 23 Jul 2008 10:16:27 +0530, "Madhusudhan Chikkature"
> > <madhu.cr@ti.com> wrote:
> > > Hi Felipe,
> > > 
> > >> Tony, weird that we still have these prototypes in these headers.
> > >> Could be some merging conflict ?
> > > Yes. I see that these prototypes are still present in the board3430 and
> > > board2430 header files in the omap tree.
> > > 
> > >> Anyways, please apply the attached patch. We're using
> > >> usb_musb_init() and usb_ehci_init() now.
> > > You mean I should apply the attached patch you sent for local use, right?
> > > And I guess I dont need to resend this perticular BCI patch, am I
> > correct?
> > 
> > No :-)
> > 
> > that was to Tony. Just replied to your mail so it's easy to see why we need
> > that patch :-)
> 
> Pushing these today. Do you have a patch for moving the extern
> prototypes into the twl header?

I was talking about these:

From: Felipe Balbi <felipe.balbi@nokia.com>

arch: omap: get rid of usb_init() protytpes

we now use usb_musb_init() and usb_ehci_init() functions

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

diff --git a/include/asm-arm/arch-omap/board-2430sdp.h b/include/asm-arm/arch-omap/board-2430sdp.h
index fde6915..83d0eec 100644
--- a/include/asm-arm/arch-omap/board-2430sdp.h
+++ b/include/asm-arm/arch-omap/board-2430sdp.h
@@ -36,6 +36,5 @@
 
 /* Function prototypes */
 extern void sdp2430_flash_init(void);
-extern void sdp2430_usb_init(void);
 
 #endif /* __ASM_ARCH_OMAP_2430SDP_H */
diff --git a/include/asm-arm/arch-omap/board-3430sdp.h b/include/asm-arm/arch-omap/board-3430sdp.h
index d583008..85f769e 100644
--- a/include/asm-arm/arch-omap/board-3430sdp.h
+++ b/include/asm-arm/arch-omap/board-3430sdp.h
@@ -29,7 +29,6 @@
 #ifndef __ASM_ARCH_OMAP_3430SDP_H
 #define __ASM_ARCH_OMAP_3430SDP_H
 
-extern void sdp3430_usb_init(void);
 extern void sdp3430_flash_init(void);
 
 #define DEBUG_BASE                     0x08000000  /* debug board */

-- 
balbi
