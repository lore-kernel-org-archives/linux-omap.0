From: John Sarman <johnsarman@gmail.com>
Subject: MMC3 Overo
Date: Wed, 5 Aug 2009 22:02:42 -0400
Message-ID: <bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
	 <bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com>
	 <bb2708720908050902o39c67430pbdcd12e9b835ab70@mail.gmail.com>
	 <873a866xdo.fsf@deeprootsystems.com>
	 <bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com>
	 <5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>
	 <4A79C83E.9040603@deeprootsystems.com>
	 <5e088bd90908051121h38678c9fha73b7beb88752156@mail.gmail.com>
	 <4A79D104.60607@deeprootsystems.com>
	 <bb2708720908051229x49f10094w9b19b468d4bfaec8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:52996 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbZHFCKg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 22:10:36 -0400
Received: by fxm28 with SMTP id 28so478724fxm.17
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 19:10:36 -0700 (PDT)
In-Reply-To: <bb2708720908051229x49f10094w9b19b468d4bfaec8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

On Wed, Aug 5, 2009 at 2:35 PM, Kevin Hilman<khilman@deeprootsystems.co=
m> wrote:
> Steve Sakoman wrote:
>>
>> On Wed, Aug 5, 2009 at 10:58 AM, Kevin
>> Hilman<khilman@deeprootsystems.com> wrote:
>>>
>>> Steve Sakoman wrote:
>>>>
>>>> And up to now in each case I shrug and say "no time to do that now=
,
>>>> I'll just leave kernel pinmuxing turned off and do it in u-boot"
>>>
>>> I agree there are lots of shortcomings in the current mux code and =
we've
>>> been hitting them regularily lately.
>>>
>>> That being said, for mux settings that done one-time only at boot, =
what
>>> are
>>> the problems you're running into?
>>
>> It's been a few months since I last encountered this, so the exact
>> details are a bit fuzzy.
>>
>> I seem to recall that there were some basic issues with enabling
>> kernel pinmuxing in that some of the setup that was done for all
>> machines was just wrong for my particular machine. =A0IIRC, it was d=
ue
>> to assumptions about which pad was used for a particular function (f=
or
>> those functions which can be steered to multiple GPIO pads).
>>
>> So I faced having to undo that change in my board file as well as an=
y
>> issues that may have arisen from glitches on the GPIO pins during th=
e
>> process. =A0And since there were several of these I gave up and turn=
ed
>> off kernel pinmuxing.
>>
>> I'd be happy if we cleaned up the "one size fits all" pinmuxing to
>> just that subset that truly does fit all boards, and leave the rest =
to
>> the board files. =A0I'd also be content to have it all done in the b=
oard
>> file for each machine.
>
> Indeed, any assumptions about common muxing that are not indeed commo=
n are
> bugs and should be fixed.
>
> The "right" solution is to have everything in the kernel, and split a=
cross
> SoC "common" init and board specific init. =A0Of course u-boot
> will still have to do some early muxing, but it should be redone in
> the kernel so it's trivial to change bootloaders.
>
> So the real missing piece is someone to step up and rework the mux co=
de.
> The bigger problem is that the vast majority of folks don't care abou=
t the
> common case and only care about getting thing working for a specific
> platform.
>
> Kevin
>
I =A0like the idea of having the board file configure the mux. =A0First=
 of
all lets address the shortcomings of mux.h. =A0The Pin values are
labeled as so:
<snip from mux.h>
* NOTE: Please use the following naming style for new pin entries.
=A0* =A0 =A0 =A0 For example, W8_1610_MMC2_DAT0, where:
=A0* =A0 =A0 =A0 - W8 =A0 =A0 =A0 =A0=3D ball
=A0* =A0 =A0 =A0 - 1610 =A0 =A0 =A0=3D 1510 or 1610, none if common for=
 both 1510 and 1610
=A0* =A0 =A0 =A0 - MMC2_DAT0 =3D function

But lets take the 3530 as an example.
=A0The 3530 has three separate packages. =A0CBB, CBC, and CUS. =A0Now l=
ets
look at MMC3_clk (the root of my original problem that started this
thread)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CBB =A0 =A0 =A0 =A0 =A0 =
=A0 =A0CBC =A0 =A0 =A0 =A0 =A0 =A0CUS
mmc3_clk =A0 =A0 =A0 =A0 AB1 / AF10 =A0 =A0R9 / AB2 =A0 =A0 AC1

So to properly add these to mux.h we need to add 5 entries for mmc3_clk
=A0 =A0 =A0 AB1_35XXCBB_MMC3_CLK
=A0 =A0 =A0 AF10_35XXCBB_MMC3_CLK
=A0 =A0 =A0 R9_35XXCBC_MMC3_CLK
=A0 =A0 =A0 AB2_35XXCBC_MMC3_CLK
=A0 =A0 =A0 AC1_35XXCUS_MMC3_CLK
We would then have to update mux.c making sure the position matches
and add the proper settings.

So this is obviously a maintenance nightmare.

Another option is to add a CONFIG_35XX_CBB or CBC or CUS when selecting=
 a board
=A0example in menuconfig selecting MACH_OVERO would select =A0CONFIG_35=
XX_CBB.
Then in a new mux_35xx.h located in the mach_omap2 folder have
=A0#ifdef CONFIG_35XX_CBB
=A0//all muxable balls
=A0 #define N4 =A0 =A0 =A0 0x078
=A0 #define AB1 =A0 =A0 0x164
=A0etc .....
=A0#endif
where we just use the Ball name defined as its offset in the 35xx case

then we create a file say board_overo_mux.c

=A0 in it we call
=A0 configure_pin(AB1, MODE3, INPUT | PU | PE);
=A0 for every ball that is muxable.

voila, =A0we have a predefined limit of pins so once mux_35xx.h is full=
y
defined, and the driver code is in place then the only thing that a
developer would need to do to leverage the mux is edit his board file.

Im sure I have glossed ove many details but this is a general outline.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
