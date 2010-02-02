From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: MEM_Free() cleanup
Date: Tue, 02 Feb 2010 20:43:31 +0200
Message-ID: <1265136211.26885.0.camel@sanganak>
References: <577decfb1227d1772fb5a92f796a101464be2b50.1265038929.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49107 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab0BBSoN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 13:44:13 -0500
In-Reply-To: <577decfb1227d1772fb5a92f796a101464be2b50.1265038929.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "omar.ramirez@ti.com" <omar.ramirez@ti.com>
Cc: "nm@ti.com" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "deepak.chitriki@ti.com" <deepak.chitriki@ti.com>

On Mon, 2010-02-01 at 17:57 +0100, Palande Ameya (Nokia-D/Helsinki)
wrote:
> Since kfree() checks for null pointer, there is no need to check is again in
> MEM_Free(). This patch also reorganizes the function to make it more readable.
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  drivers/dsp/bridge/services/mem.c |   40 ++++++++++++++----------------------
>  1 files changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
> index cee646a..dfe352d 100644
> --- a/drivers/dsp/bridge/services/mem.c
> +++ b/drivers/dsp/bridge/services/mem.c
> @@ -495,35 +495,27 @@ void MEM_VFree(IN void *pMemBuf)
>  void MEM_Free(IN void *pMemBuf)
>  {
>  #ifdef MEM_CHECK
> -	struct memInfo *pMem = (void *)((u32)pMemBuf - sizeof(struct memInfo));
> +	struct memInfo *pMem;
>  #endif
> -
> -	DBC_Require(pMemBuf != NULL);
> -
>  	GT_1trace(MEM_debugMask, GT_ENTER, "MEM_Free: pMemBufs 0x%x\n",
>  		  pMemBuf);
> -
> -	if (pMemBuf) {
> -#ifndef MEM_CHECK
> -		kfree(pMemBuf);
> +#ifdef MEM_CHECK
> +	if (!pMemBuf) {
> +		GT_1trace(MEM_debugMask, GT_7CLASS,
> +			"Invalid allocation or Buffer underflow\n");
> +		return;
> +	}
> +	pMem = (void *)((u32)pMemBuf - sizeof(struct memInfo));
> +	if (pMem && pMem->dwSignature == memInfoSign) {
> +		spin_lock(&mMan.lock);
> +		MLST_RemoveElem(&mMan.lst, (struct list_head *)pMem);
> +		spin_unlock(&mMan.lock);
> +		pMem->dwSignature = 0;
> +		kfree(pMem);
> +	}
>  #else
> -		if (pMem) {
> -			if (pMem->dwSignature == memInfoSign) {
> -				spin_lock(&mMan.lock);
> -				MLST_RemoveElem(&mMan.lst,
> -						(struct list_head *)pMem);
> -				spin_unlock(&mMan.lock);
> -				pMem->dwSignature = 0;
> -				kfree(pMem);
> -			} else {
> -				GT_1trace(MEM_debugMask, GT_7CLASS,
> -					"Invalid allocation or "
> -					"Buffer underflow at %x\n",
> -					(u32) pMem + sizeof(struct memInfo));
> -			}
> -		}
> +	kfree(pMemBuf);
>  #endif
> -	}
>  }
>  
>  /*

NACK!
I found a better solution. Will post patches soon :)

Cheers,
Ameya.

