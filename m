From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: control: add OMAP5 support for dsp boot
 programming
Date: Thu, 16 May 2013 08:46:53 -0700
Message-ID: <20130516154653.GS5600@atomide.com>
References: <1366234263-29875-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28400 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab3EPPq4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 11:46:56 -0400
Content-Disposition: inline
In-Reply-To: <1366234263-29875-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [130417 14:40]:
> Support for OMAP5 is added to the omap_dsp_ctrl_write_boot_addr()
> to enable the DSP boot.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Thanks applying into omap-for-v3.11/fixes-non-critical.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/control.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index 2adb268..31e0dfe 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -249,6 +249,7 @@ void omap_ctrl_write_dsp_boot_addr(u32 bootaddr)
>  	u32 offset = cpu_is_omap243x() ? OMAP243X_CONTROL_IVA2_BOOTADDR :
>  		     cpu_is_omap34xx() ? OMAP343X_CONTROL_IVA2_BOOTADDR :
>  		     cpu_is_omap44xx() ? OMAP4_CTRL_MODULE_CORE_DSP_BOOTADDR :
> +		     soc_is_omap54xx() ? OMAP4_CTRL_MODULE_CORE_DSP_BOOTADDR :
>  		     0;
>  
>  	if (!offset) {
> -- 
> 1.8.2
> 
