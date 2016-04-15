From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v6 00/17] memory: omap-gpmc: mtd: nand: Support GPMC
 NAND on non-OMAP platforms
Date: Fri, 15 Apr 2016 13:12:02 +0200
Message-ID: <20160415131202.7cf2ae5e@bbrezillon>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
	<20160413212500.GD5995@atomide.com>
	<5710B58C.7050108@ti.com>
	<20160415120942.3131eac1@bbrezillon>
	<5710C86A.9060108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5710C86A.9060108@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 15 Apr 2016 13:54:34 +0300
Roger Quadros <rogerq@ti.com> wrote:

> On 15/04/16 13:09, Boris Brezillon wrote:
> > Hi Roger,
> > 
> > On Fri, 15 Apr 2016 12:34:04 +0300
> > Roger Quadros <rogerq@ti.com> wrote:
> > 
> >> Tony & Boris,
> >>
> >> On 14/04/16 00:25, Tony Lindgren wrote:
> >>> * Roger Quadros <rogerq@ti.com> [160407 03:10]:
> >>>> Hi,
> >>>>
> >>>> As this series has cross dependency between omap and mtd subsystems,
> >>>> I'll set up a immutable branch which omap-soc and l2-mtd must
> >>>> merge in together to avoid any conflicts/breakage during integration.
> >>>>
> >>>> Brian has acked all mtd patches. Tony needs to give his Ack for the
> >>>> gpmc driver part and then I can provide the immutable branch.
> >>>
> >>> Looks good to me, please feel free to add:
> >>>
> >>> Acked-by: Tony Lindgren <tony@atomide.com>
> >>>
> >>
> >> I've added Tony and Rob's Acked-by tags and pushed the patches at the
> >> below PULL request.
> >>
> >> Please take this into omap-soc and l2-mtd trees. Thanks.
> > 
> > I Pulled this branch into nand/next and had to resolve a few conflicts
> > (as you may have noticed, a few other reworks in the NAND and MTD layer
> > have been merged in the meantime).
> 
> OK. I'm not sure how well this will play when this merges into liunx-next
> via the omap-soc tree.
> 
> Instead, can you please create a non-mutable nand/base for me (which could be
> today's nand/next) and I can base my branch on that and Tony can use my
> branch without causing any merge-conflict in linux-next?

You want those patches to go through the arm-soc tree, right?
I'm not an expert, but I'd say that Tony should take those patches and
provide an immutable branch I can pull into nand/next.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
