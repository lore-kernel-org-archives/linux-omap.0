From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/7] ARM: OMAP1: ams-delta: convert latches to
 basic_mmio_gpio
Date: Mon, 19 Dec 2011 17:04:46 -0800
Message-ID: <20111220010446.GA6464@atomide.com>
References: <cover.1324331816.git.jkrzyszt@tis.icnet.pl>
 <a4b2fd8d5b0f14b24cf6edbb618fa51daf8eefba.1324331816.git.jkrzyszt@tis.icnet.pl>
 <20111220000600.GY6464@atomide.com>
 <201112200159.36558.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18537 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab1LTBEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 20:04:50 -0500
Content-Disposition: inline
In-Reply-To: <201112200159.36558.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111219 16:28]:
> On Tuesday 20 of December 2011 at 01:06:00, Tony Lindgren wrote:
> > 
> > This part especially looks like it really should be just a regular
> > device driver under drivers/ somewhere. 
> 
> I really don't understand what kind of a driver you might mean here.
> 
> The latch_gpios[] table is initially filled with all latch1 and latch2 
> GPIO pins in order to register and initialize them from the board file 
> until they are handled by respective existing device drivers (leds, 
> nand, lcd, serio, serial8250, asoc) instead of those drivers accessing 
> the latches with those old ams_delta_latch[12]_write() functions. That 
> table will get almost empty after the transision process is completed, 
> holding only pins not used by any drivers / connected to unsued devices, 
> in order to initialize them from the board file for power saving 
> purposes. A separate driver for the purpose of initializing a few GPIO 
> pins seems an overkill.

OK maybe update the comments a bit to describe how that table will
mostly disappear? It's not obvious from glancing over this patch
series :)
 
> The new ams_delta_latch_write() function is a unified replacement for 
> those removed ams_delta_latch[12]_write(), and serves as a temporary 
> wrapper over gpio_set_value(), providing the old API for those not yet 
> updated device drivers, and will be removed after all drivers are 
> converted.
> 
> Perhaps I was not clear enough with my intention of a smooth step by 
> step transition to the GPIO API without breaking any signle driver with 
> any single patch.
> 
> > That might simplify things quite a bit for you..
> 
> Will be simplified, step by step, while moving GPIO handling from the 
> board file to all those existing device drivers.
> 
> I hope this clarifies things enough.

Yes thanks :)

Tony
