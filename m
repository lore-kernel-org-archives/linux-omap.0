From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Wed, 21 Mar 2012 11:42:26 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
	<1326983304-14619-2-git-send-email-hvaibhav@ti.com>	<87mx9ej8fp.fsf@ti.com>
	<CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
 <4F672364.3020403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52087 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784Ab2CULms convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 07:42:48 -0400
In-Reply-To: <4F672364.3020403@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Ming Lei <tom.leiming@gmail.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Mon, Mar 19, 2012 at 17:45:32, Shilimkar, Santosh wrote:
> On Monday 19 March 2012 05:14 PM, Ming Lei wrote:
> > On Mon, Mar 19, 2012 at 7:11 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> >>
> >> I think you made very good point here. With the above patch, we are almost missing the capability of registering dmtimer as a clocksource for OMAP.
> >> It will always use 32k-counter, and never fall back to dmtimer.
> >>
> >> Then the only options we have here is,
> >>
> >> 1) Register both the timers, 32k-counter and dmtimer for clocksource; let
> >>   Kernel pick up best rating clocksource out of these two.
> >>
> >>   In case of OMAP1/2/3/4, kernel will use dmtimer, since it has better
> >>   Rating. User can choose the 32k-counter clocksource via bootargs.
> >>
> >>   Impact: without bootargs for clocksource selection, kernel will choose
> >>     dmtimer, impacting loss of time during suspend/resume.
> >>
> This is the right option. The problem is gptimer clocksource
> doesn't work across power transitions and hence it is broken.
> 
> Even for the perf, with PM enabled, dmtimer can't be used or it needs
> to be used with 32KHz clock which makes it no better than sync timer.
> 
> So here keeping 32K sync timer is default clocksource makes sense since
> it is the only working and viable option.
> 
> So what can be done is register both 32K and gptimer together but make
> gptimer clocksource registration depends on PM enabled.
> 
> This should solve all the needs I guess.
> 

I am not sure this will work on all platforms, for example, AM33XX, where
We do not have 32ksync timer available, but we need PM support. Also, I 
personally think, we should not again use compile time option here.

So the only option I have here is, register both the clocksources, let dmtimer be a default clocksource for the kernel (since it has better rating),
And based on kernel parameter user can change the clocksource, specially 
for PM use-cases.


Implementation point of view, I just need to do something like,

static void __init omap2_gp_clocksource_init(int gptimer_id,
							const char *fck_source)
{
	int res;

	res = omap_init_clocksource_32k();
	if (!res)
		pr_err("failed to register 32ksync counter as a clocksource\n");

	/* 
	 * Continue with dmtimer registration as well, irrespective of
	 * whether 32ksync timer registration succeeded or not.
	 */
}

> >>
> >> 2) Let the current code be as is, means, the clocksource registration will
> >>   Happened based on "#ifdef CONFIG_OMAP_32K_TIMER" and this option
> >>   selection will be Controlled by Kconfig rules.
> > 
> We should get rid off CONFIG_OMAP_32K_TIMER.
> 

Agreed, I will take this activity once I close on this.

Thanks,
Vaibhav

> Regards
> Santosh
> 
> 

