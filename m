From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: fix MMC2 loopback clock handling
Date: Thu, 12 Jan 2012 17:22:41 +0200
Message-ID: <4F0EFAC1.2080003@compulab.co.il>
References: <1326378405-27632-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:59076
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753494Ab2ALPWu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 10:22:50 -0500
In-Reply-To: <1326378405-27632-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/12/12 16:26, Grazvydas Ignotas wrote:
> Currently MMC2 setup code can only enable loopback clock and
> relies on reset value for boards that need to have it disabled.
> This causes a problem with certain bootloaders that always enable
> that clock, resulting with unwanted bootloader dependencies.
> 
> Fix this by making it disable the clock if board data says so.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
> depends on "ARM: OMAP: fix erroneous mmc2 clock change on mmc3 setup"
> http://marc.info/?l=linux-omap&m=132416866125291&w=2
> 
>  arch/arm/mach-omap2/hsmmc.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 8658bd7..ad0adb5 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -175,11 +175,12 @@ static void hsmmc2_select_input_clk_src(struct omap_mmc_platform_data *mmc)
>  {
>  	u32 reg;
>  
> -	if (mmc->slots[0].internal_clock) {
> -		reg = omap_ctrl_readl(control_devconf1_offset);
> +	reg = omap_ctrl_readl(control_devconf1_offset);
> +	if (mmc->slots[0].internal_clock)
>  		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
> -		omap_ctrl_writel(reg, control_devconf1_offset);
> -	}
> +	else
> +		reg &= ~OMAP2_MMCSDIO2ADPCLKISEL;
> +	omap_ctrl_writel(reg, control_devconf1_offset);
>  }
>  
>  static void hsmmc2_before_set_reg(struct device *dev, int slot,

-- 
Regards,
Igor.
