From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Tue, 14 Oct 2008 21:06:35 +0300
Message-ID: <20081014180634.GL20247@frodo>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com> <alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com> <20081014172921.GJ20247@frodo> <200810141047.44803.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39630 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbYJNSGp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 14:06:45 -0400
Content-Disposition: inline
In-Reply-To: <200810141047.44803.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Tue, Oct 14, 2008 at 10:47:44AM -0700, David Brownell wrote:
> On Tuesday 14 October 2008, Felipe Balbi wrote:
> > I didn't quite get you here. The idea of mmc_fck is so that
> > 
> > clk_get(dev, "mmc_fck");
> > 
> > works fine and returns the correct clock. If we have several fck and ick
> > function names, how will we clk_get() the right one ??
> 
> If "dev" is an MMC device, there's no way to confuse
> its "fck" and "ick" with those for, say, I2C.   Right?
> That's the whole point of associating logical clock
> names with the device.
> 
> And as Paul noted, if a device has several such clocks,
> then it needs several such names.

hmm... that's true. Forgot about matching dev as well :-p
hehehe. Makes sense to me, let's use fclk and iclk then :-)

The main idea then would be that clk(dev, "iclk") translates to english
into "get me the interface clock of mmc device" (when dev is an mmc
device, of course).

-- 
balbi
