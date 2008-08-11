From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix isp1301_omap compile (Re: testers wanted:
 isp1301_omap  conversion to new-style i2c driver)
Date: Mon, 11 Aug 2008 11:40:26 -0700
Message-ID: <20080811184026.DF0861E1FB2@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20080617204300.77c8e516@hyperion.delvare>
 <20080807183416.115c67ba@hyperion.delvare>
 <200808071651.43297.david-b@pacbell.net>
 <20080808072954.GH24923@atomide.com>
 <20080808111751.494702cc@hyperion.delvare>
 <20080808094551.GP24923@atomide.com>
 <20080808094853.GW30719@gandalf.research.nokia.com>
 <20080811152410.GN25784@atomide.com>
 <20080811182327.465d5889@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:37842 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751867AbYHKSfD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Aug 2008 14:35:03 -0400
In-Reply-To: <20080811182327.465d5889@hyperion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khali@linux-fr.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, felipe.balbi@nokia.com, dsaxena@plexity.net, carlos.aguiar@indt.org.br

> That one isn't mine, the original code already has the problem.
> Apparently this was broken by the following patch from David:
>
> 	f35ae6346850f6c192269b09088b20261760f0e0

Tony, actually ... there were some issues in the omap_udc code too.

> The fix should be sent to Linus ASAP, otherwise the driver won't build
> in 2.6.27. You have my ack.
