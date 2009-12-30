From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch-v2.6.33-rc2+ 02/12] arm: omap: musb: fix board power budget
 by passing it to usb_musb_init
Date: Wed, 30 Dec 2009 14:13:05 +0300
Message-ID: <4B3B35C1.6060501@ru.mvista.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com> <1262127092-14878-3-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:54135 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752696AbZL3LN1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 06:13:27 -0500
In-Reply-To: <1262127092-14878-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org

Hello.

Felipe Balbi wrote:

> each board might have a different charge pump and
> thus able to source more or less current on vbus
> so let power be easily configurable.
>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

[...]

> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index ba71f76..b4b8ccc 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -124,12 +124,7 @@ static struct musb_hdrc_platform_data musb_plat = {
>  	/* .clock is set dynamically */
>  	.set_clock	= musb_set_clock,
>  	.config		= &musb_config,
> -
> -	/* REVISIT charge pump on TWL4030 can supply up to
> -	 * 100 mA ... but this value is board-specific, like
> -	 * "mode", and should be passed to usb_musb_init().
> -	 */
> -	.power		= 50,			/* up to 100 mA */
> +	/* .power	= DYNAMIC, */
>  };
>  
>  static u64 musb_dmamask = DMA_BIT_MASK(32);
> @@ -146,7 +141,7 @@ static struct platform_device musb_device = {
>  	.resource	= musb_resources,
>  };
>  
> -void __init usb_musb_init(void)
> +void __init usb_musb_init(unsigned power)
>  {
>  	if (cpu_is_omap243x())
>  		musb_resources[0].start = OMAP243X_HS_BASE;
> @@ -159,6 +154,7 @@ void __init usb_musb_init(void)
>  	 * musb_core.c have been converted to use use clkdev.
>  	 */
>  	musb_plat.clock = "ick";
> +	musb_plat.power = power >> 1;
>   

   Probably OMAP boards never supply much current, but otherwise capping 
the value of 'power' at 510 seems a good idea.

WBR, Sergei


