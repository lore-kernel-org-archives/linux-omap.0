From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi() forCONFIG_THUMB2_KERNEL
Date: Wed, 8 Dec 2010 16:40:18 +0530
Message-ID: <df00a773077a1dac38b7e6b67190d8f9@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org><1291656937-24992-3-git-send-email-dave.martin@linaro.org><a86d8e4b47fad17e71d0202f3c469868@mail.gmail.com><AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com><2080abb418a8d3c651dd41353ef59d25@mail.gmail.com><d9fec68fc0ce14215439c6e753871bc2@mail.gmail.com><AANLkTim-tdF83gnQ-0o0i7bp7QmQHoT_KbZMHrWTE12g@mail.gmail.com><289b46ad4e4f4a05b6636134e446010c@mail.gmail.com>
 <AANLkTi=OC4ydAtrxNK4Jd_CDo9eLayRusOm9CNM_JFei@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:46352 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753625Ab0LHLKT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Dec 2010 06:10:19 -0500
Received: by pxi7 with SMTP id 7so280303pxi.36
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 03:10:19 -0800 (PST)
In-Reply-To: <AANLkTi=OC4ydAtrxNK4Jd_CDo9eLayRusOm9CNM_JFei@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin@linaro.org]
> Sent: Wednesday, December 08, 2010 4:35 PM
> To: Santosh Shilimkar
> Cc: Tony Lindgren; linux-omap@vger.kernel.org; linaro-
> dev@lists.linaro.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi(=
)
> forCONFIG_THUMB2_KERNEL
>
> On Wed, Dec 8, 2010 at 10:45 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> >> -----Original Message-----
> >> From: Dave Martin [mailto:dave.martin@linaro.org]
> >> Sent: Wednesday, December 08, 2010 4:11 PM
> >> To: Santosh Shilimkar
> >> Cc: linux-arm-kernel@lists.infradead.org; Tony Lindgren; linux-
> >> omap@vger.kernel.org; linaro-dev@lists.linaro.org
> >> Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of
do_wfi()
> >> forCONFIG_THUMB2_KERNEL
> >>
> >> On Wed, Dec 8, 2010 at 5:59 AM, Santosh Shilimkar
> >> <santosh.shilimkar@ti.com> wrote:
> >> > Dave,
> >> >
> >> >> -----Original Message-----
> >> >> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> >> >> Sent: Wednesday, December 08, 2010 11:27 AM
> >> >> To: Dave Martin
> >> >> Cc: linux-arm-kernel@lists.infradead.org; Tony Lindgren; linux-
> >> >> omap@vger.kernel.org; linaro-dev@lists.linaro.org
> >> >> Subject: RE: [PATCH v2 2/3] ARM: omap4: Correct definition of
> > do_wfi()
> >> >> forCONFIG_THUMB2_KERNEL
> >> >>
> >> >> > -----Original Message-----
> >> >> > From: Dave Martin [mailto:dave.martin@linaro.org]
> >> >> > Sent: Tuesday, December 07, 2010 10:21 PM
> >> >> > To: Santosh Shilimkar
> >> >> > Cc: linux-arm-kernel@lists.infradead.org; Tony Lindgren; linu=
x-
> >> >> > omap@vger.kernel.org; linaro-dev@lists.linaro.org
> >> >> > Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of
> >> do_wfi()
> >> >> > forCONFIG_THUMB2_KERNEL
> >> >> >
> >> >> > Hi,
> >> >> >
> >> >> > On Tue, Dec 7, 2010 at 6:28 AM, Santosh Shilimkar
> >> >> > <santosh.shilimkar@ti.com> wrote:
> >> >> > > Dave,
> >> >
> >> > [.....]
> >> >>
> >> >> > So anything inside #ifdef CONFIG_THUMB2_KERNEL can assume
> > v7/Thumb-2
> >> >> > capable (and hence reasonably new) tools.
> >> >> >
> >> >> > I'll follow up shortly with a patch to the generic ARM Kconfi=
g
to
> >> make
> >> >> > this explicit, so that ARCH_OMAP2 and THUMB2_KERNEL can't
> >> accidentally
> >> >> > be configured together.
> >> >> >
> >> >> sure
> >> >
> >> > When you are doing the changes can you please check if you could
> build
> >> > the THUMB2 kernel with omap2plus_defconfig. I suspect the build
will
> >> > fail.
> >>
> >> With my Kconfig patch, kconfig won't let you turn on Thumb-2 in th=
at
> >> configuration:
> >>
> >>
> >
>
http://lists.arm.linux.org.uk/lurker/message/20101207.165737.0897658f.e=
n.h
> >> tml
> >>
> >> If you want to turn on Thumb-2, you must disable ARCH_OMAP2 first.
=A0If
> >> my understanding is correct, this is the right behaviour.
> >>
> >>
> > Ofcourse it will build with ARCH_OMAP2 disabled :) (ARMv6 dependenc=
y)
> > In other words, I wanted to say that "omap2plus_defconfig" can't
> > be used as is to build THUMB kernel binary.
>
> Well, yes, that's another way of looking at it.  Anyway, I think this
> is the intended result -- is it OK for you?
>
Should be ok considering you can't do much with it. But I let Tony comm=
ent
on it.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
