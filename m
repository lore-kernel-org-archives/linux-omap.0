From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [rft/rfc/patch-2.6.28-rc3+ 00/59] namespace cleanup patches
Date: Wed, 12 Nov 2008 01:21:41 +0200
Message-ID: <20081111232141.GD23454@frodo>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38439 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbYKKXWG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:22:06 -0500
Content-Disposition: inline
In-Reply-To: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Wed, Nov 12, 2008 at 12:56:19AM +0200, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Get rid of omap_{read,write}[bsl] defines.
> Virtual and physical addresses usage was fixed by Russel King and
> there's no need anymore for keeping a define to a standard kernel
> function. Get rid of those to keep the namespace cleaner.
> 
> Build tested with all omap defconfigs.
> Depends on my previous "make clk fwk build again on omap1" patch.

for convinience, these patches plus the clock fix for omap1 and the mmc
fix are available at [1]

[1] http://felipebalbi.com/patches/omap/linux-omap-20081112.tar.gz

-- 
balbi
