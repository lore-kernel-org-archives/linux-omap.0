From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH:v4 03/13] OMAP: GPIO: Include platform_data structure
 for GPIO
Date: Thu, 24 Jun 2010 12:33:28 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032366AE8A@dbde02.ent.ti.com>
References: <1277218916-15213-1-git-send-email-charu@ti.com>
 <1277218916-15213-2-git-send-email-charu@ti.com>
 <1277218916-15213-3-git-send-email-charu@ti.com>
 <1277218916-15213-4-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52274 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab0FXHDw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 03:03:52 -0400
In-Reply-To: <1277218916-15213-4-git-send-email-charu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Varadarajan, Charulatha
> Sent: Tuesday, June 22, 2010 8:32 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com; paul@pwsan.com; tony@atomide.com; Nayak,
> Rajendra; Basak, Partha; Cousson, Benoit; Varadarajan, Charulatha
> Subject: [PATCH:v4 03/13] OMAP: GPIO: Include platform_data structure for
> GPIO
> 
> This patch introduces platform_data structure for GPIO
> so that GPIO module can be implemented in platform device model.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Basak, Partha <p-basak2@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/gpio.h |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-
> omap/include/plat/gpio.h
> index de1c604..212ce22 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -28,6 +28,7 @@
> 
>  #include <linux/io.h>
>  #include <mach/irqs.h>
> +#include <linux/platform_device.h>
> 
>  #define OMAP1_MPUIO_BASE			0xfffb5000
> 
> @@ -71,6 +72,25 @@
>  				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
>  				 IH_GPIO_BASE + (nr))
> 
> +#define METHOD_MPUIO		0
> +#define METHOD_GPIO_1510	1
> +#define METHOD_GPIO_1610	2
> +#define METHOD_GPIO_7XX		3
> +#define METHOD_GPIO_24XX	5
> +#define METHOD_GPIO_44XX	6
> +
> +struct omap_gpio_dev_attr {
> +	int gpio_bank_width;	/* GPIO bank width */
> +	bool dbck_flag;		/* dbck validity - True only for OMAP3&4 */
> +	bool omap1_ick_flag;	/* OMAP1 ick - True only for OMAP15xx */
> +};
Can we have the field names of the structure something like this?
int	bank_width;
bool	ick_flag;

My understanding is variable name of base pointer to the structure would typically contain "gpio" string. To give a live example, you have used bank_type in struct omap_gpio_platform_data{} below.

With regard to flag name specific to omap1, let it be "true" for OMAP1 and "false" for the remainig platform.



> +
> +struct omap_gpio_platform_data {
> +	u16 virtual_irq_start;
> +	int bank_type;
> +	struct omap_gpio_dev_attr *gpio_attr;
> +};
> +
>  extern int omap_gpio_init(void);	/* Call from board init only */
>  extern void omap2_gpio_prepare_for_idle(int power_state);
>  extern void omap2_gpio_resume_after_idle(void);
> --
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
