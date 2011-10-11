From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 3/8] ti816evm: Add support for musb interface
Date: Tue, 11 Oct 2011 14:08:59 +0200
Message-ID: <4E9431DB.3070600@compulab.co.il>
References: <1318332369-9732-1-git-send-email-ajay.gupta@ti.com> <1318332369-9732-4-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:56140
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751497Ab1JKMJJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 08:09:09 -0400
In-Reply-To: <1318332369-9732-4-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, Ravi Babu <ravibabu@ti.com>, Hemant Pedanekar <hemantp@ti.com>, Tony Lindgren <tony@atomide.com>

Hi Ajay,

On 10/11/11 13:26, Ajay Kumar Gupta wrote:
> From: Ravi Babu <ravibabu@ti.com>
> 
> Adding musb support in ti816 EVM board file.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Signed-off-by: Ravi Babu <ravibabu@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>

This patch can result in a merge conflict, therefore I think
this one should be taken through Tony's tree.

Also you should work together with Hemant Pedanekar and
someone of you should rebase on top of the other otherwise
one of the patches (yours or Hemant's) possibly will not apply.

> ---
>  arch/arm/mach-omap2/board-ti8168evm.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
> index 2c243df..1f3d423 100644
> --- a/arch/arm/mach-omap2/board-ti8168evm.c
> +++ b/arch/arm/mach-omap2/board-ti8168evm.c
> @@ -23,6 +23,14 @@
>  #include <plat/irqs.h>
>  #include <plat/board.h>
>  #include <plat/common.h>
> +#include <plat/usb.h>
> +
> +static struct omap_musb_board_data musb_board_data = {
> +	.set_phy_power	= ti81xx_musb_phy_power,
> +	.interface_type	= MUSB_INTERFACE_ULPI,
> +	.mode           = MUSB_OTG,
> +	.power		= 500,
> +};
>  
>  static struct omap_board_config_kernel ti8168_evm_config[] __initdata = {
>  };
> @@ -33,6 +41,7 @@ static void __init ti8168_evm_init(void)
>  	omap_sdrc_init(NULL, NULL);
>  	omap_board_config = ti8168_evm_config;
>  	omap_board_config_size = ARRAY_SIZE(ti8168_evm_config);
> +	usb_musb_init(&musb_board_data);
>  }
>  
>  static void __init ti8168_evm_map_io(void)

-- 
Regards,
Igor.
