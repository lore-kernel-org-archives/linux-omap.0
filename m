From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 2/4] ARM: OMAP4 PM: Add IO Daisychain support
Date: Fri, 7 Oct 2011 15:33:22 +0530
Message-ID: <58f6ce4e2bd78efdfd59b4a8c84090c2@mail.gmail.com>
References: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
 <1317750724-32553-3-git-send-email-vishwanath.bs@ti.com> <alpine.DEB.2.00.1110070209480.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:55989 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752157Ab1JGKD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 06:03:27 -0400
Received: by wwi18 with SMTP id 18so5407261wwi.3
        for <linux-omap@vger.kernel.org>; Fri, 07 Oct 2011 03:03:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110070209480.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Friday, October 07, 2011 1:44 PM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; linux-arm-
> kernel@lists.infradead.org; Rajendra Nayak
> Subject: Re: [PATCH 2/4] ARM: OMAP4 PM: Add IO Daisychain support
>
> Hi
>
> some comments:
>
> On Tue, 4 Oct 2011, Vishwanath BS wrote:
>
> > From: Rajendra Nayak <rnayak@ti.com>
> >
> > patch adds IO Daisychain support for OMAP4 as per section 3.9.4 in
> OMAP4430
> > Public TRM.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > ---
> >  arch/arm/mach-omap2/pm.h     |    1 +
> >  arch/arm/mach-omap2/pm44xx.c |   36
> ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 37 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> > index 9a36a7c..2e09d72 100644
> > --- a/arch/arm/mach-omap2/pm.h
> > +++ b/arch/arm/mach-omap2/pm.h
> > @@ -22,6 +22,7 @@ extern int omap3_can_sleep(void);
> >  extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32
> state);
> >  extern int omap3_idle_init(void);
> >  extern void omap3_enable_io_chain(void);
> > +extern void omap4_trigger_wuclk_ctrl(void);
> >
> >  #if defined(CONFIG_PM_OPP)
> >  extern int omap3_opp_init(void);
> > diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-
> omap2/pm44xx.c
> > index 59a870b..aa7cff4 100644
> > --- a/arch/arm/mach-omap2/pm44xx.c
> > +++ b/arch/arm/mach-omap2/pm44xx.c
> > @@ -16,8 +16,17 @@
> >  #include <linux/err.h>
> >  #include <linux/slab.h>
> >
> > +#include <plat/common.h>
> > +
> >  #include "powerdomain.h"
> >  #include <mach/omap4-common.h>
> > +#include "pm.h"
> > +#include "cm-regbits-44xx.h"
> > +#include "cminst44xx.h"
> > +#include "prm-regbits-44xx.h"
> > +#include "prcm44xx.h"
> > +#include "prm44xx.h"
> > +#include "prminst44xx.h"
> >
> >  struct power_state {
> >  	struct powerdomain *pwrdm;
> > @@ -30,6 +39,33 @@ struct power_state {
> >
> >  static LIST_HEAD(pwrst_list);
> >
> > +#define MAX_IOPAD_LATCH_TIME 1000
>
> This macro is missing a comment, which should precede it, describing
> what
> this value is.
OK
>
> > +
> > +void omap4_trigger_wuclk_ctrl(void)
> > +{
> > +	int i = 0;
> > +
> > +	/* Enable GLOBAL_WUEN */
> > +	if (!omap4_cminst_read_inst_reg_bits(OMAP4430_PRM_PARTITION,
> > +			OMAP4430_PRM_DEVICE_INST,
> OMAP4_PRM_IO_PMCTRL_OFFSET,
> > +			OMAP4430_GLOBAL_WUEN_MASK))
>
> The above line doesn't look right.  It's accessing a PRM instance
> register
> with omap4_cminst_*()?  Shouldn't that be omap4_prminst_*()?
Ya, it would make sense to use omap4_prminst_* though functionally both
have the same effect.

>
> > +
> 	omap4_prminst_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
> > +			OMAP4430_GLOBAL_WUEN_MASK, OMAP4430_PRM_PARTITION,
> > +			OMAP4430_PRM_DEVICE_INST,
> OMAP4_PRM_IO_PMCTRL_OFFSET);
> > +
> > +	/* Trigger WUCLKIN enable */
> > +	omap4_prminst_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK,
> OMAP4430_WUCLK_CTRL_MASK,
> > +		OMAP4430_PRM_PARTITION, OMAP4430_PRM_DEVICE_INST,
> OMAP4_PRM_IO_PMCTRL_OFFSET);
> > +	omap_test_timeout(
> > +		((omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
> OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET)
> > +		>> OMAP4430_WUCLK_STATUS_SHIFT) == 1),
> > +		MAX_IOPAD_LATCH_TIME, i);
> > +	/* Trigger WUCLKIN disable */
> > +	omap4_prminst_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, 0x0,
> > +		OMAP4430_PRM_PARTITION, OMAP4430_PRM_DEVICE_INST,
> OMAP4_PRM_IO_PMCTRL_OFFSET);
> > +	return;
> > +}
>
> This function belongs in mach-omap2/prminst44xx.c.  I still think it
> would
> be good if we moved all PRM/CM direct register accesses into prm*.c
> or
> cm*.c files in mach-omap2/.  Then none of those prm*.h includes
> would be
> needed in pm44xx.c either.
OK. Let me explore that.

Regards
Vishwa
>
> > +
> >  #ifdef CONFIG_SUSPEND
> >  static int omap4_pm_suspend(void)
> >  {
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
>
> - Paul
