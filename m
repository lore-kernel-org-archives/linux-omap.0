From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 2/3] OMAP4: Ethernet: KS8851
	Board Support
Date: Wed, 5 May 2010 13:04:15 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C7096@dbde02.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043DEEB8C1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043DEEB8C1-lTKHBJngVwKIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Arce, Abraham" <x0066660-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
> [mailto:linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Arce, Abraham
> Sent: Wednesday, May 05, 2010 12:40 PM
> To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [PATCH v1 2/3] OMAP4: Ethernet: KS8851 Board Support
> 
> 
> Enable Micrel KS8851 SPI network chip for OMAP4430
> 
> Signed-off-by: Abraham Arce <x0066660-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |   30 
> ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c 
> b/arch/arm/mach-omap2/board-4430sdp.c
> index b88f28c..801c2a7 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -18,6 +18,7 @@
>  #include <linux/io.h>
>  #include <linux/gpio.h>
>  #include <linux/usb/otg.h>
> +#include <linux/spi/spi.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -32,6 +33,30 @@
>  #include <asm/hardware/gic.h>
>  #include <asm/hardware/cache-l2x0.h>
>  
> +#define ETHERNET_KS8851_IRQ		34
> +#define ETHERNET_KS8851_POWER_ENABLE	48
> +#define ETHERNET_KS8851_QUART		138
> +
> +static struct spi_board_info sdp4430_spi_board_info[] __initdata = {
> +	{
> +		.modalias               = "ks8851",
> +		.bus_num                = 1,
> +		.chip_select            = 0,
> +		.max_speed_hz           = 24000000,
> +		.irq                    = ETHERNET_KS8851_IRQ,
> +	},
> +};
> +
> +static void omap_ethernet_init(void)
> +{
> +	gpio_request(ETHERNET_KS8851_POWER_ENABLE, "ethernet");
> +	gpio_direction_output(ETHERNET_KS8851_POWER_ENABLE, 1);
> +	gpio_request(ETHERNET_KS8851_QUART, "quart");
> +	gpio_direction_output(ETHERNET_KS8851_QUART, 1);
> +	gpio_request(ETHERNET_KS8851_IRQ, "ks8851");

Any reason for not checking return value of gpio_request()?

-Manjunath
------------------------------------------------------------------------------
