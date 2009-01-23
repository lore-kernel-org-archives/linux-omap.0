From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.29-rc1-omap git] twl4030_keypad cleanup
Date: Fri, 23 Jan 2009 15:23:23 -0800
Message-ID: <20090123232318.GZ7172@atomide.com>
References: <200901200051.47122.david-b@pacbell.net> <20090123201751.GC440@frodo> <200901231311.03982.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61660 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757630AbZAWXX1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 18:23:27 -0500
Content-Disposition: inline
In-Reply-To: <200901231311.03982.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, OMAP <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [090123 13:11]:
> On Friday 23 January 2009, Felipe Balbi wrote:
> > This looks good. I also see this driver is going to mainline, so we're
> > gonna have to drop this driver from l-o on 2.6.30 merge window, right ?
> 
> If by "we" you mean "Tony", I suppose so.  ;)
> 
> My notion is that this patch merges, and then I'll send
> two patches:  (a) to OMAP, a rename patch; (b) to mainline,
> submit the cleaned-up-and-renamed driver.
> 
> Then when it merges to mainline, there will be no deltas
> between the driver versions, and Tony won't have to think
> about such issues.

Great, I like!

Tony
