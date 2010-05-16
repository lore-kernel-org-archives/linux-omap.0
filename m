From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 2/6] DSPBRIDGE: remember mapping and page info in
	proc_map
Date: Mon, 17 May 2010 02:00:50 +0300
Message-ID: <AANLkTings2eFLq9wrQ9G145l6jk_fTNT-c2GIR2NW5Co@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<1272746671-13423-3-git-send-email-ohad@wizery.com> <AANLkTilh4LfJKp7S3Xt29Noghzixtk-z3RuKzGcLC5xL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41439 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab0EPXBL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 19:01:11 -0400
Received: by gwaa20 with SMTP id a20so181389gwa.19
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 16:01:10 -0700 (PDT)
In-Reply-To: <AANLkTilh4LfJKp7S3Xt29Noghzixtk-z3RuKzGcLC5xL@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Hi Felipe,

On Sat, May 15, 2010 at 11:34 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, May 1, 2010 at 11:44 PM, Ohad Ben-Cohen <ohad@wizery.com> wro=
te:
>> Every time the MM application calls proc_map to map
>> a memory area, remember the details of that mapping,
>> together with the related page structures.
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> ---
>> If you want, you can also reach me at < =A0ohadb at ti dot com =A0>.
>
>> @@ -948,6 +949,7 @@ static dsp_status bridge_dev_create(OUT struct w=
md_dev_context **ppDevContext,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D DSP_EMEMORY;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto func_end;
>> =A0 =A0 =A0 =A0}
>> +
>> =A0 =A0 =A0 =A0status =3D cfg_get_host_resources((struct cfg_devnode=
 *)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0drv_get_first_dev_extension(),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0&resources);
>
> Completely unrelated change. Moreover, this creates conflicts on
> future commits since that code is gone.

Which change are you referring to ? This is merely a newline :)
Or are you referring to something else ?

Thanks,
Ohad.

>
> --
> Felipe Contreras
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
