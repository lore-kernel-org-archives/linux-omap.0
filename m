From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc3-omap git 1/2] mmc-twl4030 gpios for all
	controllers
Date: Fri, 7 Nov 2008 13:03:31 -0800
Message-ID: <20081107210330.GM21736@atomide.com>
References: <200811071155.55180.david-b@pacbell.net> <20081107200732.GK21736@atomide.com> <200811071252.58072.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62679 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYKGVDd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 16:03:33 -0500
Content-Disposition: inline
In-Reply-To: <200811071252.58072.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081107 12:53]:
> On Friday 07 November 2008, Tony Lindgren wrote:
> > > Goes on top of the patch I sent yesterday.
> > 
> > Great, pushing both today.
> > 
> > > So the remaining notably-messy bits of mmc-twl4030 glue seem
> > > to be lack of MMC3 support, and the voltage regulator stuff
> > > hard-wiring knowledge and not using drivers/regulator.
> > 
> > OK
> 
> BTW ... "messy" doesn't mean there's a reason not to start
> pushing this upstream.  :)

Yeah, I'll post all the files within few days for review.

Tony
