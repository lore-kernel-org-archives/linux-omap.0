From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] Revert "ARM: OMAP3530evm: set pendown_state and debounce time for ads7846"
Date: Mon, 06 Aug 2012 13:52:18 -0700
Message-ID: <871ujj7ngd.fsf@ti.com>
References: <876298iv9s.fsf@ti.com>
	<1344284535-16717-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:58553 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756604Ab2HFUwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 16:52:21 -0400
Received: by pbbrr13 with SMTP id rr13so3096157pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 13:52:19 -0700 (PDT)
In-Reply-To: <1344284535-16717-1-git-send-email-grinberg@compulab.co.il> (Igor
	Grinberg's message of "Mon, 6 Aug 2012 23:22:15 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zumeng Chen <zumeng.chen@windriver.com>, Arnd Bergmann <arnd@arndb.de>

Igor Grinberg <grinberg@compulab.co.il> writes:

> 1) The above commit introduced a common ->get_pendown_state() function
> into the generic code, but that function was board-specific for the
> OMAP3EVM and thus broke most other boards using this code.
>
> 2) The above commit was mis-merged introducing another bug which
> prevents the ads7846 driver probe function to succeed.
> The omap_ads7846_init() function frees the pendown GPIO in case there is
> no ->get_pendown_state() function set by the caller (board specific
> code), so it can be requested later by the ads7846 driver.
> The above commit add a common ->get_pendown_state() function without
> removing the gpio_free() call and thus once the ads7846 driver tries
> to use the pendown GPIO, it crashes as the pendown GPIO has not been
> requested.
>
> 3) The above commit introduces NO new functionality as
> get_pendown_state() function is already implemented in a suitable way by
> the ads7846 driver and the debounce time handling has already been
> fixed by commit 97ee9f01 (ARM: OMAP: fix the ads7846 init code).
>
> This reverts commit 16aced80f6739beb2a6ff7b6f96c83ba80d331e8.
>
> Conflicts:
> 	arch/arm/mach-omap2/common-board-devices.c
>
> Solved by taking the working version prior to the above commit.
>
> Cc: Zumeng Chen <zumeng.chen@windriver.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> Kevin, sorry for the late reply.
> How about the above commit message and the below patch?
>
> The patch applies cleanly to Tony's master branch (6 Aug 2012)
> or Kevin's kevin-omap-pm/for_3.6/fixes/ads7846
> after resetting two top most commits.

Now that v3.6-rc1 is out, it should probalby be applied on top of -rc1.
I've taken care of that and tested as well.

> This patch has been tested on both above branches on cm-t3730.
> Any other board tested will be greately appreciated.
>
> Also, if after all said in the commit message, you still don't
> want to revert the original patch, feel free to post your thoughts.

After all the digging I did, I agree that the revert is the best
solution.  

While it's a slightly different problem/bug, I think the gpio_free() in
common-board-devices.c should still be unconditonal since the
gpio_request() is now unconditional.  That can be a separate patch though.

Acked-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>

Tested on 3430/n900, 3530/Overo, 3730/Overo STORM, 3730/BB-xM.

The Overo boards were the ones that were crashing due to this bug since
the pendown GPIO was the only one used in the bank.

Tony, can you queue this up for v3.6-rc?  I have a version in my
for_3.6/fixes/ads7846-2 branch with the tags above applied, based on v3.6-rc1.

Thanks

Kevin

>  arch/arm/mach-omap2/board-omap3evm.c       |    1 +
>  arch/arm/mach-omap2/common-board-devices.c |   11 -----------
>  arch/arm/mach-omap2/common-board-devices.h |    1 -
>  3 files changed, 1 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index ef230a0..0d362e9 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -58,6 +58,7 @@
>  #include "hsmmc.h"
>  #include "common-board-devices.h"
>  
> +#define OMAP3_EVM_TS_GPIO	175
>  #define OMAP3_EVM_EHCI_VBUS	22
>  #define OMAP3_EVM_EHCI_SELECT	61
>  
> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
> index 1473474..c187586 100644
> --- a/arch/arm/mach-omap2/common-board-devices.c
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -35,16 +35,6 @@ static struct omap2_mcspi_device_config ads7846_mcspi_config = {
>  	.turbo_mode	= 0,
>  };
>  
> -/*
> - * ADS7846 driver maybe request a gpio according to the value
> - * of pdata->get_pendown_state, but we have done this. So set
> - * get_pendown_state to avoid twice gpio requesting.
> - */
> -static int omap3_get_pendown_state(void)
> -{
> -	return !gpio_get_value(OMAP3_EVM_TS_GPIO);
> -}
> -
>  static struct ads7846_platform_data ads7846_config = {
>  	.x_max			= 0x0fff,
>  	.y_max			= 0x0fff,
> @@ -55,7 +45,6 @@ static struct ads7846_platform_data ads7846_config = {
>  	.debounce_rep		= 1,
>  	.gpio_pendown		= -EINVAL,
>  	.keep_vref_on		= 1,
> -	.get_pendown_state	= &omap3_get_pendown_state,
>  };
>  
>  static struct spi_board_info ads7846_spi_board_info __initdata = {
> diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
> index 4c4ef6a..a0b4a428 100644
> --- a/arch/arm/mach-omap2/common-board-devices.h
> +++ b/arch/arm/mach-omap2/common-board-devices.h
> @@ -4,7 +4,6 @@
>  #include "twl-common.h"
>  
>  #define NAND_BLOCK_SIZE	SZ_128K
> -#define OMAP3_EVM_TS_GPIO	175
>  
>  struct mtd_partition;
>  struct ads7846_platform_data;
