From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [RFC] Remove the debug print noise
Date: Fri, 6 Aug 2010 12:14:19 +0300
Message-ID: <20100806091419.GF23778@atomide.com>
References: <1280753271-21182-1-git-send-email-shubhrajyoti@ti.com>
 <20100802125215.GA30753@nokia.com>
 <0680EC522D0CC943BC586913CF3768C003B38719CA@dbde02.ent.ti.com>
 <4C56CC5A.3040708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65278 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933055Ab0HFJNz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 05:13:55 -0400
Content-Disposition: inline
In-Reply-To: <4C56CC5A.3040708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Nishanth Menon <nm@ti.com> [100802 16:40]:
> Datta, Shubhrajyoti had written, on 08/02/2010 07:59 AM, the following:
> >
> >>-----Original Message-----
> >>From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> >>Sent: Monday, August 02, 2010 6:22 PM
> >>To: Datta, Shubhrajyoti
> >>Cc: linux-omap@vger.kernel.org; Tony Lindgren
> >>Subject: Re: [PATCH] [RFC] Remove the debug print noise
> >>
> >>Hi,
> >>
> >>On Mon, Aug 02, 2010 at 02:47:51PM +0200, ext Shubhrajyoti D wrote:
> >>>@@ -626,7 +626,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter
> >>*adap,
> >>>	if (r < 0)
> >>>		return r;
> >>>	if (r == 0) {
> >>>-		dev_err(dev->dev, "controller timed out\n");
> >>>+		dev_dbg(dev->dev, "controller timed out\n");
> >>you would better be searching for the cause of the timeout. 1 second is
> >>enough time (or should be) for any i2c command to complete. If you have
> >>an easy way to reproduce this problem, then better search for its
> >>rootcause. If I remember correctly, this timeout was put here for a good
> >>reason.
> >
> >The reason I am getting the timeout is that there isn't a device
> >to respond in that address However # ./i2cdetect -y -r 3
> >     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> >00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> >10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> >20: -- -- -- -- -- -- -- -- -- 29 -- -- -- -- -- --
> >30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> >40: -- -- -- -- -- -- -- -- 48 -- -- 4b -- -- -- --
> >
> >Is more readable than      0  1  2  3  4  5  6  7  8  9  a  b  c
> >d  e  f
> >00:          -- i2c_omap i2c_omap.3: controller timed out
> >-- -- i2c_omap i2c_omap.3: controller timed out
> >-- -- i2c_omap i2c_omap.3: controller timed out
> >-- -- i2c_omap i2c_omap.3: controller timed out
> >-- -- i2c_omap i2c_omap.3: controller timed out
> >-- -- i2c_omap i2c_omap.3: controller timed out
> >-- --
> >
> 
> this is still not a debug message -> dev_warn perhaps to flag that
> this is indeed an error from the driver point of view?
> 
> >>Tony, any comments ?

Errors like this should be handled at the I2C bus level,
not at the driver level. But looks like the I2C bus does
not do anything about it.. So dev_warn sounds good to me.

Tony

