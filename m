From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] OMAP4: Pandaboard: Fixing MMC card detect gpio line
Date: Fri, 17 Dec 2010 11:50:29 -0600
Message-ID: <AANLkTim_vp6VsdZtN+3ehWuDyw2TE4+x_+f0KZ3Mn6EB@mail.gmail.com>
References: <1291723986-24658-1-git-send-email-raghuveer.murthy@ti.com> <4CFFB704.3030905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46385 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754883Ab0LQRuu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 12:50:50 -0500
Received: by mail-wy0-f171.google.com with SMTP id 38so918976wyb.30
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 09:50:49 -0800 (PST)
In-Reply-To: <4CFFB704.3030905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Anders <x0132446@ti.com>, Tony L <tony@atomide.com>
Cc: "Murthy, Raghuveer" <raghuveer.murthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Dec 8, 2010 at 10:49, David Anders <x0132446@ti.com> wrote:
> On 12/07/2010 06:13 AM, Murthy, Raghuveer wrote:
>>
>> The .gpio_cd member of omap2_hsmmc_info is not initialized. This
>> will default to zero. On Pandaboard this interferes with gpio line
>> assigned for powering TFP410 DVI chip.
>>
>> This fix was missed out in the previous commit bf56f0a6668cd, from
>> Nishanth Menon
>>
>> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
>> Signed-off-by: Raghuveer Murthy<raghuveer.murthy@ti.com>
>> Acked-by: Nishanth Menon<nm@ti.com>
>>
>
> Tested-by: David Anders <x0132446@ti.com>
Tony,
this is a regression introduced in my commit for .37-rc1. any chance
of this making to one of 37 rc cycles? I can re-post this patch
including l-a if that is the path you'd like.

Regards,
Nishanth Menon


>
>> ---
>> =A0arch/arm/mach-omap2/board-omap4panda.c | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c
>> b/arch/arm/mach-omap2/board-omap4panda.c
>> index ad6b5cc..0ccc24f 100644
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -142,6 +142,7 @@ static struct omap2_hsmmc_info mmc[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.caps =A0 =A0 =A0 =A0 =A0 =3D MMC_CAP=
_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
>> =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0{} =A0 =A0 =A0/* Terminator */
>> =A0};
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
