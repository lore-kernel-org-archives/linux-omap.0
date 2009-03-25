From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap3evm mmc problem
Date: Wed, 25 Mar 2009 10:22:55 -0700
Message-ID: <20090325172254.GO8057@atomide.com>
References: <gq1s6e$ssu$1@ger.gmane.org> <200903210234.03670.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54018 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbZCYRW7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 13:22:59 -0400
Content-Disposition: inline
In-Reply-To: <200903210234.03670.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: dfoley <dfoley@telus.net>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [090321 02:34]:
> On Friday 20 March 2009, dfoley wrote:
> > Does anyone else get these mmc errors or know why on the OMAP 3530 Development board ?
> 
> Which dev board?  LDP?  EVM?
> 
> 
> > mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
> > regulator: Unable to get requested regulator: vmmc
> 
> Needs patches to setup whichever regulator is used
> with the MMC1 controller.  Look at Beagle, Overo,
> or SDP for examples...
> 
> 
> > mmci-omap-hs mmci-omap-hs.0: err -19 configuring card detect

Is this again the CONFIG_REGULATOR missing in .config?

Tony
