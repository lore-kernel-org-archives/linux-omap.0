From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Mon, 2 Feb 2015 09:44:18 -0800
Message-ID: <20150202174416.GE9418@atomide.com>
References: <20150117164709.GS18552@atomide.com>
 <CAALWOA-v=-KZ5W+Giwq9Z7rdA8JM2Q+zgqZPz-5sDrHD_b-_7A@mail.gmail.com>
 <20150117181404.GW18552@atomide.com>
 <CAALWOA-cdqPbLo4JvykGFODy2xUOozWg6OjzoGPLasJA022kJg@mail.gmail.com>
 <20150119172914.GY18552@atomide.com>
 <CAALWOA_54qoQgyCkGy10v+7-eQ87ddeCTG-dbP-P6x493HAswA@mail.gmail.com>
 <20150123164756.GB7718@atomide.com>
 <CAALWOA9F7UH5ORXdjyHAyekohZdSiE-+enNg5vsxOV5RgfqEdw@mail.gmail.com>
 <20150126155850.GD28663@atomide.com>
 <CAALWOA9gSegCofYF-csg_2zdRkz=W5g8UAOqBbrA-NG0-oR1ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.ore.mailhop.org ([54.149.240.58]:45568 "EHLO
	smtp4.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932689AbbBBRrM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2015 12:47:12 -0500
Content-Disposition: inline
In-Reply-To: <CAALWOA9gSegCofYF-csg_2zdRkz=W5g8UAOqBbrA-NG0-oR1ww@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150128 13:46]:
> On 26 January 2015 at 16:58, Tony Lindgren <tony@atomide.com> wrote:
> > See earlier I was assuming copy paste issues from dm814x to dm816x
> 
> Ahh, you thought the 816x was 814x-derived... yes I can imagine that
> will have led to some confusion.
> 
> > I'm pretty sure I verified the that the audio_pll_clk1 is hardwwired
> > to 32KiHz by looking at it with a scope on the clkout pin.
> 
> Yeah it comes straight from the "rtcdivider" so it'll produce
> 0.0016384 * devosc.

Not much about "rtcdivider" in the dm816x TRM..
 
> The global clock structure overview in the TRM (figure 2-6) actually
> correctly marks the former-audio-fapll clocks (except audio5 := osc0,
> yielding sysclk22 after divider) but you already need to know what the
> hell is going on to recognize that.

That seems to be in the dm814x TRM. OK so it looks like in
mainline kernel drivers/clk/ti/fapll.c we can then fix the hardcoded
value in ti_fapll_synth_recalc_rate() to return the rate of fd->clk_ref
multiplied 0.0016384 instead of 32768.

And we probably should add what you're explaining to the comments
also to make some sense out of it :)

Regards,

Tony
