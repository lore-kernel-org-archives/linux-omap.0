From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can : AM3517EVM : add platform specific init
Date: Fri, 11 Mar 2011 17:57:59 +0100
Message-ID: <4D7A5497.4070801@grandegger.com>
References: <1299775153-16766-1-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:43049 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab1CKQzw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 11:55:52 -0500
In-Reply-To: <1299775153-16766-1-git-send-email-abhilash.kv@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, Sriramakrishnan <srk@ti.com>

On 03/10/2011 05:39 PM, Abhilash K V wrote:
> CAN module on AM3517 requires programming of IO expander
> as part of init sequence. Added transceiver_switch
> callback to handle this.
> 
> Signed-off-by: Sriramakrishnan <srk@ti.com>
> Reviewed-by:  Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
> ---
>  arch/arm/mach-omap2/board-am3517evm.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
> index 2e4aad2..782d72d 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -734,6 +734,23 @@ static struct omap_board_mux board_mux[] __initdata = {
>  };
>  #endif
>  
> +/*
> + * HECC information
> + */
> +
> +#define CAN_STB         214
> +static void hecc_phy_control(int on)
> +{
> +        int r;
> +
> +        r = gpio_request(CAN_STB, "can_stb");
> +        if (r) {
> +                printk(KERN_ERR "failed to get can_stb \n");
> +                return;
> +        }
> +
> +        gpio_direction_output(CAN_STB, (on==1)?0:1);
> +}

This function is called ony *any* ifconfig up and down request. I would
expect gpio_request() will return -EBUSY when it's called more than once.

Wolfgang.

