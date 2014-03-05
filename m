From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 4/4] ARM: OMAP2+: Add pdata quirk for sys_clkout2 for
 omap3 DBB056
Date: Wed, 5 Mar 2014 09:21:56 -0800
Message-ID: <20140305172156.GF4983@atomide.com>
References: <1392387656-15186-1-git-send-email-chf.fritz@googlemail.com>
 <1392387656-15186-5-git-send-email-chf.fritz@googlemail.com>
 <20140228223741.GM13624@atomide.com>
 <53172175.5060603@ti.com>
 <1394025932.16566.44.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22574 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbaCERWE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Mar 2014 12:22:04 -0500
Content-Disposition: inline
In-Reply-To: <1394025932.16566.44.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Nishanth Menon <nm@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <zonque@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Christoph Fritz <chf.fritz@googlemail.com> [140305 05:28]:
> On Wed, 2014-03-05 at 15:07 +0200, Tero Kristo wrote:
> > On 03/01/2014 12:37 AM, Tony Lindgren wrote:
> > > * Christoph Fritz <chf.fritz@googlemail.com> [140214 06:24]:
> > >> Full device tree support for clock control, especially to set frequencies,
> > >> is not yet accomplished. Until then, configure the 24Mhz of sys_clkout2 to
> > >> feed an USB-Hub here.
> > >
> > > Hmm would like to see Tero's comments on this, I wonder if we should
> > > wait on this to avoid extra churn?
> > 
> > Well, the set I posted that adds default clock parenting / default rate 
> > support to DT hasn't actually moved forward, so you might want to take 
> > this in as is now if it should be rushed. The clk-enable part isn't done 
> > currently by anything anyway. Just wondering though, should you create 
> > some sort of driver for your usb-hub which would control these clocks?
> 
> The USB-Hub, a USB2512 is wired as non-configurable. Its pin
> 'XTAL1/CLKIN' can be connected to either a crystal or an external clock
> input. To economise the crystal, the clock-out of the omap is wired
> here.
> 
> So in my view, a driver is unnecessary.

Yeah that makes sense. Let's try not to rely on pdata-quirks.c for
the new boards.

Regards,

Tony
