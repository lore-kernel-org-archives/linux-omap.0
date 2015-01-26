From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Mon, 26 Jan 2015 07:58:50 -0800
Message-ID: <20150126155850.GD28663@atomide.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com>
 <20150117164709.GS18552@atomide.com>
 <CAALWOA-v=-KZ5W+Giwq9Z7rdA8JM2Q+zgqZPz-5sDrHD_b-_7A@mail.gmail.com>
 <20150117181404.GW18552@atomide.com>
 <CAALWOA-cdqPbLo4JvykGFODy2xUOozWg6OjzoGPLasJA022kJg@mail.gmail.com>
 <20150119172914.GY18552@atomide.com>
 <CAALWOA_54qoQgyCkGy10v+7-eQ87ddeCTG-dbP-P6x493HAswA@mail.gmail.com>
 <20150123164756.GB7718@atomide.com>
 <CAALWOA9F7UH5ORXdjyHAyekohZdSiE-+enNg5vsxOV5RgfqEdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.ore.mailhop.org ([54.149.88.251]:34504 "EHLO
	smtp3.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbbAZQCA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2015 11:02:00 -0500
Content-Disposition: inline
In-Reply-To: <CAALWOA9F7UH5ORXdjyHAyekohZdSiE-+enNg5vsxOV5RgfqEdw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150125 00:37]:
> On 23 January 2015 at 17:47, Tony Lindgren <tony@atomide.com> wrote:
> > That's interesting info thanks :) Yeah it seems dm814x was done after
> > dm816x and that clears at least some of the clockdomain confusion
> > that I though was TRM copy-paste issue.
> 
> Well it is in some sense still a copy-paste issue when e.g.
> CM_SYSCLK18_CLKSEL refers to the "Audio PLL generated 32 Khz Clock"
> when there is none (it means the "Audio PLL A divider" output, which
> itself is in fact fed by the rtcdivider).

Sounds like that's a copy paste issue from dm816x to dm814x then :)
See earlier I was assuming copy paste issues from dm814x to dm816x
before you confirmed dm816x was done before dm814x. On the dm816x
I'm pretty sure I verified the that the audio_pll_clk1 is hardwwired
to 32KiHz by looking at it with a scope on the clkout pin.
 
> Probably the sillyest copy-paste error is section 1.3.2.2.1 on the DSP
> interrupt controller, whose list of interrupts is from Freon/Primus
> (omap-L13x) which is not even remotely similar to the actual list in
> section 1.7.3.  Which reminds me, I also have a centaurus irqs
> spreadsheet which may be more convenient than the lists in the PDF and
> includes some that were censored from public docs:
> https://docs.google.com/spreadsheets/d/1O3IFMdAfLMWVBQ8rzLPexMbi4LDD5ECfpVYGF6HMv_0/view
> (note however that I consistently use 0-based indexing, regardless of
> the TRM which tends to vary on that)

Heheh that should be also helpful.
 
> > > And there are gaps in the memory map suggesting maybe there were more
> > > submodules in earlier versions.  I know it differs from Netra's
> > > security subsystem since one module offset is different... hmm, now
> > > I'm curious. I'll see if I can find a moment to brush the dust off the
> > > evm816x here and make a quick inventory.
> >
> > Should be usable for NFSroot with all the patches I've sent using the
> > ti u-boot and and appended DTB uImage. Sorry not all of it is yet in
> > Linux next though
> 
> With "make a quick inventory" I meant peeking and poking around in the
> subsystem using JTAG, which is generally better done without any OS
> running on the target :-)  I don't actually have any real motivation
> to run linux on the evm816x; we selected the DM814x for our target
> (before it became clear support for it had basically dropped like a
> brick), though it may still take a bit before I have time to see how
> far I can get with booting Linux on it.

Oh OK. Yeah it sounds like you could generate the required dm814x .dts
entries with a few macros from your spreadsheets :) 
 
> The inventory of SecSS on Netra yielded exactly the same list of
> accelerators and other peripherals as on Centaurus btw. The only
> changes seem to be in subsystem control stuff. I was not succesful in
> attaching to the secM3 via JTAG though, but this may have been an
> issue with the target config since Code Composer was being more
> annoying than usual about it.

What are you using to identify the devices? The device revision
register? Or are there actually some populated interconnect data
available with device info that could be used for a real scannable
bus?

Regards,

Tony
