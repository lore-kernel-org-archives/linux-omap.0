From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] Fix isp1301_omap compile (Re: testers wanted:
 isp1301_omap  conversion to new-style i2c driver)
Date: Mon, 18 Aug 2008 14:34:22 +0200
Message-ID: <20080818143422.58ef5131@hyperion.delvare>
References: <200808071651.43297.david-b@pacbell.net>
	<20080808072954.GH24923@atomide.com>
	<20080808111751.494702cc@hyperion.delvare>
	<20080808094551.GP24923@atomide.com>
	<20080808094853.GW30719@gandalf.research.nokia.com>
	<20080811152410.GN25784@atomide.com>
	<20080811182327.465d5889@hyperion.delvare>
	<20080811184026.DF0861E1FB2@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20080812092918.GD29948@atomide.com>
	<20080812115147.3896bbcd@hyperion.delvare>
	<20080818122144.GC17827@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:12741 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbYHRMeg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 08:34:36 -0400
In-Reply-To: <20080818122144.GC17827@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, felipe.balbi@nokia.com, dsaxena@plexity.net, carlos.aguiar@indt.org.br

On Mon, 18 Aug 2008 15:21:45 +0300, Tony Lindgren wrote:
> * Jean Delvare <khali@linux-fr.org> [080812 12:52]:
> > Hi Tony,
> > 
> > On Tue, 12 Aug 2008 12:29:18 +0300, Tony Lindgren wrote:
> > > * David Brownell <david-b@pacbell.net> [080811 21:35]:
> > > > > That one isn't mine, the original code already has the problem.
> > > > > Apparently this was broken by the following patch from David:
> > > > >
> > > > > 	f35ae6346850f6c192269b09088b20261760f0e0
> > > > 
> > > > Tony, actually ... there were some issues in the omap_udc code too.
> > > 
> > > Yeah, blame it on me, looks like I missed that one somehow with the
> > > __REG removal.
> > > 
> > > > > The fix should be sent to Linus ASAP, otherwise the driver won't build
> > > > > in 2.6.27. You have my ack.
> > > 
> > > Can you send it via your I2C? Let me know if your want me to send it
> > > via arm-omap fixes.
> > 
> > Please take care of it. The patch that broke the driver came through
> > your tree so I think it makes more sense to have the fix come through
> > your tree as well.
> 
> Well looks like there's already cbbcb9b0c7e4d1fd90cf54427382dae525773dc2
> taking care of it the second part of my earlier patch.
> 
> But the following patch still needs to be merged into Felipe's
> "2c/isp1301_omap: Convert to a new-style i2c driver, part 1" patch.

I've done that already.

-- 
Jean Delvare
