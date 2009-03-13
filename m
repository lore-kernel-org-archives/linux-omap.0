From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] PM: Start C-state definitions from base 0
Date: Fri, 13 Mar 2009 10:32:30 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC28104B@dbde02.ent.ti.com>
References: <1236892668-8710-1-git-send-email-premi@ti.com>
 <87mybq2uut.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34872 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbZCMFCn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 01:02:43 -0400
In-Reply-To: <87mybq2uut.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Friday, March 13, 2009 4:49 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCHv2] PM: Start C-state definitions from base 0
> 
> Sanjeev Premi <premi@ti.com> writes:
> 
> > The current definition of C-states starts from base 1.
> > Whereas, the cpuidle driver uses base 0. This patch eliminates need 
> > for explicit mapping due to different base values.
> >
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  arch/arm/mach-omap2/cpuidle34xx.c |   23 ++++++++++-------------
> >  1 files changed, 10 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c 
> > b/arch/arm/mach-omap2/cpuidle34xx.c
> > index 62fbb2e..50bf412 100644
> > --- a/arch/arm/mach-omap2/cpuidle34xx.c
> > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> > @@ -33,13 +33,13 @@
> >  
> >  #ifdef CONFIG_CPU_IDLE
> >  
> > -#define OMAP3_MAX_STATES 7
> > -#define OMAP3_STATE_C1 1 /* C1 - MPU WFI + Core active */ -#define 
> > OMAP3_STATE_C2 2 /* C2 - MPU CSWR + Core active */ -#define 
> > OMAP3_STATE_C3 3 /* C3 - MPU OFF + Core active */ -#define 
> > OMAP3_STATE_C4 4 /* C4 - MPU RET + Core RET */ -#define 
> OMAP3_STATE_C5 
> > 5 /* C5 - MPU OFF + Core RET */ -#define OMAP3_STATE_C6 6 
> /* C6 - MPU 
> > OFF + Core OFF */
> > +#define OMAP3_MAX_STATES 6
> > +#define OMAP3_STATE_C1 0 /* C1 - MPU WFI + Core active */ #define 
> > +OMAP3_STATE_C2 1 /* C2 - MPU CSWR + Core active */ #define 
> > +OMAP3_STATE_C3 2 /* C3 - MPU OFF + Core active */ #define 
> > +OMAP3_STATE_C4 3 /* C4 - MPU RET + Core RET */ #define 
> OMAP3_STATE_C5 
> > +4 /* C5 - MPU OFF + Core RET */ #define OMAP3_STATE_C6 5 
> /* C6 - MPU 
> > +OFF + Core OFF */
> >  
> >  struct omap3_processor_cx {
> >  	u8 valid;
> > @@ -228,7 +228,7 @@ struct cpuidle_driver omap3_idle_driver = {
> >   */
> >  int omap3_idle_init(void)
> >  {
> > -	int i, count = 0;
> > +	int count;
> >  	struct omap3_processor_cx *cx;
> >  	struct cpuidle_state *state;
> >  	struct cpuidle_device *dev;
> > @@ -244,8 +244,8 @@ int omap3_idle_init(void)
> >  
> >  	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
> >  
> > -	for (i = 1; i < OMAP3_MAX_STATES; i++) {
> > -		cx = &omap3_power_states[i];
> > +	for (count = 0; count < OMAP3_MAX_STATES; count++) {
> > +		cx = &omap3_power_states[count];
> >  		state = &dev->states[count];
> >  
> >  		if (!cx->valid)
> 
> Still not quite right.
> 
> The reason for a different loop iterator and 'count' was so 
> that states that are not 'valid' do not get regsitered with 
> CPUidle.  With this patch, some of the dev->states[] pointers 
> that get registered with CPUidle will have bogus values if 
> there are any !valid states at boot time.
> 
> Since you are not fixing the valid state problem in this 
> patch, I suggest you keep the separate iterator and count, 
> and just start i at zero instead of 1.
> 
> Then, when you fix the valid state problem, you can drop the 
> checking for valid sates at init time all together, and then 
> use a single iterator for this loop.

Since the ".valid" for each of the states was 1 in the init
for all states; I did the change above. Will re-submit v3
later today.

~sanjeev

> 
> Kevin
> 
> > @@ -259,11 +259,8 @@ int omap3_idle_init(void)
> >  		if (cx->type == OMAP3_STATE_C1)
> >  			dev->safe_state = state;
> >  		sprintf(state->name, "C%d", count+1);
> > -		count++;
> >  	}
> >  
> > -	if (!count)
> > -		return -EINVAL;
> >  	dev->state_count = count;
> >  
> >  	if (cpuidle_register_device(dev)) {
> > --
> > 1.5.6
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" 
> > in the body of a message to majordomo@vger.kernel.org More 
> majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> 