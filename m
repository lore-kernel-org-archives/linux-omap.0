From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH] DSPBRIDGE Memory leak when dynbase is loaded
Date: Mon, 19 Jan 2009 11:05:19 -0600
Message-ID: <A24693684029E5489D1D202277BE8944165DCB8A@dlee02.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A5303F220B869@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52861 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbZASRFa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 12:05:30 -0500
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5303F220B869@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <x00omar@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Ramirez Luna, Omar
> Sent: Monday, January 19, 2009 11:00 AM
> To: Pandita, Vikram; Hiroshi DOYU
> Cc: linux-omap@vger.kernel.org; Kanigeri, Hari; Gupta, Ramesh
> Subject: [PATCH] DSPBRIDGE Memory leak when dynbase is loaded
> 
> From: Omar Ramirez <x0084701@mmlinux.(none)>
> Date: Wed, 14 Jan 2009 15:47:54 -0600
> Subject: [PATCH] DSPBRIDGE Memory leak when dynbase is loaded
> 
> This patch fixes a memory leak that happens whenever
> a dynamic base image is loaded and then the driver is
> uninstalled.
> 
> Signed-off-by: Omar Ramirez Luna <x0084701@ti.com>
> ---
>  drivers/dsp/bridge/dynload/cload.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/dynload/cload.c
> b/drivers/dsp/bridge/dynload/cload.c
> index 271ab81..a6d7ae6 100644
> --- a/drivers/dsp/bridge/dynload/cload.c
> +++ b/drivers/dsp/bridge/dynload/cload.c
> @@ -1806,6 +1806,8 @@ loop_end:
>  		if (syms->Find_Matching_Symbol
>  			(syms, LOADER_DLLVIEW_ROOT) == NULL)
>  			syms->Deallocate(syms, root);
> +		if (root != NULL)
> +			syms->Deallocate(syms, root);

I would suggest a simpler check like this:

		if (!syms->Find_Matching_Symbol(syms, LOADER_DLLVIEW_ROOT) ||
									root)
			syms->Deallocate(syms, root);

Regards,
Sergio

>  	}
>  #endif
>  func_end:
> --
> 1.5.4.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

