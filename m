From: Ming Lei <ming.lei@canonical.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 27 Jan 2012 22:09:41 +0800
Message-ID: <CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59044 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab2A0OJo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 09:09:44 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RqmUp-0000FZ-Fn
	for linux-omap@vger.kernel.org; Fri, 27 Jan 2012 14:09:43 +0000
Received: by dadi2 with SMTP id i2so1431061dad.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Jan 2012 06:09:41 -0800 (PST)
In-Reply-To: <20120127132826.GD2347@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "eranian@gmail.com" <eranian@gmail.com>, "Cousson, Benoit" <b-cousson@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

2012/1/27 Will Deacon <will.deacon@arm.com>:
> Mans,
>
> On Fri, Jan 27, 2012 at 12:56:35PM +0000, M=E5ns Rullg=E5rd wrote:
>> Will Deacon <will.deacon@arm.com> writes:
>> > Did this lead anywhere in the end? It seems as though Ming Lei has=
 a working
>> > setup but Stephane is unable to replicate it, despite applying the=
 necessary
>> > patches and trying an updated bootloader.
>>
>> With the patches listed above plus the one in [1], I get PMU interru=
pts.
>> However, unless I restrict the profiled process to one CPU
>> (taskset 1 perf record ...), I get a panic in armpmu_event_update() =
with
>> the 'event' argument being null when called from armv7pmu_handle_irq=
().
>>
>> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/69696
>
> Great, thanks for trying this out. Which version of the kernel were y=
ou
> using?

The patch is required for 3.3-rc1 in case that omap4 pmu works well.

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
