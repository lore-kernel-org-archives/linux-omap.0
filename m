From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Add new lower-latency C1 state take #2
Date: Sun, 15 Mar 2009 22:10:29 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC281858@dbde02.ent.ti.com>
References: <1236952954-5769-1-git-send-email-peter.de-schrijver@nokia.com>
	<1236961156-19262-1-git-send-email-peter.de-schrijver@nokia.com>
 <874oxxvzxu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43203 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbZCOQkq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 12:40:46 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Sunday, March 15, 2009 9:46 PM
> To: 'Kevin Hilman'
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] Add new lower-latency C1 state take #2
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> > Sent: Saturday, March 14, 2009 3:38 AM
> > To: Peter 'p2' De Schrijver
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] Add new lower-latency C1 state take #2
> > 
> > "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
> > 
> > > This patch introduces a new C state which allows MPU to go
> > to WFI but
> > > keeps the core domain active. This offers a much better
> > wakeup latency
> > > (3us vs 10s of us for the current C1) at the cost of a
> > higher power consumption.
> > > Fixed the comments.
> > >
> > > Signed-off-by: Peter 'p2' De Schrijver
> > <peter.de-schrijver@nokia.com>
> > 
> > Thanks, pushing to PM branch.
> > 
> > Kevin
> > 
> > > ---
> > >  arch/arm/mach-omap2/cpuidle34xx.c |  121
> > > ++++++++++++++++++++++++-------------
> > >  1 files changed, 78 insertions(+), 43 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
> > > b/arch/arm/mach-omap2/cpuidle34xx.c
> > > index 62fbb2e..7da2fd8 100644
> > > --- a/arch/arm/mach-omap2/cpuidle34xx.c
> > > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> > > @@ -26,6 +26,7 @@
> > >  #include <mach/pm.h>
> > >  #include <mach/prcm.h>
> > >  #include <mach/powerdomain.h>
> > > +#include <mach/clockdomain.h>
> > >  #include <mach/control.h>
> > >  #include <mach/serial.h>
> > >  
> > > @@ -33,13 +34,14 @@
> > >  
> > >  #ifdef CONFIG_CPU_IDLE
> > >  
> > > -#define OMAP3_MAX_STATES 7
> > > +#define OMAP3_MAX_STATES 8
> > >  #define OMAP3_STATE_C1 1 /* C1 - MPU WFI + Core active 
> */ -#define
> > > OMAP3_STATE_C2 2 /* C2 - MPU CSWR + Core active */ -#define
> > > OMAP3_STATE_C3 3 /* C3 - MPU OFF + Core active */ -#define
> > > OMAP3_STATE_C4 4 /* C4 - MPU RET + Core RET */ -#define
> > OMAP3_STATE_C5
> > > 5 /* C5 - MPU OFF + Core RET */ -#define OMAP3_STATE_C6 6
> > /* C6 - MPU
> > > OFF + Core OFF */
> > > +#define OMAP3_STATE_C2 2 /* C2 - MPU WFI + Core inactive
> > */ #define
> > > +OMAP3_STATE_C3 3 /* C3 - MPU CSWR + Core inactive */ #define
> > > +OMAP3_STATE_C4 4 /* C4 - MPU OFF + Core iactive */ #define
> > > +OMAP3_STATE_C5 5 /* C5 - MPU RET + Core RET */ #define
> > OMAP3_STATE_C6
> > > +6 /* C6 - MPU OFF + Core RET */ #define OMAP3_STATE_C7 7
> > /* C7 - MPU
> > > +OFF + Core OFF */
> > >  
> > >  struct omap3_processor_cx {
> > >  	u8 valid;
> > > @@ -63,6 +65,18 @@ static int omap3_idle_bm_check(void)
> > >  	return 0;
> > >  }
> > >  
> > > +static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
> > > +				struct clockdomain *clkdm)
> > > +{
> > > +	omap2_clkdm_allow_idle(clkdm);
> > > +}
> > > +
> > > +static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
> > > +				struct clockdomain *clkdm)
> > > +{
> > > +	omap2_clkdm_deny_idle(clkdm);
> > > +}
> > > +
> 
> These functions don't return any value. Even the functions
> omap2_clkdm_allow_idle() and omap2_clkdm_deny_idle() are void.
> 
> So, the return type should be changed to void. Else complier 
> would throw warnings like:
> 
> warning: no return statement in function returning non-void
> 
> ~sanjeev
> 

[sp] I commented on the patch without trying myself.
     The return type "int" is necessary for calls to functions
     pwrdm_for_each_clkdm().

     So, real solution would be to return with a value.

@@ -70,12 +70,14 @@ static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
                                struct clockdomain *clkdm) {
        omap2_clkdm_allow_idle(clkdm);
+       return 0;
 }

 static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
                                struct clockdomain *clkdm)
 {
        omap2_clkdm_deny_idle(clkdm);
+       return 0;
 }

~sanjeev

> > >  /**
> > >   * omap3_enter_idle - Programs OMAP3 to enter the specified state
> > >   * @dev: cpuidle device
> > > @@ -99,9 +113,19 @@ static int omap3_enter_idle(struct
> > cpuidle_device *dev,
> > >  	if (omap_irq_pending())
> > >  		goto return_sleep_time;
> > >  
> > > +	if (cx->type == OMAP3_STATE_C1) {
> > > +		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
> > > +		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> > > +	}
> > > +
> > >  	/* Execute ARM wfi */
> > >  	omap_sram_idle();
> > >  
> > > +	if (cx->type == OMAP3_STATE_C1) {
> > > +		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
> > > +		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
> > > +	}
> > > +
> > >  return_sleep_time:
> > >  	getnstimeofday(&ts_postidle);
> > >  	ts_idle = timespec_sub(ts_postidle, ts_preidle); @@
> > -140,79 +164,90
> > > @@ DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
> > >  /* omap3_init_power_states - Initialises the OMAP3
> > specific C states.
> > >   *
> > >   * Below is the desciption of each C state.
> > > - *	C1 . MPU WFI + Core active
> > > - *	C2 . MPU CSWR + Core active
> > > - *	C3 . MPU OFF + Core active
> > > - *	C4 . MPU CSWR + Core CSWR
> > > - *	C5 . MPU OFF + Core CSWR
> > > - *	C6 . MPU OFF + Core OFF
> > > + * 	C1 . MPU WFI + Core active
> > > + *	C2 . MPU WFI + Core inactive
> > > + *	C3 . MPU CSWR + Core inactive
> > > + *	C4 . MPU OFF + Core inactive
> > > + *	C5 . MPU CSWR + Core CSWR
> > > + *	C6 . MPU OFF + Core CSWR
> > > + *	C7 . MPU OFF + Core OFF
> > >   */
> > >  void omap_init_power_states(void)
> > >  {
> > >  	/* C1 . MPU WFI + Core active */
> > >  	omap3_power_states[OMAP3_STATE_C1].valid = 1;
> > >  	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
> > > -	omap3_power_states[OMAP3_STATE_C1].sleep_latency = 10;
> > > -	omap3_power_states[OMAP3_STATE_C1].wakeup_latency = 10;
> > > -	omap3_power_states[OMAP3_STATE_C1].threshold = 30;
> > > +	omap3_power_states[OMAP3_STATE_C1].sleep_latency = 2;
> > > +	omap3_power_states[OMAP3_STATE_C1].wakeup_latency = 2;
> > > +	omap3_power_states[OMAP3_STATE_C1].threshold = 5;
> > >  	omap3_power_states[OMAP3_STATE_C1].mpu_state = PWRDM_POWER_ON;
> > >  	omap3_power_states[OMAP3_STATE_C1].core_state = PWRDM_POWER_ON;
> > >  	omap3_power_states[OMAP3_STATE_C1].flags =
> > CPUIDLE_FLAG_TIME_VALID;
> > >  
> > > -	/* C2 . MPU CSWR + Core active */
> > > +	/* C2 . MPU WFI + Core inactive */
> > >  	omap3_power_states[OMAP3_STATE_C2].valid = 1;
> > >  	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
> > > -	omap3_power_states[OMAP3_STATE_C2].sleep_latency = 50;
> > > -	omap3_power_states[OMAP3_STATE_C2].wakeup_latency = 50;
> > > -	omap3_power_states[OMAP3_STATE_C2].threshold = 300;
> > > -	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_RET;
> > > +	omap3_power_states[OMAP3_STATE_C2].sleep_latency = 10;
> > > +	omap3_power_states[OMAP3_STATE_C2].wakeup_latency = 10;
> > > +	omap3_power_states[OMAP3_STATE_C2].threshold = 30;
> > > +	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
> > >  	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
> > > -	omap3_power_states[OMAP3_STATE_C2].flags = 
> > CPUIDLE_FLAG_TIME_VALID |
> > > -				CPUIDLE_FLAG_CHECK_BM;
> > > +	omap3_power_states[OMAP3_STATE_C2].flags =
> > CPUIDLE_FLAG_TIME_VALID;
> > >  
> > > -	/* C3 . MPU OFF + Core active */
> > > +	/* C3 . MPU CSWR + Core inactive */
> > >  	omap3_power_states[OMAP3_STATE_C3].valid = 1;
> > >  	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
> > > -	omap3_power_states[OMAP3_STATE_C3].sleep_latency = 1500;
> > > -	omap3_power_states[OMAP3_STATE_C3].wakeup_latency = 1800;
> > > -	omap3_power_states[OMAP3_STATE_C3].threshold = 4000;
> > > -	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_OFF;
> > > +	omap3_power_states[OMAP3_STATE_C3].sleep_latency = 50;
> > > +	omap3_power_states[OMAP3_STATE_C3].wakeup_latency = 50;
> > > +	omap3_power_states[OMAP3_STATE_C3].threshold = 300;
> > > +	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_RET;
> > >  	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
> > >  	omap3_power_states[OMAP3_STATE_C3].flags =
> > CPUIDLE_FLAG_TIME_VALID |
> > >  				CPUIDLE_FLAG_CHECK_BM;
> > >  
> > > -	/* C4 . MPU CSWR + Core CSWR*/
> > > +	/* C4 . MPU OFF + Core inactive */
> > >  	omap3_power_states[OMAP3_STATE_C4].valid = 1;
> > >  	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
> > > -	omap3_power_states[OMAP3_STATE_C4].sleep_latency = 2500;
> > > -	omap3_power_states[OMAP3_STATE_C4].wakeup_latency = 7500;
> > > -	omap3_power_states[OMAP3_STATE_C4].threshold = 12000;
> > > -	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_RET;
> > > -	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_RET;
> > > +	omap3_power_states[OMAP3_STATE_C4].sleep_latency = 1500;
> > > +	omap3_power_states[OMAP3_STATE_C4].wakeup_latency = 1800;
> > > +	omap3_power_states[OMAP3_STATE_C4].threshold = 4000;
> > > +	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_OFF;
> > > +	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_ON;
> > >  	omap3_power_states[OMAP3_STATE_C4].flags =
> > CPUIDLE_FLAG_TIME_VALID |
> > >  				CPUIDLE_FLAG_CHECK_BM;
> > >  
> > > -	/* C5 . MPU OFF + Core CSWR */
> > > +	/* C5 . MPU CSWR + Core CSWR*/
> > >  	omap3_power_states[OMAP3_STATE_C5].valid = 1;
> > >  	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
> > > -	omap3_power_states[OMAP3_STATE_C5].sleep_latency = 3000;
> > > -	omap3_power_states[OMAP3_STATE_C5].wakeup_latency = 8500;
> > > -	omap3_power_states[OMAP3_STATE_C5].threshold = 15000;
> > > -	omap3_power_states[OMAP3_STATE_C5].mpu_state = PWRDM_POWER_OFF;
> > > +	omap3_power_states[OMAP3_STATE_C5].sleep_latency = 2500;
> > > +	omap3_power_states[OMAP3_STATE_C5].wakeup_latency = 7500;
> > > +	omap3_power_states[OMAP3_STATE_C5].threshold = 12000;
> > > +	omap3_power_states[OMAP3_STATE_C5].mpu_state = PWRDM_POWER_RET;
> > >  	omap3_power_states[OMAP3_STATE_C5].core_state = PWRDM_POWER_RET;
> > >  	omap3_power_states[OMAP3_STATE_C5].flags =
> > CPUIDLE_FLAG_TIME_VALID |
> > >  				CPUIDLE_FLAG_CHECK_BM;
> > >  
> > > -	/* C6 . MPU OFF + Core OFF */
> > > +	/* C6 . MPU OFF + Core CSWR */
> > >  	omap3_power_states[OMAP3_STATE_C6].valid = 1;
> > >  	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
> > > -	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 10000;
> > > -	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 30000;
> > > -	omap3_power_states[OMAP3_STATE_C6].threshold = 300000;
> > > +	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 3000;
> > > +	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 8500;
> > > +	omap3_power_states[OMAP3_STATE_C6].threshold = 15000;
> > >  	omap3_power_states[OMAP3_STATE_C6].mpu_state = PWRDM_POWER_OFF;
> > > -	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_OFF;
> > > +	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_RET;
> > >  	omap3_power_states[OMAP3_STATE_C6].flags =
> > CPUIDLE_FLAG_TIME_VALID |
> > >  				CPUIDLE_FLAG_CHECK_BM;
> > > +
> > > +	/* C7 . MPU OFF + Core OFF */
> > > +	omap3_power_states[OMAP3_STATE_C7].valid = 1;
> > > +	omap3_power_states[OMAP3_STATE_C7].type = OMAP3_STATE_C7;
> > > +	omap3_power_states[OMAP3_STATE_C7].sleep_latency = 10000;
> > > +	omap3_power_states[OMAP3_STATE_C7].wakeup_latency = 30000;
> > > +	omap3_power_states[OMAP3_STATE_C7].threshold = 300000;
> > > +	omap3_power_states[OMAP3_STATE_C7].mpu_state = PWRDM_POWER_OFF;
> > > +	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_OFF;
> > > +	omap3_power_states[OMAP3_STATE_C7].flags =
> > CPUIDLE_FLAG_TIME_VALID |
> > > +				CPUIDLE_FLAG_CHECK_BM;
> > >  }
> > >  
> > >  struct cpuidle_driver omap3_idle_driver = {
> > > --
> > > 1.5.6.3
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" 
> > > in the body of a message to majordomo@vger.kernel.org More
> > majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" 
> > in the body of a message to majordomo@vger.kernel.org More 
> majordomo 
> > info at http://vger.kernel.org/majordomo-info.html
> > 
> > 