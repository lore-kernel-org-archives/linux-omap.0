From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc3-omap 0/4] twl4030 regulator support
Date: Thu, 13 Nov 2008 17:03:12 -0800
Message-ID: <20081114010311.GE3106@atomide.com>
References: <200811111756.20719.david-b@pacbell.net> <20081113223211.GN3106@atomide.com> <200811131616.43078.david-b@pacbell.net> <200811131646.12074.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53150 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbYKNBDP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 20:03:15 -0500
Content-Disposition: inline
In-Reply-To: <200811131646.12074.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081113 17:01]:
> On Thursday 13 November 2008, David Brownell wrote:
> > On Thursday 13 November 2008, Tony Lindgren wrote:
> > > Nice! Do you want to wait a bit before converting HSMMC to avoid
> > > adding extra dependencies to get that driver merged upstream first?
> > 
> > That would seem simplest, yes.
> > 
> 
> Oh, and somewhat related ... nothing seems to turn off unused
> regulators.  I'm thinking that bitmasks to define the P1/P2/P3
> group memberships of most power resources would do the job.

Yeah I was wondering about that too. Should the processor group
membership be set only once during init?

Tony
