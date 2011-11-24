From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Thu, 24 Nov 2011 05:07:37 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A803F09A@DBDE01.ent.ti.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
 <1321274409-24643-2-git-send-email-rnayak@ti.com>
 <20111114172312.GI31337@atomide.com> <4EC1EB9D.1000503@ti.com>
 <CACRpkdYuw+AfVtgfsbpkd=uvfWd8yE-n25EC0FDffhiGUS2MBw@mail.gmail.com>
 <CAJuYYwSgzkDed5-R=PaBR_F6ssj_EhxLDfCREXUA=UaynkgZyg@mail.gmail.com>
 <CACRpkdbBQoOU8hyew6tXth3Ohrg5_rN7M+tbVsYFcOjgq73aCw@mail.gmail.com>
 <CAJuYYwT_useS-8cH+qfDu5t7wh73yUuJAVXMjP5CXBS2VM3bag@mail.gmail.com>
 <CACRpkdax0GK=mNNao7FPc6JG0RwVywSEzGJPC_u73iJ_eOTgqQ@mail.gmail.com>
 <20111122175409.GE31337@atomide.com>
 <DD2280C9-D4E2-41FF-BDE7-9119237B62C0@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51025 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab1KXFIG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Nov 2011 00:08:06 -0500
In-Reply-To: <DD2280C9-D4E2-41FF-BDE7-9119237B62C0@dominion.thruhere.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>, Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "linus.walleij@stericsson.com" <linus.walleij@stericsson.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Koen Kooi
> Sent: Wednesday, November 23, 2011 8:51 PM
> To: Tony Lindgren
> Cc: Linus Walleij; Thomas Abraham; Nayak, Rajendra; linux-
> omap@vger.kernel.org; linaro-dev@lists.linaro.org;
> linus.walleij@stericsson.com; linux-samsung-soc; devicetree-
> discuss@lists.ozlabs.org
> Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
> 
> 
> Op 22 nov. 2011, om 18:54 heeft Tony Lindgren het volgende geschreven:
> 
> > * Linus Walleij <linus.walleij@linaro.org> [111122 03:30]:
> >> On Tue, Nov 22, 2011 at 12:09 PM, Thomas Abraham
> >> <thomas.abraham@linaro.org> wrote:
> >>> On 17 November 2011 19:27, Linus Walleij <linus.walleij@linaro.org>
> wrote:
> >>>>
> >>>> Maybe I'm mistaken about the device tree ambitions, but
> >>>> I was sort of hoping that it would not contain too much
> >>>> custom magic numbers that need to be cross-referenced
> >>>> elsewhere ... or rather - the more understandable the device
> >>>> tree is, the more we win.
> >>>
> >>> Device tree is expected to describe the hardware. So to
> >>> cross-reference the hardware manual to understand device tree should
> >>> be fine I guess. For instance, GPIO numbers in dts would be written as
> >>> a numeric number and not a enum or other format. And by looking up the
> >>> manual, we understand the actual details of the GPIO pin.
> >>>
> >>> If dt-compiler had a option to support #define like in C, the numbers
> >>> could have been made more easier to understand. Like, 3 to mean
> >>> GPIO_PULL_UP in Exynos dts file.
> >>
> >> OK I think I get it now, so DT bindings shall really NOT be read
> >> by any of the pinctrl core, it is *supposed* to be all driver-specific.
> >> Then it makes perfect sense to have it as it is.
> >
> > Yes the driver nodes should describe in DT which pins to use:
> >
> >        serial@12340000 {
> >                compatible = "8250";
> >                reg = <0x12340000 0x40>;
> >                reg-shift = <2>;
> >                interrupts = < 10 >;
> > 		pins = "uart1_rx", "uart1_tx";
> >        };
> >
> > Note that we should use the actual signal names, not package specific
> > pad names. This way they have a high likelyhood to work for new packages
> > too by just mapping the signals to the new package.
> 
> How would this handle the situation where you can mux a signal to multiple
> pins? IIRC omap3 and am335x can do funny stuff with the display pins like
> being able to map the blue bits to different pinblocks.
> 
That's quite not true, in case of omap3 pins are labeled as R0-R7, B0-B7 and
G0-G7; what changes is pixel format.

AM335x LCDC is completely different IP altogether and spec doesn't map
Colors to pins. It barely maps bit0 from memory to pinX.
Now you call it as a standard or legacy or may be due to SGX software,
the pixel format we use is BGR (as in memory). 
It is completely depends on how you interface the pins to LCD (considering)
Software support/requirement.

Thanks,
Vaibhav


> regards,
> 
> Koen
