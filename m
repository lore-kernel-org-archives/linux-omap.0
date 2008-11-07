From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc3-omap git 1/2] mmc-twl4030 gpios for all controllers
Date: Fri, 7 Nov 2008 12:52:57 -0800
Message-ID: <200811071252.58072.david-b@pacbell.net>
References: <200811071155.55180.david-b@pacbell.net> <20081107200732.GK21736@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:44145 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750976AbYKGUw7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 15:52:59 -0500
In-Reply-To: <20081107200732.GK21736@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Friday 07 November 2008, Tony Lindgren wrote:
> > Goes on top of the patch I sent yesterday.
> 
> Great, pushing both today.
> 
> > So the remaining notably-messy bits of mmc-twl4030 glue seem
> > to be lack of MMC3 support, and the voltage regulator stuff
> > hard-wiring knowledge and not using drivers/regulator.
> 
> OK

BTW ... "messy" doesn't mean there's a reason not to start
pushing this upstream.  :)

- dave
