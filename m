From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 8/8] ARM: DRA7: dts: Add the dts files for dra7 SoC
 and dra7-evm board
Date: Tue, 13 Aug 2013 10:46:29 +0100
Message-ID: <20130813094629.GH27165@e106331-lin.cambridge.arm.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-9-git-send-email-rnayak@ti.com>
 <20130812114402.GB6616@e106331-lin.cambridge.arm.com>
 <5209DF2F.5040409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:33651 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755784Ab3HMJrH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Aug 2013 05:47:07 -0400
Content-Disposition: inline
In-Reply-To: <5209DF2F.5040409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@linaro.org" <khilman@linaro.org>, "tony@atomide.com" <tony@atomide.com>, "benoit.cousson@gmail.com" <benoit.cousson@gmail.com>, "r.sricharan@ti.com" <r.sricharan@ti.com>, "ambresh@ti.com" <ambresh@ti.com>, "sourav.poddar@ti.com" <sourav.poddar@ti.com>, marc.zyngier@arm.com

[Adding Marc to Cc]

On Tue, Aug 13, 2013 at 08:24:31AM +0100, Rajendra Nayak wrote:
> []..
> 
> >> +
> >> +       cpus {
> >> +               cpu@0 {
> >> +                       compatible = "arm,cortex-a15";
> >> +                       timer {
> >> +                               compatible = "arm,armv7-timer";
> >> +                               /*
> >> +                                * PPI secure/nonsecure IRQ,
> >> +                                * active low level-sensitive
> >> +                                */
> >> +                               interrupts = <1 13 0x308>,
> >> +                                            <1 14 0x308>;
> >> +                               clock-frequency = <6144000>;
> >> +                       };
> >> +               };
> >
> > The cpu nodes should have a reg matching their unit-address, and a
> > device_type = "cpu".
> >
> > The timer nodes should *not* be under the CPU nodes. They should be
> > under under the root node. I realise that it makes intuitive sense to
> > describe per-cpu resources this way, but that's not the way the bindings
> > are intended to be used (does thei DT even work?).
> >
> > No virtual/hypervisor interrupts?
> 
> Mark, all valid points. I just updated the patch to include all the missing
> interrupts and registers for timer and gic and moved the timer node out as
> its supposed to be.

Great!

> 
> >
> > Do you really need the clock-frequency property? It's far preferrable to
> > have your bootloader do the right thing and program CNTFRQ with the
> > correct value.
> 
> I kept the clock-frequency property since our bootloader does not handle this
> and I am not sure if its a good idea to have the dependency on bootloader
> to do this.

There is precedent for handling it this way, but it would be far nicer
to fix the bootloader to set CNTFRQ. For one thing it's only writeable
from the secure side, so a host os can't fix it up for guests that might
depend on it rather than dt. I realise it's not necessarily as simple as
it sounds to fix that up, however.

[...]

> +       timer {
> +               compatible = "arm,armv7-timer";
> +               /* PPI secure/nonsecure IRQ */

The comment's now stale, and I don't think it's necessary - the binding
defines the order these are in.

> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
> +               clock-frequency = <6144000>;
> +       };

Thanks,
Mark.
