From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
Date: Tue, 17 Jan 2012 14:39:11 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1201171425060.2722@xanadu.home>
References: <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com>
 <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
 <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <20120117162720.GG11475@arm.com>
 <CAMQu2gyCcGYk0tC_g2R9+OBYCvwupcjuUkRC5JxJ7maAVTs1YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:47933 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393Ab2AQTjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jan 2012 14:39:13 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LXY004RTJVAHD70@VL-VM-MR003.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 17 Jan 2012 14:37:58 -0500 (EST)
In-reply-to: <CAMQu2gyCcGYk0tC_g2R9+OBYCvwupcjuUkRC5JxJ7maAVTs1YA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

On Tue, 17 Jan 2012, Shilimkar, Santosh wrote:

> On Tue, Jan 17, 2012 at 5:27 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > BTW, does the firmware make any checks on what bits it allows to be set?
> > Some of them may have security implications (and may not even be
> > documented).
> >
> > Anyway, the first step is this API provided by the secure firmware.
> > Since such API may need to be called before the MMU is initialised,
> > Linux would need to have knowledge of the platform type early on. Having
> > some platform hook (asm macro) to call early on wouldn't work with the
> > single zImage configuration. Stack space is not an issue as we already
> > have one for ARMv7 for D-cache flushing (XIP kernels would work but they
> > aren't that many).
> >
> That's true.

That stack is ugly and _does_ break XIP (even if there aren't that many 
if at all on ARMv7).  Since we're already writing to RAM while setting 
up the initial page table and therefore we did the necessary work to 
locate it already, we could as well put a temporary stack for early 
usage right below the page table.

> >> Firmware point is actually irrelevant for OMAP since it can't be
> >> changed once it is ROMed.
> >>
> >> Patching in boot-loaders isn't an option either since every customers
> >> prefers to use there own boot-loader and then controlling this vital
> >> bits is impossible.
> >>
> >> So I re-iterate that we need to have solution to this problem.
> >
> > I don't disagree with this, a solution is needed. In the past I was for
> > having platform hooks in the early kernel code path but in the light of
> > latest kernel developments (FDT, single zImage), I no longer see this as
> > acceptable.
> >
> Thanks for acknowledging the problem. Not allowing such hooks for single
> zImage doesn't seems to be right. Nobody ships kernel build for all socs,
> and it's usage is really limited to few distro's. But that's different topic.

No, I think this is right on topic.  If nobody ships a kernel for 
multiple SOCs, this is because right now this can't be done.  But 
distros are craving for this ability.

> How about allowing platform hooks for single SOC builds. I mean having
> this code under !single_zImage or something like that. That way we don't
> impact the single zImage efforts and also allow socs to have all those
> critical, vital bits enabled for the SOC specific builds.

Absolutely not!  Because if we start doing that, people will get lazy 
and no platform will ever work in a multi-SOC kernel.

If your SOC require some fancy setup that is not shared by other 
platforms then please abstract that into the bootloader, or make sure it 
can be deferred later on.



Nicolas
