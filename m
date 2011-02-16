From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 6/6] cbus: retu: set pm_power_off to NULL when removing
 retu
Date: Wed, 16 Feb 2011 21:51:09 +0200
Message-ID: <20110216195109.GD2451@legolas.emea.dhcp.ti.com>
References: <1297885350-3462-1-git-send-email-balbi@ti.com>
 <1297885350-3462-7-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57925 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750844Ab1BPTvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 14:51:15 -0500
Received: by mail-ey0-f175.google.com with SMTP id 28so997021eya.34
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 11:51:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297885350-3462-7-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Feb 16, 2011 at 09:42:30PM +0200, Felipe Balbi wrote:
> we need to clear pm_power_off otherwise we
> will have kernel trying to call an unexistent
> function.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/cbus/retu.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
> index d0454bd..0ca58b7 100644
> --- a/drivers/cbus/retu.c
> +++ b/drivers/cbus/retu.c
> @@ -489,6 +489,7 @@ static int __init retu_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err2:
> +	pm_power_off = NULL;
>  	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
>  	free_irq(retu->irq, retu);
>  
> @@ -504,7 +505,8 @@ static int __exit retu_remove(struct platform_device *pdev)
>  {
>  	struct retu		*retu = platform_get_drvdata(pdev);
>  
> -	irq = platform_get_irq(pdev, 0);
> +	pm_power_off = NULL;
> +	the_retu = NULL;

there it goes, I commited that hunk to the wrong patch. Sorry about
that.

-- 
balbi
