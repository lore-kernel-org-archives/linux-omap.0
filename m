From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Thu, 17 Nov 2011 09:08:40 +0100
Message-ID: <CACRpkdYuw+AfVtgfsbpkd=uvfWd8yE-n25EC0FDffhiGUS2MBw@mail.gmail.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
	<1321274409-24643-2-git-send-email-rnayak@ti.com>
	<20111114172312.GI31337@atomide.com>
	<4EC1EB9D.1000503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34733 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab1KQIIl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Nov 2011 03:08:41 -0500
Received: by ggnb2 with SMTP id b2so723211ggn.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 00:08:40 -0800 (PST)
In-Reply-To: <4EC1EB9D.1000503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linus.walleij@stericsson.com

On Tue, Nov 15, 2011 at 5:33 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Monday 14 November 2011 10:53 PM, Tony Lindgren wrote:
>> * Rajendra Nayak<rnayak@ti.com> =A0[111114 04:05]:
>>>
>>> > =A0+static const struct pinctrl_pin_desc omap4_core_pads[] =3D {
>>> > =A0+ =A0 =A0PINCTRL_PIN(0, "c12"),
>>> > =A0+ =A0 =A0PINCTRL_PIN(1, "d12"),
>>> > =A0+ =A0 =A0PINCTRL_PIN(2, "c13"),
>> ...
>>
>> Let's not even plan on adding this data here. We already have
>> about 6000 lines of pinmux data for omaps even without this patch.
>>
> But the plan is to get rid of those 6000 lines of pinmux data that
> exists today for OMAP. I did not remove it now, because I still need
> to take care of the pull up/down configurations which are missing.
> Once thats in place, we can get rid of the existing data completely.
>
> Linus,
> Is there a plan to move even the data that exists in the pinmux
> drivers today (including the function/pin-groups definition)
> eventually to DT? Or is it just the 'mapping' data to map
> devices to functions (that today is done from board files) which
> alone will be moved?

Not for the U300 driver, for the simple reason that it cannot
use device tree. So both methods of providing the data need
to be allowed - either as static data (the U300 driver does not
even have platform data, the pin data is encoded in the driver
itself since it's tied to U300 and not used for any other systems
or variants) or as device tree lookups.

That said I have no clue on how to make the DT bindings
=46TM, patches and suggestions welcome.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
