From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Wed, 28 Mar 2012 14:37:53 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83183EB47@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com> <87mx9ej8fp.fsf@ti.com>
 <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
 <4F672364.3020403@ti.com>
 <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
 <CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
 <CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38055 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254Ab2C1Oib convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Mar 2012 10:38:31 -0400
In-Reply-To: <CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Wed, Mar 28, 2012 at 19:50:02, Shilimkar, Santosh wrote:
> On Wed, Mar 28, 2012 at 7:46 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> > On Wed, Mar 21, 2012 at 19:30:01, Shilimkar, Santosh wrote:
> >> On Wed, Mar 21, 2012 at 5:12 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> >> > On Mon, Mar 19, 2012 at 17:45:32, Shilimkar, Santosh wrote:
> >> >> On Monday 19 March 2012 05:14 PM, Ming Lei wrote:
> >> >> > On Mon, Mar 19, 2012 at 7:11 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> 
> [...]
> 
> >
> >> Btw, if you need PM, how are you going to use GPTIMER
> >> as a clocksource. Note sys-clock is generally stopped in
> >> low power states. So that leaves you option with using
> >> gptimer with 32K clock and in that case, GPTIMER
> >> is not a better clock-source compare to 32K sync timer
> >> and so shouldn't be the rating.
> >>
> >
> > AM33xx has GPTIMER1 in wakeup domain, so that we are already using as a
> > Clocksource, without any issues.
> >
> GPTIMER1 is in wakeup domain on OMAP too but that doesn't
> solve the issue I am talking. Once the sysclock is stopped, GPTIMER
> can't tick anymore even if it is in wakeup domain.
> 
> The only way it will work is using always running 32KHz clock as
> the clock input to GPT1. And then the end result is the accuracy
> of GPTIMER = sync 32K timer. So they are of same rating.
> 

Ohh ok, sorry I should have clarified it in my last response itself.

AM33xx architecture is bit different than OMAP family, and gmtimer1 is 
sourced from RTC32K clock, which is in wakeup domain.
This means we have RTC32K clock always running across suspend/resume.

0 - SEL1: Select CLK_M_OSC clock
1 - SEL2: Select CLK_32KHZ clock
2 - SEL3: Select TCLKIN clock
3 - SEL4: Select CLK_RC32K clock
4 - SEL5: Selects the CLK_32768 from 32KHz Crystal Osc


We use value "4" here, for RTC32K (always on clock).
I hope this clarifies what I am trying to say here.


Thanks,
Vaibhav

> Hope it is clear now.
> 
> Regards
> Santosh
> 

