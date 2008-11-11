From: Tony Lindgren <tony@atomide.com>
Subject: Re: [rft/rfc/patch-2.6.28-rc3+ 00/59] namespace cleanup patches
Date: Tue, 11 Nov 2008 15:47:13 -0800
Message-ID: <20081111234711.GO3984@atomide.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com> <20081111232141.GD23454@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53458 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbYKKXrQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:47:16 -0500
Content-Disposition: inline
In-Reply-To: <20081111232141.GD23454@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

* Felipe Balbi <me@felipebalbi.com> [081111 15:22]:
> On Wed, Nov 12, 2008 at 12:56:19AM +0200, Felipe Balbi wrote:
> > From: Felipe Balbi <felipe.balbi@nokia.com>
> > 
> > Get rid of omap_{read,write}[bsl] defines.
> > Virtual and physical addresses usage was fixed by Russel King and
> > there's no need anymore for keeping a define to a standard kernel
> > function. Get rid of those to keep the namespace cleaner.
> > 
> > Build tested with all omap defconfigs.
> > Depends on my previous "make clk fwk build again on omap1" patch.
> 
> for convinience, these patches plus the clock fix for omap1 and the mmc
> fix are available at [1]

Felipe, have you tested any of these? To me looks like you're missing
the associated ioremap before you can use __raw_read/write instead of
omap_read/write.

Tony

> [1] http://felipebalbi.com/patches/omap/linux-omap-20081112.tar.gz
