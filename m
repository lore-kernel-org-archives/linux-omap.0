From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] of: dma: Fix-up for warnings !CONFIG_OF
Date: Fri, 30 Nov 2012 05:17:57 +0530
Message-ID: <1354232877.7077.74.camel@vkoul-udesk3>
References: <1354227867-13357-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7215 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754996Ab2K3AGw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 19:06:52 -0500
In-Reply-To: <1354227867-13357-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Rob Herring <robherring2@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Fengguang Wu <fengguang.wu@intel.com>

On Thu, 2012-11-29 at 16:24 -0600, Jon Hunter wrote:
> When compiling the kernel with DMA engine support enabled and device-tree
> support disabled, the following warnings are observed.
Thanks, already committed same change last night.
> 
> In file included from drivers/dma/dmaengine.c:65:0:
> include/linux/of_dma.h: In function 'of_dma_controller_free':
> include/linux/of_dma.h:57:1: warning: no return statement in function
> 	returning non-void [-Wreturn-type]
> drivers/dma/dmaengine.c: At top level:
> include/linux/of_dma.h:47:12: warning: 'of_dma_controller_register'
> 	defined but not used [-Wunused-function]
> include/linux/of_dma.h:55:12: warning: 'of_dma_controller_free' defined
> 	but not used [-Wunused-function]
> include/linux/of_dma.h:65:25: warning: 'of_dma_simple_xlate' defined
> 	but not used [-Wunused-function]
> 
> Fix-up the warnings by adding a return value for the
> of_dma_controller_free() stub and make all the stubs static inline to
> avoid the unused warnings.
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  include/linux/of_dma.h |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
> index 84b64f8..b14a34f 100644
> --- a/include/linux/of_dma.h
> +++ b/include/linux/of_dma.h
> @@ -44,7 +44,7 @@ extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>  extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
>  		struct of_dma *ofdma);
>  #else
> -static int of_dma_controller_register(struct device_node *np,
> +static inline int of_dma_controller_register(struct device_node *np,
>  		struct dma_chan *(*of_dma_xlate)
>  		(struct of_phandle_args *, struct of_dma *),
>  		void *data)
> @@ -52,18 +52,19 @@ static int of_dma_controller_register(struct device_node *np,
>  	return -ENODEV;
>  }
>  
> -static int of_dma_controller_free(struct device_node *np)
> +static inline int of_dma_controller_free(struct device_node *np)
>  {
> +	return 0;
>  }
>  
> -static struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
> -						     char *name)
> +static inline struct dma_chan *of_dma_request_slave_channel(
> +		struct device_node *np, char *name)
>  {
>  	return NULL;
>  }
>  
> -static struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
> -		struct of_dma *ofdma)
> +static inline struct dma_chan *of_dma_simple_xlate(
> +		struct of_phandle_args *dma_spec, struct of_dma *ofdma)
>  {
>  	return NULL;
>  }


-- 
~Vinod

