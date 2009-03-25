From: David Brownell <david-b@pacbell.net>
Subject: Re: omap3evm mmc problem
Date: Wed, 25 Mar 2009 10:40:36 -0700
Message-ID: <200903251040.36300.david-b@pacbell.net>
References: <gq1s6e$ssu$1@ger.gmane.org> <200903210234.03670.david-b@pacbell.net> <20090325172254.GO8057@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:39846 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1764061AbZCYRkj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Mar 2009 13:40:39 -0400
In-Reply-To: <20090325172254.GO8057@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, dfoley <dfoley@telus.net>
Cc: linux-omap@vger.kernel.org

On Wednesday 25 March 2009, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [090321 02:34]:
> > On Friday 20 March 2009, dfoley wrote:
> > > Does anyone else get these mmc errors or know why on the OMAP 3530 Development board ?
> > 
> > Which dev board?  LDP?  EVM?
> > 
> > 
> > > mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
> > > regulator: Unable to get requested regulator: vmmc
> > 
> > Needs patches to setup whichever regulator is used
> > with the MMC1 controller.  Look at Beagle, Overo,
> > or SDP for examples...
> > 
> > 
> > > mmci-omap-hs mmci-omap-hs.0: err -19 configuring card detect
> 
> Is this again the CONFIG_REGULATOR missing in .config?

Maybe.  Do all the boards set up their regulators now?

