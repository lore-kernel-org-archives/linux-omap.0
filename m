From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Get rid of memset() from MEM_Calloc()
Date: Tue, 23 Feb 2010 10:23:13 -0600
Message-ID: <4B8400F1.9010403@ti.com>
References: <b487eb065323f57efcaea92d30f8cca5041589ee.1266334736.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56008 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169Ab0BWQXP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 11:23:15 -0500
In-Reply-To: <b487eb065323f57efcaea92d30f8cca5041589ee.1266334736.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2/16/2010 9:40 AM, Ameya Palande wrote:
> Signed-off-by: Ameya Palande<ameya.palande@nokia.com>
> ---
>   drivers/dsp/bridge/services/mem.c |   11 ++++-------
>   1 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
> index 614396e..2501eee 100644
> --- a/drivers/dsp/bridge/services/mem.c
> +++ b/drivers/dsp/bridge/services/mem.c
> @@ -227,16 +227,13 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
>   		case MEM_NONPAGED:
>   		/* If non-paged memory required, see note at top of file. */
>   		case MEM_PAGED:
> -			pMem = kmalloc(cBytes,
> +			pMem = kzalloc(cBytes,
>   				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
> -			if (pMem)
> -				memset(pMem, 0, cBytes);
> -
>   			break;
>   		case MEM_LARGEVIRTMEM:
> -			pMem = vmalloc(cBytes);
> -			if (pMem)
> -				memset(pMem, 0, cBytes);
> +			pMem = __vmalloc(cBytes,
> +				GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO,
> +				PAGE_KERNEL);
>   			break;
>   		default:
>   			GT_1trace(MEM_debugMask, GT_6CLASS,

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge

- omar
