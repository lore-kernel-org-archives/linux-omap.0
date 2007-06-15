From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6 / 12] Mach omap2 updation for 3430
Date: Fri, 15 Jun 2007 01:13:24 -0700
Message-ID: <20070615081323.GD10128@atomide.com>
References: <20070614114651.GF28804@atomide.com>
	<9C23CDD79DA20A479D4615857B2E2C47011E659F@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47011E659F@dlee13.ent.ti.com>
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

* Syed Mohammed, Khasim <x0khasim@ti.com> [070614 14:03]:
> Hi Tony,
> 
> >> +#ifdef CONFIG_ARCH_OMAP24XX
> >> +		if (cpu_is_omap24xx()) {
> >> +			bank->base_reg = IO_ADDRESS(OMAP24XX_IC_BASE);
> >> +		}
> >> +#endif
> >> +#ifdef CONFIG_ARCH_OMAP34XX
> >> +		if (cpu_is_omap34xx()) {
> >> +			bank->base_reg = IO_ADDRESS(OMAP34XX_IC_BASE);
> >> +		}
> >> +#endif
> >>  		omap_irq_bank_init_one(bank);
> >>
> >>  		nr_irqs += bank->nr_irqs;
> >>
> >
> >You should be able to leave out the ifdefs above, if one of the omaps
> >is disabled, then it will get optimized out as it will be if (0) {}.
> 
> In few more places I found this kind of issue. I think this kind of common definition issues will be more in future.
> 
> >This is assuming the _IC_BASE defines are visible to both, of course.
> 
> Basically we have omap24xx.h and omap34xx.h for OMAP2/3 specific definitions. Now for the above illustrated approach we should have two different definitions, where to define such Macros? 
> 
> Note: We will not include omap24xx.h for 34xx compilation (vice versa).

We can include them, it should not hurt as the defines have 24XX or
34XX prefix.

> Option 1: Having such Macros with same name in both 24xx and 34xx .h files
> 
> In omap24xx.h:
> #define OMAP_IC_BASE	<OMAP2 IC BASE VALUE>
> 
> In omap34xx.h
> #define OMAP_IC_BASE	< OMAP3 IC BASE VALUE >
> 
> Option 2: Having a separate header file for such macros.
> 
> omap_common.h
> #define OMAP24XX_IC_BASE	< OMAP2 IC BASE VALUE >
> #define OMAP34XX_IC_BASE	< OMAP3 IC BASE VALUE >
> 
> This common header file can be included in both 24xx and 34xx board files
> 
> Option 3: Define both macros in 24xx and 34xx header files (Crap).
> 
> In omap24xx.h:
> #define OMAP24XX_IC_BASE	< OMAP2 IC BASE VALUE >
> #define OMAP34XX_IC_BASE	< OMAP3 IC BASE VALUE >#define OMAP_IC_BASE
> 
> In omap34xx.h
> #define OMAP24XX_IC_BASE	< OMAP2 IC BASE VALUE >
> #define OMAP34XX_IC_BASE	< OMAP3 IC BASE VALUE >#define OMAP_IC_BASE
> 
> 
> Kindly let me know your views on the same.

Well I think option 2 or 3 may still be the best if we eventually want
to compile both 24xx and 34xx into the same kernel. Maybe just have it
defined in irq.c or .h if not needed elsewhere?

Tony
