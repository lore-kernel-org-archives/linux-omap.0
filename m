From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 07/14] dspbridge: deh: ensure only tlb #0 is enabled
Date: Mon, 17 May 2010 14:10:35 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB6CB3D2@dlee06.ent.ti.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
 <1274024765-21076-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54667 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750Ab0EQTKh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 15:10:37 -0400
In-Reply-To: <1274024765-21076-8-git-send-email-felipe.contreras@gmail.com>
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
> Subject: [PATCH 07/14] dspbridge: deh: ensure only tlb #0 is enabled
> 
> We don't want the DSP to continue writing into other mapped pages, no
> matter how unlikely.
> 
> Based on extensive discussion with Fernando Guzman Lugo.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  drivers/dsp/bridge/core/ue_deh.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/core/ue_deh.c
> b/drivers/dsp/bridge/core/ue_deh.c
> index 61e5e4e..f661aaf 100644
> --- a/drivers/dsp/bridge/core/ue_deh.c
> +++ b/drivers/dsp/bridge/core/ue_deh.c
> @@ -235,6 +235,14 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32
> ulEventMask, u32 dwErrInfo)
>  		print_dsp_trace_buffer(dev_context);
>  		dump_dl_modules(dev_context);
> 
> +		/*
> +		 * Before acking the MMU fault, let's make sure MMU can only
> +		 * access entry #0. Then add a new entry so that the DSP OS
> +		 * can continue in order to dump the stack.
> +		 */
> +		hw_mmu_twl_disable(resources->dw_dmmu_base);
> +		hw_mmu_tlb_flush_all(resources->dw_dmmu_base);
> +
>  		hw_mmu_tlb_add(resources->dw_dmmu_base,
>  				virt_to_phys(dummy_va_addr), fault_addr,
>  				HW_PAGE_SIZE4KB, 1,
> --
> 1.7.1

