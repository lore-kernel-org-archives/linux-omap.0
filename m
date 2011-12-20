From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v2 2/7] ARM: OMAP1: ams-delta: convert latches to basic_mmio_gpio
Date: Tue, 20 Dec 2011 02:18:02 +0100
Message-ID: <201112200218.03283.jkrzyszt@tis.icnet.pl>
References: <cover.1324331816.git.jkrzyszt@tis.icnet.pl> <201112200159.36558.jkrzyszt@tis.icnet.pl> <20111220010446.GA6464@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:51209 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab1LTBSq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 20:18:46 -0500
In-Reply-To: <20111220010446.GA6464@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

On Tuesday 20 of December 2011 at 02:04:46, Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111219 16:28]:
> > On Tuesday 20 of December 2011 at 01:06:00, Tony Lindgren wrote:
> > > 
> > > This part especially looks like it really should be just a regular
> > > device driver under drivers/ somewhere. 
> > 
> > I really don't understand what kind of a driver you might mean here.
> > 
> > The latch_gpios[] table is initially filled with all latch1 and latch2 
> > GPIO pins in order to register and initialize them from the board file 
> > until they are handled by respective existing device drivers (leds, 
> > nand, lcd, serio, serial8250, asoc) instead of those drivers accessing 
> > the latches with those old ams_delta_latch[12]_write() functions. That 
> > table will get almost empty after the transision process is completed, 
> > holding only pins not used by any drivers / connected to unsued devices, 
> > in order to initialize them from the board file for power saving 
> > purposes. A separate driver for the purpose of initializing a few GPIO 
> > pins seems an overkill.
> 
> OK maybe update the comments a bit to describe how that table will
> mostly disappear? It's not obvious from glancing over this patch
> series :)

To be sure, do you mean in-line comments? Or the changelog message?

Janusz
