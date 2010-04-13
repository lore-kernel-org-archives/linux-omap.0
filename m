From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: Re: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after
 DSP_MMUFAULT
Date: Tue, 13 Apr 2010 11:54:53 -0500
Message-ID: <4BC4A1DD.3060700@ti.com>
References: <1271177200-1054-1-git-send-email-deepak.chitriki@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44789 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753364Ab0DMQyy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Apr 2010 12:54:54 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3DGssg5025960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Apr 2010 11:54:54 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o3DGsrLV001288
	for <linux-omap@vger.kernel.org>; Tue, 13 Apr 2010 11:54:54 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3DGsr9S026296
	for <linux-omap@vger.kernel.org>; Tue, 13 Apr 2010 11:54:53 -0500 (CDT)
In-Reply-To: <1271177200-1054-1-git-send-email-deepak.chitriki@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Please ignore this patch.

Thanks,
Deepak

Chitriki Rudramuni, Deepak wrote:
> kmalloc() does not guarantee page aligned memory always,hence
> resulting in virtual addresses not getting aligned to page boundary.
> This patch replaces kmalloc() with __get_free_pages() which
> allocates kernel memory in terms of PAGES fixing the Kernel
> memory corruption after DSP_MMUFAULT.
>
> Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>
> ---
>  drivers/dsp/bridge/wmd/ue_deh.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
> index 14dd8ae..7ed5f60 100644
> --- a/drivers/dsp/bridge/wmd/ue_deh.c
> +++ b/drivers/dsp/bridge/wmd/ue_deh.c
> @@ -239,7 +239,8 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
>  			       "bridge_deh_notify: DSP_MMUFAULT, fault "
>  			       "address = 0x%x\n", (unsigned int)fault_addr);
>  			dummy_va_addr =
> -			    (u32) mem_calloc(sizeof(char) * 0x1000, MEM_PAGED);
> +			    (void *)__get_free_pages(GFP_ATOMIC | __GFP_ZERO,
> +						     0);
>  			mem_physical =
>  			    VIRT_TO_PHYS(PG_ALIGN_LOW
>  					 ((u32) dummy_va_addr, PG_SIZE4K));
> @@ -338,6 +339,6 @@ dsp_status bridge_deh_get_info(struct deh_mgr *hdeh_mgr,
>   */
>  void bridge_deh_release_dummy_mem(void)
>  {
> -	kfree((void *)dummy_va_addr);
> +	free_pages((void *)dummy_va_addr, 0);
>  	dummy_va_addr = 0;
>  }
>   

