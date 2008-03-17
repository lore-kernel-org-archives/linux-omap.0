From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix compile issues for DSP
Date: Mon, 17 Mar 2008 18:46:07 +0200
Message-ID: <20080317164606.GC20921@atomide.com>
References: <20080317154822.GB4775@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55005 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYCQQqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 12:46:46 -0400
Content-Disposition: inline
In-Reply-To: <20080317154822.GB4775@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [080317 18:01]:
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> diff --git a/include/asm-arm/arch-omap/dsp_common.h b/include/asm-arm/arch-omap/dsp_common.h
> index e515801..0c7565e 100644
> --- a/include/asm-arm/arch-omap/dsp_common.h
> +++ b/include/asm-arm/arch-omap/dsp_common.h
> @@ -49,7 +49,7 @@ struct omap_dsp {
>  	int			initialized;
>  };
>  
> -if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
> +#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
>  extern void omap_dsp_request_mpui(void);
>  extern void omap_dsp_release_mpui(void);
>  extern int omap_dsp_request_mem(void);

Heh, thanks :) Pushing today.

Tony
