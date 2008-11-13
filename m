From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] omap1: clk: make clk fwk build again on omap1
Date: Thu, 13 Nov 2008 22:47:50 +0200
Message-ID: <20081113204749.GC25855@frodo>
References: <1226444207-14588-1-git-send-email-me@felipebalbi.com> <20081113185548.GA3106@atomide.com> <200811131123.12594.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:32791 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbYKMUsR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 15:48:17 -0500
Content-Disposition: inline
In-Reply-To: <200811131123.12594.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Nov 13, 2008 at 11:23:12AM -0800, David Brownell wrote:
> On Thursday 13 November 2008, Tony Lindgren wrote:
> > Huh? At least OSK builds and boots just fine here.
> > Have you tested this patch?
> 
> But I got a boatload of build warnings for clocks,
> even though they were just warnings.
> 
> It did boot, but root-on-CF seems to have some
> oopsing problems.  I think I saw some IDE/block
> layer updates post-RC3, maybe they'll fix that.

The warnings is because enabled_reg (from struct clk on omap) changed
from a pointer (probably void __iomem *, gotta check history) to a u32
and only omap2/3 was fixed. This patch fixes that in fact. But for me,
funny enough, i didn't get warnings, I got build error :-s

-- 
balbi
