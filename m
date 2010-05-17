From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 08/14] dspbridge: deh: refactor in
 mmu_fault_print_stack()
Date: Mon, 17 May 2010 14:11:07 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB6CB3D5@dlee06.ent.ti.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
 <1274024765-21076-9-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48597 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019Ab0EQTLK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 15:11:10 -0400
In-Reply-To: <1274024765-21076-9-git-send-email-felipe.contreras@gmail.com>
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
> Subject: [PATCH 08/14] dspbridge: deh: refactor in mmu_fault_print_stack()
> 
> All this code is just to print the stack, so make it clearer.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  drivers/dsp/bridge/core/ue_deh.c |   58 +++++++++++++++++++++------------
> -----
>  1 files changed, 32 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/core/ue_deh.c
> b/drivers/dsp/bridge/core/ue_deh.c
> index f661aaf..1d1b87b 100644
> --- a/drivers/dsp/bridge/core/ue_deh.c
> +++ b/drivers/dsp/bridge/core/ue_deh.c
> @@ -189,9 +189,8 @@ static void wait_for_timer(void)
>  	omap_dm_timer_disable(timer);
>  }
> 
> -void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32
> dwErrInfo)
> +static void mmu_fault_print_stack(struct bridge_dev_context *dev_context)
>  {
> -	struct bridge_dev_context *dev_context;
>  	struct cfg_hostres *resources;
>  	struct hw_mmu_map_attrs_t map_attrs = {
>  		.endianism = HW_LITTLE_ENDIAN,
> @@ -200,12 +199,41 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32
> ulEventMask, u32 dwErrInfo)
>  	};
>  	void *dummy_va_addr;
> 
> +	resources = dev_context->resources;
> +	dummy_va_addr = (void*)__get_free_page(GFP_ATOMIC);
> +
> +	/*
> +	 * Before acking the MMU fault, let's make sure MMU can only
> +	 * access entry #0. Then add a new entry so that the DSP OS
> +	 * can continue in order to dump the stack.
> +	 */
> +	hw_mmu_twl_disable(resources->dw_dmmu_base);
> +	hw_mmu_tlb_flush_all(resources->dw_dmmu_base);
> +
> +	hw_mmu_tlb_add(resources->dw_dmmu_base,
> +			virt_to_phys(dummy_va_addr), fault_addr,
> +			HW_PAGE_SIZE4KB, 1,
> +			&map_attrs, HW_SET, HW_SET);
> +
> +	wait_for_timer();
> +	/* Clear MMU interrupt */
> +	hw_mmu_event_ack(resources->dw_dmmu_base,
> +			HW_MMU_TRANSLATION_FAULT);
> +	dump_dsp_stack(dev_context);
> +
> +	hw_mmu_disable(resources->dw_dmmu_base);
> +	free_page((unsigned long)dummy_va_addr);
> +}
> +
> +void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32
> dwErrInfo)
> +{
> +	struct bridge_dev_context *dev_context;
> +
>  	if (!deh_mgr)
>  		return;
> 
>  	dev_info(bridge, "%s: device exception\n", __func__);
>  	dev_context = deh_mgr->hbridge_context;
> -	resources = dev_context->resources;
> 
>  	switch (ulEventMask) {
>  	case DSP_SYSERROR:
> @@ -230,32 +258,10 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32
> ulEventMask, u32 dwErrInfo)
>  			(unsigned int) deh_mgr->err_info.dw_val1,
>  			(unsigned int) deh_mgr->err_info.dw_val2,
>  			(unsigned int) fault_addr);
> -		dummy_va_addr = (void*)__get_free_page(GFP_ATOMIC);
> 
>  		print_dsp_trace_buffer(dev_context);
>  		dump_dl_modules(dev_context);
> -
> -		/*
> -		 * Before acking the MMU fault, let's make sure MMU can only
> -		 * access entry #0. Then add a new entry so that the DSP OS
> -		 * can continue in order to dump the stack.
> -		 */
> -		hw_mmu_twl_disable(resources->dw_dmmu_base);
> -		hw_mmu_tlb_flush_all(resources->dw_dmmu_base);
> -
> -		hw_mmu_tlb_add(resources->dw_dmmu_base,
> -				virt_to_phys(dummy_va_addr), fault_addr,
> -				HW_PAGE_SIZE4KB, 1,
> -				&map_attrs, HW_SET, HW_SET);
> -
> -		wait_for_timer();
> -		/* Clear MMU interrupt */
> -		hw_mmu_event_ack(resources->dw_dmmu_base,
> -				HW_MMU_TRANSLATION_FAULT);
> -		dump_dsp_stack(dev_context);
> -
> -		hw_mmu_disable(resources->dw_dmmu_base);
> -		free_page((unsigned long)dummy_va_addr);
> +		mmu_fault_print_stack(dev_context);
>  		break;
>  #ifdef CONFIG_BRIDGE_NTFY_PWRERR
>  	case DSP_PWRERROR:
> --
> 1.7.1

