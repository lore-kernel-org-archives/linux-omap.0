From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/11] Adding OMAP3430 support to mach-omap2
Date: Tue, 29 May 2007 11:16:53 -0700
Message-ID: <20070529181652.GC26933@atomide.com>
References: <20070529164859.GA26322@atomide.com>
	<9C23CDD79DA20A479D4615857B2E2C47FF1167@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF1167@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070529 10:33]:
> Hi Tony,
> 
> >>  clock_34xx.c | 1255
> >+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >
> ><snip>
> >
> >Well clock_34xx.c can be merged to existing clock.c. With Pau's PRCM
> >patches, only few registers are different now.
> >
> 
> Can we keep this for now? We can start a different thread for Clock and PRCM for 3430. It will take a while before it gets stabilized. Mean while can we get 3430 booting in tree.

Let's just leave out the clock code for now and keep it as a separate
patch.

> >>  void __init omap2_check_revision(void)
> >> @@ -119,7 +119,11 @@ void __init omap2_check_revision(void)
> >>  	system_rev |= rev << 8;
> >>
> >>  	/* Add the cpu class info (24xx) */
> >> +#ifndef CONFIG_ARCH_OMAP3
> >>  	system_rev |= 0x24;
> >> +#else
> >> +	system_rev |= 0x34;
> >> +#endif
> >>
> >>  	pr_info("OMAP%04x", system_rev >> 16);
> >>  	if ((system_rev >> 8) & 0x0f)
> >
> >This is yet another artificial barrier to compile in many revisions,
> >let's try to avoid that. You should be able to set system_rev based
> >on the hardware register values.
> 
> The current 3430 version doesn't populate these kind of registers, we have to wait for a while for second version. Till then we have to use this kind of mechanism. The 2430 ones support these registers, but it will be a different patch to deal with. For, 3430 I will prefer keeping same thing for a while.

:)

OK, can you add a REVISIT comment there then?

Tony
