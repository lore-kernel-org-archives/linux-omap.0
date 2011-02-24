From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: omap dss tft display connection
Date: Thu, 24 Feb 2011 11:56:15 +0100
Message-ID: <AANLkTikn6YiQoJir_=1qWPv62wSZCic=9aCQyLeV=k0k@mail.gmail.com>
References: <AANLkTinPiAg8zVkW6Z0UsvDO57UwFSyVEbbjkwj4=EXh@mail.gmail.com>
	<1298543951.16119.63.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46073 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571Ab1BXK4Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 05:56:16 -0500
Received: by vws12 with SMTP id 12so300241vws.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 02:56:15 -0800 (PST)
In-Reply-To: <1298543951.16119.63.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Toomi,

On Thu, Feb 24, 2011 at 11:39 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> On Thu, 2011-02-24 at 04:05 -0600, Belisko Marek wrote:
>> Hello,
>>
>> would be possible to configure dss on omap3530 which is connected to
>> 18bit TFT display in such way:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A08 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08
>> | | | | | | | |-| | | | | | | |-| | | | | | | |
>> =C2=A0 =C2=A0 6 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 6
>> | | | | | |-| | | | | |-| | | | | |
>>
>> So no standard connection (2 bits in every color are skipped) but it=
's
>> shifted so last 6 bits remain unused.
>> When use generic panel it seems I have no red color (just combinatio=
n
>> of blue and green).
>>
>> It is anyway possible to drive such a connection? Or HW needs to ne =
changed?
>
> Can you explain a bit more what you are trying to do? At least I didn=
't
> quite understand =3D).
Sorry maybe my question wasn't clear ;). I have mini8100 board
connected to 18bit
hitachi TX18D35 connected in way I described in first email (LCD
datalines connected to
lower 18 bits dss data lines).

So my question was what to change (only .phy.dpi.data_lines =3D 18 is e=
nought?)
to keep driving my display correctly ;)

I try that option but no visible change.

Hopefully better description like before ;)

>
> Why don't you use the 18bit TFT with 18 datalines?
>
> =C2=A0Tomi
>
>
>

thanks,

marek

--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
