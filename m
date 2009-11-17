From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/8] musb: Update setup_usb() call for all Davinci boards
Date: Tue, 17 Nov 2009 18:53:35 +0300
Message-ID: <4B02C6FF.6050806@ru.mvista.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-2-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-3-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-4-git-send-email-ajay.gupta@ti.com> <1258470596-24321-5-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:61476 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750905AbZKQPxA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 10:53:00 -0500
In-Reply-To: <1258470596-24321-5-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, cooloney@kernel.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, gadiyar@ti.com

Ajay Kumar Gupta wrote:

> setup_usb() has been modified to pass board specific data so updating
> this function call from all Davinci based boards.

> Added "struct device;" to fix below compilation warning for Davinci boards.
> "musb.h: struct device, defined within parameter list"

    You should fix the missing #include in the musb.h, not band-aid it here...

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

> diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
> index 77e8067..31c5741 100644
> --- a/arch/arm/mach-davinci/board-dm355-evm.c
> +++ b/arch/arm/mach-davinci/board-dm355-evm.c
> @@ -24,6 +24,7 @@
>  #include <media/tvp514x.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/eeprom.h>
> +#include <linux/usb/musb.h>
>  
>  #include <asm/setup.h>
>  #include <asm/mach-types.h>
> @@ -317,6 +318,12 @@ static struct spi_board_info dm355_evm_spi_info[] __initconst = {
>  	},
>  };
>  
> +/* musb board specific data */
> +static struct musb_hdrc_board_data musb_bdata __initdata = {
> +	.power = 250,	/* (power in mA)/2 */
> +	.potpgt = 4,	/* (potpgt in msec)/2 */
> +};
> +
>  static __init void dm355_evm_init(void)
>  {
>  	struct clk *aemif;
> @@ -344,7 +351,7 @@ static __init void dm355_evm_init(void)
>  	gpio_request(2, "usb_id_toggle");
>  	gpio_direction_output(2, USB_ID_VALUE);
>  	/* irlml6401 switches over 1A in under 8 msec */
> -	setup_usb(500, 8);
> +	setup_usb(&musb_bdata);

    Unfortunately, this will conflict with a patch queued for 2.6.33 in 
linux-davinci. Though in fact, it will render the part of this patch 
useless... :-/

> diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
> index 1fd3917..dab784c 100644
> --- a/arch/arm/mach-davinci/include/mach/common.h
> +++ b/arch/arm/mach-davinci/include/mach/common.h
> @@ -20,11 +20,14 @@ extern void davinci_irq_init(void);
>  extern void __iomem *davinci_intc_base;
>  extern int davinci_intc_type;
>  
> +struct device;

    NAK. <linux/usb/musb.h> should be fixed instead.

> +#include <linux/usb/musb.h>
> +
>  /* parameters describe VBUS sourcing for host mode */
> -extern void setup_usb(unsigned mA, unsigned potpgt_msec);
> +extern void setup_usb(struct musb_hdrc_board_data *board_data);
>  
>  /* parameters describe VBUS sourcing for host mode */
> -extern void setup_usb(unsigned mA, unsigned potpgt_msec);
> +extern void setup_usb(struct musb_hdrc_board_data *board_data);

    Don't you see -- these are duplicate? You could kill the second one. :-)

    BTW, the mentioned linux-davinci patch moved the declaration to 
<mach/usb.h> (and renamed the function too).

WBR, Sergei
