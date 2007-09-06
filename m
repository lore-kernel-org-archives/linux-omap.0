From: Tony Lindgren <tony@atomide.com>
Subject: Re: Some musb Blackfin porting issues
Date: Thu, 6 Sep 2007 07:43:56 -0700
Message-ID: <20070906144356.GC7618@atomide.com>
References: <1189061545.8833.11.camel@roc-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1189061545.8833.11.camel@roc-desktop>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Bryan Wu <bryan.wu@analog.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Bryan Wu <bryan.wu@analog.com> [070905 23:55]:
> Dear David and Tony:
> 
> I almost imported the musb stack to our Blackfin tree. But there are
> some code highly coupled with ARM Linux architecture. Please give me
> some idea about following issues:
> 
> 1. Clock framework is not available in Blackfin Linux arch currently. Is
> it possible to skip it?

Yes, you can have custom clock enable/disable functions, see tusb_set_clock()
in arch/arm/mach-omap2/board-n800-usb.c.

> 2. Registers layout in musb-regs.h is different with BF54x processor. I
> plan to write a musb-bf54x.h to replace the whole definition in
> musb-regs.h. Is that possible or do it conflict with current musb
> design?
> in musb-regs.h:
> ---
> #ifdef CONFIG_BF54x
> #include "musb-bf54x.h"
> #else
> ..... /* original code from musb-regs.h */
> #endif
> --

I guess that's the way to go for now to get things working. Dave?

Tony
