From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [PATCH (for-next)] ASoC: Add support for IGEP v2
Date: Wed, 18 Nov 2009 10:11:34 +0100
Message-ID: <70c9a9110911180111k4c4e889cx93a1187e27cb5984@mail.gmail.com>
References: <1258479067-2564-1-git-send-email-eballetbo@gmail.com>
	 <4B03B7B2.9090401@compulab.co.il>
	 <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA9BB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:61413 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbZKRJL3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 04:11:29 -0500
Received: by fxm21 with SMTP id 21so911556fxm.21
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 01:11:34 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA9BB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Mike Rapoport <mike@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

> This part isn't relevant to ASoC. Shouldn't it go separately through =
linux-omap?
>
> It could possibly get folded into the patch adding this board support=
 in the
> first place.
>
> - Anand

Oops, sorry is a mistake I will resend the patch without this.

Thanks,

Enric

2009/11/18 Gadiyar, Anand <gadiyar@ti.com>:
> Mike Rapoport wrote:
>> Enric Balletbo i Serra wrote:
>> > From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
>> >
>> >
>> > Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
>> > ---
>> > =C2=A0arch/arm/mach-omap2/Kconfig | =C2=A0 =C2=A02 +-
>> > =C2=A0sound/soc/omap/Kconfig =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A07 =
++
>> > =C2=A0sound/soc/omap/Makefile =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +
>> > =C2=A0sound/soc/omap/igep0020.c =C2=A0 | =C2=A0148 +++++++++++++++=
++++++++++++++++++++++++++++
>> > =C2=A04 files changed, 158 insertions(+), 1 deletions(-)
>> > =C2=A0create mode 100644 sound/soc/omap/igep0020.c
>> >
>> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kco=
nfig
>> > index 68866f3..6922198 100644
>> > --- a/arch/arm/mach-omap2/Kconfig
>> > +++ b/arch/arm/mach-omap2/Kconfig
>> > @@ -114,7 +114,7 @@ config MACH_OMAP_3630SDP
>> > =C2=A0 =C2=A0 depends on ARCH_OMAP3 && ARCH_OMAP34XX
>> >
>> > =C2=A0config MACH_IGEP0020
>> > - =C2=A0 bool "IGEP0020"
>> > + =C2=A0 bool "IGEP v2 board"
>> > =C2=A0 =C2=A0 depends on ARCH_OMAP3 && ARCH_OMAP34XX
>> >
>> > =C2=A0config MACH_OMAP_4430SDP
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
