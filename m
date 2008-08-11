From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] Fix isp1301_omap compile (Re: testers wanted:
 isp1301_omap  conversion to new-style i2c driver)
Date: Mon, 11 Aug 2008 18:23:27 +0200
Message-ID: <20080811182327.465d5889@hyperion.delvare>
References: <20080617204300.77c8e516@hyperion.delvare>
	<20080807183416.115c67ba@hyperion.delvare>
	<200808071651.43297.david-b@pacbell.net>
	<20080808072954.GH24923@atomide.com>
	<20080808111751.494702cc@hyperion.delvare>
	<20080808094551.GP24923@atomide.com>
	<20080808094853.GW30719@gandalf.research.nokia.com>
	<20080811152410.GN25784@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:34570 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYHKQXq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 12:23:46 -0400
In-Reply-To: <20080811152410.GN25784@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Deepak Saxena <dsaxena@plexity.net>, carlos.aguiar@indt.org.br

Hi Tony,

On Mon, 11 Aug 2008 18:24:11 +0300, Tony Lindgren wrote:
> Hi,
> 
> * Felipe Balbi <felipe.balbi@nokia.com> [080808 12:49]:
> > On Fri, Aug 08, 2008 at 12:45:52PM +0300, Tony Lindgren wrote:
> > > Yeah, I will add it to linux-omap for testing for sure. This should be
> > > easy to test though, it either works or does not.. But we need to find
> > > somebody to boot it and connect USB cable to it :)
> > 
> > Hi Carlos,
> > 
> > could you test it for us on H2 ??
> > 
> > Do you guys still have H2 boards there ?
> 
> Also H4 needs to be tested.
> 
> I've synced linux-omap tree with mainline tree at v2.6.27-rc2, and
> applied Felipe's and Jean's patches. Following patch should be merged
> to them to fix compile.

Thank you.

> From d12a00e66e97f2e808217eb3e9c9e88d4a281530 Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 11 Aug 2008 17:45:32 +0300
> Subject: [PATCH] I2C: Fix isp1301_omap.c compile
> 
> Fix isp1301_omap.c compile
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
> index c250668..71a0a2e 100644
> --- a/drivers/i2c/chips/isp1301_omap.c
> +++ b/drivers/i2c/chips/isp1301_omap.c
> @@ -1210,7 +1210,7 @@ static void isp1301_release(struct device *dev)
>  {
>  	struct isp1301	*isp;
>  
> -	isp = device_get_drvdata(dev);
> +	isp = dev_get_drvdata(dev);
>  
>  	/* ugly -- i2c hijacks our memory hook to wait_for_completion() */
>  	if (isp->i2c_release)

Oops, good catch, thanks. Fixed.

> @@ -1564,7 +1564,7 @@ static int __init isp1301_probe(struct i2c_client *i2c)
>  	if (machine_is_omap_h2()) {
>  		/* full speed signaling by default */
>  		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1,
> -			MC1_SPEED_REG);
> +			MC1_SPEED);
>  		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_2,
>  			MC2_SPD_SUSP_CTRL);
>  

That one isn't mine, the original code already has the problem.
Apparently this was broken by the following patch from David:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=f35ae6346850f6c192269b09088b20261760f0e0

The fix should be sent to Linus ASAP, otherwise the driver won't build
in 2.6.27. You have my ack.

-- 
Jean Delvare
