From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: update mach-types for rm680
Date: Mon, 13 Dec 2010 10:52:29 -0800
Message-ID: <20101213185229.GX3054@atomide.com>
References: <1292237195-5695-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44150 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab0LMSwe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 13:52:34 -0500
Content-Disposition: inline
In-Reply-To: <1292237195-5695-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

* Anand Gadiyar <gadiyar@ti.com> [101213 02:46]:
> Temporary hack to update mach-types for rm680; without
> this the master branch of linux-omap will be broken for
> omap2plus_defconfig builds.
> 
> Nyet-Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
> Tony,
> 
> Not sure how this is handled normally. Do you sync up
> mach-types with Russell's tree, or locally apply a patch
> like the one below?

Oops, thanks for catching that. I'll add this to omap-testing
as a temporary patch so it will get merged to the master
branch.

Tony
 
>  arch/arm/tools/mach-types |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: ehci/arch/arm/tools/mach-types
> ===================================================================
> --- ehci.orig/arch/arm/tools/mach-types
> +++ ehci/arch/arm/tools/mach-types
> @@ -3044,3 +3044,4 @@ harvest_desoto		MACH_HARVEST_DESOTO	HARV
>  msm8x60_qrdc		MACH_MSM8X60_QRDC	MSM8X60_QRDC		3060
>  spear900		MACH_SPEAR900		SPEAR900		3061
>  pcontrol_g20		MACH_PCONTROL_G20	PCONTROL_G20		3062
> +nokia_rm680		MACH_NOKIA_RM680	NOKIA_RM680		3220
