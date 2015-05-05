From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: twl4030-power: Fix pmic for boards that need AC
 charger disabled
Date: Tue, 5 May 2015 07:16:39 -0700
Message-ID: <20150505141639.GD4810@atomide.com>
References: <1427736974-1842-1-git-send-email-tony@atomide.com>
 <20150504143213.GF24469@atomide.com>
 <20150505081735.GR4047@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49208 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993136AbbEEOQl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 May 2015 10:16:41 -0400
Content-Disposition: inline
In-Reply-To: <20150505081735.GR4047@x1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [150505 01:18]:
> On Mon, 04 May 2015, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [150330 10:41]:
> > > I noticed the PMIC configuration on 37xx-evm won't actually shut down
> > > the voltages during off-idle. Turns out 37xx-evm needs the AC charger
> > > state transitions disabled like we are doing for SDP and LDP in the
> > > legacy booting case.
> > > 
> > > Let's fix this for device tree based booting by setting up the quirk
> > > flag based on the compatible flag. And let's also use the existing
> > > define for STARTON_CHG.
> > > 
> > > Note that SDP and EVM do not have the PMIC clken wired to gate the
> > > the oscillator while LDP has.
> > 
> > Looks like this fix is still pending?
> 
> Applied now, thanks.

OK thanks!

Tony
