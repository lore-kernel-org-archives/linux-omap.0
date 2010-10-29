From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] McBSP: Fix the free variable update at remove.
Date: Sat, 30 Oct 2010 00:35:22 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034BE1DF32@dbde02.ent.ti.com>
References: <1288340367-29956-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48234 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758457Ab0J2THn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Oct 2010 15:07:43 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9TJ7efL015540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 29 Oct 2010 14:07:42 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o9TJ7dLK014583
	for <linux-omap@vger.kernel.org>; Sat, 30 Oct 2010 00:37:40 +0530 (IST)
In-Reply-To: <1288340367-29956-1-git-send-email-shubhrajyoti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

Shubro,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Datta, Shubhrajyoti
> Sent: Friday, October 29, 2010 4:19 AM
> To: linux-omap@vger.kernel.org
> Cc: Pandita, Vikram; Datta, Shubhrajyoti; ABRAHAM, KISHON VIJAY
> Subject: [PATCH] McBSP: Fix the free variable update at remove.
> 
> From: Shubhrajyoti D <shubhrajyoti@ti.com>
> 
> At remove the free variable is wrongly updated.Attempting to solve the
> same.
> 
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reported-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index eac4b97..6802ed1 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -1845,7 +1845,7 @@ static int __devexit
> omap_mcbsp_remove(struct platform_device *pdev)
> 
>  		mcbsp->fclk = NULL;
>  		mcbsp->iclk = NULL;
> -		mcbsp->free = 0;
> +		mcbsp->free = 1;
Isn't it better to use TRUE/FALSE instead of 1/0 if it's a Boolean variable?

Vishwa

>  		mcbsp->dev = NULL;
>  	}
> 
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
