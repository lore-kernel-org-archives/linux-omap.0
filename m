From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2/2 rc8-omap-git] twl4030-core irq simplification
Date: Tue, 7 Oct 2008 12:53:48 +0300
Message-ID: <20081007095347.GI21037@atomide.com>
References: <200810062043.35080.david-b@pacbell.net> <20081007085912.GG21037@atomide.com> <200810070218.10819.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65213 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbYJGJuu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 05:50:50 -0400
Content-Disposition: inline
In-Reply-To: <200810070218.10819.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081007 12:18]:
> On Tuesday 07 October 2008, Tony Lindgren wrote:
> > Pushed.
> 
> Cool.  Now, once the pwrirq updates get sorted out, there
> will be only two main steps left in my plan:
> 
>  - Rework the twl4030 core SIH init.  Basically, use a
>    different IRQ setup data structure, which will be kept
>    around for later use by ...
> 
>  - New generic SIH IRQ handling code using that data, and
>    looking much like the current GPIO stuff (in current GIT,
>    after you merged the patch updating it) -- but sharable
>    between at least GPIO and pwrirq, and replacing pwrirq.
> 
> I'm going to hold back on sending that stuff out until at
> least next week, to let things shake out a bit more.   Find
> the i2c-omap issue; sort the Overo puzzle; etc.

Yeah, OK. Let's get broken things fixed so we can tag -omap1
soon after 2.6.27 is released.

Tony
