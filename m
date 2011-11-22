From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Tue, 22 Nov 2011 13:05:43 +0100
Message-ID: <CACRpkdax0GK=mNNao7FPc6JG0RwVywSEzGJPC_u73iJ_eOTgqQ@mail.gmail.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
	<1321274409-24643-2-git-send-email-rnayak@ti.com>
	<20111114172312.GI31337@atomide.com>
	<4EC1EB9D.1000503@ti.com>
	<CACRpkdYuw+AfVtgfsbpkd=uvfWd8yE-n25EC0FDffhiGUS2MBw@mail.gmail.com>
	<CAJuYYwSgzkDed5-R=PaBR_F6ssj_EhxLDfCREXUA=UaynkgZyg@mail.gmail.com>
	<CACRpkdbBQoOU8hyew6tXth3Ohrg5_rN7M+tbVsYFcOjgq73aCw@mail.gmail.com>
	<CAJuYYwT_useS-8cH+qfDu5t7wh73yUuJAVXMjP5CXBS2VM3bag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37275 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab1KVMFo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 07:05:44 -0500
In-Reply-To: <CAJuYYwT_useS-8cH+qfDu5t7wh73yUuJAVXMjP5CXBS2VM3bag@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linus.walleij@stericsson.com, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org

On Tue, Nov 22, 2011 at 12:09 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> On 17 November 2011 19:27, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> Maybe I'm mistaken about the device tree ambitions, but
>> I was sort of hoping that it would not contain too much
>> custom magic numbers that need to be cross-referenced
>> elsewhere ... or rather - the more understandable the device
>> tree is, the more we win.
>
> Device tree is expected to describe the hardware. So to
> cross-reference the hardware manual to understand device tree should
> be fine I guess. For instance, GPIO numbers in dts would be written as
> a numeric number and not a enum or other format. And by looking up the
> manual, we understand the actual details of the GPIO pin.
>
> If dt-compiler had a option to support #define like in C, the numbers
> could have been made more easier to understand. Like, 3 to mean
> GPIO_PULL_UP in Exynos dts file.

OK I think I get it now, so DT bindings shall really NOT be read
by any of the pinctrl core, it is *supposed* to be all driver-specific.
Then it makes perfect sense to have it as it is.

So for example in the pinctrl-coh901xxx.c example driver I have
locally defined registers presets like:

#define U300_FLOATING_INPUT { \
        .bias_mode = PIN_CONFIG_BIAS_HIGH_IMPEDANCE, \
        .output = false, \
}

#define U300_PULL_UP_INPUT { \
        .bias_mode = PIN_CONFIG_BIAS_PULL_UP, \
        .output = false, \
}

Then this type of stuff shall keep its custom format in the device
tree, and the driver for coh901xxx reads that out.

Thanks for helping me understand this crucial assumption of how
it works...

Yours,
Linus Walleij
