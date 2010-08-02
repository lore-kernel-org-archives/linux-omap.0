From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] [RFC] Remove the debug print noise
Date: Mon, 2 Aug 2010 15:52:15 +0300
Message-ID: <20100802125215.GA30753@nokia.com>
References: <1280753271-21182-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19137 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab0HBMxT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 08:53:19 -0400
Content-Disposition: inline
In-Reply-To: <1280753271-21182-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi,

On Mon, Aug 02, 2010 at 02:47:51PM +0200, ext Shubhrajyoti D wrote:
>@@ -626,7 +626,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> 	if (r < 0)
> 		return r;
> 	if (r == 0) {
>-		dev_err(dev->dev, "controller timed out\n");
>+		dev_dbg(dev->dev, "controller timed out\n");

you would better be searching for the cause of the timeout. 1 second is 
enough time (or should be) for any i2c command to complete. If you have 
an easy way to reproduce this problem, then better search for its 
rootcause. If I remember correctly, this timeout was put here for a good 
reason.

Tony, any comments ?

-- 
balbi

DefectiveByDesign.org
