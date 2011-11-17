From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Thu, 17 Nov 2011 14:57:12 +0100
Message-ID: <CACRpkdbBQoOU8hyew6tXth3Ohrg5_rN7M+tbVsYFcOjgq73aCw@mail.gmail.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
	<1321274409-24643-2-git-send-email-rnayak@ti.com>
	<20111114172312.GI31337@atomide.com>
	<4EC1EB9D.1000503@ti.com>
	<CACRpkdYuw+AfVtgfsbpkd=uvfWd8yE-n25EC0FDffhiGUS2MBw@mail.gmail.com>
	<CAJuYYwSgzkDed5-R=PaBR_F6ssj_EhxLDfCREXUA=UaynkgZyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56841 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab1KQN5N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Nov 2011 08:57:13 -0500
In-Reply-To: <CAJuYYwSgzkDed5-R=PaBR_F6ssj_EhxLDfCREXUA=UaynkgZyg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linus.walleij@stericsson.com, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org

On Thu, Nov 17, 2011 at 12:26 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> For now, the Samsung GPIO, Pinconfig and Pinmux information is
> represented in device tree as listed below.

Does this mean that the understanding of this format is merged into
the mainline kernel drivers or is it keps out-of-tree?

> i2c@1C004000 {
> =A0 =A0 =A0 =A0 =A0compatible =3D "...";
> =A0 =A0 =A0 =A0 =A0reg =3D <0x... 0x..>;
> =A0 =A0 =A0 =A0 =A0 gpios =3D <&gpa0 2 2 3 0>,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<&gpa0 3 2 3 0>;
> =A0 =A0 =A0 =A0 =A0...
> };
>
> The format of the gpio specifier is
> <[Pad Controller phandle] [pin number within the controller] [Pin Mux
> Function] [Pull Up/Down] [Drive Strength]>
>
> From a perspective of writing a 'gpios' property for a device node,
> this is quite simple. Looking up the hardware manual of the SoC can
> provide all the values that should be used in the gpio specifier.

That may not be as simple as it seems if all you have is the
device tree and no manual, but I get the picture.

> The GPIO/PinCtrl driver can provide a translate function that picks u=
p
> the values for the gpio specifier and writes the same value to the
> pad-controller registers. But, this a deviation from the existing
> pinctrl subsystem code which mainly relies on name of the pin-group
> and pin-function.
>
> Does this seem to be a feasible option for specifying
> gpio/pinconfig/pinmux dt bindings?

I would prefer the above to use the nice generic enums from the
pin control subsystem's pinmux and pinconf properties in the
end so the device tree on its own is understandable without
any manual whatsoever, but we'll see about that.

Maybe I'm mistaken about the device tree ambitions, but
I was sort of hoping that it would not contain too much
custom magic numbers that need to be cross-referenced
elsewhere ... or rather - the more understandable the device
tree is, the more we win.

Thanks,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
