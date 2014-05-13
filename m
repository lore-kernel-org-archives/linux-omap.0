From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support
Date: Tue, 13 May 2014 13:39:55 +0200
Message-ID: <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com>
References: <20140507175919.GH9502@atomide.com>
	<20140508233300.GI2198@atomide.com>
	<536C8293.4070506@ti.com>
	<20140509155504.GE17814@atomide.com>
	<53707A64.2060203@ti.com>
	<CABxcv=kwhodeFTHoVpn1nHeh9+kV5fwMN9s3Kbk6h7_xJp4UYA@mail.gmail.com>
	<53709706.10501@ti.com>
	<CABxcv=mY0a+yJgmCTPN=BhSQD57Pw022zOd5_KxEgvvF_-=O7Q@mail.gmail.com>
	<20140512142646.GA31772@atomide.com>
	<5370E0C9.8050201@ti.com>
	<20140512155132.GH31772@atomide.com>
	<5371F923.80000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:37957 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759497AbaEMLj4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 07:39:56 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so235010wgh.14
        for <linux-omap@vger.kernel.org>; Tue, 13 May 2014 04:39:55 -0700 (PDT)
In-Reply-To: <5371F923.80000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, May 13, 2014 at 12:51 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 12/05/14 18:51, Tony Lindgren wrote:
>
>>> It's already in v3.15.
>>
>> Oh great.. And you dumped it into arch/arm/mach-omap2 too and I somehow
>> even acked it :( Looks like there's also the custom mux hacks. And
>> custom hwmod hacks. And ongoing soc_is_xxx tinkering. Now let's not add
>
> The omap2_dss_hwmod_data, create_dss_pdev and create_simple_dss_pdev,
> omap_display_init stuff can be removed when the DT conversion has been done.
>
> For the omap4_dsi_mux_pads (or the omap5 dsi muxing that was recently
> discussed) I still have no solution, but I haven't spent time on it. I
> have dropped the omap5 dsi muxing from the latest series for that reason.
>
> dispc_disable_outputs and omap_dss_reset are needed because omap_device
> doesn't handle resetting DSS properly, as special steps need to be done
> for that. omap_dss_reset is called from the hwmod/omap_device code, so I
> don't think this code can be anywhere else.
>
> For the omap_display_get_version() I have no good solution. Making
> separate .dts versions for all the needed OMAP ES versions seems like a
> huge hassle to me, but that is one solution.
>
> I think that would mean having separate .dtsi files for omapdss for
> omap3_es1, omap3_es3plus, omap4_es1, omap4_es2, omap4_es3plus, and then
> having separate omapxxxx.dtsi files for all of those, and then separate
> board .dts files for the ES versions used on each board.
>
> Or is there some sane way to define such things in dts?
>

Unfortunately there isn't.

I have a similar problem with the IGEP boards since there are just too
many variations of them (e.g: DM3730 SoC vs OMAP3530 SoC, NAND vs
OneNAND, 256MB vs 512MB flash memory sizes, with and without wifi
chip, etc).

Since dts are supposed to describe the hardware, each revision with a
slighter variation forces to have a different dts. My solution was to
not try to have a dts for every single variation in mainline but only
one for the most common revision and that could be used as a reference
to modify and ship on each device. Unfortunately that is not possible
to you since each DSS IP block is used by many boards.

>> _any_ new crap into arch/arm/mach-omap2/display.c.
>>
>> So please consider this a huge eternal NAK to add any more crap to
>> arch/arm/mach-omap2/display.c from me. No more new soc_is beyond
>> the soc_is_am43xx() you have in linux next. No more adding
>> of_find_compatible_node() beyond ti,omap5-dss you have in linux next.
>>
>> And no more new panel remapping in this file as soon as you have found
>> a better solution. Preferrably by v3.17 merge window. This file just
>> needs to disappear. Yuk.
>
> Do you object to the compatible string remapping as such, or just that
> it's in arch/arm/mach-omap2?
>
> I guess nothing prevents me from moving it to drivers/, and having some
> early-ish initcall doing the job.
>
> If the remapping as such is horrible, I'm all ears for better ideas. I
> spent quite a lot of time on it, and that's the best I could come up with.
>
> It's rather simple prefixing of the compatible strings for selected
> devices. The purpose of that is to have proper data in the .dts files
> (which I think is very important) with the cost of having some rather
> simple internal hacks in the kernel, which can be removed immediately
> when we have a common display driver framework.
>

Even though the compatible trick that I said before could be an
alternative, it has the problem that does not describes the hardware
as you said. The restriction of the DT being a stable API and get it
right from the beginning forces us to make these kind of technical
decisions.

So, since we can change the kernel later but not the DTS, I agree with
you that the remapping is the least bad of our options.

>>> I'm not sure what it would give us to try to be compatible with
>>> simple-panel.txt. The simple-panel bindings won't probably be compatible
>>> with the future common display drivers in any case, as the simple-panel
>>> binding is just too limited and doesn't describe the hardware fully.
>>
>> Hmm what else does a panel need where the existing binding cannot be
>> extended?
>
> The existing simple-panel binding doesn't describe the connections of
> the panel, i.e. its video input. I guess it can be extended, but I don't
> see what the benefit is of trying to create new panel bindings
> compatible with the simple-panel bindings. As I see, the simple-panel
> bindings work only with very limited use cases, where the drivers make
> assumptions. Simple panel bindings cannot be used with omapdss, nor can
> it be used with the future common display framework.
>
> But I'm not really familiar with using extending current bindings, and
> making new bindings compatible with old ones. Can you explain why it'd
> be good to have the sharp panel bindings compatible with simple-panel?
> In what kind of scenario would it be used?
>
>  Tomi
>
>

Best regards,
Javier
