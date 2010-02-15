From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Fix memory corruption in DRV_ProcFreeDMMRes
Date: Mon, 15 Feb 2010 17:59:58 +0200
Message-ID: <20100215155958.GA5458@annwn.felipec.org>
References: <018f9cad9a346b7a841268f4520a73a98c9cf7c9.1266246072.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62199 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab0BOQAT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 11:00:19 -0500
Content-Disposition: inline
In-Reply-To: <018f9cad9a346b7a841268f4520a73a98c9cf7c9.1266246072.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>, "deepak.chitriki@ti.com" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "x0095840@ti.com" <x0095840@ti.com>

On Mon, Feb 15, 2010 at 04:36:31PM +0100, Ameya Palande wrote:
> This patch fixes following issues:
> 
> 1. pDMMRes was dereferenced and modified when it was already freed by
> PROC_Ummap(). This results in memory corruption.
> 
> 2.Instead of passing ulDSPAddr, ulDSPResAddr was passed to PROC_UnMap()
> which will not retrieve correct DMMRes element.

You forgot to mention that this patch applies on top of your previous
reserve resource cleanup patches.

> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>

And:
Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>

> ---
>  drivers/dsp/bridge/rmgr/drv.c |   15 +++++----------
>  1 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
> index 9d5c077..747b34c 100644
> --- a/drivers/dsp/bridge/rmgr/drv.c
> +++ b/drivers/dsp/bridge/rmgr/drv.c
> @@ -273,11 +273,14 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
>  		pDMMList = pDMMList->next;
>  		if (pDMMRes->dmmAllocated) {
>  			status = PROC_UnMap(pDMMRes->hProcessor,
> -				 (void *)pDMMRes->ulDSPResAddr, pCtxt);
> +				 (void *)pDMMRes->ulDSPAddr, pCtxt);
> +			/*
> +			 * PROC_UnMap has freed pDMMRes pointer, so don't access
> +			 * it now
> +			 */

I don't see the need for this comment on the code.

Cheers.

-- 
Felipe Contreras
