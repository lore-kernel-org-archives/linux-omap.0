From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] FOR TESTING ONLY
Date: Mon, 6 Dec 2010 11:49:18 -0800
Message-ID: <20101206194917.GQ8345@atomide.com>
References: <20101202114805.GT5429@legolas.emea.dhcp.ti.com>
 <20101202222736.GZ17222@atomide.com>
 <20101203124453.GC2633@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36836 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab0LFTtW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 14:49:22 -0500
Content-Disposition: inline
In-Reply-To: <20101203124453.GC2633@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [101203 04:35]:
> On Thu, Dec 02, 2010 at 02:27:36PM -0800, Tony Lindgren wrote:
> >
> >Great, yeah I'll merge them into linux-omap master branch for testing
> >probably later on today.
> 
> Cool, I just made the updates Mike asked and it's now all good again
> :-p

It will get repulled the next time I rebuild l-o master branch.
 
> I'm hoping Greg will still accept these patches on monday for merge
> window, cross your fingers :-p
> 
> for 2.6.39 I'll get them all to build together. Not quite there yet.
> TUSB6010 messed up the whole code with ifdefs, I need to check how to do
> that one properly.

It seems the right long term solution is to get drivers/dma dmaengine
to work for us for both system DMA and CPPI DMA. Well there are probably
other problems you're dealing with too..

Tony
