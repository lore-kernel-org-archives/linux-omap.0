From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 00/17] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Fri, 15 Apr 2016 08:41:40 -0700
Message-ID: <20160415154139.GS5995@atomide.com>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
 <20160413212500.GD5995@atomide.com>
 <5710B58C.7050108@ti.com>
 <20160415120942.3131eac1@bbrezillon>
 <5710C86A.9060108@ti.com>
 <20160415135108.63716f06@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160415135108.63716f06@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> [160415 04:52]:
> Roger, Tony,
> 
> On Fri, 15 Apr 2016 13:54:34 +0300
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> 
> > On 15/04/16 13:09, Boris Brezillon wrote:
> > > Hi Roger,
> > > 
> > > On Fri, 15 Apr 2016 12:34:04 +0300
> > > Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> > > 
> > >> Tony & Boris,
> > >>
> > >> On 14/04/16 00:25, Tony Lindgren wrote:
> > >>> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [160407 03:10]:
> > >>>> Hi,
> > >>>>
> > >>>> As this series has cross dependency between omap and mtd subsystems,
> > >>>> I'll set up a immutable branch which omap-soc and l2-mtd must
> > >>>> merge in together to avoid any conflicts/breakage during integration.
> > >>>>
> > >>>> Brian has acked all mtd patches. Tony needs to give his Ack for the
> > >>>> gpmc driver part and then I can provide the immutable branch.
> > >>>
> > >>> Looks good to me, please feel free to add:
> > >>>
> > >>> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > >>>
> > >>
> > >> I've added Tony and Rob's Acked-by tags and pushed the patches at the
> > >> below PULL request.
> > >>
> > >> Please take this into omap-soc and l2-mtd trees. Thanks.
> > > 
> > > I Pulled this branch into nand/next and had to resolve a few conflicts
> > > (as you may have noticed, a few other reworks in the NAND and MTD layer
> > > have been merged in the meantime).
> > 
> > OK. I'm not sure how well this will play when this merges into liunx-next
> > via the omap-soc tree.
> > 
> > Instead, can you please create a non-mutable nand/base for me (which could be
> > today's nand/next) and I can base my branch on that and Tony can use my
> > branch without causing any merge-conflict in linux-next?
> 
> I just created a branch called nand/for-gpmc-rework based on today's
> nand/next, but I'm still unsure how to proceed once you've rebased your
> work on this branch?
> 
> Tony will first have to pull my immutable branch, then pull yours, and
> then I'll have to pull an immutable branch from the the omap-soc tree
> to get your changes into my nand/next branch (in case other patches
> modify the same files before I send my PR). Am I missing something?
> If I'm not, then this option looks over-complicated to me.

Well why don't you merge it all via NAND then? I'm not seeing
any merge conflicts with the arch/arm/mach-omap* code.

> ITOH, if we decide to let your patches go through the nand or omap-soc
> tree, only one immutable branch will be created, and either the nand or
> omap-soc maintainer (depending on who takes the patches) will have to
> pull it into its -next branch.
> 
> I'm quite new to all this merging process, so don't hesitate to correct
> me if I'm wrong.

Well the rules are that if something agreed to be immutable, then
it will never get redone. And the immutable branch should be based
on the absolute minimal set of patches against some earlier tag,
usually -rc1 is a good one. This avoids other tree to need to pull
in a huge amount of changes from other trees just to avoid merge
conflicts.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
