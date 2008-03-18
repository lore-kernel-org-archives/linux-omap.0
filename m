From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] DSP: Fix dsp_common.c compile breakage
Date: Tue, 18 Mar 2008 11:18:52 +0200
Message-ID: <20080318091852.GF20921@atomide.com>
References: <1205783450-16673-1-git-send-email-me@felipebalbi.com> <1205783450-16673-2-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56356 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYCRJTf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 05:19:35 -0400
Content-Disposition: inline
In-Reply-To: <1205783450-16673-2-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080317 21:49]:
> Recent changes broke compilation for omap1.
> 
> Signed-off-by: Felipe Balbi <me@felipebalbi.com>
> ---
>  drivers/dsp/dspgateway/dsp_common.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dsp/dspgateway/dsp_common.c b/drivers/dsp/dspgateway/dsp_common.c
> index af97ce1..aeeadf4 100644
> --- a/drivers/dsp/dspgateway/dsp_common.c
> +++ b/drivers/dsp/dspgateway/dsp_common.c
> @@ -478,7 +478,7 @@ void dsp_cpustat_set_icrmask(u16 mask)
>  	mutex_unlock(&cpustat.lock);
>  }
>  
> -#ifdef CONFIG_ARCH_OMAP1
> +#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
>  void omap_dsp_request_mpui(void)
>  {
>  	mutex_lock(&cpustat.lock);
> @@ -594,7 +594,7 @@ void dsp_unregister_mem_cb(void) { }
>  
>  arch_initcall(omap_dsp_init);
>  
> -#ifdef CONFIG_ARCH_OMAP1
> +#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
>  EXPORT_SYMBOL(omap_dsp_request_mpui);
>  EXPORT_SYMBOL(omap_dsp_release_mpui);
>  EXPORT_SYMBOL(omap_dsp_request_mem);

Pushing Dave's patch instead, can you please check that it works OK
for you?

Tony
