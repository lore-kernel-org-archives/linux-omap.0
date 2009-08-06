From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: MMC3 Overo
Date: Thu, 06 Aug 2009 07:30:11 -0700
Message-ID: <871vnp8170.fsf@deeprootsystems.com>
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
	<bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:5476 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbZHFOaX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 10:30:23 -0400
Received: by rv-out-0506.google.com with SMTP id f6so162958rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2009 07:30:22 -0700 (PDT)
In-Reply-To: <bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com> (John Sarman's message of "Wed\, 5 Aug 2009 22\:02\:42 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Sarman <johnsarman@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

John Sarman <johnsarman@gmail.com> writes:

> On Wed, Aug 5, 2009 at 2:35 PM, Kevin Hilman<khilman@deeprootsystems.=
com> wrote:
>> Steve Sakoman wrote:
>>>
>>> On Wed, Aug 5, 2009 at 10:58 AM, Kevin
>>> Hilman<khilman@deeprootsystems.com> wrote:
>>>>
>>>> Steve Sakoman wrote:
>>>>>
>>>>> And up to now in each case I shrug and say "no time to do that no=
w,
>>>>> I'll just leave kernel pinmuxing turned off and do it in u-boot"
>>>>
>>>> I agree there are lots of shortcomings in the current mux code and=
 we've
>>>> been hitting them regularily lately.
>>>>
>>>> That being said, for mux settings that done one-time only at boot,=
 what
>>>> are
>>>> the problems you're running into?
>>>
>>> It's been a few months since I last encountered this, so the exact
>>> details are a bit fuzzy.
>>>
>>> I seem to recall that there were some basic issues with enabling
>>> kernel pinmuxing in that some of the setup that was done for all
>>> machines was just wrong for my particular machine. =A0IIRC, it was =
due
>>> to assumptions about which pad was used for a particular function (=
for
>>> those functions which can be steered to multiple GPIO pads).
>>>
>>> So I faced having to undo that change in my board file as well as a=
ny
>>> issues that may have arisen from glitches on the GPIO pins during t=
he
>>> process. =A0And since there were several of these I gave up and tur=
ned
>>> off kernel pinmuxing.
>>>
>>> I'd be happy if we cleaned up the "one size fits all" pinmuxing to
>>> just that subset that truly does fit all boards, and leave the rest=
 to
>>> the board files. =A0I'd also be content to have it all done in the =
board
>>> file for each machine.
>>
>> Indeed, any assumptions about common muxing that are not indeed comm=
on are
>> bugs and should be fixed.
>>
>> The "right" solution is to have everything in the kernel, and split =
across
>> SoC "common" init and board specific init. =A0Of course u-boot
>> will still have to do some early muxing, but it should be redone in
>> the kernel so it's trivial to change bootloaders.
>>
>> So the real missing piece is someone to step up and rework the mux c=
ode.
>> The bigger problem is that the vast majority of folks don't care abo=
ut the
>> common case and only care about getting thing working for a specific
>> platform.
>>
>> Kevin
>>
> I =A0like the idea of having the board file configure the mux. =A0Fir=
st of
> all lets address the shortcomings of mux.h. =A0The Pin values are
> labeled as so:
> <snip from mux.h>
> * NOTE: Please use the following naming style for new pin entries.
> =A0* =A0 =A0 =A0 For example, W8_1610_MMC2_DAT0, where:
> =A0* =A0 =A0 =A0 - W8 =A0 =A0 =A0 =A0=3D ball
> =A0* =A0 =A0 =A0 - 1610 =A0 =A0 =A0=3D 1510 or 1610, none if common f=
or both 1510 and 1610
> =A0* =A0 =A0 =A0 - MMC2_DAT0 =3D function
>
> But lets take the 3530 as an example.
> =A0The 3530 has three separate packages. =A0CBB, CBC, and CUS. =A0Now=
 lets
> look at MMC3_clk (the root of my original problem that started this
> thread)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CBB =A0 =A0 =A0 =A0 =A0=
 =A0 =A0CBC =A0 =A0 =A0 =A0 =A0 =A0CUS
> mmc3_clk =A0 =A0 =A0 =A0 AB1 / AF10 =A0 =A0R9 / AB2 =A0 =A0 AC1
>
> So to properly add these to mux.h we need to add 5 entries for mmc3_c=
lk
> =A0 =A0 =A0 AB1_35XXCBB_MMC3_CLK
> =A0 =A0 =A0 AF10_35XXCBB_MMC3_CLK
> =A0 =A0 =A0 R9_35XXCBC_MMC3_CLK
> =A0 =A0 =A0 AB2_35XXCBC_MMC3_CLK
> =A0 =A0 =A0 AC1_35XXCUS_MMC3_CLK
> We would then have to update mux.c making sure the position matches
> and add the proper settings.
>
> So this is obviously a maintenance nightmare.

So why don't we drop the ball (pun intended.) ;)

This is what I proposed to Phillip Ballister for his SPI changes for Be=
agle.

Though I haven't looked at the details for each package, I have a hard
time imagining that the reg offsets and functionality for each package
is different.  In fact, I'm pretty sure they're even the same between
34xx and 35xx. =20

IOW, why not just name it OMAP3_MMC3_CLK and have a single entry.

Then each board file that cares simply has to call omap_cfg_reg() on
that name and not care about the package.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
