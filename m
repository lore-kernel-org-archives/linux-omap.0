From: Marc Zyngier <maz@misterjones.org>
Subject: Re: [PATCH] Fix IGEPv2 second MMC channel power supply
Date: Tue, 16 Nov 2010 09:20:22 +0000
Message-ID: <20101116092022.7b4ea99f@taxman.wild-wind.fr.eu.org>
References: <1289734452-31625-1-git-send-email-maz@misterjones.org>
	<14a0f1b94e21549cf4ad2f33647364e3@secure211.sgcpanel.com>
	<AANLkTi=wJ24iqN8+tPw=AOO1H7u0oxaO=SaBh5-Lxr_m@mail.gmail.com>
	<20101114185207.252e3c1f@taxman.wild-wind.fr.eu.org>
	<AANLkTimuf1khCKLc4Bc23gONxqPGmq1N3j3kSjkzccPu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from inca-roads.misterjones.org ([213.251.177.50]:46217 "EHLO
	inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934022Ab0KPJUZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 04:20:25 -0500
In-Reply-To: <AANLkTimuf1khCKLc4Bc23gONxqPGmq1N3j3kSjkzccPu@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?ISO-8859-1?B?QmFsbGV0YvI=?= i Serra <eballetbo@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Mon, 15 Nov 2010 09:32:22 +0100
Enric Balletb=F2 i Serra <eballetbo@gmail.com> wrote:

Hi Enric,
>=20
> So the DUMMY_REGULATOR is only a workaround when a regulator is not
> defined and shouldn't be used ? Sorry if this is a stupid question bu=
t
> regulator interface is not too clear for me.

My understanding is that DUMMY_REGULATOR kicks in when the regulator
setup is incomplete, and when it's better to fix things behind the
user's back rather than leaving him with a broken device.

> The reality is this :
>=20
>  -------     --------
> | 3V3 |   | 1V8 |
>  -------    --------
>     |          |
>  -----------------
> |   WIFI/BT  |
>  -----------------
>         | ( MMC2  at 1V8 )
>  ----------------
> |   OMAP   |
>  ---------------
>=20
> 3V3 is a fixed regulator
> 1V8 is a fixed regulator (VIO from TWL4030)
>=20
> So, which you think is the right solution ?

I think we should provide a fixed regulator to the device, wired to
the .vio field of twl4030_platform_data. I'll submit a patch later
today, once I get a chance to test it on my board.

Cheers,

	M.
--=20
I'm the slime oozin' out from your TV set...
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
