From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: clean up some smatch warnings, fix some
 printk(KERN_ERR ...
Date: Tue, 7 Aug 2012 03:40:23 -0700
Message-ID: <20120807104023.GV11011@atomide.com>
References: <20120807103009.8053.69389.stgit@dusk.lan>
 <20120807103439.8053.65054.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50208 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2HGKk0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 06:40:26 -0400
Content-Disposition: inline
In-Reply-To: <20120807103439.8053.65054.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120807 03:35]:
> --- a/arch/arm/mach-omap1/lcd_dma.c
> +++ b/arch/arm/mach-omap1/lcd_dma.c
> @@ -94,7 +94,6 @@ void omap_set_lcd_dma_b1_rotation(int rotate)
>  	if (cpu_is_omap15xx()) {
>  		printk(KERN_ERR "DMA rotation is not supported in 1510 mode\n");
>  		BUG();
> -		return;
>  	}
>  	lcd_dma.rotate = rotate;
>  }
> @@ -154,7 +153,6 @@ static void set_b1_regs(void)
>  		break;
>  	default:
>  		BUG();
> -		return;
>  	}
>  
>  	vxres = lcd_dma.vxres ? lcd_dma.vxres : lcd_dma.xres;
> @@ -234,7 +232,6 @@ static void set_b1_regs(void)
>  		break;
>  	default:
>  		BUG();
> -		return;	/* Suppress warning about uninitialized vars */
>  	}
>  
>  	if (cpu_is_omap15xx()) {

I think these will cause new randconfig warnings without CONFIG_BUG set.

Tony
