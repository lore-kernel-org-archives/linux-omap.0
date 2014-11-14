From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v9] ARM: omap: edma: add suspend resume hook
Date: Fri, 14 Nov 2014 18:07:15 +0100
Message-ID: <546636C3.8070202@zonque.org>
References: <1409043173-24357-1-git-send-email-zonque@gmail.com> <546635DB.4020202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:59362 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161333AbaKNRHX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2014 12:07:23 -0500
In-Reply-To: <546635DB.4020202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, d-gerlach@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com

Hi Sekhar,

On 11/14/2014 06:03 PM, Sekhar Nori wrote:
> I think I have asked this before, and I am still not sure why this call 
> to pm_runtime_get_sync() is needed here. From my testing today, this 
> does seem to be a a no-op and this call returns from rpm_resume() 
> because of this check:
> 
> 	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> 	    && dev->power.runtime_status == RPM_ACTIVE)
> 		retval = 1;

Yes. IIRC, it was in fact not needed.

> So, AFAICS, the net effect is an increment of dev->power.usage_count
> (which is already greater than 0) and its subsequent decrement at the
> end of the function.
> 
> After removing this call I did not see any EDMA malfunction as well 
> (can access MMC/SD just fine after suspend/resume cycle).
> 
> So, any objections to merging this patch with the attached hunk 
> applied?

Looks good to me, we can still add it back later if it turns out to be
needed.


Thanks,
Daniel


> Thanks,
> Sekhar
> 
> ---8<---
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 1f492d5be9c0..79de6a23047b 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -1803,13 +1803,7 @@ static int edma_probe(struct platform_device *pdev)
>  
>  static int edma_pm_resume(struct device *dev)
>  {
> -       int i, j, r;
> -
> -       r = pm_runtime_get_sync(dev);
> -       if (r < 0) {
> -               dev_err(dev, "%s: get_sync returned %d\n", __func__, r);
> -               return r;
> -       }
> +       int i, j;
>  
>         for (j = 0; j < arch_num_cc; j++) {
>                 struct edma *cc = edma_cc[j];
> @@ -1844,8 +1838,6 @@ static int edma_pm_resume(struct device *dev)
>                 }
>         }
>  
> -       pm_runtime_put_sync(dev);
> -
>         return 0;
>  }
> 
> 

