From: Ming Lei <ming.lei@canonical.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Sat, 21 Jan 2012 11:25:26 +0800
Message-ID: <CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
	<4F0B182D.7060507@us.ibm.com>
	<20120109224945.GA23090@mudshark.cambridge.arm.com>
	<CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
	<CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
	<CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
	<CAMsRxfLtLnMiP0ZGr6rNLv-UeLUwOSJ=7do2nezOU5OkOA+MbQ@mail.gmail.com>
	<CACVXFVMbrQGi4Sg9TUPP5Bcc5kzFoX74n=ii4QrDRudbuDHOGg@mail.gmail.com>
	<CAMsRxfJmHkZw2f0A+4FsStJpXk_vrxvDduRcRGkcWpqp8a9m_w@mail.gmail.com>
	<CACVXFVOQNDRs=c8A2YC+WvYAHs5Abbz-QUEe1VJqrj2esFO11g@mail.gmail.com>
	<CAMsRxf+e38jRcyxESLhYDZ3OL910AQdapZD9P8vWDXfUE34DAA@mail.gmail.com>
	<CACVXFVPnhSy_DbdK+ro8G78QjL2s6fBBq1Dvq-pmxJ20qA-ymA@mail.gmail.com>
	<CAMsRxfJ2VrfFZevkxoZzSD5fZn1CErF68y0ny+MZi5r___ERJA@mail.gmail.com>
	<CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
	<CACVXFVNfc8fKe=6LVruj387-vQ85WHL7tAgZUT=9h6AQUM0X0Q@mail.gmail.com>
	<CAMsRxfLcO0eM8mkKUZcR8X6SG-MMRFasRK7hQCT-3-NuKN_+1g@mail.gmail.com>
	<CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
	<CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
	<CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34490 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898Ab2AUDZc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jan 2012 22:25:32 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RoRa4-0005WD-Em
	for linux-omap@vger.kernel.org; Sat, 21 Jan 2012 03:25:28 +0000
Received: by dake40 with SMTP id e40so668414dak.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 19:25:26 -0800 (PST)
In-Reply-To: <CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eranian@gmail.com
Cc: Will Deacon <will.deacon@arm.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>

On Fri, Jan 20, 2012 at 9:47 PM, stephane eranian
<eranian@googlemail.com> wrote:
> Started afresh from:
>
> 90a4c0f uml: fix compile for x86-64
>
> And added 3, 4, 5, 6:
> 603c316 arm: omap4: pmu: support runtime pm
> 4899fbd arm: omap4: support pmu
> d737bb1 arm: omap4: create pmu device via hwmod
> 4e0259e arm: omap4: hwmod: introduce emu hwmod
>
> Still no interrupts firing. I am using your .config file.
>
> My HW:
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant =A0 =A0 : 0x1
> CPU part =A0 =A0 =A0 =A0: 0xc09
> CPU revision =A0 =A0: 2
>
> Hardware =A0 =A0 =A0 =A0: OMAP4 Panda board
> Revision =A0 =A0 =A0 =A0: 0020
>
> There must be something I am missing here.

Have you applied the patch in link[1]?


thanks,
--
Ming Lei

[1], http://marc.info/?l=3Dlinux-arm-kernel&m=3D132697975416659&w=3D2
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
