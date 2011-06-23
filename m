From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 1/6] omap: prcm: switch to a chained IRQ handler
 mechanism
Date: Thu, 23 Jun 2011 02:51:03 -0700
Message-ID: <20110623095103.GZ23145@atomide.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
 <1308760934-9757-2-git-send-email-t-kristo@ti.com>
 <20110623081940.GW23145@atomide.com>
 <1308820129.5972.15.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:44883 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758872Ab1FWJvG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 05:51:06 -0400
Content-Disposition: inline
In-Reply-To: <1308820129.5972.15.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Mahadeva, Avinash" <avinashhm@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

* Tero Kristo <t-kristo@ti.com> [110623 02:04]:
> On Thu, 2011-06-23 at 10:19 +0200, Tony Lindgren wrote:
> > 
> > Please note consider that this data will be coming from device
> > tree and will disappear from here. We won't be merging any new
> > data after v3.1 unless it comes from device tree. So this too
> > will need to be converted because we won't be able to add support
> > for new omaps otherwise.
> 
> This part I am not too sure what you mean with this. Do you have some
> info / examples about the device tree somewhere and how this data should
> be converted?

Well there's some minimal data in the devel-devicetree branch currently.
That allows you to play with it if, the last commit contains some
instructions for the devicetree append support.

Then there are tons of examples in arch/powerpc/boot/dts. Basically
we'll have something like omap34xx.dts included into the board .dts
file. So your prcm interrupt data would live in the omap34xx.dts as
would 34xx specific mux data. Then the board specific .dts contains
the configured pins etc.

Just something to consider for organizing the code so you don't have
to change things around much after the device tree support is merged :)

Regards,

Tony
