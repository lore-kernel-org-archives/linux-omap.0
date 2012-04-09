From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to	check
 presence of 32k timer
Date: Mon, 9 Apr 2012 06:25:48 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83184AC0A@DBDE01.ent.ti.com>
References: <CACVXFVPbU2OqTN=S0AZCD10KuSBYxqyyRH_xee+WTaCD6VSmMQ@mail.gmail.com>
	<CAMQu2gzuQ-q+3RHsW0=U305jCF-td5-PEXkGZ6WnQTqA1K8oAQ@mail.gmail.com>
	<CACVXFVPu1GEQy+sCgXMB8JCszPBBs8zHRVm94TYb1-y2afkqgw@mail.gmail.com>
	<CAMQu2gwuRpZ133962r3N4Y4K3oQ88ySa=SyoS6v=sSHGA=SGKw@mail.gmail.com>
	<CACVXFVMjSPhF_+CfbF2vD5ts+WtZGjofEWmknB0D1OpTM7geZw@mail.gmail.com>
	<CAMQu2gyEUhDyyng+_oC5NpXHzWMaTGsnCSTTZcMUi2pLV0z8RQ@mail.gmail.com>
	<87sjgmt211.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A8318461E8@DBDE01.ent.ti.com>
	<CAMQu2gxuFsovKTPK8wFOO8vMeiyMFnTqNDRZYgAcCsVWytpOTA@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83184846A@DBDE01.ent.ti.com>
	<20120405095221.GC25053@n2100.arm.linux.org.uk>
	<79CD15C6BA57404B839C016229A409A831848621@DBDE01.ent.ti.com>
	<87hawxkgoi.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A831849432@DBDE01.ent.ti.com>
 <874nswftjc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54162 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831Ab2DIG0J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 02:26:09 -0400
In-Reply-To: <874nswftjc.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Ming Lei <tom.leiming@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Sat, Apr 07, 2012 at 02:48:47, Hilman, Kevin wrote:
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> 
> [...]
> 
> > I liked Santosh's idea in using command line argument "clocksource=" and 
> > make decision based on this. I have implemented it and tried it on both
> > OMAP3EVM and beaglebone and it works great.
> >
> > I have introduced something like this in mach-omap2/timer.c,
> >
> > static int __init omap2_override_clocksource(char* str)
> > {
> > 	if (!str)
> > 		return 0;
> > 	/*
> > 	 * For OMAP architecture, we only have two options
> > 	 *    - sync_32k (default)
> > 	 *    - gp timer
> > 	 */
> > 	if (!strcmp(str, "gp timer"))
> > 		use_gptimer_clksrc = true;
> >
> > 	return 0;
> > }
> > early_param("clocksource", omap2_override_clocksource);
> 
> How does this interact with the existing clocksource cmdline parameter
> already in kernel/time/clocksource.c? (c.f. boot_override_clocksource()) 
> 

Not really, it doesn't interact with existing clocksource parameter
Already present in kernel/time/clocksource.c.

Both works independently...

> IMO, this duplicates that functionality but less elegantly.
> 
> What should happen is to let clocksource selection happen normally
> (based on presence or lack of HW, or cmdline override.)  Once that has
> happened, you can then setup_sched_clock() with parameters from querying
> the clocksource itself.
> 

After Russell's response, it is clear that we should not change the 
clocksource dynamically, its not useful. So I do not see any benefits
following that feature (as of now).

We just need to make sure that, we detect our clocksource and call
setup_sched_clock() with appropriate rating.

Thanks,
Vaibhav

