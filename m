From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] Fix isp1301_omap compile (Re: testers wanted:
 isp1301_omap  conversion to new-style i2c driver)
Date: Tue, 12 Aug 2008 11:51:47 +0200
Message-ID: <20080812115147.3896bbcd@hyperion.delvare>
References: <20080617204300.77c8e516@hyperion.delvare>
	<20080807183416.115c67ba@hyperion.delvare>
	<200808071651.43297.david-b@pacbell.net>
	<20080808072954.GH24923@atomide.com>
	<20080808111751.494702cc@hyperion.delvare>
	<20080808094551.GP24923@atomide.com>
	<20080808094853.GW30719@gandalf.research.nokia.com>
	<20080811152410.GN25784@atomide.com>
	<20080811182327.465d5889@hyperion.delvare>
	<20080811184026.DF0861E1FB2@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20080812092918.GD29948@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:19027 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbYHLJv7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 05:51:59 -0400
In-Reply-To: <20080812092918.GD29948@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, felipe.balbi@nokia.com, dsaxena@plexity.net, carlos.aguiar@indt.org.br

Hi Tony,

On Tue, 12 Aug 2008 12:29:18 +0300, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [080811 21:35]:
> > > That one isn't mine, the original code already has the problem.
> > > Apparently this was broken by the following patch from David:
> > >
> > > 	f35ae6346850f6c192269b09088b20261760f0e0
> > 
> > Tony, actually ... there were some issues in the omap_udc code too.
> 
> Yeah, blame it on me, looks like I missed that one somehow with the
> __REG removal.
> 
> > > The fix should be sent to Linus ASAP, otherwise the driver won't build
> > > in 2.6.27. You have my ack.
> 
> Can you send it via your I2C? Let me know if your want me to send it
> via arm-omap fixes.

Please take care of it. The patch that broke the driver came through
your tree so I think it makes more sense to have the fix come through
your tree as well.

Thanks,
-- 
Jean Delvare
