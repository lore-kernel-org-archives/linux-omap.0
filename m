From: Ricardo Salveti <rsalveti@rsalveti.net>
Subject: Re: [PATCH 0/7] omap4: Fixes, hacks for es2.0
Date: Mon, 13 Sep 2010 15:51:38 -0300
Message-ID: <AANLkTing5cmd+-7URxcyDnAktm3LKFzj0FX81woisH86@mail.gmail.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
	<87fwxjx7qj.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD17EDFA@dbde02.ent.ti.com>
	<87y6bavrn3.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD17EE0A@dbde02.ent.ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F026BF@dbde02.ent.ti.com>
	<AANLkTimJ+tHk7ZPmPkuwHi2svU0Qw_SqGHazn4W=_ApC@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F0273D@dbde02.ent.ti.com>
	<AANLkTim6yki=wj73K1+Tv=SZ877YLXBrXrBCLnAn6P7o@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F02F22@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61411 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab0IMSvj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 14:51:39 -0400
Received: by eyb6 with SMTP id 6so2845930eyb.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Sep 2010 11:51:38 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F02F22@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Bryan Wu <bryan.wu@canonical.com>

On Mon, Sep 13, 2010 at 12:06 PM, Ghorai, Sukumar <s-ghorai@ti.com> wro=
te:
>> >> > [Ghorai] I have tested MMC/SD boot using omap3_defconfig on ZOO=
M3,
>> 4430
>> >> ES2.0 SDP, Blaze and Panda and all booting fine.
>> >> >
>> >> > And omap_4430sdp_defconfig also ok omap4.
>> >>
>> >> Which Panda version are you using during your tests? I tried
>> >> omap_4430sdp_defconfig using omap4-for-tony branch at my ES2.0 an=
d I'm
>> >> unable to detect the MMC.
>> >>
>> >> Do I need any other patch to make the MMC work with Panda?
>> > [Ghorai] I have tested based on following tree/branch and using ES=
2.0
>> PANDA only. Can you share bootlog enabling mmc/sd debug message?
>> > http://dev.omapzoom.org/?p=3Dsantosh/kernel-omap4-
>> base.git;a=3Dshortlog;h=3Drefs/heads/omap4-for-tony
>>
>> My boot log:
>> http://paste.ubuntu.com/491645/
>>
> [Ghorai] can you use this bootargs?
> setenv bootargs root=3D/dev/mmcblk0p2 rw rootwait mem=3D463M console=3D=
ttyS2,115200n8
> And here is the log from my setup.
> [ =C2=A0 =C2=A02.493194] Waiting for root device /dev/mmcblk0p2...
> [ =C2=A0 =C2=A02.502960] mmc0: host does not support reading read-onl=
y switch. assuming write-enable.
> [ =C2=A0 =C2=A02.523895] mmc0: new high speed SDHC card at address e1=
ed
> [ =C2=A0 =C2=A02.531616] mmcblk0: mmc0:e1ed SD04G 3.75 GiB
> [ =C2=A0 =C2=A02.539550] =C2=A0mmcblk0: p1 p2
> [ =C2=A0 =C2=A02.607360] EXT3-fs: barriers not enabled
>
>> Using x-loader from
>> http://gitorious.org/pandaboard/x-loader/commits/omap4_panda_L24.9 a=
nd
>> upstream u-boot.
> [Ghorai] can you try with this x-loader
> https://docs.google.com/leaf?id=3D0B8fdjBBEQ4lDZGE3ZTBjNzEtOTQ0Ni00Zm=
=46lLTlhODgtN2QzNjUwMzBkNDI2&hl=3Den
> In the mean time I will try with yours!

I'm unable to boot with your x-loader at my ES2.0 (6 and 8 layers),
however I'm able to boot it with ES1. Are you sure you're testing it
at an ES2 board?

This is what I get, it just hangs:
Texas Instruments X-Loader 1.41 (Aug 11 2010 - 10:51:13)
Could not read bootloader!
X-Loader hangs

Cheers,
--=20
Ricardo Salveti de Araujo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
