From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.23-omap] misc musb tweaks
Date: Sun, 14 Oct 2007 18:10:34 -0700
Message-ID: <200710141810.34403.david-b@pacbell.net>
References: <200710121426.00525.david-b@pacbell.net>
	<20071014171642.GF22833@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071014171642.GF22833@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sunday 14 October 2007, Tony Lindgren wrote:
> I guess we should still at least clean up the CONFIG_USB_INVENTRA_DMA
> sections in the common DMA code before submitting to linux-usb-devel.

That's ugly as all get-out, but not what I'd call a blocking issue.

It *should* be essentially an overhaul to the guts of the DMA glue:
there are {RX,TX}_{submit,complete}_{gadget,host} paths, which should
get unified, then seriously retested on several platforms.  That's
not straightforward... and there's no reason not to do that *AFTER*
the code goes upstream.

Similarly with the Blackfin (525?) support:  that can be done after
a upstream merge, too.


> What else should we still fix before submitting to linux-usb-devel?

I don't see much of a reason why it shouldn't go upstream "now"...

What we need is someone to create the patches.  When I asked a while
back, nobody really objected to "one huge patch" ... though I think
breaking it down into

 (a) drivers/usb/musb/*.[hc]
 (b) the various platform hooks, in arch/ and include/asm-*/*
 (c) kbuild stuff (Kconfig and Makefile updates)

would be best.  That is, no need to split out the gadget side
from the host side, or TUSB6010 from OMAP2430 from DaVinci, etc.
(It'd also be good to have a MAINTAINERS entry...)

If someone did that part, and made sure the TUSB6010 stuff would
build on some non-OMAP hardware (without DMA), I could sanity
check it and sign off before sending it upstream.  Dunno if it'd
make 2.6.24, but I'd not rule it out.

- Dave
