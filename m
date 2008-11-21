From: Tony Lindgren <tony@atomide.com>
Subject: Re: [OMAP and mainline][RFC 2.6.28-rc2-omap 3/3] USB: OHCI-OMAP:
	Switch to gpio_request/free calls
Date: Fri, 21 Nov 2008 15:40:48 -0800
Message-ID: <20081121234047.GK4927@atomide.com>
References: <1225455447-12179-1-git-send-email-jarkko.nikula@nokia.com> <20081112095318.621bb99d.jarkko.nikula@nokia.com> <20081121221638.GE4927@atomide.com> <200811211537.13253.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55595 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbYKUXkw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 18:40:52 -0500
Content-Disposition: inline
In-Reply-To: <200811211537.13253.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081121 15:37]:
> On Friday 21 November 2008, Tony Lindgren wrote:
> > > > 
> > > I just sent a patch extending width to 20 bytes via LKML and you in cc
> > > list. I looked mainline and there were many labels more than 12 but
> > > less 20 bytes. One longer was "board a9m9750dev extirq2" but looks like
> > > it can be squeezed.
> > 
> > Jarkko, any news on updating this patch series? It would be nice to
> > have this queued up for  2.6.29.
> 
> The gpiolib change is in mainline git.
> 

But I guess Jarkko will still change some names in his patch series?

Tony
