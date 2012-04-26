From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
Date: Thu, 26 Apr 2012 06:23:46 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FE807@DBDE01.ent.ti.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
	<1335260749-25877-4-git-send-email-hvaibhav@ti.com>
	<CA+Bv8XYemH3zW48id_ZAvC2gU_uZMFei6dMO1GUog_YTvFBV2Q@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83E9FE722@DBDE01.ent.ti.com>
 <CA+Bv8XaWkBr7ZDTjmjDg_K+JhEfWdYEt=eKQ5Gj8NMbw4K=Jmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55335 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937Ab2DZGXz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 02:23:55 -0400
In-Reply-To: <CA+Bv8XaWkBr7ZDTjmjDg_K+JhEfWdYEt=eKQ5Gj8NMbw4K=Jmg@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

On Thu, Apr 26, 2012 at 11:26:09, Russ Dill wrote:
> On Wed, Apr 25, 2012 at 10:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> > On Thu, Apr 26, 2012 at 10:06:40, Russ Dill wrote:
> >> On Tue, Apr 24, 2012 at 2:45 AM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> >> > Current OMAP code supports couple of clocksource options based
> >> > on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> >> > and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
> >> > So there can be 3 options -
> >> >
> >> > 1. 32KHz sync-timer
> >> > 2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
> >> > 3. 32KHz based gptimer.
> >> >
> >> > The optional gptimer based clocksource was added so that it can
> >> > give the high precision than sync-timer, so expected usage was 2
> >> > and not 3.
> >> > Unfortunately option 2, clocksource doesn't meet the requirement of
> >> > free-running clock as per clocksource need. It stops in low power states
> >> > when sys_clock is cut. That makes gptimer based clocksource option
> >> > useless for OMAP2/3/4 devices with sys_clock as a clock input.
> >> > Option 3 will still work but it is no better than 32K sync-timer
> >> > based clocksource.
> >> >
> >> > So ideally we can kill the gptimer based clocksource option but there
> >> > are some OMAP based derivative SoCs like AM33XX which doesn't have
> >> > 32K sync-timer hardware IP and need to fallback on 32KHz based gptimer
> >> > clocksource.
> >> > Considering above, make sync-timer and gptimer clocksource runtime
> >> > selectable so that both OMAP and AMXXXX continue to use the same code.
> >> >
> >> > Also, in order to precisely configure/setup sched_clock for given
> >> > clocksource, decision has to be made early enough in boot sequence.
> >> >
> >> > So, the solution is,
> >> >
> >> > Use kernel parameter ("clocksource=") to override
> >> > default 32k_sync-timer, in addition to this, we also use hwmod database
> >> > lookup mechanism, through which at run-time we can identify availability
> >> > of 32k-sync timer on the device, else fall back to gptimer.
> >> >
> >> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> >> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> > Cc: Kevin Hilman <khilman@ti.com>
> >> > Cc: Benoit Cousson <b-cousson@ti.com>
> >> > Cc: Tony Lindgren <tony@atomide.com>
> >> > Cc: Paul Walmsley <paul@pwsan.com>
> >> > Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> >> > Cc: Ming Lei <tom.leiming@gmail.com>
> >>
> >> This fails to boot on my Mistral am37x-evm with omap2plus_defconfig
> >>
> >
> > Thanks Russ, for validating it.
> >
> > But I do not see any relation between your boot process stuck and this patch.
> > What is the observation without these patches?
> 
> With no patches applied it boots, with 1/3 applied it boots, with 2/3
> applied it boots, with 3/3 applied it gets hung. I also tested on my
> beagleboard b4, that booted fine.
> 

You mean to say, on Beagleboard it boots up fine. And same fails on EVM?

Thanks,
Vaibhav

