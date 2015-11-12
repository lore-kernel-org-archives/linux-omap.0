From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/3] ARM: OMAP2+: remove custom abort handler for t410
Date: Thu, 12 Nov 2015 09:51:17 -0800
Message-ID: <20151112175116.GO3218@atomide.com>
References: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
 <1444905142-21500-3-git-send-email-l.stach@pengutronix.de>
 <1447335155.3101.6.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1447335155.3101.6.camel@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patchwork-lst@pengutronix.de
List-Id: linux-omap@vger.kernel.org

* Lucas Stach <l.stach@pengutronix.de> [151112 05:33]:
> Tony,
> 
> can you please take this patch through the OMAP tree for 4.4? The first
> patch in this series went in through Russells tree, so the below code
> now has the possibility to hide a real abort later during boot.

OK will do thanks. I've also verified that the abort handler is no longer
needed. After seeing where it happens, fixing it was trivial :)

FYI, the fix was 57df53808534 ("ARM: OMAP2+: Fix imprecise external abort
caused by bogus SRAM init"). Other platforms may have similar issues where
it's not really anything left behind by the bootloader but a real kernel
bug.

Regards,

Tony

> 
> Am Donnerstag, den 15.10.2015, 12:32 +0200 schrieb Lucas Stach:
> > This is not needed anymore. Handling a potentially pending imprecise external
> > abort left behind by the bootloader is now done in a slightly safer way inside
> > the common ARM startup code.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/pdata-quirks.c | 29 -----------------------------
> >  1 file changed, 29 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> > index ea56397599c2..3a2bc2a88db4 100644
> > --- a/arch/arm/mach-omap2/pdata-quirks.c
> > +++ b/arch/arm/mach-omap2/pdata-quirks.c
> > @@ -24,9 +24,6 @@
> >  #include <linux/platform_data/iommu-omap.h>
> >  #include <linux/platform_data/wkup_m3.h>
> >  
> > -#include <asm/siginfo.h>
> > -#include <asm/signal.h>
> > -
> >  #include "common.h"
> >  #include "common-board-devices.h"
> >  #include "dss-common.h"
> > @@ -385,29 +382,6 @@ static void __init omap3_pandora_legacy_init(void)
> >  }
> >  #endif /* CONFIG_ARCH_OMAP3 */
> >  
> > -#ifdef CONFIG_SOC_TI81XX
> > -static int fault_fixed_up;
> > -
> > -static int t410_abort_handler(unsigned long addr, unsigned int fsr,
> > -			      struct pt_regs *regs)
> > -{
> > -	if ((fsr == 0x406 || fsr == 0xc06) && !fault_fixed_up) {
> > -		pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
> > -			addr, fsr);
> > -		fault_fixed_up = 1;
> > -		return 0;
> > -	}
> > -
> > -	return 1;
> > -}
> > -
> > -static void __init t410_abort_init(void)
> > -{
> > -	hook_fault_code(16 + 6, t410_abort_handler, SIGBUS, BUS_OBJERR,
> > -			"imprecise external abort");
> > -}
> > -#endif
> > -
> >  #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
> >  static struct iommu_platform_data omap4_iommu_pdata = {
> >  	.reset_name = "mmu_cache",
> > @@ -536,9 +510,6 @@ static struct pdata_init pdata_quirks[] __initdata = {
> >  	{ "openpandora,omap3-pandora-600mhz", omap3_pandora_legacy_init, },
> >  	{ "openpandora,omap3-pandora-1ghz", omap3_pandora_legacy_init, },
> >  #endif
> > -#ifdef CONFIG_SOC_TI81XX
> > -	{ "hp,t410", t410_abort_init, },
> > -#endif
> >  #ifdef CONFIG_SOC_OMAP5
> >  	{ "ti,omap5-uevm", omap5_uevm_legacy_init, },
> >  #endif
> 
> -- 
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |
> 
