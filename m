From: Olof Johansson <olof@lixom.net>
Subject: Re: OMAP34xx
Date: Sat, 4 Feb 2012 11:23:06 -0800
Message-ID: <CAOesGMiboY+7QwfhkbHD3uA8-5Lb8c8ZY+Jwm8__QPLN2L7YdA@mail.gmail.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
	<20120204190109.GL20333@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56886 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab2BDTXH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 14:23:07 -0500
Received: by ghrr11 with SMTP id r11so2132346ghr.19
        for <linux-omap@vger.kernel.org>; Sat, 04 Feb 2012 11:23:06 -0800 (PST)
In-Reply-To: <20120204190109.GL20333@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Sat, Feb 4, 2012 at 11:01 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 10:24]:
>> Does someone want to try building and running Linux on (eg) an OMAP3=
4xx
>> platform before I post my next email message on this subject, and
>> maybe send me a bunch of patches required to fix stuff, to be applie=
d
>> to my tree _and_ _then_ forwarded to Linus next Friday.
>>
>> So, think of this as your last chance, and you'll get the picture ab=
out
>> how pissed off I am with the - yet again - current poor state of OMA=
P
>> in mainline, which seems to happen every merge window.
>>
>> Consider this: when Linus started using a PowerPC platform, the Powe=
rPC
>> people quickly realized that pushing patches upstream which broke st=
uff
>> was a really bad idea, because they got publically flamed for such
>> actions especially when stuff was not obviously tested.
>>
>> This is no different... and this is _not_ my original email which I =
have
>> queued up with the real hot flames in over this. =A0This is the tone=
d down
>> version. =A0The flames won't get sent if OMAP gets fixed quickly - a=
nd if
>> testing improves to stop this constant cycle of regressions at every
>> merge window.
>
> Do you have the patches applied already queued up in arm-soc fixes
> branch?

I've been sitting on those longer than I meant to, my bad. I'll send a
pull request to Linus in a little bit.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
