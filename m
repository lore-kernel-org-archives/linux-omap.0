From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: musb bogosity
Date: Fri, 8 Aug 2008 12:37:54 +0300
Message-ID: <20080808093754.GU30719@gandalf.research.nokia.com>
References: <20080808082722.GA6580@linux-sh.org> <20080808083245.GS30719@gandalf.research.nokia.com> <20080808090445.GT30719@gandalf.research.nokia.com> <20080808092109.GA7468@linux-sh.org>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080808092109.GA7468@linux-sh.org>
Sender: linux-next-owner@vger.kernel.org
To: ext Paul Mundt <lethal@linux-sh.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-next@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 08, 2008 at 06:21:09PM +0900, ext Paul Mundt wrote:
> Yes, that fixes that problem at least, thanks.

Cool :-)

> Now the I/O bits are the only outstanding issue, as I still need the
> CONFIG_SUPERH test in musb_io.h to get around conflicting definitions.

I think we're gonna need that for a while, can you send a proper patch
changing that ifndef ??

Feel free to put my Acked-by: Felipe Balbi <felipe.balbi@nokia.com> if
you wish.

> Presently ARM and SH are the only ones that define the readsl() variants
> anyways, so stubbing in an extra ifdef there is fine as a temporary
> measure, but it's not a long-term solution. The only reason SH defines
> them at all is because we ran in to this exact same problem the last time
> an ARM driver tried passing itself off as generic ;-)

eheh... But this actually is a generic driver, we're only missing a pci
bus glue to use the musb chip on the opt cards, that would be really
nice :-)

-- 
balbi
