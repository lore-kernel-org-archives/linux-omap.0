From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [PATCH] Fix IGEPv2 second MMC channel power supply
Date: Sun, 14 Nov 2010 19:11:46 +0100
Message-ID: <AANLkTi=wJ24iqN8+tPw=AOO1H7u0oxaO=SaBh5-Lxr_m@mail.gmail.com>
References: <1289734452-31625-1-git-send-email-maz@misterjones.org>
	<14a0f1b94e21549cf4ad2f33647364e3@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:35474 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434Ab0KNSLr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Nov 2010 13:11:47 -0500
Received: by qyk12 with SMTP id 12so2892867qyk.19
        for <linux-omap@vger.kernel.org>; Sun, 14 Nov 2010 10:11:46 -0800 (PST)
In-Reply-To: <14a0f1b94e21549cf4ad2f33647364e3@secure211.sgcpanel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Marc Zyngier <maz@misterjones.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

2010/11/14 Felipe Balbi <me@felipebalbi.com>:
> Hi,
>
> On Sun, 14 Nov 2010 11:34:12 +0000, Marc Zyngier <maz@misterjones.org=
>
> wrote:
>> @@ -272,8 +273,8 @@ static struct regulator_init_data igep2_vmmc1 =3D=
 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | REGUL=
ATOR_CHANGE_MODE
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | REGUL=
ATOR_CHANGE_STATUS,
>> =C2=A0 =C2=A0 =C2=A0 },
>> - =C2=A0 =C2=A0 .num_consumer_supplies =C2=A0=3D 1,
>> - =C2=A0 =C2=A0 .consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D &igep2_vm=
mc1_supply,
>> + =C2=A0 =C2=A0 .num_consumer_supplies =C2=A0=3D 2,
>
> use ARRAY_SIZE(igep2_vmmc1_supplies),
>
> --
> balbi
>

Why we need to define an unexistent regulator in board file ? This
should not be done enabling the CONFIG_DUMMY_REGULATOR in your kernel
configuration  ?

Cheers,
   Enric
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
