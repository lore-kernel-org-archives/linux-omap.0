From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 09/13] OMAP3: PM: Apply errata i540 before save secure ram
Date: Fri, 19 Nov 2010 13:54:32 +0100
Message-ID: <AANLkTikCwf0AR0v4ncfjptG=qRrH3Hs47RhDHK-zDkyG@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<1290131698-6194-10-git-send-email-nm@ti.com>
	<AANLkTi=Biq8y_FQunP9ih9fO1csvwkX_sCPR7yLA+n3U@mail.gmail.com>
	<4CE669B8.3040002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34092 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab0KSMyd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 07:54:33 -0500
Received: by qyk33 with SMTP id 33so4781qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 04:54:32 -0800 (PST)
In-Reply-To: <4CE669B8.3040002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

On Fri, Nov 19, 2010 at 1:12 PM, Nishanth Menon <nm@ti.com> wrote:
> Jean Pihet wrote, on 11/19/2010 04:09 AM:
> [...]
>>>
>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm3=
4xx.c
>>> index f520b38..c7e2db0 100644
>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>> @@ -422,6 +422,14 @@ void omap_sram_idle(void)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap=
3_per_save_context();
>>> =A0 =A0 =A0 =A0}
>>>
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* We need to disable the autoidle bit from MPU INT=
C,
>>> + =A0 =A0 =A0 =A0* otherwise INTC would get stall, and we would nev=
er
>>> + =A0 =A0 =A0 =A0* come out of WFI. This is done here because
>>> + =A0 =A0 =A0 =A0* save secure ram also does WFI.
>>> + =A0 =A0 =A0 =A0*/
>>
>> The comment should mention the errata ID i540, for easier readabilit=
y
>> and maintenance.
>
> Thanks for your review. I agree + I was given an offline feedback:
>
> 1 bug =3D Erratum
> 1+ bug =3D Errata
Argh I did the same mistake. My latin lessons must be too for away now =
;-)

>
> ;) I should be fixing my grammar throughout all patches - so I believ=
e they
> all become Erratum ID: etc.. will try to fix them as well in my v2.
>

Thanks,
Jean

>
> --
> Regards,
> Nishanth Menon
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
