From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Fix IO address issue.
Date: Thu, 9 Oct 2008 15:40:11 +0300
Message-ID: <20081009124011.GB32342@gandalf.research.nokia.com>
References: <1223555249-5223-1-git-send-email-roman.tereshonkov@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61957 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947AbYJIMkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 08:40:19 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m99CeG22004964
	for <linux-omap@vger.kernel.org>; Thu, 9 Oct 2008 07:40:17 -0500
Content-Disposition: inline
In-Reply-To: <1223555249-5223-1-git-send-email-roman.tereshonkov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Roman Tereshonkov <roman.tereshonkov@nokia.com>
Cc: linux-omap@vger.kernel.org

On Thu, Oct 09, 2008 at 03:27:29PM +0300, Tereshonkov Roman wrote:
> 
> Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> ---
>  drivers/misc/sti/sdti.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/sti/sdti.c b/drivers/misc/sti/sdti.c
> index c35821d..2631ccf 100644
> --- a/drivers/misc/sti/sdti.c
> +++ b/drivers/misc/sti/sdti.c
> @@ -32,7 +32,7 @@
>  #define CPU2_TRACE_EN		0x02
>  
>  static struct clk *sdti_ck;
> -unsigned long sti_base, sti_channel_base;
> +void __iomem sti_base, sti_channel_base;

this is wrong. They should be pointers

>  static DEFINE_SPINLOCK(sdti_lock);
>  
>  void omap_sti_channel_write_trace(int len, int id, void *data,
> @@ -137,14 +137,14 @@ static int __devinit omap_sdti_probe(struct platform_device *pdev)
>  	}
>  
>  	size = res->end - res->start;
> -	sti_base = (unsigned long)ioremap(res->start, size);
> +	sti_base = ioremap(res->start, size);
>  	if (unlikely(!sti_base))
>  		return -ENODEV;
>  
>  	size = cres->end - cres->start;
> -	sti_channel_base = (unsigned long)ioremap(cres->start, size);
> +	sti_channel_base = ioremap(cres->start, size);
>  	if (unlikely(!sti_channel_base)) {
> -		iounmap((void *)sti_base);
> +		iounmap(sti_base);
>  		return -ENODEV;
>  	}
>  
> @@ -153,8 +153,8 @@ static int __devinit omap_sdti_probe(struct platform_device *pdev)
>  
>  static int __devexit omap_sdti_remove(struct platform_device *pdev)
>  {
> -	iounmap((void *)sti_channel_base);
> -	iounmap((void *)sti_base);
> +	iounmap(sti_channel_base);
> +	iounmap(sti_base);
>  	omap_sdti_exit();
>  
>  	return 0;
> -- 
> 1.5.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
