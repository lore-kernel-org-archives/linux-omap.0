From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/2] omap3evm: fix compilation warning for
 omap3evm_flash_init
Date: Tue, 22 Sep 2009 18:49:08 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436C43D74@dbde02.ent.ti.com>
References: <1253625132-15050-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35100 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755154AbZIVNTO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 09:19:14 -0400
In-Reply-To: <1253625132-15050-1-git-send-email-ajay.gupta@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "tony@atomide.com" <tony@atomide.com>

Tony,

> -----Original Message-----
> From: Gupta, Ajay Kumar
> Sent: Tuesday, September 22, 2009 6:42 PM
> To: linux-omap@vger.kernel.org
> Cc: felipe.balbi@nokia.com; david-b@pacbell.net; tony@atomide.com; Gupta,
> Ajay Kumar
> Subject: [PATCH 1/2] omap3evm: fix compilation warning for
> omap3evm_flash_init

Please read the patch indexes as, 
[PATCH 1/2] ==> [PATCH 1/4]
[PATCH 2/2] ==> [PATCH 2/4]

and they all are against linux-omap tree as of today.

-Ajay
> 
> omap3evm_flash_init() was earlier defined in seperate file but now need to
> merge to
> board_omap3evm.c file.
> 
> Removing it to fix the compilation. It should be added back with function
> definitions.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> index 7b4e16c..62a6f32 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -324,7 +324,6 @@ static void __init omap3_evm_init(void)
>  	/* Setup EHCI phy reset padconfig */
>  	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
>  	usb_ehci_init(&ehci_pdata);
> -	omap3evm_flash_init();
>  	ads7846_dev_init();
>  }
> 
> --
> 1.6.2.4

