From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH] tidspbridge: select OMAP_IOMMU dependency
Date: Mon, 11 Oct 2010 09:50:48 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F47B2B9B@dlee06.ent.ti.com>
References: <1286624530-30581-1-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36560 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754137Ab0JKOu4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 10:50:56 -0400
In-Reply-To: <1286624530-30581-1-git-send-email-ionut.nicu@mindbit.ro>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ionut Nicu <ionut.nicu@mindbit.ro>


Hi Ionut, 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ionut Nicu
> Sent: Saturday, October 09, 2010 6:42 AM
> To: linux-omap@vger.kernel.org
> Cc: Ionut Nicu
> Subject: [PATCH] tidspbridge: select OMAP_IOMMU dependency
> 
> Since the iommu migration patches tidspbridge depends on the 
> OMAP specific IOMMU implementation. We need to add this 
> dependency, otherwise we'll have link time errors.

Patch already sent:
http://marc.info/?l=linux-omap&m=128632367005506&w=2

Regards,
Fernando Guzman.

> 
> Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
> ---
>  drivers/staging/tidspbridge/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/tidspbridge/Kconfig 
> b/drivers/staging/tidspbridge/Kconfig
> index 93de4f2..ff64d46 100644
> --- a/drivers/staging/tidspbridge/Kconfig
> +++ b/drivers/staging/tidspbridge/Kconfig
> @@ -6,6 +6,7 @@ menuconfig TIDSPBRIDGE
>  	tristate "DSP Bridge driver"
>  	depends on ARCH_OMAP3
>  	select OMAP_MBOX_FWK
> +	select OMAP_IOMMU
>  	help
>  	  DSP/BIOS Bridge is designed for platforms that 
> contain a GPP and
>  	  one or more attached DSPs.  The GPP is considered the 
> master or
> --
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 