From: Ricardo Salveti <rsalveti@rsalveti.net>
Subject: Re: [PATCH 0/7] omap4: Fixes, hacks for es2.0
Date: Fri, 10 Sep 2010 12:29:31 -0300
Message-ID: <AANLkTim6yki=wj73K1+Tv=SZ877YLXBrXrBCLnAn6P7o@mail.gmail.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
	<87fwxjx7qj.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD17EDFA@dbde02.ent.ti.com>
	<87y6bavrn3.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD17EE0A@dbde02.ent.ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F026BF@dbde02.ent.ti.com>
	<AANLkTimJ+tHk7ZPmPkuwHi2svU0Qw_SqGHazn4W=_ApC@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F0273D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33744 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab0IJP3d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 11:29:33 -0400
Received: by eyb6 with SMTP id 6so1766341eyb.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Sep 2010 08:29:32 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F0273D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Fri, Sep 10, 2010 at 12:09 PM, Ghorai, Sukumar <s-ghorai@ti.com> wro=
te:
>> -----Original Message-----
>> On Fri, Sep 10, 2010 at 7:30 AM, Ghorai, Sukumar <s-ghorai@ti.com> w=
rote:
>> >> -----Original Message-----
>> > [..snip..]
>> >> > >> > The series is boot tested tested on 4430 SDP, Blaze with
>> >> > >> > omap_4430sdp_defconfig with file over NFS and MMC.
>> >> > >> >
>> >> > >> > Also boot tested omap3_defconfig with ramdisk on OMAP4 and=
 OMAP3
>> >> > >> > SDPs. Same observation with Panda
>> >> > >> >
>> >> > >> > With omap3_defconfig, MMC while mounting the rootfs over M=
MC,
>> the
>> >> > >> > boot hangs. Same observation with Panda
>> >> > >>
>> >> > >> On my ES2.0 Panda, rootfs on MMC is now working with this se=
ries.
>> >> > >>
>> >> > > I observed the same with MMC. Ramdisk boot worked for me on P=
ANDA.
>> >> >
>> >> > Note that I said "now working". =C2=A0I think you read my messa=
ge as "not
>> >> > working."
>> >> >
>> >> Yes I read it otherway ... Second time today :)
>> >>
>> >> > IOW, rootfs on MMC *is* working for me on my es2.0 Panda. =C2=A0=
 I applied
>> >> > your series to current l-o master, and it works.
>> >> >
>> >> Cool!!
>> >
>> > [Ghorai] I have tested MMC/SD boot using omap3_defconfig on ZOOM3,=
 4430
>> ES2.0 SDP, Blaze and Panda and all booting fine.
>> >
>> > And omap_4430sdp_defconfig also ok omap4.
>>
>> Which Panda version are you using during your tests? I tried
>> omap_4430sdp_defconfig using omap4-for-tony branch at my ES2.0 and I=
'm
>> unable to detect the MMC.
>>
>> Do I need any other patch to make the MMC work with Panda?
> [Ghorai] I have tested based on following tree/branch and using ES2.0=
 PANDA only. Can you share bootlog enabling mmc/sd debug message?
> http://dev.omapzoom.org/?p=3Dsantosh/kernel-omap4-base.git;a=3Dshortl=
og;h=3Drefs/heads/omap4-for-tony

My boot log:
http://paste.ubuntu.com/491645/

Using x-loader from
http://gitorious.org/pandaboard/x-loader/commits/omap4_panda_L24.9 and
upstream u-boot.

Cheers,
--=20
Ricardo Salveti de Araujo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
