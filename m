From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 04/14] dspbridge: deh: free dummy page immediately
Date: Mon, 17 May 2010 14:09:40 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB6CB3CF@dlee06.ent.ti.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
 <1274024765-21076-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39625 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371Ab0EQTJo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 15:09:44 -0400
In-Reply-To: <1274024765-21076-5-git-send-email-felipe.contreras@gmail.com>
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
> Subject: [PATCH 04/14] dspbridge: deh: free dummy page immediately
> 
> There's no need to keep it around. DSP should stop trying to access
> system memory.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  drivers/dsp/bridge/core/ue_deh.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/core/ue_deh.c
> b/drivers/dsp/bridge/core/ue_deh.c
> index 605cec7..593a0e3 100644
> --- a/drivers/dsp/bridge/core/ue_deh.c
> +++ b/drivers/dsp/bridge/core/ue_deh.c
> @@ -60,8 +60,6 @@
>  /* Max time to check for GP Timer IRQ */
>  #define GPTIMER_IRQ_WAIT_MAX_CNT       1000
> 
> -static void *dummy_va_addr;
> -
>  static struct omap_dm_timer *timer;
> 
>  dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
> @@ -203,6 +201,7 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32
> ulEventMask, u32 dwErrInfo)
>  		.element_size = HW_ELEM_SIZE16BIT,
>  		.mixed_size = HW_MMU_CPUES,
>  	};
> +	void *dummy_va_addr;
> 
>  	if (!deh_mgr)
>  		return;
> @@ -259,6 +258,9 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32
> ulEventMask, u32 dwErrInfo)
>  		hw_mmu_event_ack(resources->dw_dmmu_base,
>  				HW_MMU_TRANSLATION_FAULT);
>  		dump_dsp_stack(dev_context);
> +
> +		hw_mmu_disable(resources->dw_dmmu_base);
> +		free_page((unsigned long)dummy_va_addr);
>  		break;
>  #ifdef CONFIG_BRIDGE_NTFY_PWRERR
>  	case DSP_PWRERROR:
> @@ -321,6 +323,4 @@ dsp_status bridge_deh_get_info(struct deh_mgr
> *deh_mgr,
> 
>  void bridge_deh_release_dummy_mem(void)
>  {
> -	free_page((unsigned long)dummy_va_addr);
> -	dummy_va_addr = NULL;
>  }
> --
> 1.7.1

