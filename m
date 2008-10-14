From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Tue, 14 Oct 2008 10:47:44 -0700
Message-ID: <200810141047.44803.david-b@pacbell.net>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com> <alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com> <20081014172921.GJ20247@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:34795 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750875AbYJNSC1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 14:02:27 -0400
In-Reply-To: <20081014172921.GJ20247@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Tuesday 14 October 2008, Felipe Balbi wrote:
> I didn't quite get you here. The idea of mmc_fck is so that
> 
> clk_get(dev, "mmc_fck");
> 
> works fine and returns the correct clock. If we have several fck and ick
> function names, how will we clk_get() the right one ??

If "dev" is an MMC device, there's no way to confuse
its "fck" and "ick" with those for, say, I2C.   Right?
That's the whole point of associating logical clock
names with the device.

And as Paul noted, if a device has several such clocks,
then it needs several such names.

