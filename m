From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] DSPBRIDGE: replace IO_ADDRESS with ioremap
Date: Mon, 11 Jan 2010 14:32:31 -0800
Message-ID: <20100111223231.GB5055@atomide.com>
References: <1263240766-13000-1-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61109 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab0AKWc0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 17:32:26 -0500
Content-Disposition: inline
In-Reply-To: <1263240766-13000-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishant Menon <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

* Omar Ramirez Luna <omar.ramirez@ti.com> [100111 12:02]:
> Use ioremap() instead of using IO_ADDRESS macro to make it generic.
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> CC: Nishant Menon <nm@ti.com>
> CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
> CC: Ameya Palande <ameya.palande@nokia.com>
> CC: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  drivers/dsp/bridge/services/clk.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
> index d1c68fc..116e10e 100644
> --- a/drivers/dsp/bridge/services/clk.c
> +++ b/drivers/dsp/bridge/services/clk.c
> @@ -54,10 +54,9 @@
>  
>  typedef volatile unsigned long  REG_UWORD32;
>  
> -#define SSI_Base        0x48058000
> -
> -#define SSI_BASE                     IO_ADDRESS(SSI_Base)
> -
> +#define OMAP_SSI_OFFSET			0x58000
> +#define OMAP_SSI_SIZE			0x1000
> +#define OMAP_SSI_SYSCONFIG_OFFSET	0x10
>  
>  struct SERVICES_Clk_t {
>  	struct clk *clk_handle;
> @@ -355,7 +354,9 @@ s32 CLK_Get_UseCnt(IN enum SERVICES_ClkId clk_id)
>  void SSI_Clk_Prepare(bool FLAG)
>  {
>  	u32 ssi_sysconfig;
> -	ssi_sysconfig = __raw_readl((SSI_BASE) + 0x10);
> +	void __iomem *ssi_base;
> +
> +	ssi_base = ioremap(L4_34XX_BASE + OMAP_SSI_OFFSET, OMAP_SSI_SIZE);

Please check the results from ioremap. Currently we're using static mapping,
but that may not always be the case in the future.

Regards,

Tony
