From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio
Date: Mon, 21 May 2012 09:12:31 -0700
Message-ID: <CA+Bv8XZvgNws2_Eer7MwEZGVdxHFYnkvOZVHYs0kT2=8r3f5sg@mail.gmail.com>
References: <20120509163649.GN5088@atomide.com>
	<1336601703-27977-1-git-send-email-Russ.Dill@ti.com>
	<1337616478.2717.13.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58325 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755429Ab2EUQMd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 12:12:33 -0400
Received: by lahd3 with SMTP id d3so3601470lah.19
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 09:12:31 -0700 (PDT)
In-Reply-To: <1337616478.2717.13.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, chase.maupin@ti.com, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>

On Mon, May 21, 2012 at 9:07 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Wed, 2012-05-09 at 15:15 -0700, Russ Dill wrote:
>> This removes several boot warnings from board-omap3beagle.c:
>>
>> =C2=A0- gpio_request: gpio--22 (DVI reset) status -22
>> =C2=A0- Unable to get DVI reset GPIO
>>
>> There is a combination of leftover code and revision confusion.
>> Additionally, xM support is currently a hack.
>>
>> For original Beagleboard this removes the double initialization of G=
PIO
>> 170, properly configures it as an output, and wraps the initializati=
on
>> in an if block so that xM does not attempt to request it.
>>
>> For Beagleboard xM it removes reference to GPIO 129 which was part
>> of rev A1 and A2 designs, but never functioned. It then properly ass=
igns
>> beagle_dvi_device.reset_gpio in beagle_twl_gpio_setup and removes th=
e
>> hack of initializing it high. Additionally, it uses
>> gpio_set_value_cansleep since this GPIO is connected through i2c.
>>
>> Unfortunately, there is no way to tell the difference between xM A2 =
and
>> A3. However, GPIO 129 does not function on rev A1 and A2, and the TW=
L
>> GPIO used on A3 and beyond is not used on rev A1 and A2, there are n=
o
>> problems created by this fix.
>>
>> v4
>> =C2=A0- Rebase onto git://gitorious.org/linux-omap-dss2/linux.git fo=
r-l-o-3.5
>> =C2=A0- Use dvi_pd_gpio instead of reset_gpio to match with new nami=
ng
>
> Hmm, was this rebased correctly? It doesn't apply to for-l-o-3.5 bran=
ch.

It sits on top of for-l-o-3.5 and '[OMAP] Mark Beagleboard-xM MMC bus
as 4-bit'. You can cherry-pick 1afb82e4 before applying, or I can drop
that patch from the series and resend.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
