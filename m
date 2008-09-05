From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Add missing macro argument for devm_release_*
	family
Date: Fri, 5 Sep 2008 10:19:20 -0700
Message-ID: <20080905171920.GL24202@atomide.com>
References: <1220346384-15792-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55944 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbYIERTW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 13:19:22 -0400
Content-Disposition: inline
In-Reply-To: <1220346384-15792-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080902 02:07]:
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

This should be sent via LKML.

Tony

> ---
>  include/linux/ioport.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 22d2115..c813c63 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -158,9 +158,9 @@ extern struct resource * __devm_request_region(struct device *dev,
>  				struct resource *parent, resource_size_t start,
>  				resource_size_t n, const char *name);
>  
> -#define devm_release_region(start,n) \
> +#define devm_release_region(dev,start,n) \
>  	__devm_release_region(dev, &ioport_resource, (start), (n))
> -#define devm_release_mem_region(start,n) \
> +#define devm_release_mem_region(dev,start,n) \
>  	__devm_release_region(dev, &iomem_resource, (start), (n))
>  
>  extern void __devm_release_region(struct device *dev, struct resource *parent,
> -- 
> 1.5.5.1.357.g1af8b
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
