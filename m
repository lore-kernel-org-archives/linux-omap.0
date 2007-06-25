From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Pre 3430 patch for io.c map table cleanup
Date: Mon, 25 Jun 2007 01:57:12 -0700
Message-ID: <20070625085711.GC32406@atomide.com>
References: <20070621120333.GJ20283@atomide.com>
	<9C23CDD79DA20A479D4615857B2E2C47012A5209@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47012A5209@dlee13.ent.ti.com>
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

* Syed Mohammed, Khasim <x0khasim@ti.com> [070621 06:13]:
> Hi Tony,
> 
> >> +#if defined(CONFIG_ARCH_OMAP2420)
> >> +	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
> >> +	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
> >> +#elif defined(CONFIG_ARCH_OMAP2430)
> >> +	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
> >> +	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
> >> +#endif
> >>  	/* Normally devicemaps_init() would flush caches and tlb after
> >>  	 * mdesc->map_io(), but we must also do it here because of the CPU
> >>  	 * revision check below.
> >
> >You don't need the #defines here. This adds yet another artificial
> >barrier to compiling in both.
> >
> >Use cpu_is_omap34xx() et al to init them.
> 
> We had discussion on this topic and I had communicated why defines are required.

Oh yeah, that's right, sorry I forgot about the cpu detection issue.

> Let me know your views on the same.

Yes, I'll apply your current patch and we'll deal with the cpu
detection issues later on.

Tony
