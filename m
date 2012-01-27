From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 27 Jan 2012 13:47:01 +0000
Message-ID: <yw1xwr8dmf56.fsf@unicorn.mansr.com>
References: <CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
	<CACVXFVNfc8fKe=6LVruj387-vQ85WHL7tAgZUT=9h6AQUM0X0Q@mail.gmail.com>
	<CAMsRxfLcO0eM8mkKUZcR8X6SG-MMRFasRK7hQCT-3-NuKN_+1g@mail.gmail.com>
	<CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
	<CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
	<CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
	<CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
	<CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
	<20120127121311.GB2347@mudshark.cambridge.arm.com>
	<yw1x1uqlnw1o.fsf@unicorn.mansr.com>
	<20120127132826.GD2347@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:49636 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab2A0NrD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 08:47:03 -0500
In-Reply-To: <20120127132826.GD2347@mudshark.cambridge.arm.com> (Will Deacon's
	message of "Fri, 27 Jan 2012 13:28:26 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "eranian@gmail.com" <eranian@gmail.com>, "Cousson, Benoit" <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Will Deacon <will.deacon@arm.com> writes:

> Mans,
>
> On Fri, Jan 27, 2012 at 12:56:35PM +0000, M=E5ns Rullg=E5rd wrote:
>> Will Deacon <will.deacon@arm.com> writes:
>> > Did this lead anywhere in the end? It seems as though Ming Lei has=
 a working
>> > setup but Stephane is unable to replicate it, despite applying the=
 necessary
>> > patches and trying an updated bootloader.
>>=20
>> With the patches listed above plus the one in [1], I get PMU interru=
pts.
>> However, unless I restrict the profiled process to one CPU
>> (taskset 1 perf record ...), I get a panic in armpmu_event_update() =
with
>> the 'event' argument being null when called from armv7pmu_handle_irq=
().
>>=20
>> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/69696
>
> Great, thanks for trying this out. Which version of the kernel were y=
ou
> using? I fixed a bunch of NULL pointer derefs. during the 3.2 window,=
 but if
> you were using an -rc kernel you have have hit one of them.

This was with the Linaro tilt-3.2 kernel from
git://git.linaro.org/landing-teams/working/ti/kernel.git, commit
73e2c294444f209d281f7cd10b52b53b087e74f1.  Maybe one of the many patche=
s
it has on top of 3.2 is to blame.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
