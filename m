From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Rid of product specific SDTI pin multiplexing.
Date: Tue, 5 Aug 2008 13:53:31 +0300
Message-ID: <20080805105331.GR7193@atomide.com>
References: <1217925839-3583-1-git-send-email-roman.tereshonkov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50271 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbYHEKxd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 06:53:33 -0400
Content-Disposition: inline
In-Reply-To: <1217925839-3583-1-git-send-email-roman.tereshonkov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Cc: linux-omap@vger.kernel.org

* Roman Tereshonkov <roman.tereshonkov@nokia.com> [080805 11:48]:
> 

Pushing today.

Tony


> Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> ---
>  drivers/misc/sti/sdti.c |   27 ++-------------------------
>  1 files changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/misc/sti/sdti.c b/drivers/misc/sti/sdti.c
> index adfbcbc..e12fb12 100644
> --- a/drivers/misc/sti/sdti.c
> +++ b/drivers/misc/sti/sdti.c
> @@ -31,13 +31,8 @@
>  #define CPU1_TRACE_EN		0x01
>  #define CPU2_TRACE_EN		0x02
>  
> -#define EPM_BASE		0x5401D000
> -#define EPM_CONTROL_0		0x50
> -#define EPM_CONTROL_1		0x54
> -#define EPM_CONTROL_2		0x58
> -
>  static struct clk *sdti_ck;
> -unsigned long sti_base, sti_channel_base, epm_base;
> +unsigned long sti_base, sti_channel_base;
>  static DEFINE_SPINLOCK(sdti_lock);
>  
>  void omap_sti_channel_write_trace(int len, int id, void *data,
> @@ -69,20 +64,6 @@ static void omap_sdti_reset(void)
>  		printk(KERN_WARNING "XTI: no real reset\n");
>  }
>  
> -void init_epm(void)
> -{
> -	epm_base = (unsigned long)ioremap(EPM_BASE, 256);
> -	if (unlikely(!epm_base)) {
> -		printk(KERN_ERR "EPM cannot be ioremapped\n");
> -		return;
> -	}
> -
> -	__raw_writel(1<<30, epm_base + EPM_CONTROL_2);
> -	__raw_writel(0x78, epm_base + EPM_CONTROL_0);
> -	__raw_writel(0x80000000, epm_base + EPM_CONTROL_1);
> -	__raw_writel(1<<31 | 0x00007770, epm_base + EPM_CONTROL_2);
> -}
> -
>  static int __init omap_sdti_init(void)
>  {
>  	char buf[64];
> @@ -95,9 +76,6 @@ static int __init omap_sdti_init(void)
>  	}
>  	clk_enable(sdti_ck);
>  
> -	/* Init emulation pin manager */
> -	init_epm();
> -
>  	omap_sdti_reset();
>  	sti_writel(0xC5ACCE55, SDTI_LOCK_ACCESS);
>  
> @@ -110,7 +88,7 @@ static int __init omap_sdti_init(void)
>  	/* 4 bits dual, fclk/3 */
>  	sti_writel(0x43, SDTI_SCONFIG);
>  
> -	/* CPU1 trace enable */
> +	/* CPU2 trace enable */
>  	sti_writel(i | CPU2_TRACE_EN, SDTI_WINCTRL);
>  	i = sti_readl(SDTI_WINCTRL);
>  
> @@ -177,7 +155,6 @@ static int __devexit omap_sdti_remove(struct platform_device *pdev)
>  {
>  	iounmap((void *)sti_channel_base);
>  	iounmap((void *)sti_base);
> -	iounmap((void *)epm_base);
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
