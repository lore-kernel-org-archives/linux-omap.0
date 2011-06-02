From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH RFC] OMAP2PLUS: Enable HIGHMEM
Date: Thu, 2 Jun 2011 18:51:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D2D2801@dbde02.ent.ti.com>
References: <1307016381-21878-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38635 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879Ab1FBNWE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 09:22:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p52DM08b012630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 2 Jun 2011 08:22:02 -0500
In-Reply-To: <1307016381-21878-1-git-send-email-santosh.shilimkar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Shilimkar, Santosh
> Sent: Thursday, June 02, 2011 5:36 PM
> To: linux-omap@vger.kernel.org
> Cc: Shilimkar, Santosh
> Subject: [PATCH RFC] OMAP2PLUS: Enable HIGHMEM
> 
> HIGMEM support is kernel is quite mature now and we have boards
[sp]             ^^ replace with "in"

> like ZOOM, PANDA, SDP where 1 GB memories are installed.
> 
> Enable HIGMEM to make use of the additional memory.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> This won't boards which doesn't have excess memory. Tested
> on OMAP4430 SDP

[sp] Comment is unclear on what happens on the boards with
     lesser memories esp. since the change will impact all
     boards. You may want to explain.

> 
>  arch/arm/mach-omap2/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 19d5891..25e819e 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -19,6 +19,7 @@ config ARCH_OMAP2PLUS_TYPICAL
>  	select MENELAUS if ARCH_OMAP2
>  	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
>  	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
> +	select HIGHMEM 
>  	help
>  	  Compile a kernel suitable for booting most boards
>  
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 