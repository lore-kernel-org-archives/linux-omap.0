From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] Fix section mismatch warnings on some OMAP1 boards
Date: Wed, 12 Nov 2008 09:13:45 +0000
Message-ID: <20081112091345.GA2853@earth.li>
References: <20081111225720.GA3162@earth.li> <20081112003637.GU3984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from limegreen.tangerine.org.uk ([217.147.81.4]:33584 "EHLO
	limegreen.tangerine.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751510AbYKLJOE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2008 04:14:04 -0500
Content-Disposition: inline
In-Reply-To: <20081112003637.GU3984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

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

Hmmm. Well that isn't going to work at present anyway, because the 3
members of ams_delta_config are marked __initdata.

> Let's rather just get rid of all the omap_board_config_kernel stuff
> and use platform_data instead.

Ok. I shall attempt to find time to test Felipe's USB tag removal patch.

J.
