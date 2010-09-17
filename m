From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP3630 PM: Update C state latencies
Date: Fri, 17 Sep 2010 20:28:19 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703118AFBED@dbde02.ent.ti.com>
References: <1284732790-13440-1-git-send-email-vishwanath.bs@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301F6E9D3DD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51862 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754864Ab0IQO60 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 10:58:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8HEwNMo020934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Sep 2010 09:58:25 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o8HEwNfu004052
	for <linux-omap@vger.kernel.org>; Fri, 17 Sep 2010 20:28:23 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301F6E9D3DD@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Chalhoub, Nicole" <n-chalhoub@ti.com>

Hi Sanjeev,

> -----Original Message-----
> From: Premi, Sanjeev
> Sent: Friday, September 17, 2010 7:57 PM
> To: Sripathy, Vishwanath; linux-omap@vger.kernel.org
> Cc: Sripathy, Vishwanath; Chalhoub, Nicole
> Subject: RE: [PATCH] OMAP3630 PM: Update C state latencies
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Vishwanath BS
> > Sent: Friday, September 17, 2010 7:43 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Sripathy, Vishwanath; Chalhoub, Nicole
> > Subject: [PATCH] OMAP3630 PM: Update C state latencies
> >
> > This patch has changes to update the C state latencies for OMAP3630
> > and removes the useless C-States, keeping only the optimized
> > ones with
> > their corresponding measured latencies.
> > Only 4 C-states are kept instead of 7 C-States:
> >   * 	C1 . MPU WFI clock gated + Core autogating
> >   *	C3 . MPU CSWR + Core inactive
> >   *	C5 . MPU CSWR + Core CSWR
> >   *	C7 . MPU OFF + Core OFF
> >  A new C-State C1 is created which is the same as the
> > existing C1 but clocks
> >  gated. It will be the default state. When calling the safe
> > state, the clocks
> >  gating is denied as it was the case previously. With these
> > changes, gain is
> >  in power consumption is observed on some use cases.
> >
> > Thanks to Nicole Chaloub<n-chalhoub@ti.com> and Vincent Bour
> > <v-bour@ti.com>
> > for their investigation.
> >
> > Tested on ZOOM3 board using latest pm branch.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > Signed-off-by: Nicole Chalhoub <n-chalhoub@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-zoom3.c |   19 +++++++++++++++++++
> >  arch/arm/mach-omap2/cpuidle34xx.c |    9 ++++++---
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> [sp] Are these latencies board specific?
>      Same question for applicability of C-States.
> 
>      Just wanted to understand if the same patch will/
>      applies for other boards using 36x as well.

Latency has 2 components associated with it namely SW sleep and wake up latencies and HW sleep and wkup latencies. I believe that HW sleep and wkup latency would be pretty same across various OMAP36xx platforms. 
However I am not sure if the SW latency will also be similar across different variants of 36xx since they might have different memory parts impacting DDR access time. As long as SW execution time is similar, I think these values/C states can be reused across.

Vishwa
> 
> ~sanjeev
> 
> >
> > diff --git a/arch/arm/mach-omap2/board-zoom3.c
> > b/arch/arm/mach-omap2/board-zoom3.c
> > index 03411b2..c47b2a3 100644
> > --- a/arch/arm/mach-omap2/board-zoom3.c
> > +++ b/arch/arm/mach-omap2/board-zoom3.c
> > @@ -25,10 +25,28 @@
> >  #include "mux.h"
> >  #include "sdram-hynix-h8mbx00u0mer-0em.h"
> >  #include "smartreflex-class3.h"
> > +#include "pm.h"
> >
> >  static struct omap_board_config_kernel zoom_config[] __initdata = {
> >  };
> >
> > +static struct cpuidle_params omap3_cpuidle_params_table[] = {
> > +	/* C1 */
> > +	{1, 74, 78, 152},
> > +	/* C2 */
> > +	{0, 165, 90, 255},
> > +	/* C3 */
> > +	{1, 163, 180, 345},
> > +	/* C4 */
> > +	{0, 2852, 605, 3457},
> > +	/* C5 */
> > +	{1, 800, 366, 2120},
> > +	/* C6 */
> > +	{0, 4080, 801, 4881},
> > +	/* C7 */
> > +	{1, 4300, 8794, 159000},
> > +};
> > +
> >  static struct mtd_partition zoom_nand_partitions[] = {
> >  	/* All the partition sizes are listed in terms of NAND
> > block size */
> >  	{
> > @@ -74,6 +92,7 @@ static void __init omap_zoom_init_irq(void)
> >  {
> >  	omap_board_config = zoom_config;
> >  	omap_board_config_size = ARRAY_SIZE(zoom_config);
> > +	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
> >  	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
> >  			h8mbx00u0mer0em_sdrc_params);
> >  	omap_init_irq();
> > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
> > b/arch/arm/mach-omap2/cpuidle34xx.c
> > index 3d3d035..2bbfc43 100644
> > --- a/arch/arm/mach-omap2/cpuidle34xx.c
> > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> > @@ -136,7 +136,8 @@ static int omap3_enter_idle(struct
> > cpuidle_device *dev,
> >  	if (omap_irq_pending() || need_resched())
> >  		goto return_sleep_time;
> >
> > -	if (cx->type == OMAP3_STATE_C1) {
> > +	/* deny idle only if we are entering safe state */
> > +	if (dev->last_state != state) {
> >  		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
> >  		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> >  	}
> > @@ -144,7 +145,7 @@ static int omap3_enter_idle(struct
> > cpuidle_device *dev,
> >  	/* Execute ARM wfi */
> >  	omap_sram_idle();
> >
> > -	if (cx->type == OMAP3_STATE_C1) {
> > +	if (dev->last_state != state) {
> >  		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
> >  		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
> >  	}
> > @@ -233,14 +234,16 @@ static int omap3_enter_idle_bm(struct
> > cpuidle_device *dev,
> >  			       struct cpuidle_state *state)
> >  {
> >  	struct cpuidle_state *new_state = next_valid_state(dev, state);
> > +	int t;
> >
> >  	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) &&
> > omap3_idle_bm_check()) {
> >  		BUG_ON(!dev->safe_state);
> >  		new_state = dev->safe_state;
> >  	}
> >
> > +	t = omap3_enter_idle(dev, new_state);
> >  	dev->last_state = new_state;
> > -	return omap3_enter_idle(dev, new_state);
> > +	return t;
> >  }
> >
> >  DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
