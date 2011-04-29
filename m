From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/2] AM35xx-Craneboard:Display: Add DVI and TV Support
Date: Fri, 29 Apr 2011 16:44:44 +0400
Message-ID: <4DBAB2BC.1090202@ru.mvista.com>
References: <[PATCH]> <1304077261-17811-2-git-send-email-srinath@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304077261-17811-2-git-send-email-srinath@mistralsolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: srinath@mistralsolutions.com
Cc: linux-omap@vger.kernel.org, nm@ti.com, linux@arm.linux.org.uk, umeshk@mistralsolutions.com, tony@atomide.com, nagendra@mistralsolutions.com, linux-kernel@vger.kernel.org, khilman@deeprootsystems.com, jdk@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 29-04-2011 15:41, srinath@mistralsolutions.com wrote:

> From: Srinath <srinath@mistralsolutions.com>

> Added Display (DVI and TV) support for CraneBoard.

> Signed-off-by: Srinath <srinath@mistralsolutions.com>
[...]

> diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
> index 05867b5..83fe85b 100644
> --- a/arch/arm/mach-omap2/board-am3517crane.c
> +++ b/arch/arm/mach-omap2/board-am3517crane.c
[...]
> @@ -66,11 +69,83 @@ static struct usbhs_omap_board_data usbhs_bdata __initdata = {
>   	.reset_gpio_port[2]  = -EINVAL
>   };
>
> +static void __init am3517_crane_display_init(void)
> +{
> +	int ret;
> +
> +	ret = omap_mux_init_gpio(GPIO_DVI_ENABLE, OMAP_PIN_OUTPUT);
> +	if (ret<  0) {
> +		pr_err("Can not configure mux for GPIO_DVI_ENABLE %d\n",
> +			GPIO_DVI_ENABLE);
> +		return;
> +	}
> +
> +	ret = gpio_request(GPIO_DVI_ENABLE, "dvi_enable");
> +	if (ret<  0) {
> +		pr_err("Can not request GPIO %d\n", GPIO_DVI_ENABLE);
> +		return;
> +	}
> +
> +	ret = gpio_direction_output(GPIO_DVI_ENABLE, 1);
> +	if (ret<  0) {
> +		gpio_free(GPIO_DVI_ENABLE);
> +		pr_err("Unable to enable DVI\n");
> +		return;
> +	}

    You can use gpio_request_one() ISO gpio_request()/gpio_direction_output().

WBR, Sergei
