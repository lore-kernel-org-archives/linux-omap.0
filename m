From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Mon, 1 Oct 2012 21:59:37 +0200
Message-ID: <CACRpkdaib2M1_UwSbyUG8qwZC2h7xaT5VU7WMj=y+h4S4LianQ@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
	<CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
	<331ABD5ECB02734CA317220B2BBEABC13EA3E24E@DBDE01.ent.ti.com>
	<CACRpkdZ_NxST-oJ=MWC5L=r8uQD_71eHUVUR85v4jfsYpqz=UQ@mail.gmail.com>
	<20121001154451.GI4840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52756 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab2JAT7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 15:59:38 -0400
Received: by weyt9 with SMTP id t9so3153988wey.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Oct 2012 12:59:37 -0700 (PDT)
In-Reply-To: <20121001154451.GI4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@wwwdotorg.org>, Grant Likely <grant.likely@secretlab.ca>, "dong.aisheng@linaro.org" <dong.aisheng@linaro.org>

On Mon, Oct 1, 2012 at 5:44 PM, Tony Lindgren <tony@atomide.com> wrote:

>> OK that is typical pinctrl driver implementation work.
>> I hope Tony can advice on this?
>
> I think we're best off to just stick to alternative named modes
> passed from device tree. For example, for GPIO wake-ups you can
> have named modes such as "default", "enabled" and "idle" where
> "idle" muxes things for GPIO wake-ups for the duration of idle.
>
> It seems that should also work for leds-gpio. And you can
> define more named modes as needed.


This is what we're doing for ux500 and should be a good model.

> You really don't want the client driver or the GPIO driver doing
> things like pull-up/down automatically as that is board specific and
> can also depend on things like externall pull resistors.

Nope. We've had instances of people getting bad leakage
because of pulling down a line where there is already a
pull-down resistor on the board :-(

>> OK so the threshold is that we need to get it right for the first
>> one and then the others will look good too.
>
> It seems we want to keep leds-gpio, gpio framework and pinctrl
> framework generic. It also seems you should be able to do
> what you're describing using the pinctrl named modes.

I think so too.

Yours,
Linus Walleij
