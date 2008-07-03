From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] OMAP3: EVM: KEYPAD: Fix Kconfig dependency
Date: Thu, 3 Jul 2008 13:55:18 +0300
Message-ID: <20080703105516.GT14276@atomide.com>
References: <4862A888.2070808@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58712 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbYGCMVW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:21:22 -0400
Content-Disposition: inline
In-Reply-To: <4862A888.2070808@ridgerun.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: linux-omap@vger.kernel.org

* Miguel Aguilar <miguel.aguilar@ridgerun.com> [080625 23:18]:
> Add twl4030 keypad driver support to OMAP3 EVM

Pushing today, this one needed fixing too for the path.

Tony

> Signed-off-by: Miguel Angel Aguilar <miguel.aguilar@ridgerun.com> ---
> drivers/input/keyboard/Kconfig                 |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/reference_kernel/drivers/input/keyboard/Kconfig b/linux-2.6.26/drivers/input/keyboard/Kconfig
> index 0f96a30..cf86a7b 100644
> --- a/reference_kernel/drivers/input/keyboard/Kconfig
> +++ b/linux-2.6.26/drivers/input/keyboard/Kconfig
> @@ -261,7 +261,7 @@ config KEYBOARD_OMAP
>
> config KEYBOARD_TWL4030
> 	tristate "TI TWL4030 keypad support"
> -	depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP_3430SDP)
> +	depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP_3430SDP || MACH_OMAP3EVM)
> 	help
> 	  Say Y here if you want to use the OMAP TWL4030 keypad.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
