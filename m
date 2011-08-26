From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 4/6] ti816evm: Add support for musb interface
Date: Fri, 26 Aug 2011 15:32:54 +0400
Message-ID: <4E578466.1040405@ru.mvista.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com> <1314357108-2279-5-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63663 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab1HZLdi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Aug 2011 07:33:38 -0400
In-Reply-To: <1314357108-2279-5-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, tony@atomide.com, Ravi B <ravibabu@ti.com>

Hello.

On 26-08-2011 15:11, Ajay Kumar Gupta wrote:

> From: Ravi B <ravibabu@ti.com>

> Adding musb support in ti816 EVM board file.

> Signed-off-by: Ajay Kumar Gupta<ajay.gupta@ti.com>
> Signed-off-by: Ravi B<ravibabu@ti.com>

    As far as I know, full name is required in signoff.

> ---
>   arch/arm/mach-omap2/board-ti8168evm.c |   15 +++++++++++++++
>   1 files changed, 15 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
> index e516a04..77200d4 100644
> --- a/arch/arm/mach-omap2/board-ti8168evm.c
> +++ b/arch/arm/mach-omap2/board-ti8168evm.c
> @@ -23,6 +23,20 @@
>  #include<plat/irqs.h>
>  #include<plat/board.h>
>  #include<plat/common.h>
> +#include<plat/usb.h>
> +
> +static struct omap_musb_board_data musb_board_data = {
> +	.set_phy_power	= ti81xx_musb_phy_power,
> +	.interface_type	= MUSB_INTERFACE_ULPI,
> +#ifdef CONFIG_USB_MUSB_OTG
> +	.mode           = MUSB_OTG,
> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> +	.mode           = MUSB_HOST,
> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> +	.mode           = MUSB_PERIPHERAL,
> +#endif

    This #ifdef'ery is not longer necessary afetr this patch:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=75a14b1434a0ca409bcc8ab9b6b2e680796c487e

WBR, Sergei
