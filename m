From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH 8/10] OPP layer and additional cleanups
Date: Thu, 7 Jan 2010 14:03:14 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870300519663@dbde02.ent.ti.com>
References: <1262266172.20175.184.camel@boson>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43421 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932562Ab0AGIdS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 03:33:18 -0500
In-Reply-To: <1262266172.20175.184.camel@boson>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Romit,
With VDD1 OPP resource being removed, how are you maitaning link between MPU and DSP frequencies? I could not find such a link in the below code. May be I am missing something??

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Dasgupta, Romit
> Sent: Thursday, December 31, 2009 7:00 PM
> To: paul@pwsan.com; Menon, Nishanth; khilman@deeprootsystems.com
> Cc: linux-omap@vger.kernel.org
> Subject: [PATCH 8/10] OPP layer and additional cleanups
>
> 1. Removed the OPP resources and instead introduced voltage resources.
>    This leads to a leaner implementation of DVFS. It still has scope for
>    cleanup and this will be done soon.
>
> 2. Introduced a L3 frequency resource a.k.a. l3_freq.
>
> 3. L3 frequency changes are now handled through CPUFREQ notifiers.
>
> 4. The frequency resources use the new OPP layer APIs.
>
> 5. Removed hardcoded call to vcbypass function of the smartreflex driver.
>    Now we invoke the generic voltage scaling function.
>
> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-
> omap2/resource34xx.c
> index 157b38e..59b8faa 100644
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -37,6 +37,8 @@
>  #warning MPU latency constraints require CONFIG_CPU_IDLE to function!
>  #endif
>
> +static struct device vdd1_volt_dev, vdd2_volt_dev;
> +
>  /**
>   * init_latency - Initializes the mpu/core latency resource.
>   * @resp: Latency resource to be initalized
> @@ -146,115 +148,6 @@ int set_pd_latency(struct shared_resource *resp, u32
> latency)
>       return 0;
>  }
>
> -static struct shared_resource *vdd1_resp;
> -static struct shared_resource *vdd2_resp;
> -static struct device dummy_mpu_dev;
> -static struct device dummy_dsp_dev;
> -static struct device vdd2_dev;
> -static int vdd1_lock;
> -static int vdd2_lock;
> -static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
> -static int curr_vdd1_opp;
> -static int curr_vdd2_opp;
> -static DEFINE_MUTEX(dvfs_mutex);
> -
> -/**
> - * opp_to_freq - convert OPPID to frequency (DEPRECATED)
> - * @freq: return frequency back to caller
> - * @opps: opp list
> - * @opp_id: OPP ID we are searching for
> - *
> - * return 0 and freq is populated if we find the opp_id, else,
> - * we return error
> - *
> - * NOTE: this function is a standin for the timebeing as opp_id is deprecated
> - */
> -static int __deprecated opp_to_freq(unsigned long *freq,
> -             const struct omap_opp *opps, u8 opp_id)
> -{
> -     struct omap_opp *opp;
> -
> -     BUG_ON(!freq || !opps);
> -
> -     opp = opp_find_by_opp_id(opps, opp_id);
> -     if (!opp)
> -             return -EINVAL;
> -
> -     *freq = opp_get_freq(opp);
> -
> -     return 0;
> -}
> -
> -/**
> - * freq_to_opp - convert a frequency back to OPP ID (DEPRECATED)
> - * @opp_id: opp ID returned back to caller
> - * @opps: opp list
> - * @freq: frequency we are searching for
> - *
> - * return 0 and opp_id is populated if we find the freq, else, we return error
> - *
> - * NOTE: this function is a standin for the timebeing as opp_id is deprecated
> - */
> -static int __deprecated freq_to_opp(u8 *opp_id, struct omap_opp *opps,
> -             unsigned long freq)
> -{
> -     struct omap_opp *opp;
> -
> -     BUG_ON(!opp_id || !opps);
> -     opp = opp_find_freq_ceil(opps, &freq);
> -     if (IS_ERR(opp))
> -             return -EINVAL;
> -     *opp_id = opp_get_opp_id(opp);
> -     return 0;
> -}
> -
> -/**
> - * init_opp - Initialize the OPP resource
> - */
> -void init_opp(struct shared_resource *resp)
> -{
> -     struct clk *l3_clk;
> -     int ret;
> -     u8 opp_id;
> -     resp->no_of_users = 0;
> -
> -     if (!mpu_opps || !dsp_opps || !l3_opps)
> -             return;
> -
> -     /* Initialize the current level of the OPP resource
> -     * to the  opp set by u-boot.
> -     */
> -     if (strcmp(resp->name, "vdd1_opp") == 0) {
> -             vdd1_resp = resp;
> -             dpll1_clk = clk_get(NULL, "dpll1_ck");
> -             dpll2_clk = clk_get(NULL, "dpll2_ck");
> -             ret = freq_to_opp(&opp_id, mpu_opps, dpll1_clk->rate);
> -             BUG_ON(ret); /* TBD Cleanup handling */
> -             curr_vdd1_opp = opp_id;
> -     } else if (strcmp(resp->name, "vdd2_opp") == 0) {
> -             vdd2_resp = resp;
> -             dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
> -             l3_clk = clk_get(NULL, "l3_ick");
> -             ret = freq_to_opp(&opp_id, l3_opps, l3_clk->rate);
> -             BUG_ON(ret); /* TBD Cleanup handling */
> -             curr_vdd2_opp = opp_id;
> -     }
> -     resp->curr_level = opp_id;
> -     return;
> -}
> -
> -int resource_access_opp_lock(int res, int delta)
> -{
> -     if (res == VDD1_OPP) {
> -             vdd1_lock += delta;
> -             return vdd1_lock;
> -     } else if (res == VDD2_OPP) {
> -             vdd2_lock += delta;
> -             return vdd2_lock;
> -     }
> -     return -EINVAL;
> -}
> -
>  #ifndef CONFIG_CPU_FREQ
>  static unsigned long compute_lpj(unsigned long ref, u_int div, u_int mult)
>  {
> @@ -277,235 +170,60 @@ static unsigned long compute_lpj(unsigned long ref, u_int
> div, u_int mult)
>  }
>  #endif
>
> -static int program_opp_freq(int res, int target_level, int current_level)
> -{
> -     int ret = 0, l3_div;
> -     int *curr_opp;
> -     unsigned long mpu_freq, dsp_freq, l3_freq;
> -#ifndef CONFIG_CPU_FREQ
> -     unsigned long mpu_cur_freq;
> -#endif
> -
> -     /* Check if I can actually switch or not */
> -     if (res == VDD1_OPP) {
> -             ret = opp_to_freq(&mpu_freq, mpu_opps, target_level);
> -             ret |= opp_to_freq(&dsp_freq, dsp_opps, target_level);
> -#ifndef CONFIG_CPU_FREQ
> -             ret |= opp_to_freq(&mpu_cur_freq, mpu_opps, current_level);
> -#endif
> -     } else {
> -             ret = opp_to_freq(&l3_freq, l3_opps, target_level);
> -     }
> -     /* we would have caught all bad levels earlier.. */
> -     if (unlikely(ret))
> -             return ret;
> +struct _vdd_priv {
> +     struct omap_opp *curr;
> +     struct omap_opp *target;
> +};
>
> -     lock_scratchpad_sem();
> -     if (res == VDD1_OPP) {
> -             curr_opp = &curr_vdd1_opp;
> -             clk_set_rate(dpll1_clk, mpu_freq);
> -             clk_set_rate(dpll2_clk, dsp_freq);
> -#ifndef CONFIG_CPU_FREQ
> -             /*Update loops_per_jiffy if processor speed is being changed*/
> -             loops_per_jiffy = compute_lpj(loops_per_jiffy,
> -                     mpu_cur_freq / 1000, mpu_freq / 1000);
> -#endif
> -     } else {
> -             curr_opp = &curr_vdd2_opp;
> +void init_volt(struct shared_resource *resp)
> +{
> +     struct omap_opp *opp = NULL;
> +
> +     if (!strcmp(resp->name, "vdd1_volt")) {
> +             opp = find_opp_by_freq(OPP_MPU,
> +                                     clk_get(NULL, "dpll1_ck")->rate,
> +                                     OPP_ENABLED | OPP_EQ);
> +     } else if (!strcmp(resp->name, "vdd2_volt")) {
> +             int l3_div = 0;
>               l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
> -                     OMAP3430_CLKSEL_L3_MASK;
> -             ret = clk_set_rate(dpll3_clk, l3_freq * l3_div);
> -     }
> -     if (ret) {
> -             unlock_scratchpad_sem();
> -             return current_level;
> +                             OMAP3430_CLKSEL_L3_MASK;
> +             opp = find_opp_by_freq(OPP_L3, clk_get(NULL,
> +                                             "dpll3_m2_ck")->rate / l3_div,
> +                                     OPP_ENABLED | OPP_EQ);
>       }
> -#ifdef CONFIG_PM
> -     omap3_save_scratchpad_contents();
> -#endif
> -     unlock_scratchpad_sem();
> -
> -     *curr_opp = target_level;
> -     return target_level;
> +     BUG_ON(!opp);
> +     resp->curr_level = opp_to_volt(opp); /* in uV */
> +     return;
>  }
>
> -static int program_opp(int res, struct omap_opp *opp, int target_level,
> -             int current_level)
> +int set_volt(struct shared_resource *resp, u32 target_volt)
>  {
> -     int i, ret = 0, raise;
> -     unsigned long freq;
> -#ifdef CONFIG_OMAP_SMARTREFLEX
> -     unsigned long t_opp, c_opp;
> -
> -     t_opp = ID_VDD(res) | ID_OPP_NO(target_level);
> -     c_opp = ID_VDD(res) | ID_OPP_NO(current_level);
> -#endif
> -
> -     /* See if have a freq associated, if not, invalid opp */
> -     ret = opp_to_freq(&freq, opp, target_level);
> -     if (unlikely(ret))
> -             return ret;
> -
> -     if (target_level > current_level)
> -             raise = 1;
> -     else
> -             raise = 0;
> -
> -     for (i = 0; i < 2; i++) {
> -             if (i == raise)
> -                     ret = program_opp_freq(res, target_level,
> -                                     current_level);
> -#ifdef CONFIG_OMAP_SMARTREFLEX
> -             else {
> -                     u8 vc, vt;
> -                     struct omap_opp *oppx;
> -                     unsigned long uvdc;
> -
> -                     /*
> -                      * transitioning from good to good OPP
> -                      * none of the following should fail..
> -                      */
> -                     oppx = opp_find_freq_exact(opp, freq, true);
> -                     BUG_ON(IS_ERR(oppx));
> -                     uvdc = opp_get_voltage(oppx);
> -                     vt = omap_twl_uv_to_vsel(uvdc);
> -
> -                     BUG_ON(opp_to_freq(&freq, opp, current_level));
> -                     oppx = opp_find_freq_exact(opp, freq, true);
> -                     BUG_ON(IS_ERR(oppx));
> -                     uvdc = opp_get_voltage(oppx);
> -                     vc = omap_twl_uv_to_vsel(uvdc);
> -
> -                     /* ok to scale.. */
> -                     sr_voltagescale_vcbypass(t_opp, c_opp, vt, vc);
> -             }
> -#endif
> +     int ret = 0;
> +     struct omap_opp *current_opp, *target_opp;
> +
> +     if (!strcmp(resp->name, "vdd1_volt") && voltage_scale) {
> +             current_opp =
> +                     ((struct _vdd_priv *)(vdd1_volt.resource_data))->curr;
> +             target_opp =
> +                     ((struct _vdd_priv *)
> +                             (vdd1_volt.resource_data))->target;
> +             ret = voltage_scale(RAIL_VDD1, current_opp, target_opp);
> +     } else if (!strcmp(resp->name, "vdd2_volt") && voltage_scale) {
> +             current_opp =
> +                     ((struct _vdd_priv *)(vdd2_volt.resource_data))->curr;
> +             target_opp =
> +                     ((struct _vdd_priv *)
> +                             (vdd2_volt.resource_data))->target;
> +             ret = voltage_scale(RAIL_VDD2, current_opp, target_opp);
>       }
> -
>       return ret;
>  }
>
> -int resource_set_opp_level(int res, u32 target_level, int flags)
> -{
> -     unsigned long mpu_freq, mpu_old_freq, l3_freq;
> -     int ret;
> -#ifdef CONFIG_CPU_FREQ
> -     struct cpufreq_freqs freqs_notify;
> -#endif
> -     struct shared_resource *resp;
> -
> -     if (res == VDD1_OPP)
> -             resp = vdd1_resp;
> -     else if (res == VDD2_OPP)
> -             resp = vdd2_resp;
> -     else
> -             return 0;
> -
> -     if (resp->curr_level == target_level)
> -             return 0;
> -
> -     if (!mpu_opps || !dsp_opps || !l3_opps)
> -             return 0;
> -
> -     /* Check if I can actually switch or not */
> -     if (res == VDD1_OPP) {
> -             ret = opp_to_freq(&mpu_freq, mpu_opps, target_level);
> -             ret |= opp_to_freq(&mpu_old_freq, mpu_opps, resp->curr_level);
> -     } else {
> -             ret = opp_to_freq(&l3_freq, l3_opps, target_level);
> -     }
> -     if (ret)
> -             return ret;
> -
> -     mutex_lock(&dvfs_mutex);
> -
> -     if (res == VDD1_OPP) {
> -             if (flags != OPP_IGNORE_LOCK && vdd1_lock) {
> -                     mutex_unlock(&dvfs_mutex);
> -                     return 0;
> -             }
> -#ifdef CONFIG_CPU_FREQ
> -             freqs_notify.old = mpu_old_freq/1000;
> -             freqs_notify.new = mpu_freq/1000;
> -             freqs_notify.cpu = 0;
> -             /* Send pre notification to CPUFreq */
> -             cpufreq_notify_transition(&freqs_notify, CPUFREQ_PRECHANGE);
> -#endif
> -             resp->curr_level = program_opp(res, mpu_opps, target_level,
> -                     resp->curr_level);
> -#ifdef CONFIG_CPU_FREQ
> -             /* Send a post notification to CPUFreq */
> -             cpufreq_notify_transition(&freqs_notify, CPUFREQ_POSTCHANGE);
> -#endif
> -     } else {
> -             if (!(flags & OPP_IGNORE_LOCK) && vdd2_lock) {
> -                     mutex_unlock(&dvfs_mutex);
> -                     return 0;
> -             }
> -             resp->curr_level = program_opp(res, l3_opps, target_level,
> -                     resp->curr_level);
> -     }
> -     mutex_unlock(&dvfs_mutex);
> -     return 0;
> -}
> -
> -int set_opp(struct shared_resource *resp, u32 target_level)
> -{
> -     int ret = -EINVAL;
> -
> -     if (resp == vdd1_resp) {
> -             if (target_level < 3)
> -                     resource_release("vdd2_opp", &vdd2_dev);
> -
> -             ret = resource_set_opp_level(VDD1_OPP, target_level, 0);
> -             /*
> -              * For VDD1 OPP3 and above, make sure the interconnect
> -              * is at 100Mhz or above.
> -              * throughput in KiB/s for 100 Mhz = 100 * 1000 * 4.
> -              */
> -             if (target_level >= 3)
> -                     resource_request("vdd2_opp", &vdd2_dev, 400000);
> -
> -     } else if (resp == vdd2_resp) {
> -             unsigned long req_l3_freq;
> -             struct omap_opp *oppx = NULL;
> -
> -             /* Convert the tput in KiB/s to Bus frequency in MHz */
> -             req_l3_freq = (target_level * 1000)/4;
> -
> -             /* Do I have a best match? */
> -             oppx = opp_find_freq_ceil(l3_opps, &req_l3_freq);
> -             if (IS_ERR(oppx)) {
> -                     /* Give me the best we got */
> -                     req_l3_freq = ULONG_MAX;
> -                     oppx = opp_find_freq_floor(l3_opps, &req_l3_freq);
> -             }
> -
> -             /* uh uh.. no OPPs?? */
> -             BUG_ON(IS_ERR(oppx));
> -
> -             ret = freq_to_opp((u8 *)&target_level, l3_opps, req_l3_freq);
> -             /* we dont expect this to fail */
> -             BUG_ON(ret);
> -
> -             ret = resource_set_opp_level(VDD2_OPP, target_level, 0);
> -     }
> -     return 0;
> -}
> -
> -/**
> - * validate_opp - Validates if valid VDD1 OPP's are passed as the
> - * target_level.
> - * VDD2 OPP levels are passed as L3 throughput, which are then mapped
> - * to an appropriate OPP.
> +/*
> + * XXX: TODO
>   */
> -int validate_opp(struct shared_resource *resp, u32 target_level)
> +int validate_volt(struct shared_resource *resp, u32 target_volt)
>  {
> -     unsigned long x;
> -     if (strcmp(resp->name, "mpu_freq") == 0)
> -             return opp_to_freq(&x, mpu_opps, target_level);
> -     else if (strcmp(resp->name, "dsp_freq") == 0)
> -             return opp_to_freq(&x, dsp_opps, target_level);
>       return 0;
>  }
>
> @@ -514,60 +232,154 @@ int validate_opp(struct shared_resource *resp, u32
> target_level)
>   */
>  void init_freq(struct shared_resource *resp)
>  {
> -     char *linked_res_name;
> -     int ret = -EINVAL;
> -     unsigned long freq;
> +     struct omap_opp *opp = NULL;
>       resp->no_of_users = 0;
>
> -     if (!mpu_opps || !dsp_opps)
> -             return;
> -
> -     linked_res_name = (char *)resp->resource_data;
>       /* Initialize the current level of the Freq resource
> -     * to the frequency set by u-boot.
> -     */
> -     if (strcmp(resp->name, "mpu_freq") == 0)
> -             /* MPU freq in Mhz */
> -             ret = opp_to_freq(&freq, mpu_opps, curr_vdd1_opp);
> -     else if (strcmp(resp->name, "dsp_freq") == 0)
> -             /* DSP freq in Mhz */
> -             ret = opp_to_freq(&freq, dsp_opps, curr_vdd1_opp);
> -     BUG_ON(ret);
> -
> -     resp->curr_level = freq;
> +      * to the clk_rate set by bootloader.
> +      */
> +     if (!strcmp(resp->name, "mpu_freq"))
> +             opp = find_opp_by_freq(OPP_MPU,
> +                                     clk_get(NULL, "dpll1_ck")->rate,
> +                                     OPP_ENABLED | OPP_EQ);
> +     else if (!strcmp(resp->name, "dsp_freq"))
> +             opp = find_opp_by_freq(OPP_DSP,
> +                                     clk_get(NULL, "dpll2_ck")->rate,
> +                                     OPP_ENABLED | OPP_EQ);
> +     else if (!strcmp(resp->name, "l3_freq")) {
> +             int l3_div = 0;
> +             l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
> +                             OMAP3430_CLKSEL_L3_MASK;
> +             opp = find_opp_by_freq(OPP_L3, clk_get(NULL,
> +                                             "dpll3_m2_ck")->rate / l3_div,
> +                                     OPP_ENABLED | OPP_EQ);
> +     }
> +
> +     BUG_ON(!opp);
> +
> +     resp->curr_level = opp_to_freq(opp);
>       return;
>  }
>
> -int set_freq(struct shared_resource *resp, u32 target_level)
> +static char vres[][255] = {"vdd1_volt", "vdd2_volt"};
> +
> +int set_freq(struct shared_resource *resp, u32 target_freq)
>  {
> -     u8 vdd1_opp;
> -     int ret = -EINVAL;
> +     struct omap_opp *current_opp = NULL, *target_opp = NULL;
> +     int ret = 0, l3_div = 0, scale_up = 0;
> +     struct device *dev = NULL;
> +     struct clk *clk = NULL;
> +     struct _vdd_priv vdd_priv;
> +     char *volt_res = NULL;
> +#ifdef CONFIG_CPU_FREQ
> +     struct cpufreq_freqs    freqs_notify;
> +#endif
>
> -     if (!mpu_opps || !dsp_opps)
> -             return 0;
> +     if (!strcmp(resp->name, "mpu_freq")) {
> +             dev = &vdd1_volt_dev;
> +             volt_res = vres[0];
> +             clk = clk_get(NULL, "dpll1_ck");
> +             current_opp = find_opp_by_freq(OPP_MPU, clk->rate,
> +                                             OPP_EQ | OPP_ENABLED);
> +             target_opp = find_opp_by_freq(OPP_MPU, target_freq,
> +                                             OPP_EQ | OPP_ENABLED);
> +             BUG_ON(!current_opp || !target_opp);
> +             vdd_priv.curr = current_opp;
> +             vdd_priv.target = target_opp;
> +             vdd1_volt.resource_data = &vdd_priv;
> +#ifdef CONFIG_CPU_FREQ
> +             freqs_notify.old = opp_to_freq(current_opp) / 1000;
> +             freqs_notify.new = opp_to_freq(target_opp) / 1000;
> +             freqs_notify.cpu = smp_processor_id();
> +             cpufreq_notify_transition(&freqs_notify, CPUFREQ_PRECHANGE);
> +#endif
> +     } else if (!strcmp(resp->name, "dsp_freq")) {
> +             dev = &vdd1_volt_dev;
> +             volt_res = vres[0];
> +             clk = clk_get(NULL, "dpll2_ck");
> +             current_opp = find_opp_by_freq(OPP_DSP, clk->rate,
> +                                             OPP_EQ | OPP_ENABLED);
> +             target_opp = find_opp_by_freq(OPP_DSP, target_freq,
> +                                             OPP_EQ | OPP_ENABLED);
> +             BUG_ON(!current_opp || !target_opp);
> +             vdd_priv.curr = current_opp;
> +             vdd_priv.target = target_opp;
> +             vdd1_volt.resource_data = &vdd_priv;
> +
> +     } else if (!strcmp(resp->name, "l3_freq")) {
> +             dev = &vdd2_volt_dev;
> +             volt_res = vres[1];
> +             clk = clk_get(NULL, "dpll3_m2_ck");
> +             l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
> +                             OMAP3430_CLKSEL_L3_MASK;
> +             current_opp = find_opp_by_freq(OPP_L3, clk->rate / l3_div,
> +                                             OPP_EQ | OPP_ENABLED);
> +             target_opp = find_opp_by_freq(OPP_L3, target_freq,
> +                                             OPP_EQ | OPP_ENABLED);
> +
> +             target_freq *= l3_div;
> +             vdd_priv.curr = current_opp;
> +             vdd_priv.target = target_opp;
> +             vdd2_volt.resource_data = &vdd_priv;
> +     }
> +
> +     if (opp_to_freq(current_opp) == opp_to_freq(target_opp))
> +             return 0; /* This should not happen. Check with resource fmwk */
> +     else if (opp_to_freq(current_opp) < opp_to_freq(target_opp))
> +             scale_up = 1;
>
> -     if (strcmp(resp->name, "mpu_freq") == 0) {
> -             ret = freq_to_opp(&vdd1_opp, mpu_opps, target_level);
> +     lock_scratchpad_sem();
> +     if (scale_up) {
> +             ret = resource_request(volt_res, dev,
> +                              opp_to_volt(target_opp));
>               if (!ret)
> -                     ret = resource_request("vdd1_opp", &dummy_mpu_dev,
> -                                     vdd1_opp);
> -     } else if (strcmp(resp->name, "dsp_freq") == 0) {
> -             ret = freq_to_opp(&vdd1_opp, dsp_opps, target_level);
> +                     ret = clk_set_rate(clk, target_freq);
> +     } else {
> +             ret = clk_set_rate(clk, target_freq);
>               if (!ret)
> -                     ret = resource_request("vdd1_opp", &dummy_dsp_dev,
> -                                     vdd1_opp);
> +                     ret = resource_request(volt_res, dev,
> +                                     opp_to_volt(target_opp));
>       }
> +     unlock_scratchpad_sem();
> +
> +     /*
> +      * L3 clock adjustment.
> +      */
> +     if (!strcmp(resp->name, "l3_freq"))
> +             target_freq /= l3_div;
> +
> +     if (!strcmp(resp->name, "mpu_freq") && !ret)
> +#ifdef CONFIG_CPU_FREQ
> +             cpufreq_notify_transition(&freqs_notify, CPUFREQ_POSTCHANGE);
> +#else
> +             /* Update loops per jiffy */
> +             loops_per_jiffy = compute_lpj(loops_per_jiffy,
> +                                     opp_to_freq(current_opp) / 1000,
> +                                     opp_to_freq(target_opp) / 1000);
> +#endif
>       if (!ret)
> -             resp->curr_level = target_level;
> +             resp->curr_level = target_freq;
> +
>       return ret;
>  }
>
> -int validate_freq(struct shared_resource *resp, u32 target_level)
> +int validate_freq(struct shared_resource *resp, u32 target_freq)
>  {
> -     u8 x;
> -     if (strcmp(resp->name, "mpu_freq") == 0)
> -             return freq_to_opp(&x, mpu_opps, target_level);
> -     else if (strcmp(resp->name, "dsp_freq") == 0)
> -             return freq_to_opp(&x, dsp_opps, target_level);
> -     return 0;
> +     struct omap_opp *opp;
> +
> +     if (!strcmp(resp->name, "mpu_freq")) {
> +             opp = find_opp_by_freq(OPP_MPU, target_freq,
> +                                     OPP_EQ | OPP_ENABLED);
> +             return !opp_is_valid(opp);
> +     } else if (!strcmp(resp->name, "dsp_freq")) {
> +             opp = find_opp_by_freq(OPP_DSP, target_freq,
> +                                     OPP_EQ | OPP_ENABLED);
> +             return !opp_is_valid(opp);
> +     } else if (!strcmp(resp->name, "l3_freq")) {
> +             opp = find_opp_by_freq(OPP_L3, target_freq,
> +                                     OPP_EQ | OPP_ENABLED);
> +             return !opp_is_valid(opp);
> +     }
> +
> +     return 1;
>  }
> diff --git a/arch/arm/mach-omap2/resource34xx.h b/arch/arm/mach-
> omap2/resource34xx.h
> index 0b4e76e..7dd7032 100644
> --- a/arch/arm/mach-omap2/resource34xx.h
> +++ b/arch/arm/mach-omap2/resource34xx.h
> @@ -30,7 +30,6 @@
>  #include <plat/opp.h>
>  #include <plat/omap34xx.h>
>
> -extern int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
>  extern void lock_scratchpad_sem(void);
>  extern void unlock_scratchpad_sem(void);
>
> @@ -244,29 +243,33 @@ static struct shared_resource emu_pwrdm_latency = {
>       .ops            = &pd_lat_res_ops,
>  };
>
> -void init_opp(struct shared_resource *resp);
> -int set_opp(struct shared_resource *resp, u32 target_level);
> -int validate_opp(struct shared_resource *resp, u32 target_level);
> -void init_freq(struct shared_resource *resp);
> -int set_freq(struct shared_resource *resp, u32 target_level);
> -int validate_freq(struct shared_resource *resp, u32 target_level);
> +extern void init_volt(struct shared_resource *);
> +extern int set_volt(struct shared_resource *, u32);
> +extern int validate_volt(struct shared_resource *, u32);
>
>  struct bus_throughput_db {
>       /* Throughput for each OPP/Freq of the bus */
>       unsigned long throughput[3];
>  };
>
> -static struct shared_resource_ops opp_res_ops = {
> -     .init           = init_opp,
> -     .change_level   = set_opp,
> -     .validate_level = validate_opp,
> +static struct shared_resource_ops volt_res_ops = {
> +     .init           = init_volt,
> +     .change_level   = set_volt,
> +     .validate_level = validate_volt,
>  };
>
> -static struct shared_resource vdd1_opp = {
> -     .name           = "vdd1_opp",
> -     .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> -     .flags          = RES_TYPE_PERFORMANCE,
> -     .ops            = &opp_res_ops,
> +static struct shared_resource vdd1_volt = {
> +     .name = "vdd1_volt",
> +     .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +     .flags = RES_TYPE_PERFORMANCE,
> +     .ops = &volt_res_ops,
> +};
> +
> +static struct shared_resource vdd2_volt = {
> +     .name = "vdd2_volt",
> +     .omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +     .flags = RES_TYPE_PERFORMANCE,
> +     .ops = &volt_res_ops,
>  };
>
>  /* Throughput in KiB/s */
> @@ -276,15 +279,11 @@ static struct bus_throughput_db l3_throughput_db = {
>       .throughput[2] = 5312000,
>  };
>
> -static struct shared_resource vdd2_opp = {
> -     .name           = "vdd2_opp",
> -     .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> -     .flags          = RES_TYPE_PERFORMANCE,
> -     .resource_data  = &l3_throughput_db,
> -     .ops            = &opp_res_ops,
> -};
> +static char linked_res[] = "vdd1_volt";
>
> -static char linked_res[] = "vdd1_opp";
> +extern void init_freq(struct shared_resource *);
> +extern int set_freq(struct shared_resource *, u32);
> +extern int validate_freq(struct shared_resource *, u32);
>
>  static struct shared_resource_ops freq_res_ops = {
>       .init           = init_freq,
> @@ -308,6 +307,13 @@ static struct shared_resource dsp_freq = {
>       .ops            = &freq_res_ops,
>  };
>
> +static struct shared_resource l3_freq = {
> +     .name           = "l3_freq",
> +     .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +     .flags          = RES_TYPE_PERFORMANCE,
> +     .ops            = &freq_res_ops,
> +};
> +
>  struct shared_resource *resources_omap[] __initdata = {
>       &mpu_latency,
>       &core_latency,
> @@ -322,10 +328,12 @@ struct shared_resource *resources_omap[] __initdata = {
>       &neon_pwrdm_latency,
>       &usbhost_pwrdm_latency,
>       &emu_pwrdm_latency,
> -     /* OPP/frequency resources */
> -     &vdd1_opp,
> -     &vdd2_opp,
> +     /* Voltage rail resources */
> +     &vdd1_volt,
> +     &vdd2_volt,
> +     /* frequency resources */
>       &mpu_freq,
> +     &l3_freq,
>       &dsp_freq,
>       NULL
>  };
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
