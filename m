From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to	check
 presence of 32k timer
Date: Thu, 5 Apr 2012 10:31:34 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A831848621@DBDE01.ent.ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48724 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572Ab2DEKcY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 06:32:24 -0400
In-Reply-To: <20120405095221.GC25053@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Ming Lei <tom.leiming@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Thu, Apr 05, 2012 at 15:22:21, Russell King - ARM Linux wrote:
> On Thu, Apr 05, 2012 at 09:36:00AM +0000, Hiremath, Vaibhav wrote:
> > There seems to be limitation for ARM architecture, it is restricted by
> > sched_clock implementation present in "arch/arm/kernel/sched_clock.c".
> > Natively, clocksource framework does support change in rate/frequency for
> > registered timer, using,
> 
> Any kind of switching of timing sources introduces loss of time issues
> by the mere fact that you can't instantly know the counter values of
> both timing sources at precisely the same instant - because CPUs can
> only do one thing at a time.  So any kind of repeated dynamic switching
> _will_ result in a gradual loss of time - which will be indeterminant
> as it depends on the frequency of the switching and the relative delta
> between the two.
> 
> To put it another way - it is not possible to maintain high precision
> and accuracy while dynamically switching your timing sources.
> 
> I'm not about to lift the restriction that there's only one source for
> sched_clock() just for OMAP.  That'd require a lot of additional code -
> it's not just about adjusting the multiplier and shift, you also have to
> correct the returned ns value as well, which means synchronizing against
> two counters.  (And as I've pointed out above, that's impossible to do
> accurately.)
> 

Thanks a ton Russell for confirming on this,

I understand, we also have to adjust ns value and such confirmation is what exactly I was looking for.

So this means, we have to use compile time option, as existing
implementation in "arch/arm/mach-omap2/timer.c".

Thanks again, I will repost patches shortly with the code changes (mentioned 
in my last email)

Thanks,
Vaibhav
