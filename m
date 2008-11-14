From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc3-omap 0/4] twl4030 regulator support
Date: Thu, 13 Nov 2008 16:46:11 -0800
Message-ID: <200811131646.12074.david-b@pacbell.net>
References: <200811111756.20719.david-b@pacbell.net> <20081113223211.GN3106@atomide.com> <200811131616.43078.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:42179 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753109AbYKNBAt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2008 20:00:49 -0500
In-Reply-To: <200811131616.43078.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thursday 13 November 2008, David Brownell wrote:
> On Thursday 13 November 2008, Tony Lindgren wrote:
> > Nice! Do you want to wait a bit before converting HSMMC to avoid
> > adding extra dependencies to get that driver merged upstream first?
> 
> That would seem simplest, yes.
> 

Oh, and somewhat related ... nothing seems to turn off unused
regulators.  I'm thinking that bitmasks to define the P1/P2/P3
group memberships of most power resources would do the job.

- Dave

