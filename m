From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 27 Jan 2012 12:56:35 +0000
Message-ID: <yw1x1uqlnw1o.fsf@unicorn.mansr.com>
References: <CACVXFVPnhSy_DbdK+ro8G78QjL2s6fBBq1Dvq-pmxJ20qA-ymA@mail.gmail.com>
	<CAMsRxfJ2VrfFZevkxoZzSD5fZn1CErF68y0ny+MZi5r___ERJA@mail.gmail.com>
	<CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
	<CACVXFVNfc8fKe=6LVruj387-vQ85WHL7tAgZUT=9h6AQUM0X0Q@mail.gmail.com>
	<CAMsRxfLcO0eM8mkKUZcR8X6SG-MMRFasRK7hQCT-3-NuKN_+1g@mail.gmail.com>
	<CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
	<CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
	<CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
	<CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
	<CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
	<20120127121311.GB2347@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:48499 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332Ab2A0M4h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 07:56:37 -0500
In-Reply-To: <20120127121311.GB2347@mudshark.cambridge.arm.com> (Will Deacon's
	message of "Fri, 27 Jan 2012 12:13:11 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "eranian@gmail.com" <eranian@gmail.com>, "Cousson, Benoit" <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Will Deacon <will.deacon@arm.com> writes:

> Hi guys,
>
> On Sat, Jan 21, 2012 at 09:16:57AM +0000, stephane eranian wrote:
>> On Sat, Jan 21, 2012 at 4:25 AM, Ming Lei <ming.lei@canonical.com> w=
rote:
>> > On Fri, Jan 20, 2012 at 9:47 PM, stephane eranian
>> > <eranian@googlemail.com> wrote:
>> >> Started afresh from:
>> >>
>> >> 90a4c0f uml: fix compile for x86-64
>> >>
>> >> And added 3, 4, 5, 6:
>> >> 603c316 arm: omap4: pmu: support runtime pm
>> >> 4899fbd arm: omap4: support pmu
>> >> d737bb1 arm: omap4: create pmu device via hwmod
>> >> 4e0259e arm: omap4: hwmod: introduce emu hwmod
>> >>
>> >> Still no interrupts firing. I am using your .config file.
>> >>
>> >> My HW:
>> >> CPU implementer : 0x41
>> >> CPU architecture: 7
>> >> CPU variant =A0 =A0 : 0x1
>> >> CPU part =A0 =A0 =A0 =A0: 0xc09
>> >> CPU revision =A0 =A0: 2
>> >>
>> >> Hardware =A0 =A0 =A0 =A0: OMAP4 Panda board
>> >> Revision =A0 =A0 =A0 =A0: 0020
>> >>
>> >> There must be something I am missing here.
>
> Did this lead anywhere in the end? It seems as though Ming Lei has a =
working
> setup but Stephane is unable to replicate it, despite applying the ne=
cessary
> patches and trying an updated bootloader.

With the patches listed above plus the one in [1], I get PMU interrupts=
=2E
However, unless I restrict the profiled process to one CPU
(taskset 1 perf record ...), I get a panic in armpmu_event_update() wit=
h
the 'event' argument being null when called from armv7pmu_handle_irq().

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/69696

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
