From: David Brownell <david-b@pacbell.net>
Subject: Re: Some musb Blackfin porting issues
Date: Thu, 06 Sep 2007 11:44:44 -0700
Message-ID: <20070906184444.A96922371B3@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <1189061545.8833.11.camel@roc-desktop>
	<20070906144356.GC7618@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070906144356.GC7618@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: tony@atomide.com, bryan.wu@analog.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > I almost imported the musb stack to our Blackfin tree. But there are
> > some code highly coupled with ARM Linux architecture. Please give me
> > some idea about following issues:
> > 
> > 1. Clock framework is not available in Blackfin Linux arch currently. Is
> > it possible to skip it?
>
> Yes, you can have custom clock enable/disable functions, see tusb_set_clock()
> in arch/arm/mach-omap2/board-n800-usb.c.

One minor issue would then be needing stub implementations of the clk_*()
functions so the driver can link.  The same issue comes up on x86 builds,
which would be good to allow as part of routine build tests.

Maybe you can just provide a set of inlined NOP clock stubs in the musb code
that would be included as needed.  I'd suggest you avoid trying to solve
that general cross-arch problem, at least initially.


> > 2. Registers layout in musb-regs.h is different with BF54x processor. I
> > plan to write a musb-bf54x.h to replace the whole definition in
> > musb-regs.h. Is that possible or do it conflict with current musb
> > design?
> > in musb-regs.h:
> > ---
> > #ifdef CONFIG_BF54x
> > #include "musb-bf54x.h"
> > #else
> > ..... /* original code from musb-regs.h */
> > #endif
> > --
>
> I guess that's the way to go for now to get things working. Dave?

Something like that, sure.  But I'd like it better if it were more
like two different #include files, one for Blackfin and one for the
standard register layouts (matching Mentor specs).

Are those registers the same widths?  If the differences go beyond
just addressing, I'd forsee trouble ahead.

- Dave
