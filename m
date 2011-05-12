From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH V3] OMAP3+: SR Layer Cleanup
Date: Thu, 12 May 2011 13:41:00 +0200
Message-ID: <4DCBC74C.4020101@ti.com>
References: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51121 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755928Ab1ELLlJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:41:09 -0400
In-Reply-To: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Shweta,

On 5/11/2011 11:12 AM, Gulati, Shweta wrote:
> To set sr ntarget values  for all volt_domain,
> volt_table is retrieved by doing a look_up of 'vdd_name'
> field from omap_hwmod but voltage domain pointer does not
> belong to omap_hwmod and is not used anywhere else.
> As a part of voltage layer and SR Layer clean up volt
> pointer is removed from omap_hwmod and added in dev
> attributes of SR.
>
> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>
> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
> Cc: Nishanth Menon<nm@ti.com>
> ---
> V3:
>     Changed the Subject and Rephrased Commit log as reviewed
>     by Nishanth Menon.
>   V2:
>     Rebased on latest 'pm-wip/voltdm_a' branch.
>
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   17 +++++++++++++----
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   19 ++++++++++++++++---

Since this patch is touching some hwmod files, it will be good to Cc 
Paul and me. It is far from obvious from the subject that hwmod data are 
involved in this patch.

>   arch/arm/mach-omap2/smartreflex.h            |   10 ++++++++++
>   arch/arm/mach-omap2/sr_device.c              |   11 +++++++----
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 -
>   5 files changed, 46 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 3cd91ac..6a704bd 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -29,6 +29,7 @@
>
>   #include "omap_hwmod_common_data.h"
>
> +#include "smartreflex.h"
>   #include "prm-regbits-34xx.h"
>   #include "cm-regbits-34xx.h"
>   #include "wd_timer.h"
> @@ -2904,6 +2905,10 @@ static struct omap_hwmod_class omap36xx_smartreflex_hwmod_class = {
>   };
>
>   /* SR1 */
> +static struct omap_sr_dev_attr sr1_dev_attr = {
> +       .voltdm_name   = "mpu_iva",
> +};
> +
>   static struct omap_hwmod_ocp_if *omap3_sr1_slaves[] = {
>          &omap3_l4_core__sr1,
>   };
> @@ -2912,7 +2917,6 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
>          .name           = "sr1_hwmod",
>          .class          =&omap34xx_smartreflex_hwmod_class,
>          .main_clk       = "sr1_fck",
> -       .vdd_name       = "mpu_iva",
>          .prcm           = {
>                  .omap2 = {
>                          .prcm_reg_id = 1,
> @@ -2924,6 +2928,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
>          },
>          .slaves         = omap3_sr1_slaves,
>          .slaves_cnt     = ARRAY_SIZE(omap3_sr1_slaves),
> +       .dev_attr       =&sr1_dev_attr,
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
>                                          CHIP_IS_OMAP3430ES3_0 |
>                                          CHIP_IS_OMAP3430ES3_1),
> @@ -2934,7 +2939,6 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
>          .name           = "sr1_hwmod",
>          .class          =&omap36xx_smartreflex_hwmod_class,
>          .main_clk       = "sr1_fck",
> -       .vdd_name       = "mpu_iva",
>          .prcm           = {
>                  .omap2 = {
>                          .prcm_reg_id = 1,
> @@ -2946,10 +2950,15 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
>          },
>          .slaves         = omap3_sr1_slaves,
>          .slaves_cnt     = ARRAY_SIZE(omap3_sr1_slaves),
> +       .dev_attr       =&sr1_dev_attr,
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
>   };
>
>   /* SR2 */
> +static struct omap_sr_dev_attr sr2_dev_attr = {
> +       .voltdm_name    = "core",
> +};
> +
>   static struct omap_hwmod_ocp_if *omap3_sr2_slaves[] = {
>          &omap3_l4_core__sr2,
>   };
> @@ -2958,7 +2967,6 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
>          .name           = "sr2_hwmod",
>          .class          =&omap34xx_smartreflex_hwmod_class,
>          .main_clk       = "sr2_fck",
> -       .vdd_name       = "core",
>          .prcm           = {
>                  .omap2 = {
>                          .prcm_reg_id = 1,
> @@ -2970,6 +2978,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
>          },
>          .slaves         = omap3_sr2_slaves,
>          .slaves_cnt     = ARRAY_SIZE(omap3_sr2_slaves),
> +       .dev_attr       =&sr2_dev_attr,
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
>                                          CHIP_IS_OMAP3430ES3_0 |
>                                          CHIP_IS_OMAP3430ES3_1),
> @@ -2980,7 +2989,6 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
>          .name           = "sr2_hwmod",
>          .class          =&omap36xx_smartreflex_hwmod_class,
>          .main_clk       = "sr2_fck",
> -       .vdd_name       = "core",
>          .prcm           = {
>                  .omap2 = {
>                          .prcm_reg_id = 1,
> @@ -2992,6 +3000,7 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
>          },
>          .slaves         = omap3_sr2_slaves,
>          .slaves_cnt     = ARRAY_SIZE(omap3_sr2_slaves),
> +       .dev_attr       =&sr2_dev_attr,
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
>   };
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 3e88dd3..1331b39 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -30,6 +30,7 @@
>
>   #include "omap_hwmod_common_data.h"
>
> +#include "smartreflex.h"
>   #include "cm1_44xx.h"
>   #include "cm2_44xx.h"
>   #include "prm44xx.h"
> @@ -3775,6 +3776,10 @@ static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
>   };
>
>   /* smartreflex_core */
> +static struct omap_sr_dev_attr sr_core_dev_attr = {

In order to stick to the convention used so far for the other dev_attr, 
please use the following :
+/* smartreflex_core dev_attr */
+static struct omap_smartreflex_dev_attr smartreflex_core_dev_attr = {

> +       .voltdm_name   = "core",
> +};

And you should move it on top of the omap44xx_smartreflex_XXX_hwmod 
structure.

> +
>   static struct omap_hwmod omap44xx_smartreflex_core_hwmod;
>   static struct omap_hwmod_irq_info omap44xx_smartreflex_core_irqs[] = {
>          { .irq = 19 + OMAP44XX_IRQ_GIC_START },
> @@ -3809,7 +3814,6 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
>          .mpu_irqs       = omap44xx_smartreflex_core_irqs,
>          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_smartreflex_core_irqs),
>          .main_clk       = "smartreflex_core_fck",
> -       .vdd_name       = "core",
>          .prcm = {
>                  .omap4 = {
>                          .clkctrl_reg = OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
> @@ -3817,10 +3821,15 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
>          },
>          .slaves         = omap44xx_smartreflex_core_slaves,
>          .slaves_cnt     = ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
> +       .dev_attr       =&sr_core_dev_attr,

Move .dev_attr before the .slaves.

The two last points are applicable for every SR instances.

>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
>   /* smartreflex_iva */
> +static struct omap_sr_dev_attr sr_iva_dev_attr = {
> +       .voltdm_name   = "iva",
> +};
> +
>   static struct omap_hwmod omap44xx_smartreflex_iva_hwmod;
>   static struct omap_hwmod_irq_info omap44xx_smartreflex_iva_irqs[] = {
>          { .irq = 102 + OMAP44XX_IRQ_GIC_START },
> @@ -3855,7 +3864,6 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
>          .mpu_irqs       = omap44xx_smartreflex_iva_irqs,
>          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_smartreflex_iva_irqs),
>          .main_clk       = "smartreflex_iva_fck",
> -       .vdd_name       = "iva",
>          .prcm = {
>                  .omap4 = {
>                          .clkctrl_reg = OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
> @@ -3863,10 +3871,15 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
>          },
>          .slaves         = omap44xx_smartreflex_iva_slaves,
>          .slaves_cnt     = ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
> +       .dev_attr       =&sr_iva_dev_attr,
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
>   /* smartreflex_mpu */
> +static struct omap_sr_dev_attr sr_mpu_dev_attr = {
> +       .voltdm_name   = "mpu",
> +};
> +
>   static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod;
>   static struct omap_hwmod_irq_info omap44xx_smartreflex_mpu_irqs[] = {
>          { .irq = 18 + OMAP44XX_IRQ_GIC_START },
> @@ -3901,7 +3914,6 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
>          .mpu_irqs       = omap44xx_smartreflex_mpu_irqs,
>          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_smartreflex_mpu_irqs),
>          .main_clk       = "smartreflex_mpu_fck",
> -       .vdd_name       = "mpu",
>          .prcm = {
>                  .omap4 = {
>                          .clkctrl_reg = OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
> @@ -3909,6 +3921,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
>          },
>          .slaves         = omap44xx_smartreflex_mpu_slaves,
>          .slaves_cnt     = ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
> +       .dev_attr       =&sr_mpu_dev_attr,
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
> index 5f35b9e..9a7f770 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -197,6 +197,16 @@ struct omap_sr_nvalue_table {
>   };
>
>   /**
> + * struct omap_sr_dev_attr - Smartreflex Device attribute.
> + *
> + * @voltdm_name:       Name of voltdomain of SR instance

You should be more specific. This is the name of the SR sensor voltage 
domain.
The Smartreflex controller IPs are all inside the CORE voltage domain.

Regards,
Benoit
