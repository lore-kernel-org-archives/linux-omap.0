From: Tony Lindgren <tony@atomide.com>
Subject: Re: another dsp build fix ...
Date: Tue, 18 Mar 2008 11:19:29 +0200
Message-ID: <20080318091929.GH20921@atomide.com>
References: <200803172141.12298.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56881 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbYCRJUL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 05:20:11 -0400
Content-Disposition: inline
In-Reply-To: <200803172141.12298.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080318 06:41]:
> Another compile fix for DSP code ... these symbols are defined
> as NOPs in a header.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/dsp/dspgateway/dsp_common.c |    4 ++++
>  1 files changed, 4 insertions(+)
> 
> --- osk2.orig/drivers/dsp/dspgateway/dsp_common.c	2008-03-17 21:03:13.000000000 -0700
> +++ osk2/drivers/dsp/dspgateway/dsp_common.c	2008-03-17 21:03:16.000000000 -0700
> @@ -502,6 +502,7 @@ void omap_dsp_release_mpui(void)
>  	mutex_unlock(&cpustat.lock);
>  }
>  
> +#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
>  int omap_dsp_request_mem(void)
>  {
>  	int ret = 0;
> @@ -564,6 +565,7 @@ int omap_dsp_release_mem(void)
>  
>  	return 0;
>  }
> +#endif
>  
>  void dsp_register_mem_cb(int (*req_cb)(void), void (*rel_cb)(void))
>  {
> @@ -597,8 +599,10 @@ arch_initcall(omap_dsp_init);
>  #ifdef CONFIG_ARCH_OMAP1
>  EXPORT_SYMBOL(omap_dsp_request_mpui);
>  EXPORT_SYMBOL(omap_dsp_release_mpui);
> +#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
>  EXPORT_SYMBOL(omap_dsp_request_mem);
>  EXPORT_SYMBOL(omap_dsp_release_mem);
> +#endif
>  #endif /* CONFIG_ARCH_OMAP1 */
>  
>  #ifdef CONFIG_OMAP_DSP_MODULE

Pushing today.

Tony
