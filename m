From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [PATCH] [RFC] Remove the debug print noise
Date: Mon, 2 Aug 2010 18:29:29 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B38719CA@dbde02.ent.ti.com>
References: <1280753271-21182-1-git-send-email-shubhrajyoti@ti.com>
 <20100802125215.GA30753@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55110 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832Ab0HBM7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 08:59:40 -0400
In-Reply-To: <20100802125215.GA30753@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>



> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Monday, August 02, 2010 6:22 PM
> To: Datta, Shubhrajyoti
> Cc: linux-omap@vger.kernel.org; Tony Lindgren
> Subject: Re: [PATCH] [RFC] Remove the debug print noise
> 
> Hi,
> 
> On Mon, Aug 02, 2010 at 02:47:51PM +0200, ext Shubhrajyoti D wrote:
> >@@ -626,7 +626,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter
> *adap,
> > 	if (r < 0)
> > 		return r;
> > 	if (r == 0) {
> >-		dev_err(dev->dev, "controller timed out\n");
> >+		dev_dbg(dev->dev, "controller timed out\n");
> 
> you would better be searching for the cause of the timeout. 1 second is
> enough time (or should be) for any i2c command to complete. If you have
> an easy way to reproduce this problem, then better search for its
> rootcause. If I remember correctly, this timeout was put here for a good
> reason.

The reason I am getting the timeout is that there isn't a device to respond in that address However 
# ./i2cdetect -y -r 3
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- 29 -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- 48 -- -- 4b -- -- -- --

Is more readable than 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- i2c_omap i2c_omap.3: controller timed out
-- -- i2c_omap i2c_omap.3: controller timed out
-- -- i2c_omap i2c_omap.3: controller timed out
-- -- i2c_omap i2c_omap.3: controller timed out
-- -- i2c_omap i2c_omap.3: controller timed out
-- -- i2c_omap i2c_omap.3: controller timed out
-- --

> Tony, any comments ?
> 
> --
> balbi
> 
> DefectiveByDesign.org
