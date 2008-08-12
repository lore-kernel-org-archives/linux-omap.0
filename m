From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix isp1301_omap compile (Re: testers wanted:
 isp1301_omap  conversion to new-style i2c driver)
Date: Tue, 12 Aug 2008 03:17:53 -0700
Message-ID: <20080812101753.02CC4362AC4@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:28156 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752729AbYHLKMU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Aug 2008 06:12:20 -0400
In-Reply-To: <20080812092918.GD29948@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, khali@linux-fr.org, felipe.balbi@nokia.com, dsaxena@plexity.net, carlos.aguiar@indt.org.br

> > > 	f35ae6346850f6c192269b09088b20261760f0e0
> > 
> > Tony, actually ... there were some issues in the omap_udc code too.
>
> Yeah, blame it on me, looks like I missed that one somehow with the
> __REG removal.

So did a lot of other folk!
