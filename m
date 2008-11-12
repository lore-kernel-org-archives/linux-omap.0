From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix section mismatch warnings on some OMAP1 boards
Date: Wed, 12 Nov 2008 04:00:55 +0200
Message-ID: <20081112020054.GA7840@frodo>
References: <20081111225720.GA3162@earth.li> <20081112003637.GU3984@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39084 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbYKLCBD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 21:01:03 -0500
Content-Disposition: inline
In-Reply-To: <20081112003637.GU3984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jonathan McDowell <noodles@earth.li>, linux-omap@vger.kernel.org

On Tue, Nov 11, 2008 at 04:36:38PM -0800, Tony Lindgren wrote:
> * Jonathan McDowell <noodles@earth.li> [081111 15:43]:
> > I got some section mismatch warnings when compiling latest git for
> > MACH_AMS_DELTA this evening; this seems to be due to a missing
> > __initdata on the omap_board_config_kernel. Adding it fixes the
> > warnings. I noticed that although this had been done for other OMAP1
> > boards fsample, innovator and voiceblue were all lacking it too, so I
> > fixed them up at the same time.
> 
> These cannot be __initdata as they are used by get_config() in
> plat-omap/common.c, and omap_get_config() is called in some drivers
> that could be modules.
> 
> Let's rather just get rid of all the omap_board_config_kernel stuff
> and use platform_data instead.

I sent a patch getting rid of OMAP_TAG_USB and converting the usb stuff
to platform_data. Still untested as I don't have access to omap1.

here's [1] the link for it if anyone with omap1 is interested in
testing.

[1] http://marc.info/?l=linux-omap&m=122235260714143&w=2

-- 
balbi
