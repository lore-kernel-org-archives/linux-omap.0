From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/11] Adding OMAP3430 support to mach-omap2
Date: Tue, 29 May 2007 13:23:01 -0700
Message-ID: <20070529202301.GA27603@atomide.com>
References: <20070529164859.GA26322@atomide.com>
	<9C23CDD79DA20A479D4615857B2E2C47FF12A7@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF12A7@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070529 12:49]:
> Hi Tony,
> 
> One quick clarification,
> 
> >> diff -purN linux-omap/arch/arm/mach-omap2/io.c
> >val_3430_GIT/arch/arm/mach-omap2/io.c
> >> --- linux-omap/arch/arm/mach-omap2/io.c	2007-05-16 
> >>
> <snip>
> >> +#if defined(CONFIG_ARCH_OMAP24XX)
> >> +
> >> +#define L3_VIRT		L3_24XX_VIRT
> >> +#define L3_PHYS		L3_24XX_PHYS
> >> +#define L3_SIZE		L3_24XX_SIZE
> >> +
> >> +#define L4_VIRT		L4_24XX_VIRT
> >> +#define L4_PHYS		L4_24XX_PHYS
> >> +#define L4_SIZE		L4_24XX_SIZE
> >> +
> >> +#define L4_WK_VIRT	L4_WK_243X_VIRT
> >> +#define L4_WK_PHYS	L4_WK_243X_PHYS
> >> +#define L4_WK_SIZE	L4_WK_243X_SIZE
> >> +
> <snip>
> >> +#elif defined(CONFIG_ARCH_OMAP34XX)
> >> +
> >> +#define L3_VIRT		L3_34XX_VIRT
> >> +#define L3_PHYS		L3_34XX_PHYS
> >> +#define L3_SIZE		L3_34XX_SIZE
> >> +
> >> +#define L4_VIRT		L4_34XX_VIRT
> >> +#define L4_PHYS		L4_34XX_PHYS
> >> +#define L4_SIZE		L4_34XX_SIZE
> >> +
> >> +#define L4_PER_VIRT	L4_PER_34XX_VIRT
> >> +#define L4_PER_PHYS	L4_PER_34XX_PHYS
> >> +#define L4_PER_SIZE	L4_PER_34XX_SIZE
> >> +
> >> +#define L4_WK_VIRT	L4_WK_34XX_VIRT
> >> +#define L4_WK_PHYS	L4_WK_34XX_PHYS
> >> +#define L4_WK_SIZE	L4_WK_34XX_SIZE
> >> +
> >> +
> <snip>
> >> +#endif
> >
> >Let's rather change the #elif to #if to potentially compile in both
> >(altought unoptimized). 
> If we try to opt for different map descriptor table for OMAP2 and OMAP3 then these definitions might not be needed at all.

True.

> >I guess that also means changing L3_VIRT to be
> >L3_VIRT_34XX and so on.
> >
> >
> The reason these definitions were defined was to re-use the common fields (between 2430 / 3430) in map descriptor table.
> 
> If we change L3_VIRT to be L3_VIRT_34XX, this will make the map descriptor table look more redundant in code... 
> 
> Did you mean creating a two separate map descriptor tables?

Yeah, that is the best solution in the long run to support various
processors. That could also be a pre-3430 patch, and that will shrink
down the actual 3430 patch.

Regards,

Tony
