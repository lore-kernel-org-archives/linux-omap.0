From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Mon, 4 Oct 2010 12:56:54 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034B6EC60C@dbde02.ent.ti.com>
References: <1285325785-6163-1-git-send-email-vishwanath.bs@ti.com>
	<1285325785-6163-2-git-send-email-vishwanath.bs@ti.com>
 <87lj6q9ao8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50677 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012Ab0JDH1G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 03:27:06 -0400
In-Reply-To: <87lj6q9ao8.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Saturday, September 25, 2010 1:28 AM
> To: Sripathy, Vishwanath
> Cc: linux-omap@vger.kernel.org; linaro-dev@lists.linaro.org
> Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
> 
> Vishwanath BS <vishwanath.bs@ti.com> writes:
> 
> > There is no need to keep omap3 sleep code in SRAM.
> > This code can be run very well on DDR.
> 
> /me remains skeptical
> 
> > This would help us to instrument CPUIdle latencies.
> 
> Indeed, but...
> 
> I'm afraid we will need a much more descriptive changelog here,
> describing in detail why this will still work, and what about the
> previous motiviations for running SRAM has changed such that this will
> work out of SRAM.
Running the code from SRAM for CPUIdle was more of legacy from OMAP2 and there was no technical reason why it cannot be run from DDR. Also note that, once MPU enters off mode, wake up code used to run from DDR earlier (w/o these changes) as well. I will put more details in the change log.
> 
> > Tested on ZOOM3.
> 
> Tested in what way?  This path is used for both idle and suspend, and
> needs to be validated for retention and off mode.
I have tested for both retention and off mode in both CPU idle and suspend path. I will update the changelog in next version. 

Vishwa
> 
> Kevin
> 
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > Cc: Kevin Hillman <khilman@deeprootsystems.com>
> > Cc: <Linaro> linaro-dev@lists.linaro.org
> > ---
> >  arch/arm/mach-omap2/pm34xx.c |    9 +--------
> >  1 files changed, 1 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > index 85ef245..ed9d12c 100644
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -79,8 +79,6 @@ struct power_state {
> >
> >  static LIST_HEAD(pwrst_list);
> >
> > -static void (*_omap_sram_idle)(u32 *addr, int save_state);
> > -
> >  static int (*_omap_save_secure_sram)(u32 *addr);
> >
> >  static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
> > @@ -360,9 +358,6 @@ void omap_sram_idle(void)
> >  	int core_prev_state, per_prev_state;
> >  	u32 sdrc_pwr = 0;
> >
> > -	if (!_omap_sram_idle)
> > -		return;
> > -
> >  	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
> >  	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
> >  	pwrdm_clear_all_prev_pwrst(core_pwrdm);
> > @@ -438,7 +433,7 @@ void omap_sram_idle(void)
> >  	 * get saved. The restore path then reads from this
> >  	 * location and restores them back.
> >  	 */
> > -	_omap_sram_idle(omap3_arm_context, save_state);
> > +	omap34xx_cpu_suspend(omap3_arm_context, save_state);
> >  	cpu_init();
> >
> >  	if (is_suspending())
> > @@ -995,8 +990,6 @@ static int __init clkdms_setup(struct clockdomain *clkdm,
> void *unused)
> >
> >  void omap_push_sram_idle(void)
> >  {
> > -	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
> > -					omap34xx_cpu_suspend_sz);
> >  	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
> >  		_omap_save_secure_sram =
> omap_sram_push(save_secure_ram_context,
> >  				save_secure_ram_context_sz);
