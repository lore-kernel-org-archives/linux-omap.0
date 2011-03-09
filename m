From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2 15/18] I2C: OMAP2+: add correct functionality flags
 to all omap2plus i2c dev_attr
Date: Wed, 9 Mar 2011 14:49:05 +0100
Message-ID: <4D778551.5010900@ti.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com> <20110308110912.23531.6379.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59063 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213Ab1CINt2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 08:49:28 -0500
In-Reply-To: <20110308110912.23531.6379.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

Hi Andy,

On 3/8/2011 12:09 PM, Andy Green wrote:
> This adds the new functionality flags for omap i2c unit to all OMAP2
> hwmod definitions
> 
> Cc: patches@linaro.org
> Cc: Ben Dooks<ben-linux@fluff.org>
> Reported-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Andy Green<andy.green@linaro.org>

I have one minor comment about the OMAP4 dev_attr position in the structure. The point here is just to be aligned with the template used by the generator.

Acked-by: Benoit Cousson <b-cousson@ti.com>

> ---
> 
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |    7 ++++++-
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +++++++++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++++++
>   4 files changed, 27 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index de92d75..fe70365 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -1450,7 +1450,12 @@ static struct omap_hwmod_class i2c_class = {
>   	.rev		= OMAP_I2C_IP_VERSION_1,
>   };
> 
> -static struct omap_i2c_dev_attr i2c_dev_attr;
> +static struct omap_i2c_dev_attr i2c_dev_attr = {
> +	.flags		= OMAP_I2C_FLAG_NO_FIFO |
> +			  OMAP_I2C_FLAG_SIMPLE_CLOCK |
> +			  OMAP_I2C_FLAG_16BIT_DATA_REG |
> +			  OMAP_I2C_FLAG_BUS_SHIFT_2,
> +};
> 
>   /* I2C1 */
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index d737b99..a30b100 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -1527,6 +1527,9 @@ static struct omap_hwmod_class i2c_class = {
> 
>   static struct omap_i2c_dev_attr i2c_dev_attr = {
>   	.fifo_depth	= 8, /* bytes */
> +	.flags		= OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
> +			  OMAP_I2C_FLAG_BUS_SHIFT_2 |
> +			  OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
>   };
> 
>   /* I2C1 */
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 324162d..f804e78 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1876,6 +1876,9 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
> 
>   static struct omap_i2c_dev_attr i2c1_dev_attr = {
>   	.fifo_depth	= 8, /* bytes */
> +	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
> +		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
> +		 OMAP_I2C_FLAG_BUS_SHIFT_2,
>   };
> 
>   static struct omap_hwmod_irq_info i2c1_mpu_irqs[] = {
> @@ -1919,6 +1922,9 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
> 
>   static struct omap_i2c_dev_attr i2c2_dev_attr = {
>   	.fifo_depth	= 8, /* bytes */
> +	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
> +		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
> +		 OMAP_I2C_FLAG_BUS_SHIFT_2,
>   };
> 
>   static struct omap_hwmod_irq_info i2c2_mpu_irqs[] = {
> @@ -1962,6 +1968,9 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
> 
>   static struct omap_i2c_dev_attr i2c3_dev_attr = {
>   	.fifo_depth	= 64, /* bytes */
> +	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
> +		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
> +		 OMAP_I2C_FLAG_BUS_SHIFT_2,
>   };
> 
>   static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 4b903c7..bad4b8e 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -27,6 +27,7 @@
>   #include<plat/mcspi.h>
>   #include<plat/mcbsp.h>
>   #include<plat/mmc.h>
> +#include<plat/i2c.h>
> 
>   #include "omap_hwmod_common_data.h"
> 
> @@ -2090,6 +2091,10 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
>   	.rev	= OMAP_I2C_IP_VERSION_2,
>   };
> 

The generator is adding a (probably useless...) comment on top of the structure. For the comment I'd prefer to stick to the template. I'll do a massive cleanup when every OMAP4 drivers will be migrated to hwmod. And then OMAP2 & 3 at some point will stick to that as well.

> +static struct omap_i2c_dev_attr i2c_dev_attr = {
> +	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
> +};
> +
>   /* i2c1 */
>   static struct omap_hwmod omap44xx_i2c1_hwmod;
>   static struct omap_hwmod_irq_info omap44xx_i2c1_irqs[] = {
> @@ -2140,6 +2145,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
>   	},

dev_attr is there in the template:

 +	.dev_attr	=&i2c_dev_attr,

>   	.slaves		= omap44xx_i2c1_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c1_slaves),
> +	.dev_attr	=&i2c_dev_attr,
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
> 
> @@ -2193,6 +2199,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
>   	},
>   	.slaves		= omap44xx_i2c2_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c2_slaves),
> +	.dev_attr	=&i2c_dev_attr,
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
> 
> @@ -2246,6 +2253,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
>   	},
>   	.slaves		= omap44xx_i2c3_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c3_slaves),
> +	.dev_attr	=&i2c_dev_attr,
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
> 
> @@ -2299,6 +2307,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
>   	},
>   	.slaves		= omap44xx_i2c4_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c4_slaves),
> +	.dev_attr	=&i2c_dev_attr,
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };

The OMAP4 part should look like the patch below. I've just updated the scripts to add the new data you introduced.

Regards,
Benoit

---
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index d3b2a46..d8365dc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -27,6 +27,7 @@
 #include <plat/mcspi.h>
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
+#include <plat/i2c.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -2090,6 +2091,11 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
+/* i2c dev_attr */
+static struct omap_i2c_dev_attr i2c_dev_attr = {
+	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
+};
+
 /* i2c1 */
 static struct omap_hwmod omap44xx_i2c1_hwmod;
 static struct omap_hwmod_irq_info omap44xx_i2c1_irqs[] = {
@@ -2138,6 +2144,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C1_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2191,6 +2198,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C2_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2244,6 +2252,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C3_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c3_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2297,6 +2306,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C4_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c4_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-- 
1.7.0.4



