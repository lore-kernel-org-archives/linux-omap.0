From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Initialize XCCR and RCCR McBSP registers
	for McBSP DAI driver
Date: Thu, 18 Dec 2008 16:16:24 +0200
Message-ID: <20081218141623.GG30366@atomide.com>
References: <2C7D3DF36ADFFC479B44490D912B616705A484A4C7@dlee07.ent.ti.com> <20081218134137.GD30366@atomide.com> <20081218154916.62f4f449.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49551 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbYLROQ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 09:16:28 -0500
Content-Disposition: inline
In-Reply-To: <20081218154916.62f4f449.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "Lopez Cruz, Misael" <x0052729@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

* Jarkko Nikula <jarkko.nikula@nokia.com> [081218 15:49]:
> On Thu, 18 Dec 2008 15:41:37 +0200
> "ext Tony Lindgren" <tony@atomide.com> wrote:
> 
> > Hi,
> > 
> > * Lopez Cruz, Misael <x0052729@ti.com> [081218 12:16]:
> > > This patch enables XCCR and RCCR McBSP register writing in OMAP 24xx/34xx
> > > platforms. It also explicitly initializes those registers to their default
> > > values in ASoC McBSP DAI driver.
> > 
> > Can you please describe a bit what these registers do? It's impossible
> > for anybody to decipher without looking at the TRM right now.
> > 
> Agree.
> 
> > You can do the above with cpu_class_is_omap2() instead. Might be worth
> > checking that these registers are available on 2420 too.
> > 
> No they are not. These are new registers found in 2430 and OMAP3.

OK, so then it needs to be cpu_is_omap2430().. instead.

> > I agree with Jarkko's comment, the ASoC change should go via alsa list
> > as a separate patch.
> > 
> Probably -mm tree would speed up this since it requires change both in
> plat-omap and sound subsystems?

Well sounds like we should be able to get the plat-omap change merged
during the -rc cycle via omap-fixes branch.

Regards,

Tony
