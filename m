From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] mach-omap2:Remove unnessary return statement from
 the void function, omap2_show_dma_caps
Date: Mon, 1 Jun 2015 15:02:38 -0700
Message-ID: <20150601220237.GI30984@atomide.com>
References: <1432825205-4663-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55254 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbbFAWCk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 18:02:40 -0400
Content-Disposition: inline
In-Reply-To: <1432825205-4663-1-git-send-email-xerofoify@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nicholas Krause <xerofoify@gmail.com> [150528 08:06]:
> This removes the no longer required return statement at the end
> of the void function, omap2_show_dma_cap due to no need for a
> return statement due to this function always running successfully.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/arm/mach-omap2/dma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> index e1a56d8..1ed4be1 100644
> --- a/arch/arm/mach-omap2/dma.c
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -117,7 +117,6 @@ static void omap2_show_dma_caps(void)
>  	u8 revision = dma_read(REVISION, 0) & 0xff;
>  	printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
>  				revision >> 4, revision & 0xf);
> -	return;
>  }
>  
>  static unsigned configure_dma_errata(void)

Sorry for the delay, applying this into omap-for-v4.2/fixes as
it's not urgent.

Regards,

Tony
