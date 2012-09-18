From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 7/9] ARM: OMAP: iommu: optimize save and restore
 routines
Date: Tue, 18 Sep 2012 11:04:30 -0700
Message-ID: <20120918180430.GV11762@atomide.com>
References: <1347479152-588-1-git-send-email-omar.luna@linaro.org>
 <1347479152-588-8-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1347479152-588-8-git-send-email-omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [120912 12:47]:
> --- a/arch/arm/plat-omap/include/plat/iommu.h
> +++ b/arch/arm/plat-omap/include/plat/iommu.h
> @@ -27,6 +27,13 @@ struct iotlb_entry {
>  	};
>  };
>  
> +/* context registers */
> +struct iommu_regs {
> +	u32 irqen;
> +	u32 cntl;
> +	u32 ttb;
> +};
> +
>  struct omap_iommu {
>  	const char	*name;
>  	struct module	*owner;
> @@ -50,7 +57,8 @@ struct omap_iommu {
>  	struct list_head	mmap;
>  	struct mutex		mmap_lock; /* protect mmap */
>  
> -	void *ctx; /* iommu context: registres saved area */
> +	struct iommu_regs context;
> +	int ctx_loss_cnt;
>  	u32 da_start;
>  	u32 da_end;
>  };
> --- a/arch/arm/plat-omap/include/plat/iommu2.h
> +++ b/arch/arm/plat-omap/include/plat/iommu2.h
> @@ -35,8 +35,6 @@
>  #define MMU_READ_RAM		0x6c
>  #define MMU_EMU_FAULT_AD	0x70
>  
> -#define MMU_REG_SIZE		256
> -
>  /*
>   * MMU Register bit definitions
>   */

These headers should be moved to include/linux/platform_data/iommu-omap.h
or something like that. Care to take care of that too?

I guess there's no reason to have both iommu.h and iommuh2.h?

Regards,

Tony
