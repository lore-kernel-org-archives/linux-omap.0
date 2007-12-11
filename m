From: Felipe Balbi <ext-felipe.lima@nokia.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: Add support for USB on OMAP34XX
Date: Tue, 11 Dec 2007 08:24:20 -0400
Message-ID: <20071211122420.GA6553@1BRL00624.americas.nokia.com>
References: <1c8a8d69cabac728400ae8adb81f74d7@felipebalbi.com>
	<010C7BAE6783F34D9AC336EE5A01A08804FE6F5C@dbde01.ent.ti.com>
Reply-To: ext-felipe.lima@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08804FE6F5C@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 11, 2007 at 02:53:01PM +0530, ext Gadiyar, Anand wrote:
> Felipe and others,
> 
> > > Index: linux-omap/arch/arm/mach-omap2/board-3430sdp-usb.c
> > > ===================================================================
> > > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > > +++ linux-omap/arch/arm/mach-omap2/board-3430sdp-usb.c	
> <snip>
> > > +#include <linux/types.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/usb/musb.h>
> > > +
> > > +#include <asm/arch/hardware.h>
> > > +#include <asm/arch/usb.h>
> > > +
> > > +#if defined(CONFIG_USB_MUSB_HDRC) ||
> > defined(CONFIG_USB_MUSB_HDRC_MODULE)
> > 
> > What about #ifdef CONFIG_USB_MUSB_SOC
> > 
> 
> How is this relevant? Could you please elaborate?

#if defined(*) || defined(*_MODULE) looks a bit awkward.
CONFIG_USB_MUSB_SOC is a boolean macro and is true in 2430 and 34XX.

Anybody has any comments on this ??

> 
> 
> 
> > > Index: linux-omap/arch/arm/mach-omap2/board-3430sdp.c
> > > ===================================================================
> > > --- linux-omap.orig/arch/arm/mach-omap2/board-3430sdp.c	
> > 2007-12-05
> > > 10:02:53.000000000 +0530
> > > +++ linux-omap/arch/arm/mach-omap2/board-3430sdp.c	2007-12-05
> > > 17:04:09.664182922 +0530
> > > @@ -307,6 +307,8 @@
> > >  	return 0;
> > >  }
> > > 
> > > +extern void __init sdp3430_usb_init(void);
> > 
> > This extern will look better in 
> > include/asm-arm/arch-omap/board-3430sdp.h
> 
> Yes. But there are other .c files in arch/arm/mach-omap2 that declare externs.
> Specifically, board-2430sdp.c also does it this way. I thought it would be a
> good idea to retain the same structure.
> 
> I can move it to the .h file if needed. What do you think?

Don't know about the others, but I'd prefer seeing this prototype in the
header file.


-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br
+55 92 2126-1003

INdT - OSMRC - Manaus
Core Team
