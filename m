From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi() forCONFIG_THUMB2_KERNEL
Date: Wed, 8 Dec 2010 16:15:15 +0530
Message-ID: <289b46ad4e4f4a05b6636134e446010c@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org><1291656937-24992-3-git-send-email-dave.martin@linaro.org><a86d8e4b47fad17e71d0202f3c469868@mail.gmail.com><AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com><2080abb418a8d3c651dd41353ef59d25@mail.gmail.com><d9fec68fc0ce14215439c6e753871bc2@mail.gmail.com>
 <AANLkTim-tdF83gnQ-0o0i7bp7QmQHoT_KbZMHrWTE12g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38414 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753527Ab0LHKpS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 05:45:18 -0500
Received: by pvb32 with SMTP id 32so338327pvb.7
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 02:45:17 -0800 (PST)
In-Reply-To: <AANLkTim-tdF83gnQ-0o0i7bp7QmQHoT_KbZMHrWTE12g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin@linaro.org]
> Sent: Wednesday, December 08, 2010 4:11 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel@lists.infradead.org; Tony Lindgren; linux-
> omap@vger.kernel.org; linaro-dev@lists.linaro.org
> Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi()
> forCONFIG_THUMB2_KERNEL
>
> On Wed, Dec 8, 2010 at 5:59 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> > Dave,
> >
> >> -----Original Message-----
> >> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> >> Sent: Wednesday, December 08, 2010 11:27 AM
> >> To: Dave Martin
> >> Cc: linux-arm-kernel@lists.infradead.org; Tony Lindgren; linux-
> >> omap@vger.kernel.org; linaro-dev@lists.linaro.org
> >> Subject: RE: [PATCH v2 2/3] ARM: omap4: Correct definition of
do_wfi()
> >> forCONFIG_THUMB2_KERNEL
> >>
> >> > -----Original Message-----
> >> > From: Dave Martin [mailto:dave.martin@linaro.org]
> >> > Sent: Tuesday, December 07, 2010 10:21 PM
> >> > To: Santosh Shilimkar
> >> > Cc: linux-arm-kernel@lists.infradead.org; Tony Lindgren; linux-
> >> > omap@vger.kernel.org; linaro-dev@lists.linaro.org
> >> > Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of
> do_wfi()
> >> > forCONFIG_THUMB2_KERNEL
> >> >
> >> > Hi,
> >> >
> >> > On Tue, Dec 7, 2010 at 6:28 AM, Santosh Shilimkar
> >> > <santosh.shilimkar@ti.com> wrote:
> >> > > Dave,
> >
> > [.....]
> >>
> >> > So anything inside #ifdef CONFIG_THUMB2_KERNEL can assume
v7/Thumb-2
> >> > capable (and hence reasonably new) tools.
> >> >
> >> > I'll follow up shortly with a patch to the generic ARM Kconfig to
> make
> >> > this explicit, so that ARCH_OMAP2 and THUMB2_KERNEL can't
> accidentally
> >> > be configured together.
> >> >
> >> sure
> >
> > When you are doing the changes can you please check if you could build
> > the THUMB2 kernel with omap2plus_defconfig. I suspect the build will
> > fail.
>
> With my Kconfig patch, kconfig won't let you turn on Thumb-2 in that
> configuration:
>
>
http://lists.arm.linux.org.uk/lurker/message/20101207.165737.0897658f.en.h
> tml
>
> If you want to turn on Thumb-2, you must disable ARCH_OMAP2 first.  If
> my understanding is correct, this is the right behaviour.
>
>
Ofcourse it will build with ARCH_OMAP2 disabled :) (ARMv6 dependency)
In other words, I wanted to say that "omap2plus_defconfig" can't
be used as is to build THUMB kernel binary.

Thanks for conforming.
