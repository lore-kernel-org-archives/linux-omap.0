From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: Re: [RFC][PATCH 2/2] DSPBRIDGE: Distinguish between read or write
 buffers
Date: Fri, 19 Feb 2010 15:44:32 +0200
Message-ID: <4B7E95C0.3060308@ti.com>
References: <1266532429-30927-1-git-send-email-omar.ramirez@ti.com> <1266532429-30927-2-git-send-email-omar.ramirez@ti.com> <1266532429-30927-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36162 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718Ab0BSNoq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Feb 2010 08:44:46 -0500
In-Reply-To: <1266532429-30927-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

Ramirez Luna, Omar wrote:
> This patch introduces the check to differentiate the buffers
> coming to the dsp through bridgedriver. So far they can be
> input (read) or output (write) or rw (which are treated the
> same way as an output buffer), this distinctions are made from
> dsp perspective.
>
> Since this needs to be checked on map function, unused
> bits (16, 15) of flags were used to check for this argument.
>
> As 128 byte alignment limitation doesn't affect input buffers
> only writable buffers are checked. Default value for read buffers
> is set to be 1, this will enforce that users of bridge will fill
> the flags with significant values otherwise (if enabled) check
> will reject buffers not aligned to 128 bytes (even if they fall in
> the input category).
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  drivers/dsp/bridge/rmgr/proc.c |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
> index 78a31ef..4fe20ed 100644
> --- a/drivers/dsp/bridge/rmgr/proc.c
> +++ b/drivers/dsp/bridge/rmgr/proc.c
> @@ -71,6 +71,12 @@
>  
>  #define DSP_CACHE_LINE 128
>  
> +#define BUFMODE_MASK	(3 << 14)
> +
> +/* Buffer modes from DSP perspective */
> +#define RBUF		0x1	/* Input buffer */
> +#define WBUF		0x2	/* Output Buffer */
> +
>  extern char *iva_img;
>  
>  /*  ----------------------------------- Globals */
> @@ -1297,11 +1303,13 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
>  		 pReqAddr, ulMapAttr, ppMapAddr);
>  
>  #ifdef CONFIG_BRIDGE_CACHE_LINE_CHECK
> -	if (!IS_ALIGNED((u32)pMpuAddr, DSP_CACHE_LINE) ||
> -	    !IS_ALIGNED(size, DSP_CACHE_LINE)) {
> -		pr_err("%s: not aligned: 0x%x (%d)\n", __func__,
> +	if ((ulMapAttr & BUFMODE_MASK) != RBUF) {
What if the result of (ulMapAttr & BUFMODE_MASK) is invalid,still it enters the loop.Since the condition is for writable buffers only,Isn't it better to use "if ((ulMapAttr & BUFMODE_MASK) == WBUF)" condition?

> +		if (!IS_ALIGNED((u32)pMpuAddr, DSP_CACHE_LINE) ||
> +		    !IS_ALIGNED(ulSize, DSP_CACHE_LINE)) {
> +			pr_err("%s: not aligned: 0x%x (%d)\n", __func__,
>  						(u32)pMpuAddr, ulSize);
> -		return -EFAULT;
> +			return -EFAULT;
> +		}
>  	}
>  #endif
Regards,
Deepak

>  
>   


