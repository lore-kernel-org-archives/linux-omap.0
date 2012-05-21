From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 14/19] ARM: OMAP4: wakeupgen: enable clocks for
 save_secure_all
Date: Mon, 21 May 2012 12:38:17 +0300
Message-ID: <1337593097.28274.19.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	 <1336990730-26892-15-git-send-email-t-kristo@ti.com>
	 <871umj4qnl.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44627 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405Ab2EUJiY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:38:24 -0400
In-Reply-To: <871umj4qnl.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Wed, 2012-05-16 at 17:06 -0700, Kevin Hilman wrote:
> +Benoit
> 
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > save_secure_all needs l3_main_3_ick and l4_secure_clkdm enabled,
> > otherwise the secure ROM code will crash.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> I think I mentioned this already (I'm already lost in what I've said for
> thisseries), but I don't think the secure RAM stuff belongs in the
> wakeupgen driver.

As mentioned, save_secure_all saves:
- secure RAM
- GIC registers
- some other mysterious stuff

Attempting to do separate saves for secure RAM + GIC hang the device
during wakeup, in addition to being really inefficient (secure API calls
are expensive.)

-Tero

> 
> Also, this patch suggests that the OCM RAM block needs a proper hwmod
> instead of manually fiddling with the l3_main_3 hwmod and the l4_secure clkdm.
> 
> Kevin
> 
> > ---
> >  arch/arm/mach-omap2/omap-wakeupgen.c |   20 ++++++++++++++++++++
> >  1 files changed, 20 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
> > index b2165e4..c7c4db4 100644
> > --- a/arch/arm/mach-omap2/omap-wakeupgen.c
> > +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
> > @@ -29,10 +29,12 @@
> >  
> >  #include <mach/omap-wakeupgen.h>
> >  #include <mach/omap-secure.h>
> > +#include <plat/omap_hwmod.h>
> >  
> >  #include "omap4-sar-layout.h"
> >  #include "common.h"
> >  #include "pm.h"
> > +#include "clockdomain.h"
> >  
> >  #define NR_REG_BANKS		4
> >  #define MAX_IRQS		128
> > @@ -49,6 +51,8 @@ static DEFINE_SPINLOCK(wakeupgen_lock);
> >  static unsigned int irq_target_cpu[NR_IRQS];
> >  
> >  static struct powerdomain *mpuss_pd;
> > +static struct clockdomain *l4_secure_clkdm;
> > +static struct omap_hwmod *l3_main_3_oh;
> >  
> >  /*
> >   * Static helper functions.
> > @@ -300,10 +304,18 @@ static void save_secure_ram(void)
> >  static void save_secure_all(void)
> >  {
> >  	u32 ret;
> > +
> > +	omap_hwmod_enable(l3_main_3_oh);
> > +	clkdm_wakeup(l4_secure_clkdm);
> > +
> >  	ret = omap_secure_dispatcher(OMAP4_HAL_SAVEALL_INDEX,
> >  				FLAG_START_CRITICAL,
> >  				1, omap_secure_ram_mempool_base(),
> >  				0, 0, 0);
> > +
> > +	clkdm_allow_idle(l4_secure_clkdm);
> > +	omap_hwmod_idle(l3_main_3_oh);
> > +
> >  	if (ret != API_HAL_RET_VALUE_OK)
> >  		pr_err("Secure all context save failed\n");
> >  }
> > @@ -441,6 +453,14 @@ int __init omap_wakeupgen_init(void)
> >  			sar_writel(GIC_ISR_NON_SECURE, ICDISR_SPI_OFFSET, i);
> >  		iounmap(sar_base);
> >  		sar_base = NULL;
> > +	} else {
> > +		l3_main_3_oh = omap_hwmod_lookup("l3_main_3");
> > +		if (!l3_main_3_oh)
> > +			pr_err("%s: failed to get l3_main_3_oh\n", __func__);
> > +
> > +		l4_secure_clkdm = clkdm_lookup("l4_secure_clkdm");
> > +		if (!l4_secure_clkdm)
> > +			pr_err("%s: failed to get l4_secure_clkdm\n", __func__);
> >  	}
> >  
> >  	irq_hotplug_init();


