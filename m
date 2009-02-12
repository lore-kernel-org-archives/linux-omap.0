From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] musb_hdrc: Clean-up MUSB init code for next merge
	window
Date: Thu, 12 Feb 2009 11:44:54 -0800
Message-ID: <20090212194450.GC7562@atomide.com>
References: <20090212191408.19766.62874.stgit@localhost> <20090212191707.19766.23783.stgit@localhost> <20090212193013.GM10711@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57241 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760105AbZBLTo6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 14:44:58 -0500
Content-Disposition: inline
In-Reply-To: <20090212193013.GM10711@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

* Felipe Balbi <me@felipebalbi.com> [090212 11:32]:
> On Thu, Feb 12, 2009 at 11:17:08AM -0800, Tony Lindgren wrote:
> > Let's just use mach/usb.h as mach/musb.h only has one entry.
> > 
> > Cc: Felipe Balbi <felipe.balbi@nokia.com>
> > Cc: David Brownell <dbrownell@users.sourceforge.net>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/board-2430sdp.c        |    2 +-
> >  arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
> >  arch/arm/mach-omap2/board-ldp.c            |    2 +-
> >  arch/arm/mach-omap2/board-omap3beagle.c    |    2 +-
> >  arch/arm/mach-omap2/board-omap3evm.c       |    2 +-
> >  arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
> >  arch/arm/mach-omap2/board-overo.c          |    2 +-
> >  arch/arm/mach-omap2/board-rx51.c           |    2 +-
> >  arch/arm/plat-omap/include/mach/usb-musb.h |   35 ----------------------------
> >  arch/arm/plat-omap/include/mach/usb.h      |    4 ++-
> >  10 files changed, 10 insertions(+), 45 deletions(-)
> >  delete mode 100644 arch/arm/plat-omap/include/mach/usb-musb.h
> > 
> > diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> > index cc65b1a..aa5df72 100644
> > --- a/arch/arm/mach-omap2/board-2430sdp.c
> > +++ b/arch/arm/mach-omap2/board-2430sdp.c
> > @@ -36,7 +36,7 @@
> >  #include <mach/gpio.h>
> >  #include <mach/mux.h>
> >  #include <mach/board.h>
> > -#include <mach/usb-musb.h>
> > +#include <mach/usb.h>
> >  #include <mach/common.h>
> >  #include <mach/gpmc.h>
> >  #include <mach/mcspi.h>
> > diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> > index 8a0dba6..10be03e 100644
> > --- a/arch/arm/mach-omap2/board-3430sdp.c
> > +++ b/arch/arm/mach-omap2/board-3430sdp.c
> > @@ -34,7 +34,7 @@
> >  #include <mach/gpio.h>
> >  #include <mach/mux.h>
> >  #include <mach/board.h>
> > -#include <mach/usb-musb.h>
> > +#include <mach/usb.h>
> >  #include <mach/usb-ehci.h>
> >  #include <mach/common.h>
> >  #include <mach/dma.h>
> > diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> > index 73c4504..1e1fd84 100644
> > --- a/arch/arm/mach-omap2/board-ldp.c
> > +++ b/arch/arm/mach-omap2/board-ldp.c
> > @@ -35,7 +35,7 @@
> >  #include <mach/board.h>
> >  #include <mach/common.h>
> >  #include <mach/gpmc.h>
> > -#include <mach/usb-musb.h>
> > +#include <mach/usb.h>
> >  
> >  #include <asm/io.h>
> >  #include <asm/delay.h>
> > diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> > index 64c76bd..64fc613 100644
> > --- a/arch/arm/mach-omap2/board-omap3beagle.c
> > +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> > @@ -38,7 +38,7 @@
> >  #include <asm/mach/flash.h>
> >  
> >  #include <mach/board.h>
> > -#include <mach/usb-musb.h>
> > +#include <mach/usb.h>
> >  #include <mach/usb-ehci.h>
> >  #include <mach/common.h>
> >  #include <mach/gpmc.h>
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> > index 775a1f3..4946463 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -31,7 +31,7 @@
> >  
> >  #include <mach/gpio.h>
> >  #include <mach/board.h>
> > -#include <mach/usb-musb.h>
> > +#include <mach/usb.h>
> >  #include <mach/usb-ehci.h>
> >  #include <mach/common.h>
> >  #include <mach/mcspi.h>
> > diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
> > index 2637641..cd90bf4 100644
> > --- a/arch/arm/mach-omap2/board-omap3pandora.c
> > +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> > @@ -45,7 +45,7 @@
> >  #include <mach/hardware.h>
> >  #include <mach/nand.h>
> >  #include <mach/usb-ehci.h>
> > -#include <mach/usb-musb.h>
> > +#include <mach/usb.h>
> >  #include <mach/mcspi.h>
> >  
> >  #include "sdram-micron-mt46h32m32lf-6.h"
> > diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> > index c95b890..f600f70 100644
> > --- a/arch/arm/mach-omap2/board-overo.c
> > +++ b/arch/arm/mach-omap2/board-overo.c
> > @@ -46,7 +46,7 @@
> >  #include <mach/hardware.h>
> >  #include <mach/nand.h>
> >  #include <mach/usb-ehci.h>
> > -#include <mach/usb-musb.h>
> > +#include <mach/usb.h>
> >  
> >  #include "sdram-micron-mt46h32m32lf-6.h"
> >  #include "twl4030-generic-scripts.h"
> > diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> > index e845aac..98dfde1 100644
> > --- a/arch/arm/mach-omap2/board-rx51.c
> > +++ b/arch/arm/mach-omap2/board-rx51.c
> > @@ -28,7 +28,7 @@
> >  #include <mach/keypad.h>
> >  #include <mach/dma.h>
> >  #include <mach/gpmc.h>
> > -#include <mach/usb-musb.h>
> > +#include <mach/usb.h>
> >  
> >  #include <asm/io.h>
> >  #include <asm/delay.h>
> > diff --git a/arch/arm/plat-omap/include/mach/usb-musb.h b/arch/arm/plat-omap/include/mach/usb-musb.h
> > deleted file mode 100644
> > index b455b29..0000000
> > --- a/arch/arm/plat-omap/include/mach/usb-musb.h
> > +++ /dev/null
> > @@ -1,35 +0,0 @@
> > -/*
> > - * arch/arm/plat-omap/include/mach/usb-musb.h
> > - *
> > - * Hardware definitions for Mentor Graphics MUSBMHDRC.
> > - *
> > - * Initial creation by Felipe Balbi.
> > - *
> > - * This program is free software; you can redistribute it and/or modify it
> > - * under the terms of the GNU General Public License as published by the
> > - * Free Software Foundation; either version 2 of the License, or (at your
> > - * option) any later version.
> > - *
> > - * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> > - * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> > - * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
> > - * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> > - * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> > - * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> > - * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> > - * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> > - * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > - *
> > - * You should have received a copy of the GNU General Public License along
> > - * with this program; if not, write to the Free Software Foundation, Inc.,
> > - * 675 Mass Ave, Cambridge, MA 02139, USA.
> > - */
> > -
> > -#ifndef __ASM_ARCH_OMAP_USB_MUSB_H
> > -#define __ASM_ARCH_OMAP_USB_MUSB_H
> > -
> > -extern void usb_musb_init(void);
> > -
> > -#endif /* __ASM_ARCH_OMAP_USB_MUSB_H */
> > -
> > diff --git a/arch/arm/plat-omap/include/mach/usb.h b/arch/arm/plat-omap/include/mach/usb.h
> > index e078155..7d7b2b0 100644
> > --- a/arch/arm/plat-omap/include/mach/usb.h
> > +++ b/arch/arm/plat-omap/include/mach/usb.h
> > @@ -27,8 +27,8 @@
> >  #define UDC_BASE			OMAP2_UDC_BASE
> >  #define OMAP_OHCI_BASE			OMAP2_OHCI_BASE
> >  
> > -void __init usb_musb_init(void);
> > -void __init usb_ehci_init(void);
> > +extern void usb_musb_init(void);
> > +extern void usb_ehci_init(void);
> 
> This second line has nothing to with musb, right ? You should move to
> usb-ehci.h removal patch.

OK, good point, I'll get rid of usb-ehci.h as well then.

Tony
