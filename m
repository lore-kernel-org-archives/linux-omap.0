From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PM-SR] [PATCH] OMAP: PM: Remove the usage of vdd id's.
Date: Fri, 25 Jun 2010 08:15:37 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C01335B64AB@dlee02.ent.ti.com>
References: <1277391768-3361-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56320 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755165Ab0FYNPl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 09:15:41 -0400
In-Reply-To: <1277391768-3361-1-git-send-email-thara@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

[Reply 1/2]
Gopinath, Thara had written, on 06/24/2010 10:02 AM, the following:
> This patch removes the usage of vdd and sr id alltogether.
good.. thanks for doing this :). /me had enough of them ;)

> This is achieved by introducing a separte voltage domain per
> VDD and hooking this up with the voltage and smartreflex
> internal info structure. Any user of voltage or smartreflex layer
> should call into omap_volt_domain_get to get the voltage
> domain handle and make use of this to call into the various
> exported API's.
>
> These changes should be part of V2 of the sr/voltage series
> instead of being a separate patch in itself.

Apologies on the spam, but it does look like the reply never reached l-o due to size! I will split the reply into two parts if possible

This series seems to do a lot more than sr id, vdd id removal.. mebbe
splitting this series was easier for review - after spending an hr of
cross refering the humungous patch to code, i am all set to have a break ;).
I know the series will get squashed anyways, but helps review. anyways,
my attempt at giving some sane comments below.

>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    4 +
>  arch/arm/mach-omap2/pm-debug.c                |    2 +-
>  arch/arm/mach-omap2/smartreflex-class3.c      |   26 +-
>  arch/arm/mach-omap2/smartreflex.c             |  115 +++--
>  arch/arm/mach-omap2/sr_device.c               |   14 +-
>  arch/arm/mach-omap2/voltage.c                 |  697 +++++++++++++------------
>  arch/arm/mach-omap2/voltage.h                 |  126 -----
>  arch/arm/plat-omap/include/plat/smartreflex.h |   41 +-
>  arch/arm/plat-omap/include/plat/voltage.h     |  137 +++++
>  9 files changed, 617 insertions(+), 545 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/voltage.h
>  create mode 100644 arch/arm/plat-omap/include/plat/voltage.h
what is the motivation for plat/voltage.h? are we expecting external
users other than voltage related layers to use this? are all APIs
required to be exposed?

>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 074347f..c4f9abc 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -265,6 +265,7 @@ static struct omap_sr_dev_data omap34xx_sr1_dev_attr = {
>         .test_sennenable        = 0x3,
>         .test_senpenable        = 0x3,
>         .test_nvalues           = omap34xx_sr1_test_nvalues,
> +       .vdd_name               = "mpu",
>  };
>
>  static struct omap_hwmod omap34xx_sr1_hwmod = {
> @@ -294,6 +295,7 @@ static struct omap_sr_dev_data omap36xx_sr1_dev_attr = {
>         .test_sennenable        = 0x1,
>         .test_senpenable        = 0x1,
>         .test_nvalues           = omap36xx_sr1_test_nvalues,
> +       .vdd_name               = "mpu",
>  };
>
>  static struct omap_hwmod omap36xx_sr1_hwmod = {
> @@ -328,6 +330,7 @@ static struct omap_sr_dev_data omap34xx_sr2_dev_attr = {
>         .test_sennenable        = 0x3,
>         .test_senpenable        = 0x3,
>         .test_nvalues           = omap34xx_sr2_test_nvalues,
> +       .vdd_name               = "core",
>  };
>
>  static struct omap_hwmod omap34xx_sr2_hwmod = {
> @@ -356,6 +359,7 @@ static struct omap_sr_dev_data omap36xx_sr2_dev_attr = {
>         .test_sennenable        = 0x1,
>         .test_senpenable        = 0x1,
>         .test_nvalues           = omap36xx_sr2_test_nvalues,
> +       .vdd_name               = "core",
minor nitpick -> we should standardize on l3 or core -> I like core as
it is a little more precise but i see usage mixed up in
arch/arm/mach-omap2/*.[ch] - just a side note..

>  };

>
>  static struct omap_hwmod omap36xx_sr2_hwmod = {
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 9ed7146..82bb032 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -31,11 +31,11 @@
>  #include <plat/board.h>
>  #include <plat/powerdomain.h>
>  #include <plat/clockdomain.h>
> +#include <plat/voltage.h>
>
>  #include "prm.h"
>  #include "cm.h"
>  #include "pm.h"
> -#include "voltage.h"
>
>  int omap2_pm_debug;
>
> diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
> index f3b766f..0b5c824 100644
> --- a/arch/arm/mach-omap2/smartreflex-class3.c
> +++ b/arch/arm/mach-omap2/smartreflex-class3.c
> @@ -14,36 +14,36 @@
>  #include <plat/smartreflex.h>
>
>  #include "smartreflex-class3.h"
> -#include "voltage.h"
>
> -static int sr_class3_enable(int id)
> +static int sr_class3_enable(struct omap_volt_domain *volt_domain)
>  {
>         unsigned long volt = 0;
>
> -       volt = get_curr_voltage(id);
> +       volt = get_curr_voltage(volt_domain);
>         if (!volt) {
> -               pr_warning("%s: Current voltage unknown.Cannot enable SR%d\n",
> -                               __func__, id);
> +               pr_warning("%s: Current voltage unknown.Cannot enable sr_%s\n",
I am going to be a nitpick ;)->                     ^^^^ space after
that '.'
> +                               __func__, volt_domain->name);
>                 return -ENODATA;
>         }
>
> -       omap_voltageprocessor_enable(id);
> -       return sr_enable(id, volt);
> +       omap_voltageprocessor_enable(volt_domain);
> +       return sr_enable(volt_domain, volt);
>  }
>
> -static int sr_class3_disable(int id, int is_volt_reset)
> +static int sr_class3_disable(
> +               struct omap_volt_domain *volt_domain, int is_volt_reset)
>  {
> -       omap_voltageprocessor_disable(id);
> -       sr_disable(id);
> +       omap_voltageprocessor_disable(volt_domain);
> +       sr_disable(volt_domain);
>         if (is_volt_reset)
> -               omap_reset_voltage(id);
> +               omap_reset_voltage(volt_domain);
>
>         return 0;
>  }
>
> -static int sr_class3_configure(int id)
> +static int sr_class3_configure(struct omap_volt_domain *volt_domain)
>  {
> -       return sr_configure_errgen(id);
> +       return sr_configure_errgen(volt_domain);
>  }
>
>  /* SR class3 structure */
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 57fc9b2..2fb90d4 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -35,8 +35,6 @@
>  #include <plat/common.h>
>  #include <plat/smartreflex.h>
>
> -#include "voltage.h"
> -
>  #define SMARTREFLEX_NAME_LEN   16
>  #define SR_DISABLE_TIMEOUT     200
>
> @@ -60,6 +58,7 @@ struct omap_sr {
>         void __iomem            *base;
>         struct platform_device  *pdev;
>         struct list_head        node;
> +       struct omap_volt_domain *volt_domain;
>  };
>
>  /* sr_list contains all the instances of smartreflex module */
> @@ -109,13 +108,13 @@ static inline u32 sr_read_reg(struct omap_sr *sr, unsigned offset)
>         return __raw_readl(sr->base + offset);
>  }
>
> -static struct omap_sr *_sr_lookup(int srid)
> +static struct omap_sr *_sr_lookup(struct omap_volt_domain *volt_domain)
>  {
>         struct omap_sr *sr_info, *temp_sr_info;
>
>         sr_info = NULL;

generic comment - please add:
if unlikely(!volt_domain) {
        pr_err("%s: someone is passing me null as domain! FIX ME!\n",
                __func__);
        return ERR_PTR(-EINVAL); (or NULL - better ERR_PTR though..)
}

>         list_for_each_entry(temp_sr_info, &sr_list, node) {
> -               if (srid == temp_sr_info->srid) {
> +               if (volt_domain == temp_sr_info->volt_domain) {
why are we doing pointer comparsion - should'nt we do strcmp with name?

>                         sr_info = temp_sr_info;
>                         break;
>                 }
> @@ -142,7 +141,7 @@ static irqreturn_t sr_omap_isr(int irq, void *data)
>
>         /* Call the class driver notify function if registered*/
>         if (sr_class->class_type == SR_CLASS2 && sr_class->notify)
> -               sr_class->notify(sr_info->srid, status);
> +               sr_class->notify(sr_info->volt_domain, status);
>
>         return IRQ_HANDLED;
>  }
> @@ -191,7 +190,7 @@ static void sr_set_regfields(struct omap_sr *sr)
>                 sr->err_weight = OMAP3430_SR_ERRWEIGHT;
>                 sr->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
>                 sr->accum_data = OMAP3430_SR_ACCUMDATA;
> -               if (sr->srid == VDD1) {
> +               if (!(strcmp(sr->volt_domain->name, "mpu"))) {
>                         sr->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
>                         sr->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;

question -> why cant this go to hwmod data? it is a bit irritating to
have a set regfields function which seems to handle omap3430 and tells
us that 3630 needs to be done.. IMHO, this is the job of hwmod, lets
move it there and populate sr_info for us to use.

>                 } else {
> @@ -212,7 +211,7 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
>         }
>
>         sr->is_autocomp_active = 1;
> -       if (sr_class->enable(sr->srid))
> +       if (sr_class->enable(sr->volt_domain))
>                 sr->is_autocomp_active = 0;
>  }
>
> @@ -226,7 +225,7 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
>         }
>
>         if (sr->is_autocomp_active == 1) {
> -               sr_class->disable(sr->srid, 1);
> +               sr_class->disable(sr->volt_domain, 1);
>                 sr->is_autocomp_active = 0;
>         }
>  }
> @@ -244,14 +243,14 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
>   */
>  static int sr_late_init(struct omap_sr *sr_info)
>  {
> -       char name[SMARTREFLEX_NAME_LEN + 1];
> +       char *name = "sr_";
>         struct omap_sr_data *pdata = sr_info->pdev->dev.platform_data;
>         int ret = 0;
>
>         if (sr_class->class_type == SR_CLASS2 &&
>                 sr_class->notify_flags && sr_info->irq) {
>
> -               sprintf(name, "sr%d", sr_info->srid);
> +               strcat(name, sr_info->volt_domain->name);

NAK for quiet a few reasons (probably unrelated to the subject of the
patch itself - but a real problem though):
a) I have registered ISR and guess what? when we cat /proc/interrupts
with the above logic, we get " " as the interrupt names! the reason
being request_isr stores the pointer for later usage, in this case name
has local reference.
b) we assume that 3 characters sr_ is enough for voltage_domain->name,
good for mpu, dsp. how about "core" ? we will overflow crashing the system.

suggestion kzalloc it and strcat it. no sweat after that.

>                 ret = request_irq(sr_info->irq, sr_omap_isr,
>                                 IRQF_DISABLED, name, (void *)sr_info);
>                 if (ret) {
> @@ -355,7 +354,7 @@ static void sr_v2_disable(struct omap_sr *sr)
>  /**
>   * sr_configure_errgen : Configures the smrtreflex to perform AVS using the
>   *                      error generator module.
> - * @srid - The id of the sr module to be configured.
> + * @volt_domain - VDD to which the SR module to be configured belongs to.
nitpick again      ^^^^ add "pointer to" to help with kdoc (elsewhere too)
>   *
>   * This API is to be called from the smartreflex class driver to
>   * configure the error generator module inside the smartreflex module.
> @@ -364,17 +363,17 @@ static void sr_v2_disable(struct omap_sr *sr)
>   * SR CLASS 2 can choose between ERROR module and MINMAXAVG
>   * module. Returns 0 on success and error value in case of failure.
>   */
> -int sr_configure_errgen(int srid)
> +int sr_configure_errgen(struct omap_volt_domain *volt_domain)
>  {
>         u32 sr_config, sr_errconfig, errconfig_offs, vpboundint_en;
>         u32 vpboundint_st, senp_en , senn_en;
>         u8 senp_shift, senn_shift;
> -       struct omap_sr *sr = _sr_lookup(srid);
> +       struct omap_sr *sr = _sr_lookup(volt_domain);
>         struct omap_sr_data *pdata = sr->pdev->dev.platform_data;
>
>         if (!sr) {
> -               pr_warning("%s: omap_sr struct for SR%d not found\n",
> -                       __func__, srid + 1);
> +               pr_warning("%s: omap_sr struct for sr_%s not found\n",
> +                       __func__, volt_domain->name);
>                 return -EINVAL;
>         }
>
> @@ -419,7 +418,7 @@ int sr_configure_errgen(int srid)
>  /**
>   * sr_configure_minmax : Configures the smrtreflex to perform AVS using the
>   *                      minmaxavg module.
> - * @srid - The id of the sr module to be configured.
> + * @volt_domain - VDD to which the SR module to be configured belongs to.
>   *
>   * This API is to be called from the smartreflex class driver to
>   * configure the minmaxavg module inside the smartreflex module.
> @@ -428,17 +427,17 @@ int sr_configure_errgen(int srid)
>   * SR CLASS 2 can choose between ERROR module and MINMAXAVG
>   * module. Returns 0 on success and error value in case of failure.
>   */
> -int sr_configure_minmax(int srid)
> +int sr_configure_minmax(struct omap_volt_domain *volt_domain)
>  {
>         u32 sr_config, sr_avgwt;
>         u32 senp_en , senn_en;
>         u8 senp_shift, senn_shift;
> -       struct omap_sr *sr = _sr_lookup(srid);
> +       struct omap_sr *sr = _sr_lookup(volt_domain);
>         struct omap_sr_data *pdata = sr->pdev->dev.platform_data;
>

generic comment ->for all exposed functions taking volt_domain pointer.
a class driver outside the scope of this function will use these
functions. as a class driver writer, I know I am stupid and at times end
up passing null pointer to a function that really never expected it.
a unlikely(!volt_domain) check is a nice idea.. but if you depend on
_sr_lookup to do the check, that might be equally good as long as we
*dont crash* and give the developer a chance to fix his code without
banging his head on the wall ;)..

>         if (!sr) {
> -               pr_warning("%s: omap_sr struct for SR%d not found\n",
> -                       __func__, srid + 1);
> +               pr_warning("%s: omap_sr struct for sr_%s not found\n",
> +                       __func__, volt_domain->name);
>                 return -EINVAL;
>         }
>
> @@ -491,7 +490,7 @@ int sr_configure_minmax(int srid)
>
>  /**
>   * sr_enable : Enables the smartreflex module.
> - * @srid - The id of the sr module to be enabled.
> + * @volt_domain - VDD to which the SR module to be enabled belongs to.
>   * @volt - The voltage at which the Voltage domain associated with
>   * the smartreflex module is operating at. This is required only to program
>   * the correct Ntarget value.
> @@ -500,20 +499,20 @@ int sr_configure_minmax(int srid)
>   * enable a smartreflex module. Returns 0 on success. Returns error
>   * value if the voltage passed is wrong or if ntarget value is wrong.
>   */
> -int sr_enable(int srid, unsigned long volt)
> +int sr_enable(struct omap_volt_domain *volt_domain, unsigned long volt)
>  {
>         u32 nvalue_reciprocal;
>         struct omap_volt_data *volt_data;
> -       struct omap_sr *sr = _sr_lookup(srid);
> +       struct omap_sr *sr = _sr_lookup(volt_domain);
>         int ret;
>
>         if (!sr) {
> -               pr_warning("%s: omap_sr struct for SR%d not found\n",
> -                       __func__, srid + 1);
> +               pr_warning("%s: omap_sr struct for sr_%s not found\n",
> +                       __func__, volt_domain->name);
>                 return -EINVAL;
>         }
>
> -       volt_data = omap_get_volt_data(sr->srid, volt);
> +       volt_data = omap_get_volt_data(volt_domain, volt);

I would like to take up the usage of volt_data as a seperate discussion
probably later.. in the context of this patch, no complaints.

>
>         if (IS_ERR(volt_data)) {
>                 dev_warn(&sr->pdev->dev, "%s: Unable to get voltage table"
> @@ -559,7 +558,7 @@ int sr_enable(int srid, unsigned long volt)
>                 return 0;
>
>         /* Configure SR */
> -       ret = sr_class->configure(sr->srid);
> +       ret = sr_class->configure(volt_domain);
>         if (ret)
>                 return ret;
>
> @@ -571,19 +570,19 @@ int sr_enable(int srid, unsigned long volt)
>
>  /**
>   * sr_disable : Disables the smartreflex module.
> - * @srid - The id of the sr module to be disabled.
> + * @volt_domain - VDD to which the SR module to be disabled belongs to.
>   *
>   * This API is to be called from the smartreflex class driver to
>   * disable a smartreflex module.
>   */
> -void sr_disable(int srid)
> +void sr_disable(struct omap_volt_domain *volt_domain)
>  {
> -       struct omap_sr *sr = _sr_lookup(srid);
> +       struct omap_sr *sr = _sr_lookup(volt_domain);
>         struct omap_sr_data *pdata;
>
>         if (!sr) {
> -               pr_warning("%s: omap_sr struct for SR%d not found\n",
> -                       __func__, srid + 1);
> +               pr_warning("%s: omap_sr struct for sr_%s not found\n",
> +                       __func__, volt_domain->name);
>                 return;
>         }
>
> @@ -615,20 +614,20 @@ disable_clocks:
>  /**
>   * omap_smartreflex_enable : API to enable SR clocks and to call into the
>   * registered smartreflex class enable API.
> - * @srid - The id of the sr module to be enabled.
> + * @volt_domain - VDD to which the SR module to be enabled belongs to.
>   *
>   * This API is to be called from the kernel in order to enable
>   * a particular smartreflex module. This API will do the initial
>   * configurations to turn on the smartreflex module and in turn call
>   * into the registered smartreflex class enable API.
>   */
> -void omap_smartreflex_enable(int srid)
> +void omap_smartreflex_enable(struct omap_volt_domain *volt_domain)
>  {
> -       struct omap_sr *sr = _sr_lookup(srid);
> +       struct omap_sr *sr = _sr_lookup(volt_domain);
>
>         if (!sr) {
> -               pr_warning("%s: omap_sr struct for SR%d not found\n",
> -                       __func__, srid + 1);
> +               pr_warning("%s: omap_sr struct for sr_%s not found\n",
> +                       __func__, volt_domain->name);
>                 return;
>         }
>
> @@ -640,13 +639,13 @@ void omap_smartreflex_enable(int srid)
>                         "registered\n", __func__);
>                 return;
>         }
> -       sr_class->enable(srid);
> +       sr_class->enable(volt_domain);
>  }
>
>  /**
>   * omap_smartreflex_disable : API to disable SR without resetting the voltage
>   * processor voltage
> - * @srid - The id of the sr module to be disabled.
> + * @volt_domain - VDD to which the SR module to be disabled belongs to.
>   *
>   * This API is to be called from the kernel in order to disable
>   * a particular smartreflex module. This API will in turn call
> @@ -654,13 +653,13 @@ void omap_smartreflex_enable(int srid)
>   * the smartreflex class disable not to reset the VP voltage after
>   * disabling smartreflex.
>   */
> -void omap_smartreflex_disable(int srid)
> +void omap_smartreflex_disable(struct omap_volt_domain *volt_domain)
>  {
> -       struct omap_sr *sr = _sr_lookup(srid);
> +       struct omap_sr *sr = _sr_lookup(volt_domain);
>
>         if (!sr) {
> -               pr_warning("%s: omap_sr struct for SR%d not found\n",
> -                       __func__, srid + 1);
> +               pr_warning("%s: omap_sr struct for sr_%s not found\n",
> +                       __func__, volt_domain->name);
>                 return;
>         }
>
> @@ -673,12 +672,12 @@ void omap_smartreflex_disable(int srid)
>                 return;
>         }
>
> -       sr_class->disable(srid, 0);
> +       sr_class->disable(volt_domain, 0);
>  }
>  /**
>   * omap_smartreflex_disable_reset_volt : API to disable SR and reset the
>   * voltage processor voltage
> - * @srid - The id of the sr module to be disabled.
> + * @volt_domain - VDD to which the SR module to be disabled belongs to.
>   *
>   * This API is to be called from the kernel in order to disable
>   * a particular smartreflex module. This API will in turn call
> @@ -686,13 +685,13 @@ void omap_smartreflex_disable(int srid)
>   * the smartreflex class disable to reset the VP voltage after
>   * disabling smartreflex.
>   */
> -void omap_smartreflex_disable_reset_volt(int srid)
> +void omap_smartreflex_disable_reset_volt(struct omap_volt_domain *volt_domain)
>  {
> -       struct omap_sr *sr = _sr_lookup(srid);
> +       struct omap_sr *sr = _sr_lookup(volt_domain);
>
>         if (!sr) {
> -               pr_warning("%s: omap_sr struct for SR%d not found\n",
> -                       __func__, srid + 1);
> +               pr_warning("%s: omap_sr struct for sr_%s not found\n",
> +                       __func__, volt_domain->name);
>                 return;
>         }
>
> @@ -705,7 +704,7 @@ void omap_smartreflex_disable_reset_volt(int srid)
>                 return;
>         }
>
> -       sr_class->disable(srid, 1);
> +       sr_class->disable(volt_domain, 1);
>  }
>
>  /**
> @@ -768,7 +767,8 @@ static int omap_sr_autocomp_show(void *data, u64 *val)
>         struct omap_sr *sr_info = (struct omap_sr *) data;
>
>         if (!sr_info) {
> -               pr_warning("%s: omap_sr struct for SR not found\n", __func__);
> +               pr_warning("%s: omap_sr struct for sr_%s not found\n",
> +                       __func__, sr_info->volt_domain->name);
>                 return -EINVAL;
>         }
>         *val = sr_info->is_autocomp_active;
> @@ -780,7 +780,8 @@ static int omap_sr_autocomp_store(void *data, u64 val)
>         struct omap_sr *sr_info = (struct omap_sr *) data;
>
>         if (!sr_info) {
> -               pr_warning("%s: omap_sr struct for SR not found\n", __func__);
> +               pr_warning("%s: omap_sr struct for sr_%s not found\n",
> +                               __func__, sr_info->volt_domain->name);
>                 return -EINVAL;
>         }
>         if (!val)
> @@ -821,10 +822,11 @@ static int __init omap_smartreflex_probe(struct platform_device *pdev)
>  {
>         struct omap_sr *sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
>         struct omap_device *odev = to_omap_device(pdev);
> +       struct omap_sr_data *pdata = pdev->dev.platform_data;
kinda curious about this.
a) platform_get_drvdata is a better way to use this?
b) no check if pdata was NULL or not..
>         struct resource *mem, *irq;
>         int ret = 0;
>  #ifdef CONFIG_PM_DEBUG
> -       char name[4];
> +       char name[SMARTREFLEX_NAME_LEN + 1];
>         struct dentry *dbg_dir;
>  #endif
>
> @@ -844,6 +846,7 @@ static int __init omap_smartreflex_probe(struct platform_device *pdev)
>
>         sr_info->pdev = pdev;
>         sr_info->srid = pdev->id;
> +       sr_info->volt_domain = pdata->volt_domain;
>         sr_info->is_autocomp_active = 0;
>         sr_info->clk_length = 0;
>         sr_info->sr_ip_type = odev->hwmods[0]->class->rev;
> @@ -873,7 +876,8 @@ static int __init omap_smartreflex_probe(struct platform_device *pdev)
>
>  #ifdef CONFIG_PM_DEBUG
>         /* Create the debug fs enteries */
> -       sprintf(name, "SR%d", sr_info->srid + 1);
> +       strcpy(name, "sr_");
> +       strcat(name, sr_info->volt_domain->name);

see comment on core etc.. some sort of check to ensure
voltage_domain->name is not going crazy.. eg. we have core, tomorrow, we
will have ducati there. strlen, compare, then use is better.

>         dbg_dir = debugfs_create_dir(name, sr_dbg_dir);
>         (void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,
>                                 (void *)sr_info, &pm_sr_fops);

will take up the discussion on usage of autocomp hidden in debugfs on a
product later on (debugfs is disabled on final products usually and SR
comes up disabled by default - leaving no way for control of
enable/disable of it OTA - see N900 as an example where SR enablement is
an optional feature users can choose to do).

> @@ -899,7 +903,8 @@ err_free_devinfo:
>
>  static int __devexit omap_smartreflex_remove(struct platform_device *pdev)
>  {
> -       struct omap_sr *sr_info = _sr_lookup(pdev->id + 1);
> +       struct omap_sr_data *pdata = pdev->dev.platform_data;
> +       struct omap_sr *sr_info = _sr_lookup(pdata->volt_domain);
>         struct resource *mem;
>
>         if (!sr_info) {
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
> index dbf7603..89619a2 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -26,8 +26,7 @@
>  #include <plat/omap_device.h>
>  #include <plat/opp.h>
>  #include <plat/smartreflex.h>
> -
> -#include "voltage.h"
> +#include <plat/voltage.h>
>
>  struct omap_device_pm_latency omap_sr_latency[] = {
>         {
> @@ -148,8 +147,15 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
>         sr_data->device_enable = omap_device_enable;
>         sr_data->device_shutdown = omap_device_shutdown;
>         sr_data->device_idle = omap_device_idle;
> -       sr_dev_data->volts_supported = omap_get_voltage_table(i,
> -                               &sr_dev_data->volt_data);
> +       sr_data->volt_domain = omap_volt_domain_get(sr_dev_data->vdd_name);
> +       if (IS_ERR(sr_data->volt_domain)) {
> +               pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
> +                       __func__, sr_dev_data->vdd_name);
> +               return 0;
> +       }
> +
> +       sr_dev_data->volts_supported = omap_get_voltage_table(
> +                               sr_data->volt_domain, &sr_dev_data->volt_data);
>         if (!sr_dev_data->volts_supported) {
>                 pr_warning("%s: No Voltage table registerd fo VDD%d.Something \
>                                 really wrong\n\n", __func__, i + 1);
ARRGH.. unrelated to this patch, but I just saw a multistring
pr_warning!!! with a double \n!


[.. more in 2/2]
--
Regards,
Nishanth Menon

