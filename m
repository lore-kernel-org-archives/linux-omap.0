From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: Re: [PATCH] DSPBRIDGE:Fix sparse warnings
Date: Tue, 30 Mar 2010 11:40:30 -0500
Message-ID: <4BB2297E.7090802@ti.com>
References: <1269646243-9236-1-git-send-email-deepak.chitriki@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48395 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab0C3Qkc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Mar 2010 12:40:32 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2UGeWxE029309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 30 Mar 2010 11:40:32 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id o2UGeWbk026820
	for <linux-omap@vger.kernel.org>; Tue, 30 Mar 2010 11:40:32 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2UGeVwN004821
	for <linux-omap@vger.kernel.org>; Tue, 30 Mar 2010 11:40:31 -0500 (CDT)
In-Reply-To: <1269646243-9236-1-git-send-email-deepak.chitriki@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Please ignore this patch.

Regards,
Deepak

Chitriki Rudramuni, Deepak wrote:
> This patch fixes sparse warning "cast removes address space of expression"
> in drivers/dsp/bridge/wmd/tiomap_io.c
>
> Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>
> ---
>  drivers/dsp/bridge/wmd/tiomap_io.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
> index b5504a9..cc20f65 100644
> --- a/drivers/dsp/bridge/wmd/tiomap_io.c
> +++ b/drivers/dsp/bridge/wmd/tiomap_io.c
> @@ -431,22 +431,22 @@ dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val)
>  		 * 2:0 AUTO_IVA2_DPLL - Enabling IVA2 DPLL auto control
>  		 *     in CM_AUTOIDLE_PLL_IVA2 register
>  		 */
> -		*(reg_uword32 *) (resources.dw_cm_base + 0x34) = 0x1;
> +		*(reg_uword32 *) ((u32)(resources.dw_cm_base) + 0x34) = 0x1;
>  
>  		/*
>  		 * 7:4 IVA2_DPLL_FREQSEL - IVA2 internal frq set to
>  		 *     0.75 MHz - 1.0 MHz
>  		 * 2:0 EN_IVA2_DPLL - Enable IVA2 DPLL in lock mode
>  		 */
> -		temp = *(reg_uword32 *) (resources.dw_cm_base + 0x4);
> +		temp = *(reg_uword32 *) ((u32)(resources.dw_cm_base) + 0x4);
>  		temp = (temp & 0xFFFFFF08) | 0x37;
> -		*(reg_uword32 *) (resources.dw_cm_base + 0x4) = temp;
> +		*(reg_uword32 *) ((u32)(resources.dw_cm_base) + 0x4) = temp;
>  
>  		/* Restore mailbox settings */
>  		omap_mbox_restore_ctx(dev_context->mbox);
>  
>  		/* Access MMU SYS CONFIG register to generate a short wakeup */
> -		temp = *(reg_uword32 *) (resources.dw_dmmu_base + 0x10);
> +		temp = *(reg_uword32 *) ((u32)(resources.dw_dmmu_base) + 0x10);
>  
>  		dev_context->dw_brd_state = BRD_RUNNING;
>  	} else if (dev_context->dw_brd_state == BRD_RETENTION) {
> @@ -462,4 +462,4 @@ dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val)
>  	}
>  
>  	return DSP_SOK;
> -}
> \ No newline at end of file
> +}
>   

