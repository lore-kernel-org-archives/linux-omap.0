From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Tue, 3 Feb 2015 06:51:34 +0100
Message-ID: <CAALWOA_6Lx1_MrDFwSe0hOiub3FxzrrCburQf=VWnXabKbjtmA@mail.gmail.com>
References: <20150117164709.GS18552@atomide.com> <CAALWOA-v=-KZ5W+Giwq9Z7rdA8JM2Q+zgqZPz-5sDrHD_b-_7A@mail.gmail.com>
 <20150117181404.GW18552@atomide.com> <CAALWOA-cdqPbLo4JvykGFODy2xUOozWg6OjzoGPLasJA022kJg@mail.gmail.com>
 <20150119172914.GY18552@atomide.com> <CAALWOA_54qoQgyCkGy10v+7-eQ87ddeCTG-dbP-P6x493HAswA@mail.gmail.com>
 <20150123164756.GB7718@atomide.com> <CAALWOA9F7UH5ORXdjyHAyekohZdSiE-+enNg5vsxOV5RgfqEdw@mail.gmail.com>
 <20150126155850.GD28663@atomide.com> <CAALWOA9gSegCofYF-csg_2zdRkz=W5g8UAOqBbrA-NG0-oR1ww@mail.gmail.com>
 <20150202174416.GE9418@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:43836 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbbBCFv5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2015 00:51:57 -0500
Received: by mail-wg0-f50.google.com with SMTP id b13so42472273wgh.9
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2015 21:51:56 -0800 (PST)
In-Reply-To: <20150202174416.GE9418@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

On 2 February 2015 at 18:44, Tony Lindgren <tony@atomide.com> wrote:
> * Matthijs van Duin <matthijsvanduin@gmail.com> [150128 13:46]:
>> On 26 January 2015 at 16:58, Tony Lindgren <tony@atomide.com> wrote:
>> > I'm pretty sure I verified the that the audio_pll_clk1 is hardwwired
>> > to 32KiHz by looking at it with a scope on the clkout pin.
>>
>> Yeah it comes straight from the "rtcdivider" so it'll produce
>> 0.0016384 * devosc.
>
> Not much about "rtcdivider" in the dm816x TRM..
> [..]
> That seems to be in the dm814x TRM. OK so it looks like in
> mainline kernel drivers/clk/ti/fapll.c we can then fix the hardcoded
> value in ti_fapll_synth_recalc_rate() to return the rate of fd->clk_ref
> multiplied 0.0016384 instead of 32768.

Ah sorry, yes, for some reason I thought you meant the dm814x one...
(which makes no sense in retrospect)

It seems however the situation is actually similar on the dm816x since
the diagram of the audio FAPLL also shows clock 1 deriving directly
from devosc, and the associated audio frequency/divider 1 registers
read as zero. Presumably it was produced by the audio PLL in some
early design but replaced by a fixed synthesizer later on, later named
"rtcdivider" in the dm814x. Note that the multiplier 0.0016384 = 32768
/ 20e6 is for the dm814x, it'll be 32768 / 27e6 on the dm816x.

I think "audio 1" should be kept out of the fapll code entirely given
that it doesn't seem to be related to the audio FAPLL anymore in any
way other than in name.


I've also been looking at the rest of Netra's 32KiHz clock tree, but
the TRM is a real mess there, often contradicting both itself and the
TI kernel. As far as I can tell they agree on:

audio_1 = devosc * (32768 / 27e6);

audio_a = audio_1 / (CM_DPLL_APA_CLKSEL + 1);
rtc_fck = { clkin32, audio_a }[CM_DPLL_SYSCLK18_CLKSEL];

but the TRM seems to suggest the mux output is the "sec_clk32k"
specifically for the RTC while the signal I called "audio_a" here is
sysclk18 provided for debouncing and as timer option.  In contrast the
TI kernel considers the mux the only user of audio_a and its output
sysclk18.  It does also define a secure 32k but without parent or any
apparent users.

(The audio FAPLL description (1.10.3.1.4) also claims mux option 0
selects the synthesized 32k clock, but that contradicts all other
evidence so I will ignore that.)

I'm leaning more towards believing the TI kernel since on Centaurus
(all flavors) sysclk18 definitely comes from the mux. It adds a twist
however: PRCM's clkin32 doesn't come straight from the pin but PLLSS
inserts another mux which by default *also* feeds it the synthesized
32k:

rtcdivider = devosc * (32768 / 20e6);  // former audio 1
prcm_clkin32 = { rtcdivider, clkin32 }[PLLSS_SYSCLK18_CLKSRC];

sysclk18_a = rtcdivider / (CM_DPLL_RTCDIVA_CLKSEL + 1);
sysclk18 = { prcm_clkin32, sysclk18_a }[CM_DPLL_SYSCLK18_CLKSEL];

I confirmed the above on our board where clkin32 is not connected, so
I could "manually" toggle it using the internal pull up/down. This
also revealed that mux in PLLSS, unlike the PRCM one, is not
glitch-free but takes immediate effect. It also revealed the TRM's
statement that  "If newly selected clock is idle, a switchover never
occurs (previously selected clock continues to pass through the mux)"
is false. Switching sysclk18 to the idle clkin32 stopped timers fed by
it (including the "synctimer32k") and switching back also proved
impossible without toggling clkin32 or having PLLSS feed it the
rtcdivider clock. This may be the reason this (otherwise redundant)
mux exists in the first place.

Finally, Centaurus also has an internal ~32kHz RC osc as option for
the watchdog and on the 811x (also known as Jacinto 5 Eco) the clkin32
is upgraded from clock input to oscillator.
