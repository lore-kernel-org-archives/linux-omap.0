From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi() forCONFIG_THUMB2_KERNEL
Date: Wed, 8 Dec 2010 11:25:58 +0000
Message-ID: <AANLkTinhmX_mhFAbE+CEmX+TBDn_F6O+KG01L4VqSB2t@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-3-git-send-email-dave.martin@linaro.org>
	<a86d8e4b47fad17e71d0202f3c469868@mail.gmail.com>
	<AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com>
	<2080abb418a8d3c651dd41353ef59d25@mail.gmail.com>
	<d9fec68fc0ce14215439c6e753871bc2@mail.gmail.com>
	<AANLkTim-tdF83gnQ-0o0i7bp7QmQHoT_KbZMHrWTE12g@mail.gmail.com>
	<289b46ad4e4f4a05b6636134e446010c@mail.gmail.com>
	<AANLkTi=OC4ydAtrxNK4Jd_CDo9eLayRusOm9CNM_JFei@mail.gmail.com>
	<df00a773077a1dac38b7e6b67190d8f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:45382 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab0LHL0A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 06:26:00 -0500
Received: by iwn40 with SMTP id 40so1479294iwn.3
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 03:25:59 -0800 (PST)
In-Reply-To: <df00a773077a1dac38b7e6b67190d8f9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org

On Wed, Dec 8, 2010 at 11:10 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Dave Martin [mailto:dave.martin@linaro.org]
>> Sent: Wednesday, December 08, 2010 4:35 PM
>> To: Santosh Shilimkar
>> Cc: Tony Lindgren; linux-omap@vger.kernel.org; linaro-
>> dev@lists.linaro.org; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi=
()
>> forCONFIG_THUMB2_KERNEL
>>
>> On Wed, Dec 8, 2010 at 10:45 AM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
>> >> -----Original Message-----
>> >> From: Dave Martin [mailto:dave.martin@linaro.org]
>> >> Sent: Wednesday, December 08, 2010 4:11 PM
>> >> To: Santosh Shilimkar
>> >> Cc: linux-arm-kernel@lists.infradead.org; Tony Lindgren; linux-
>> >> omap@vger.kernel.org; linaro-dev@lists.linaro.org
>> >> Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of
> do_wfi()
>> >> forCONFIG_THUMB2_KERNEL
>> >>
>> >> On Wed, Dec 8, 2010 at 5:59 AM, Santosh Shilimkar
>> >> <santosh.shilimkar@ti.com> wrote:
>> >> > Dave,
>> >> >
>> >> >> -----Original Message-----
>> >> >> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
>> >> >> Sent: Wednesday, December 08, 2010 11:27 AM
>> >> >> To: Dave Martin
>> >> >> Cc: linux-arm-kernel@lists.infradead.org; Tony Lindgren; linux=
-
>> >> >> omap@vger.kernel.org; linaro-dev@lists.linaro.org
>> >> >> Subject: RE: [PATCH v2 2/3] ARM: omap4: Correct definition of
>> > do_wfi()
>> >> >> forCONFIG_THUMB2_KERNEL
>> >> >>
>> >> >> > -----Original Message-----
>> >> >> > From: Dave Martin [mailto:dave.martin@linaro.org]
>> >> >> > Sent: Tuesday, December 07, 2010 10:21 PM
>> >> >> > To: Santosh Shilimkar
>> >> >> > Cc: linux-arm-kernel@lists.infradead.org; Tony Lindgren; lin=
ux-
>> >> >> > omap@vger.kernel.org; linaro-dev@lists.linaro.org
>> >> >> > Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition o=
f
>> >> do_wfi()
>> >> >> > forCONFIG_THUMB2_KERNEL
>> >> >> >
>> >> >> > Hi,
>> >> >> >
>> >> >> > On Tue, Dec 7, 2010 at 6:28 AM, Santosh Shilimkar
>> >> >> > <santosh.shilimkar@ti.com> wrote:
>> >> >> > > Dave,
>> >> >
>> >> > [.....]
>> >> >>
>> >> >> > So anything inside #ifdef CONFIG_THUMB2_KERNEL can assume
>> > v7/Thumb-2
>> >> >> > capable (and hence reasonably new) tools.
>> >> >> >
>> >> >> > I'll follow up shortly with a patch to the generic ARM Kconf=
ig
> to
>> >> make
>> >> >> > this explicit, so that ARCH_OMAP2 and THUMB2_KERNEL can't
>> >> accidentally
>> >> >> > be configured together.
>> >> >> >
>> >> >> sure
>> >> >
>> >> > When you are doing the changes can you please check if you coul=
d
>> build
>> >> > the THUMB2 kernel with omap2plus_defconfig. I suspect the build
> will
>> >> > fail.
>> >>
>> >> With my Kconfig patch, kconfig won't let you turn on Thumb-2 in t=
hat
>> >> configuration:
>> >>
>> >>
>> >
>>
> http://lists.arm.linux.org.uk/lurker/message/20101207.165737.0897658f=
=2Een.h
>> >> tml
>> >>
>> >> If you want to turn on Thumb-2, you must disable ARCH_OMAP2 first=
=2E
> =A0If
>> >> my understanding is correct, this is the right behaviour.
>> >>
>> >>
>> > Ofcourse it will build with ARCH_OMAP2 disabled :) (ARMv6 dependen=
cy)
>> > In other words, I wanted to say that "omap2plus_defconfig" can't
>> > be used as is to build THUMB kernel binary.
>>
>> Well, yes, that's another way of looking at it. =A0Anyway, I think t=
his
>> is the intended result -- is it OK for you?
>>
> Should be ok considering you can't do much with it. But I let Tony co=
mment
> on it.

Well, it depends on what you're trying to do.  We can't combine
Thumb-2 with a combined omap kernel intended to support omap2.  But in
linaro for example we are targeting v7+ only for the kernel and
userspace, so we already build the kernel for v7 and don't include the
OMAP2 support; instead we target OMAP3/4.  I believe the situation for
Ubuntu is similar.  In our case, including the omap2 support wouldn't
be useful, since the userspace won't run on that platform anyway...

So really, my concerns are that a) the generic rules for
CONFIG_THUMB2_KERNEL are correct, and b) the omap tree works well with
this configuration to the maximum extent possible.  Obviously, mixing
ARCH_OMAP2 with THUMB2_KERNEL _isn't_ possible even in theory, so I
don't consider it a failure if that combination isn't supported.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
