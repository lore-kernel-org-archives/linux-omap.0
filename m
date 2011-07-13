From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Wed, 13 Jul 2011 01:17:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107130105530.30229@utopia.booyaka.com>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org> <201106232234.21930.rjw@sisk.pl> <alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com> <BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
 <alpine.DEB.2.00.1106281346160.2874@utopia.booyaka.com> <20110709040622.GH26900@sirena.org.uk> <20110711095812.GT5783@atomide.com> <20110711110435.GF5092@opensource.wolfsonmicro.com> <20110711111424.GV5783@atomide.com>
 <20110711112619.GH5092@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34349 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab1GMHRw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 03:17:52 -0400
In-Reply-To: <20110711112619.GH5092@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tony Lindgren <tony@atomide.com>, Arve Hj?nnev?g <arve@android.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, Len Brown <lenb@kernel.org>

(cc'ing Len)

Hi Mark,

On Mon, 11 Jul 2011, Mark Brown wrote:

> The interesting bits are things like being able to kill lots of the SoC
> core supplies when the RAM is in retention mode - the CPU needs to go
> through its shutdown procedures.

This is indeed possible on OMAP3+ chips with TWL4030+ PMICs.  Probably 
other PMICs also.  TI calls it "off-mode."  The N900 shipped with this 
feature enabled.  Not sure how many other similar products did.

This can be enabled in mainline, but not all of the mainline drivers have 
context save/restore code merged yet, so in mainline it only works with a 
subset of drivers.

> Actually, it just occurred to me that if we're waiting for a system
> timer and can hand that off to a suitable timer in the PMIC then we can
> do a suspend to RAM for the deep idle state from the hardware point of
> view.

Yep.  At LinuxCon Cambridge two years ago, we had a discussion about 
whether it would be possible to enter ACPI S-states from CPUIdle (or some 
idle governor) on Intel chips.  If I remember correctly, the conclusion 
was that ACPI always disables the screen/backlight, so it would only be 
useful for situations where that was acceptable.

To the best of my (limited) knowledge, that's the only case I know of 
where there's a hardware limitation that prevents dynamic idle from 
reaching the same low power state as system suspend.  If someone has hard 
details of a similar example, it would be great to know about it.


- Paul
