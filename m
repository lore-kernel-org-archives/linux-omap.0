From: "zumeng.chen" <zchen@windriver.com>
Subject: Re: [PATCH] ARM: OMAP2+: ads7846 init: fix fault caused by freeing
 pen-down GPIO
Date: Fri, 27 Jul 2012 05:19:33 +0800
Message-ID: <5011B465.70605@windriver.com>
References: <1342048700-15040-1-git-send-email-khilman@ti.com>	<500D494D.8020606@compulab.co.il> <500D4F2A.9090706@compulab.co.il> <87zk6mpbfa.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:56568 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab2GZVTw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 17:19:52 -0400
In-Reply-To: <87zk6mpbfa.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Zumeng Chen <zumeng.chen@windriver.com>

On 2012=E5=B9=B407=E6=9C=8827=E6=97=A5 03:30, Kevin Hilman wrote:
> + Zumeng Chen
>
> Igor Grinberg<grinberg@compulab.co.il>  writes:
>
>> Hi Kevin,
>>
>> I've just noticed that the patch has been modified by Arnd in a way
>> that of course will trigger GPIO use without being requested.
>> I'm sorry, I was not available by that time Arnd changed the patch.
> Your right, your original patch isn't the problem.  I found the root
> cause.
>
> The real problem is actually introduced by the merge of your patch fr=
om
> the arm-soc/cleanup branch, and this one from Zumeng Chen: commit
> 16aced80f6 (ARM: OMAP3530evm: set pendown_state and debounce time for
> ads7846) from the arm-soc/boards branch.
>
> However, looking closer at the one from Zumeng, that one is clearly n=
ot
> right.  It unconditionally adds a *board-specific* ->get_pendown_stat=
e
> function to the pdata that is common to *all* boards.  That's just wr=
ong
> and has the side-effect of making ->get_pendown_state() wrong on ever=
y
> board except the OMAP3EVM.  Oops.
>
> So, IMO, in addition to $SUBJECT patch, in order to get the touchscre=
en
> GPIO working on non OMAP3EVM boards, we also need something like this=
 as
> well.
Definitely, thanks Kevin.
> Igor, Zumeng, could you try this out on your boards anc confirm if it=
's
> working?  I currently don't have a board setup with a touchscreen in =
my
> board farm.
Acked

Zumeng
> Kevin
>
>  From 85516c6a3354967caf4cff434d28c3001cd411eb Mon Sep 17 00:00:00 20=
01
> From: Kevin Hilman<khilman@ti.com>
> Date: Thu, 26 Jul 2012 12:15:38 -0700
> Subject: [PATCH 2/2] ARM: OMAP2+: ads7846: fix ->get_pendown_state() =
to work
>   on all boards
>
> commit 16aced80f6 (ARM: OMAP3530evm: set pendown_state and debounce
> time for ads7846) introduced a common ->get_pendown_state() function
> into the generic code, but that function was board-specific for the
> OMAP3EVM.
>
> Fix this up to work for all boards that pass in a pendown GPIO.
>
> Cc: Zumeng Chen<zumeng.chen@windriver.com>
> Cc: Igor Grinberg<grinberg@compulab.co.il>
> Signed-off-by: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/mach-omap2/board-omap3evm.c       |    1 +
>   arch/arm/mach-omap2/common-board-devices.c |    4 +++-
>   arch/arm/mach-omap2/common-board-devices.h |    1 -
>   3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index ef230a0..0d362e9 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -58,6 +58,7 @@
>   #include "hsmmc.h"
>   #include "common-board-devices.h"
>
> +#define OMAP3_EVM_TS_GPIO	175
>   #define OMAP3_EVM_EHCI_VBUS	22
>   #define OMAP3_EVM_EHCI_SELECT	61
>
> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/ma=
ch-omap2/common-board-devices.c
> index 0fee95f..06f176f 100644
> --- a/arch/arm/mach-omap2/common-board-devices.c
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -40,9 +40,10 @@ static struct omap2_mcspi_device_config ads7846_mc=
spi_config =3D {
>    * of pdata->get_pendown_state, but we have done this. So set
>    * get_pendown_state to avoid twice gpio requesting.
>    */
> +static int omap3_gpio_pendown;
>   static int omap3_get_pendown_state(void)
>   {
> -	return !gpio_get_value(OMAP3_EVM_TS_GPIO);
> +	return !gpio_get_value(omap3_gpio_pendown);
>   }
>
>   static struct ads7846_platform_data ads7846_config =3D {
> @@ -74,6 +75,7 @@ void __init omap_ads7846_init(int bus_num, int gpio=
_pendown, int gpio_debounce,
>   	struct spi_board_info *spi_bi =3D&ads7846_spi_board_info;
>   	int err;
>
> +	omap3_gpio_pendown =3D gpio_pendown;
>   	err =3D gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
>   	if (err) {
>   		pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
> diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/ma=
ch-omap2/common-board-devices.h
> index 4c4ef6a..a0b4a428 100644
> --- a/arch/arm/mach-omap2/common-board-devices.h
> +++ b/arch/arm/mach-omap2/common-board-devices.h
> @@ -4,7 +4,6 @@
>   #include "twl-common.h"
>
>   #define NAND_BLOCK_SIZE	SZ_128K
> -#define OMAP3_EVM_TS_GPIO	175
>
>   struct mtd_partition;
>   struct ads7846_platform_data;

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
