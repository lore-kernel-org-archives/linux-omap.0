From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Sat, 17 Jan 2015 23:37:54 +0100
Message-ID: <CAALWOA-cdqPbLo4JvykGFODy2xUOozWg6OjzoGPLasJA022kJg@mail.gmail.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com> <20150117164709.GS18552@atomide.com>
 <CAALWOA-v=-KZ5W+Giwq9Z7rdA8JM2Q+zgqZPz-5sDrHD_b-_7A@mail.gmail.com> <20150117181404.GW18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56186 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbbAQWiQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2015 17:38:16 -0500
Received: by mail-wi0-f178.google.com with SMTP id z2so9967068wiv.5
        for <linux-omap@vger.kernel.org>; Sat, 17 Jan 2015 14:38:15 -0800 (PST)
In-Reply-To: <20150117181404.GW18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

On 17 January 2015 at 19:14, Tony Lindgren <tony@atomide.com> wrote:
> Oh OK. And looks like dm814x trm claims to have PINCNTL[7:0]
> bits for MUXMODE instead of just bits [2:0]?

However, the datasheet's table of possible mux modes per pin has as
column headers: 0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80. (mode 0,
called "safe mode" is mentioned separately)

For compatibility sake I'm personally more inclined to consider them
modes 0-7 with "safe mode" being -1.

Oh, and I just remembered: while 811x is mostly compatible with 814x,
it has up to 12 mux modes per pin. So replace "byte-write" by
"u16-write" in my previous post ;-)


>> It also means you can change mode with a u16-write to avoid touching
>> the upper bits
>
> Maybe that's why some bits got shifted :)

Yes, in general bitfields seem to be grouped into separate bytes in
quite a few places where it may be convenient to take advantage of the
fact that both PRCM and the Control module are byte-addressable to
avoid having to do a read-modify-update.  (For example the omap4/5
standard layout for CLKCTRL puts modulemode in byte 0, optional fclks
in byte 1, and any mux/div config the module may have in the upper
bytes. Only the am335x violates this rule.)

>> The overall control module layout is actually compatible across the
>> whole happy family
>
> Got any generic naming in mind for the helper macro we could use?

I've already been pondering what to call this family, since
architecturally they do very clearly form a fairly close family
related to, but also clearly distinct from, the omap4/5 line.

As you may notice from my spreadsheet I already generally prefer to
use their names (Netra, Centaurus, Subarctic, Aegis), both because
names are rather more memorable and distinguishable for humans than
4-digit numbers and because each actually has a flurry of wildly
different part codes depending on which subsystems happen to fail the
factory test and get disabled (which may of course be a big deal
featurewise but is rather irrelevant to the kernel).

Still leaves four names to unify... I may be biased but I'm leaning
towards "Centauroid": Centaurus (814x) seems to have a fairly central
position, being memory-map compatible with the there other members
(i.e. no subsystem/peripheral of Centaurus overlaps a different one of
another device), while the same is not true between Netra (816x) and
subarctic (335x).  I suspect this may be because Centaurus and Netra
form a single product line (DM81xx) iin one market segment (video)
while Centaurus and Subarctic form a single product line (DRA6xx) in
another market segment (automotive).


> Cool, that certainly helps. To me it looks dm814x needs it's own
> clock driver for the source clocks, but after that the dividers
> are similar to dm816x and am33xx. Have not looked at the am814x
> beyond that though.

dm814x you mean... the downfeatured Sitara version got called am387x,
naturally. ;-)

The biggest architectural differences between three chips are indeed
in PRCM, where each member has its own peculiarities:

Netra and Centaurus both have the simple but clean omap4-subset PRCM.
No fancy auto-management by hardware but at least a clean
well-organised interface, with the biggest blemish being the
register-swap in PRM_SGX.  (Subarctic's PRCM is of course shocking in
contrast, being organized by "sort -R", incompatibility with the
omap4/5 register layouts, and a seemingly endless supply of novel ways
of being inconsistent.)

Netra however has the FAPLL experiment, which apparently wasn't a
success so while Centaurus retained much of the clock tree it reverted
to using normal PLLs by replacing the FAPLLs with its PLL subsystem
containing additional clock muxes to sort of glue it onto the existing
clock tree, making the clock tree a bit messier. (Especially older
versions of the TRM were very confusing to those unfamiliar with this
Netra-heritage since FAPLL names were still all over the place.)  In
line with the "fully software managed" tradition, it seems to wire
*all* control/status signals of the PLLs directly into registers. They
can be slightly fickle (and mucking up the MPU PLL can leave you
pretty screwed, especially since the watchdog reset doesn't reset the
PLLs).


Also important: Centaurus has very similar Ethernet subsystem to that
of subarctic, though some components are a slightly older minor
revision. In violation of what a "minor revision" normally means, they
are however software-incompatible thanks to moving blocks of registers
around to different offsets, and some per-port settings became global
or vice versa.  This however seems to be a tradition for the 3-port
gigabit switch subsystem: out of curiosity I examined the ones in
other TI SoCs, and it turns out that literally *all* of them have
different, incompatible register layouts (sometimes also extending to
the switch table entries and/or DMA descriptors).


Other than this, the subsystems and peripherals are mostly familiar
omap4-generation stuff, but with a standard C674x DSP instead of
omap4's weird custom "Tesla" DSP (although some Tesla documentation
accidentally got copy-pasted into Netra's TRM). An overview of the
video situation on Centaurus (afaik, I'm not deeply into the video
stuff) can be found in this post, where I was also cheerleading your
efforts towards mainline dm81xx support:
http://e2e.ti.com/support/dsp/davinci_digital_media_processors/f/716/p/246653/1396681#1396681

There's also an interesting Security Subsystem, which houses the
crypto accelerators (2x AES, 2x Hash, DES, PKA, RNG), an SDMA engine,
128 KB + 16 KB of local RAM, a cortex-M3, some timers for its benefit,
irq routing, and an elaborate L3 firewall instance covering both
external and internal access. It is about as well-documented as the
crypto accelerators on the am335x are :P  Still, it's not hard to get
it operational, and allows e.g. sequencing of composite crypto
operations combined with DMA without the kernel having to micro-manage
it, along with secure local key storage.

Once the basics work there's definitely some neat gear on these chips
to play with
