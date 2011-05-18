From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 06/11] OMAP4: PM: VC: fix channel bit offset for MPU
Date: Wed, 18 May 2011 13:06:05 +0200
Message-ID: <87aaekuv36.fsf@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
	<1305695854-9638-7-git-send-email-nm@ti.com> <87d3jgwdvv.fsf@ti.com>
	<BANLkTimGiPSOyQDzoa2im3ewk9NbTjGJjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:57711 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932168Ab1ERLQn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 07:16:43 -0400
Received: by mail-ww0-f43.google.com with SMTP id 17so1301316wwb.12
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 04:16:42 -0700 (PDT)
In-Reply-To: <BANLkTimGiPSOyQDzoa2im3ewk9NbTjGJjg@mail.gmail.com> (Nishanth
	Menon's message of "Wed, 18 May 2011 04:47:09 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

[...]

>>
>>> to handle this on the fly, add a structure to describe this
>>> and use the structure for vc44xx mpu definition. use the
>>> default for rest of the domains.
>>
>> IMO, while it makes us generate a few more struct in the data, I thi=
nk
>> it's cleaner to not treat this as an exception. =C2=A0IOW, just defi=
ne
>> the channel struct(s) in each data file, so every VC has one associa=
ted
>> with it. =C2=A0Probably also need a WARN() and graceful failure duri=
ng init
>> if a channel doesn't have a channel config defined.
> ..
>
>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>> =C2=A0arch/arm/mach-omap2/vc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 35 +++++++++++++++++++----------------
>>> =C2=A0arch/arm/mach-omap2/vc.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 33 +++++++++++++++++++++++++++++++++
>>> =C2=A0arch/arm/mach-omap2/vc44xx_data.c | =C2=A0 10 ++++++++++
>>> =C2=A03 files changed, 62 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
>>> index f8185d2..2add945 100644
>>> --- a/arch/arm/mach-omap2/vc.c
>>> +++ b/arch/arm/mach-omap2/vc.c
> [..]
>>>
>>> + =C2=A0 =C2=A0 /* if there is an exception case, use the exception=
 data */
>>> + =C2=A0 =C2=A0 if (!vc->cfg_ch_data)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg_channel_data =3D &c=
fg_channel_common;
>>> + =C2=A0 =C2=A0 else
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg_channel_data =3D vc=
->cfg_ch_data;
>>
>> Based on the above, =C2=A0this block could be dropped, and...
>
> Except I will have to replicate this for OMAP3 and 4 - which is
> possible.. but replicated data which is needed only during init

Yes, but remember we are trying to keep data separated from code.
Eventually, much of this data will likely be migrated to the device
tree, so we want to be sure our data is cleanly separated from code.

> :( did not want vc pointer to contain __initdata pointer (dangling
> ones after boot)

Yes, so far, we're not using initdata for per-SoC stuff, and there have
been proposals around that.  However, moving to device tree will largel=
y
solve the per-SoC bloat issues around that.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
