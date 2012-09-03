From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: select PINCTRL in Kconfig
Date: Mon, 3 Sep 2012 12:41:27 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA25D99@DBDE01.ent.ti.com>
References: <1346047244-26909-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47059 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585Ab2ICMlg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 08:41:36 -0400
In-Reply-To: <1346047244-26909-1-git-send-email-anilkumar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

On Mon, Aug 27, 2012 at 11:30:44, AnilKumar, Chimata wrote:
> Select PINCTRL in Kconfig under Typical OMAP configuration, this
> is required to add pinctrl driver to omap2+ family of devices.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index dd2db02..a164568 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -18,6 +18,7 @@ config ARCH_OMAP2PLUS_TYPICAL
>  	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
>  	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
>  	select HIGHMEM
> +	select PINCTRL
>  	help
>  	  Compile a kernel suitable for booting most boards
>  
> -- 
> 1.7.9.5
> 
> 

If there are no comments on this patch, can you push this patch to devel-dt?

Thanks
AnilKumar
