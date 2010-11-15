From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [PATCH] Fix IGEPv2 second MMC channel power supply
Date: Mon, 15 Nov 2010 09:32:22 +0100
Message-ID: <AANLkTimuf1khCKLc4Bc23gONxqPGmq1N3j3kSjkzccPu@mail.gmail.com>
References: <1289734452-31625-1-git-send-email-maz@misterjones.org>
	<14a0f1b94e21549cf4ad2f33647364e3@secure211.sgcpanel.com>
	<AANLkTi=wJ24iqN8+tPw=AOO1H7u0oxaO=SaBh5-Lxr_m@mail.gmail.com>
	<20101114185207.252e3c1f@taxman.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47605 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757675Ab0KOIcX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 03:32:23 -0500
Received: by qyk4 with SMTP id 4so1840765qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 00:32:22 -0800 (PST)
In-Reply-To: <20101114185207.252e3c1f@taxman.wild-wind.fr.eu.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <maz@misterjones.org>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hi,

2010/11/14 Marc Zyngier <maz@misterjones.org>:
> On Sun, 14 Nov 2010 19:11:46 +0100
> Enric Balletb=C3=B2 i Serra <eballetbo@gmail.com> wrote:
>
>> Why we need to define an unexistent regulator in board file ? This
>> should not be done enabling the CONFIG_DUMMY_REGULATOR in your kerne=
l
>> configuration =C2=A0?
>
> I'm not adding another regulator, but instead simply exposing the fac=
t
> (or rather my guess) that the same regulator (vmmc1) is powering the
> two MMC channels. Not having access to the board schematics, I can't
> tell if that reflects the reality or not.
>
> But using CONFIG_DUMMY_REGULATOR seems the wrong idea to me, as it's
> just papering over the issue. We should be exposing what's really on
> the board (a fixed regulator if that's the case).

So the DUMMY_REGULATOR is only a workaround when a regulator is not
defined and shouldn't be used ? Sorry if this is a stupid question but
regulator interface is not too clear for me.

The reality is this :

 -------     --------
| 3V3 |   | 1V8 |
 -------    --------
    |          |
 -----------------
|   WIFI/BT  |
 -----------------
        | ( MMC2  at 1V8 )
 ----------------
|   OMAP   |
 ---------------

3V3 is a fixed regulator
1V8 is a fixed regulator (VIO from TWL4030)

So, which you think is the right solution ?

Cheers,
   Enric
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
