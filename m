From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: musb bogosity
Date: Fri, 8 Aug 2008 11:32:45 +0300
Message-ID: <20080808083245.GS30719@gandalf.research.nokia.com>
References: <20080808082722.GA6580@linux-sh.org>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080808082722.GA6580@linux-sh.org>
Sender: linux-next-owner@vger.kernel.org
To: ext Paul Mundt <lethal@linux-sh.org>
Cc: linux-next@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 08, 2008 at 05:27:22PM +0900, ext Paul Mundt wrote:
> The musb code currently kills the SH randconfig build (and this will hose
> any platform that also selects HAVE_CLK -- a PPC or AVR32 randconfig
> would have also hit this eventually), as can be seen here:
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/41095/
> 
> This initial failure comes from the fact that musb handily uses "special"
> I/O routines that it handily wraps, after having failed at grepping for
> other users. Why this driver isn't using ioread/writeXX_rep() is beyond
> me, as that's the portable interface we have for doing precisely this
> sort of thing, without this bizarre PIO/MMIO wrapper munging that isn't
> even going to work on most platforms.
> 
> With that ifdef in place, it's on to the next integral build failure:
> 
> drivers/usb/musb/musb_core.c: In function 'fifo_setup':
> drivers/usb/musb/musb_core.c:1122: error: 'MUSB_C_RAM_BITS' undeclared (first use in this function)
> drivers/usb/musb/musb_core.c:1122: error: (Each undeclared identifier is reported only once
> drivers/usb/musb/musb_core.c:1122: error: for each function it appears in.)
> drivers/usb/musb/musb_core.c: In function 'ep_config_from_table':
> drivers/usb/musb/musb_core.c:1246: error: 'MUSB_C_RAM_BITS' undeclared (first use in this function)
> drivers/usb/musb/musb_core.c: In function 'musb_remove':
> drivers/usb/musb/musb_core.c:2131: warning: unused variable 'ctrl_base'
> make[1]: *** [drivers/usb/musb/musb_core.o] Error 1
> make: *** [drivers/usb/musb/musb_core.o] Error 2
> 
> ...
> 
> $ git grep MUSB_C_RAM_BITS drivers/usb/musb
> drivers/usb/musb/musb_core.c:#define DYN_FIFO_SIZE (1<<(MUSB_C_RAM_BITS+2))
> drivers/usb/musb/tusb6010.h:#define MUSB_C_RAM_BITS 12
> 
> ...
> 
> the comment above MUSB_C_RAM_BITS seems to suggest that it's entirely dependent
> on the chip, so moving it in to musb_core.c wouldn't be terribly productive. Which
> leaves us in a situation where the core is dependent on arbitrary driver
> definitions, while the driver itself is obviously only dependent on the core.
> Has anyone actually tested this with TUSB6010 support disabled?
> 
> A quick grep suggests that blackfin is also going to get bitten by this, so
> simply tossing a depends on (ARM && BROKEN) in wouldn't help matters either.
> 
> ---
> 
> diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
> index 6bbedae..d0f812a 100644
> --- a/drivers/usb/musb/musb_io.h
> +++ b/drivers/usb/musb/musb_io.h
> @@ -37,7 +37,7 @@
>  
>  #include <linux/io.h>
>  
> -#ifndef	CONFIG_ARM
> +#if !defined(CONFIG_ARM) && !defined(CONFIG_SUPERH)
>  static inline void readsl(const void __iomem *addr, void *buf, int len)
>  	{ insl((unsigned long)addr, buf, len); }
>  static inline void readsw(const void __iomem *addr, void *buf, int len)

The right way to fix this would be by removing all those defines and
make that configuration come from platform_data. I have a patch for
that, I'll send it to Greg and try to be sure it gets applied. I've been
using it quite a while and it seems stable.

-- 
balbi
