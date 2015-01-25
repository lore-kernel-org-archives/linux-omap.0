From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Sun, 25 Jan 2015 09:34:01 +0100
Message-ID: <CAALWOA9F7UH5ORXdjyHAyekohZdSiE-+enNg5vsxOV5RgfqEdw@mail.gmail.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com> <20150117164709.GS18552@atomide.com>
 <CAALWOA-v=-KZ5W+Giwq9Z7rdA8JM2Q+zgqZPz-5sDrHD_b-_7A@mail.gmail.com>
 <20150117181404.GW18552@atomide.com> <CAALWOA-cdqPbLo4JvykGFODy2xUOozWg6OjzoGPLasJA022kJg@mail.gmail.com>
 <20150119172914.GY18552@atomide.com> <CAALWOA_54qoQgyCkGy10v+7-eQ87ddeCTG-dbP-P6x493HAswA@mail.gmail.com>
 <20150123164756.GB7718@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:55587 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbbAYIeX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jan 2015 03:34:23 -0500
Received: by mail-we0-f179.google.com with SMTP id q59so4261612wes.10
        for <linux-omap@vger.kernel.org>; Sun, 25 Jan 2015 00:34:22 -0800 (PST)
In-Reply-To: <20150123164756.GB7718@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

On 23 January 2015 at 17:47, Tony Lindgren <tony@atomide.com> wrote:
> That's interesting info thanks :) Yeah it seems dm814x was done after
> dm816x and that clears at least some of the clockdomain confusion
> that I though was TRM copy-paste issue.

Well it is in some sense still a copy-paste issue when e.g.
CM_SYSCLK18_CLKSEL refers to the "Audio PLL generated 32 Khz Clock"
when there is none (it means the "Audio PLL A divider" output, which
itself is in fact fed by the rtcdivider).

Probably the sillyest copy-paste error is section 1.3.2.2.1 on the DSP
interrupt controller, whose list of interrupts is from Freon/Primus
(omap-L13x) which is not even remotely similar to the actual list in
section 1.7.3.  Which reminds me, I also have a centaurus irqs
spreadsheet which may be more convenient than the lists in the PDF and
includes some that were censored from public docs:
https://docs.google.com/spreadsheets/d/1O3IFMdAfLMWVBQ8rzLPexMbi4LDD5ECfpVYGF6HMv_0/view
(note however that I consistently use 0-based indexing, regardless of
the TRM which tends to vary on that)


> > And there are gaps in the memory map suggesting maybe there were more
> > submodules in earlier versions.  I know it differs from Netra's
> > security subsystem since one module offset is different... hmm, now
> > I'm curious. I'll see if I can find a moment to brush the dust off the
> > evm816x here and make a quick inventory.
>
> Should be usable for NFSroot with all the patches I've sent using the
> ti u-boot and and appended DTB uImage. Sorry not all of it is yet in
> Linux next though

With "make a quick inventory" I meant peeking and poking around in the
subsystem using JTAG, which is generally better done without any OS
running on the target :-)  I don't actually have any real motivation
to run linux on the evm816x; we selected the DM814x for our target
(before it became clear support for it had basically dropped like a
brick), though it may still take a bit before I have time to see how
far I can get with booting Linux on it.

The inventory of SecSS on Netra yielded exactly the same list of
accelerators and other peripherals as on Centaurus btw. The only
changes seem to be in subsystem control stuff. I was not succesful in
attaching to the secM3 via JTAG though, but this may have been an
issue with the target config since Code Composer was being more
annoying than usual about it.
