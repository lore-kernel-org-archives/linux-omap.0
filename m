From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: next boot: 34 pass, 5 fail (next-20140122)
Date: Fri, 24 Jan 2014 21:51:14 +0100
Message-ID: <52E2D242.3080307@epfl.ch>
References: <52e06652.c103450a.79d7.6517@mx.google.com> <CAGa+x86=gKh11g1pzLqxdimeCxuZ478+ZAxd9GjO-m7Aa8L2fg@mail.gmail.com> <52E0B569.8000809@ti.com> <52E0CF58.5040109@epfl.ch> <52E0DA13.9090302@ti.com> <52E0DD9F.8000100@epfl.ch> <52E0E3D1.5050202@epfl.ch> <52E10AB4.9060002@ti.com> <52E144BC.4000900@epfl.ch> <20140123173500.GI7993@atomide.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:55548 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbaAXUvT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jan 2014 15:51:19 -0500
In-Reply-To: <20140123173500.GI7993@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@linaro.org>, kernel-build-reports@lists.linaro.org, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Ash Charles <ash@gumstix.com>



On 01/23/2014 06:35 PM, Tony Lindgren wrote:
> * Florian Vaussard <florian.vaussard@epfl.ch> [140123 08:37]:
>> On 01/23/2014 01:27 PM, Tero Kristo wrote:
>>>>>>>
>>>>>>> The problem is that the Overo (processor card on the Tobi extension
>>>>>>> board) can have a variety of processor depending on the exact model:
>>>>>>>
>>>>>>> - OMAP 35xx (1st generation: Air, Earth, Fire, Sand, Tide, Water, FE)
>>>>>>> - OMAP 3730
>>>>>>> - AM/DM 37xx
> 
> With the legacy booting, the real problem is that board-overo.c is
> trying to boot all overos with just one machine ID. Tero's patch works
> around that issue for legacy booting, but maybe it's best to do the SoC
> detection in the board-*.c files in init_early as needed rather than
> patch all the board-*.c files.
> 
> Sounds like we need to do the same for legacy booting for the original
> beagle as well?
> 
>> Ok, so with your patch and changing the include from omap34xx to
>> omap36xx, it works. Now I have to come up with a way to manage all the
>> versions without duplicating all the DT files :-(
> 
> Yeah there's no quick fix here that's suitable in the long run. The
> proper fix is to have minimal SoC specific .dts files for the
> supported overo variants that include the common board specific
> .dtsi file(s).
> 
> We did a similar thing recently for the compulab variants, see
> commit 0f0cfc69547e (ARM: dts: Add support for sbc-3xxx with cm-t3730)
> for example. Also take a look at the follo-up patches posted to
> the mailing list.
> 

I agree with your approach. But in my case, I have N x M combinations (N
Overo variants, M expansion boards). Currently we have something like 2
x 10, so having ~20 dts files (not counting all the common dtsi files)
will start to get really messy. And this will only get worst as time
goes by (more expansion boards, and maybe other pin-compatible Overo).

> With device tree based booting we don't want to build data into the
> kernel for all the SoC variants for things like clocks, pinctrl and
> hwmod. And we already need to define SoC specific things in the .dts
> files for pinctrl with clocks and hwmod heading that way too, so
> relying on the built-in kernel data won't work in the long run.
> 
> If we really wanted to, we could set some devices to disabled state
> in the bootloader or in the kernel and rely on the SoC detection. But
> then we're back to building all the data into the kernel. And we
> won't be able to boot new SoC variants with just .dts changes in
> the long run like device tree is supposed to do.
> 

Data must by in the dts file, but what is needed is a mechanism similar
to the hardware connector: the Overo's dts should be combined with the
expansion board's dts (at runtime, or offline). Overlays seem a good
candidate, but I have no experience with them. As I said to Nishanth in
the other thread, overlays are fused by the userspace in the case of
BeagleBone AFAIK. But I need them early in the boot process (otherwise,
no NIC, thus no NFS or similar goodies). I need to think more on this.

Regards,

Florian
