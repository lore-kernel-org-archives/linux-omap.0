From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 06/14] dspbridge: mmu: add hw_mmu_tlb_flush_all()
Date: Mon, 17 May 2010 14:10:05 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB6CB3D1@dlee06.ent.ti.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
 <1274024765-21076-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54622 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840Ab0EQTKH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 15:10:07 -0400
In-Reply-To: <1274024765-21076-7-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "Liu, Stanley" <stanley_liu@ti.com>, "Jansson, Cris" <cjansson@ti.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>


+Cris
+Stanley
Loop in DSP guys in case they would have something to add.

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Sunday, May 16, 2010 10:46 AM
> To: linux-omap
> Cc: Ramirez Luna, Omar; Guzman Lugo, Fernando; Felipe Contreras
> Subject: [PATCH 06/14] dspbridge: mmu: add hw_mmu_tlb_flush_all()
> 
> So that it can be used in more than one place.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  drivers/dsp/bridge/core/tiomap3430.c |    9 +--------
>  drivers/dsp/bridge/hw/hw_mmu.c       |    6 ++++++
>  drivers/dsp/bridge/hw/hw_mmu.h       |    2 ++
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/core/tiomap3430.c
> b/drivers/dsp/bridge/core/tiomap3430.c
> index 8a3eff9..d00eaaa 100644
> --- a/drivers/dsp/bridge/core/tiomap3430.c
> +++ b/drivers/dsp/bridge/core/tiomap3430.c
> @@ -74,8 +74,6 @@
>  #define PAGES_II_LVL_TABLE   512
>  #define PHYS_TO_PAGE(phys)      pfn_to_page((phys) >> PAGE_SHIFT)
> 
> -#define MMU_GFLUSH 0x60
> -
>  /* Forward Declarations: */
>  static dsp_status bridge_brd_monitor(struct bridge_dev_context
> *dev_context);
>  static dsp_status bridge_brd_read(struct bridge_dev_context *dev_context,
> @@ -216,18 +214,13 @@ static struct bridge_drv_interface
> drv_interface_fxns = {
>  	bridge_msg_set_queue_id,
>  };
> 
> -static inline void tlb_flush_all(const void __iomem *base)
> -{
> -	__raw_writeb(__raw_readb(base + MMU_GFLUSH) | 1, base + MMU_GFLUSH);
> -}
> -
>  static inline void flush_all(struct bridge_dev_context *dev_context)
>  {
>  	if (dev_context->dw_brd_state == BRD_DSP_HIBERNATION ||
>  	    dev_context->dw_brd_state == BRD_HIBERNATION)
>  		wake_dsp(dev_context, NULL);
> 
> -	tlb_flush_all(dev_context->dw_dsp_mmu_base);
> +	hw_mmu_tlb_flush_all(dev_context->dw_dsp_mmu_base);
>  }
> 
>  static void bad_page_dump(u32 pa, struct page *pg)
> diff --git a/drivers/dsp/bridge/hw/hw_mmu.c
> b/drivers/dsp/bridge/hw/hw_mmu.c
> index 965b659..e593358 100644
> --- a/drivers/dsp/bridge/hw/hw_mmu.c
> +++ b/drivers/dsp/bridge/hw/hw_mmu.c
> @@ -35,6 +35,7 @@
>  #define MMU_SMALL_PAGE_MASK      0xFFFFF000
> 
>  #define MMU_LOAD_TLB	0x00000001
> +#define MMU_GFLUSH	0x60
> 
>  /*
>   * hw_mmu_page_size_t: Enumerated Type used to specify the MMU Page
> Size(SLSS)
> @@ -585,3 +586,8 @@ static hw_status mmu_set_ram_entry(const void __iomem
> *baseAddress,
>  	return status;
> 
>  }
> +
> +void hw_mmu_tlb_flush_all(const void __iomem *base)
> +{
> +	__raw_writeb(1, base + MMU_GFLUSH);
> +}
> diff --git a/drivers/dsp/bridge/hw/hw_mmu.h
> b/drivers/dsp/bridge/hw/hw_mmu.h
> index 9b13468..0436974 100644
> --- a/drivers/dsp/bridge/hw/hw_mmu.h
> +++ b/drivers/dsp/bridge/hw/hw_mmu.h
> @@ -97,6 +97,8 @@ extern hw_status hw_mmu_pte_set(const u32 pg_tbl_va,
>  extern hw_status hw_mmu_pte_clear(const u32 pg_tbl_va,
>  				  u32 page_size, u32 virtualAddr);
> 
> +void hw_mmu_tlb_flush_all(const void __iomem *base);
> +
>  static inline u32 hw_mmu_pte_addr_l1(u32 L1_base, u32 va)
>  {
>  	u32 pte_addr;
> --
> 1.7.1

