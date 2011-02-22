From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Tue, 22 Feb 2011 11:27:59 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102221127180.22636@utopia.booyaka.com>
References: <20110217171747.GC14574@legolas.emea.dhcp.ti.com> <4D5D59E5.6020307@ti.com> <20110217173711.GF14574@legolas.emea.dhcp.ti.com> <4D5D5F13.2010602@ti.com> <20110217181849.GV20795@atomide.com> <4D5E7DFF.7020609@ti.com> <20110218154135.GF11151@legolas.emea.dhcp.ti.com>
 <4D5EA36A.4000903@ti.com> <20110221182213.GD15225@atomide.com> <4D62DAF0.9050301@ti.com> <20110221220815.GG15225@atomide.com> <4D62ECCC.3040208@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54514 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822Ab1BVS2A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 13:28:00 -0500
In-Reply-To: <4D62ECCC.3040208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Balbi, Felipe" <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

On Mon, 21 Feb 2011, Cousson, Benoit wrote:

> Meanwhile, the following will just prevent the fmwk to reset and idle the
> timer during hwmod_init.
> 
> Regards,
> Benoit

Looks okay to me for the time being.

Acked-by: Paul Walmsley <paul@pwsan.com>

> 
> 
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -3989,6 +3989,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer1_slaves[] = {
>  static struct omap_hwmod omap44xx_timer1_hwmod = {
>  	.name		= "timer1",
>  	.class		= &omap44xx_timer_1ms_hwmod_class,
> +	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
>  	.mpu_irqs	= omap44xx_timer1_irqs,
>  	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
>  	.main_clk	= "timer1_fck",
> 


- Paul
