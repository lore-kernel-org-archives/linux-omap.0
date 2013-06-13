From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP v3.10-rc regressions that no one's fixed
Date: Thu, 13 Jun 2013 04:08:00 -0700
Message-ID: <20130613110759.GD8164@atomide.com>
References: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com>
 <20130612174842.GQ8164@atomide.com>
 <51B9A514.6020706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39131 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750897Ab3FMLID (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 07:08:03 -0400
Content-Disposition: inline
In-Reply-To: <51B9A514.6020706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [130613 04:01]:
> Hi Tony,
> On Wednesday 12 June 2013 11:18 PM, Tony Lindgren wrote:
> >* Paul Walmsley <paul@pwsan.com> [130610 00:27]:
> >>
> >>Hi folks -- particularly TIers working on mainline,
> >>
> >>There are several regressions that started with v3.10-rc that no one's
> >>fixed for over a month.  Some of them should be quite easy:
> >>
> >>* 37xx EVM: boot fails
> >>   - as of v3.10-rc1
> >>   - Cause unknown
> >
> >This one is probably because of broken GPIO numbering in
> >the board file that uses hardcoded GPIOs for what are probably
> >twl GPIOs.
> >
> >Does commenting out omap3_evm_display_init() in the board file
> >fix the booting for you?
> Yes by commenting out omap3_evm_display_init() fixes the booting.
> >
> >If so, we should probably mark omap3_evm_display_init() with
> >CONFIG_BROKEN for now rather than add more late init callback
> >functions for the twl code.
> As per your suggestion I have sent a patch for marking
> omap3_evm_display_init()
> with CONFIG_BROKEN.

OK thanks.

Tony
