From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] OMAP1: clock_data: use runtime cpu / machine checks
Date: Fri, 17 Dec 2010 21:14:53 -0800
Message-ID: <AANLkTi=t4gpG-+PV04+cJ35nSn_QeaZyQXDrMeCCqQYH@mail.gmail.com>
References: <201012112150.33831.jkrzyszt@tis.icnet.pl> <alpine.DEB.2.00.1012130220430.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53267 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab0LRFPP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 00:15:15 -0500
Received: by wwa36 with SMTP id 36so1345860wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 21:15:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012130220430.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Mon, Dec 13, 2010 at 1:24 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Janusz, Cory,
>
> On Sat, 11 Dec 2010, Janusz Krzysztofik wrote:
>
>> Otherwise multi-omap1 configurations may set wrong clock speed.
>>
>> Created and tested against l-o master on Amstrad Delta.
>>
>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>
> Thanks, this is a significant step forward in building a good
> omap1_defconfig. =C2=A0Cory, do you mind testing this out? =C2=A0If i=
t works for you
> also, let's plan to take this for 2.6.38.
>
> However:
>
>> Tested with omap1_defconfig after dropping
>> CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER=3Dy and those of 12MHz xtal bas=
ed
>> clock speeds which are too high for my board.
>
> This is also key. =C2=A0Until the board files can somehow indicate wh=
ich rate
> sets are usable for their boards at runtime -- which is what the
> CONFIG_OMAP_ARM* KConfig options used to do at KConfig-time -- I don'=
t
> think omap1_defconfig is possible yet.
>
> Volunteers to tackle that project are gladly welcome :-)
>
>
> - Paul
>

This doesn't seem to work for me.  Using my own config, it'll boot
fine, but the omap1_defconfig, even after making the above changes,
still fails to boot.  I'll see if I can figure out what makes it stop.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
