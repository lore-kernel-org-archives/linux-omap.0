From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 27 Jan 2012 14:05:53 +0000
Message-ID: <yw1xsjj1me9q.fsf@unicorn.mansr.com>
References: <CAMsRxfLcO0eM8mkKUZcR8X6SG-MMRFasRK7hQCT-3-NuKN_+1g@mail.gmail.com>
	<CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
	<CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
	<CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
	<CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
	<CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
	<20120127121311.GB2347@mudshark.cambridge.arm.com>
	<yw1x1uqlnw1o.fsf@unicorn.mansr.com>
	<20120127132826.GD2347@mudshark.cambridge.arm.com>
	<yw1xwr8dmf56.fsf@unicorn.mansr.com>
	<20120127135646.GE2347@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:51298 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab2A0OFy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 09:05:54 -0500
In-Reply-To: <20120127135646.GE2347@mudshark.cambridge.arm.com> (Will Deacon's
	message of "Fri, 27 Jan 2012 13:56:46 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "eranian@gmail.com" <eranian@gmail.com>, "Cousson, Benoit" <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Will Deacon <will.deacon@arm.com> writes:

> On Fri, Jan 27, 2012 at 01:47:01PM +0000, M=E5ns Rullg=E5rd wrote:
>> Will Deacon <will.deacon@arm.com> writes:
>>=20
>> > Mans,
>> >
>> > On Fri, Jan 27, 2012 at 12:56:35PM +0000, M=E5ns Rullg=E5rd wrote:
>> >> Will Deacon <will.deacon@arm.com> writes:
>> >> > Did this lead anywhere in the end? It seems as though Ming Lei =
has a working
>> >> > setup but Stephane is unable to replicate it, despite applying =
the necessary
>> >> > patches and trying an updated bootloader.
>> >>=20
>> >> With the patches listed above plus the one in [1], I get PMU inte=
rrupts.
>> >> However, unless I restrict the profiled process to one CPU
>> >> (taskset 1 perf record ...), I get a panic in armpmu_event_update=
() with
>> >> the 'event' argument being null when called from armv7pmu_handle_=
irq().
>> >>=20
>> >> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/69696
>> >
>> > Great, thanks for trying this out. Which version of the kernel wer=
e you
>> > using? I fixed a bunch of NULL pointer derefs. during the 3.2 wind=
ow, but if
>> > you were using an -rc kernel you have have hit one of them.
>>=20
>> This was with the Linaro tilt-3.2 kernel from
>> git://git.linaro.org/landing-teams/working/ti/kernel.git, commit
>> 73e2c294444f209d281f7cd10b52b53b087e74f1.  Maybe one of the many pat=
ches
>> it has on top of 3.2 is to blame.
>
> Perhaps, or (more likely) the interrupt affinity for the CTI isn't wo=
rking
> properly and the interrupt is always delivered to CPU0. I'll keep thi=
s in
> mind in case we get any more reports like this.

It works whichever CPU I pin it to (i.e. taskset 2 also works).

=46WIW, my /proc/interrupts looks like this when perf is running:

           CPU0       CPU1
 29:   25238127    1409121       GIC  twd
 33:    4586197          0       GIC  arm-pmu
 34:          0    4744550       GIC  arm-pmu
 39:          0          0       GIC  TWL6030-PIH
 41:          0          0       GIC  l3-dbg-irq
 42:          0          0       GIC  l3-app-irq
 43:          0          0       GIC  prcm
 44:        141          0       GIC  DMA
[...]

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
