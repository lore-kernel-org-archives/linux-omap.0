From: Ricardo Salveti <rsalveti@rsalveti.net>
Subject: Re: [PATCH 0/7] omap4: Fixes, hacks for es2.0
Date: Fri, 10 Sep 2010 12:03:41 -0300
Message-ID: <AANLkTimJ+tHk7ZPmPkuwHi2svU0Qw_SqGHazn4W=_ApC@mail.gmail.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
	<87fwxjx7qj.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD17EDFA@dbde02.ent.ti.com>
	<87y6bavrn3.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD17EE0A@dbde02.ent.ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F026BF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35933 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab0IJPDn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 11:03:43 -0400
Received: by wwb34 with SMTP id 34so868644wwb.1
        for <linux-omap@vger.kernel.org>; Fri, 10 Sep 2010 08:03:42 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026BF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Fri, Sep 10, 2010 at 7:30 AM, Ghorai, Sukumar <s-ghorai@ti.com> wrot=
e:
>
>
>> -----Original Message-----
> [..snip..]
>> > >>
>> > >> > The series is boot tested tested on 4430 SDP, Blaze with
>> > >> > omap_4430sdp_defconfig with file over NFS and MMC.
>> > >> >
>> > >> > Also boot tested omap3_defconfig with ramdisk on OMAP4 and OM=
AP3
>> > >> > SDPs. Same observation with Panda
>> > >> >
>> > >> > With omap3_defconfig, MMC while mounting the rootfs over MMC,=
 the
>> > >> > boot hangs. Same observation with Panda
>> > >>
>> > >> On my ES2.0 Panda, rootfs on MMC is now working with this serie=
s.
>> > >>
>> > > I observed the same with MMC. Ramdisk boot worked for me on PAND=
A.
>> >
>> > Note that I said "now working". =C2=A0I think you read my message =
as "not
>> > working."
>> >
>> Yes I read it otherway ... Second time today :)
>>
>> > IOW, rootfs on MMC *is* working for me on my es2.0 Panda. =C2=A0 I=
 applied
>> > your series to current l-o master, and it works.
>> >
>> Cool!!
>
> [Ghorai] I have tested MMC/SD boot using omap3_defconfig on ZOOM3, 44=
30 ES2.0 SDP, Blaze and Panda and all booting fine.
>
> And omap_4430sdp_defconfig also ok omap4.

Which Panda version are you using during your tests? I tried
omap_4430sdp_defconfig using omap4-for-tony branch at my ES2.0 and I'm
unable to detect the MMC.

Do I need any other patch to make the MMC work with Panda?

Thanks,
--=20
Ricardo Salveti de Araujo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
