From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 06/16] OMAP3: PM: Smartreflex class related changes for
 smartreflex.c
Date: Fri, 5 Mar 2010 20:30:35 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321CBD2B1@dbde02.ent.ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
	<1267003757-22456-2-git-send-email-thara@ti.com>
	<1267003757-22456-3-git-send-email-thara@ti.com>
	<1267003757-22456-4-git-send-email-thara@ti.com>
	<1267003757-22456-5-git-send-email-thara@ti.com>
	<1267003757-22456-6-git-send-email-thara@ti.com>
	<1267003757-22456-7-git-send-email-thara@ti.com>
 <871vg2y365.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60102 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab0CEPAo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 10:00:44 -0500
In-Reply-To: <871vg2y365.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, March 03, 2010 12:14 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Menon, Nishanth; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH 06/16] OMAP3: PM: Smartreflex class related changes for smartreflex.c
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> OMAP3 smartreflex modules are capable of two different classes
>>> of implementaion -
>>>     Class-2: Continuous Software Calibration
>>>     Class-3: Continuous Hardware Calibration.
>>> OMAP3 along with T2/Gaia supports the Class 3 implementaion.
>>> With a different PMIC it can support Class 2 implementaion also.
>>>
>>> The idea behind this patch is that smartreflex.c should be able
>>> to support both the classes of Smartreflex and the class specific
>>> details for smartreflex should stay out of this file in a separate
>>> class file.
>>> This patch introduces smartreflex class specific hooks in
>>> smartreflex.c. This patch only takes care of smartreflex enable
>>> disable hooks which differ between Class 2 and Class 3. There
>>> are some register setting changes between both the classes which
>>> will be taken care of in a later patch.
>>> This will form the base for adding class specific
>>> drivers in later patches.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>Minor nit: the name change for omap_smartreflex_[enable|disable] is
>>unrelated to this change and should be a separate patch to go early in
>>the series.

Hi Kevin,

I agree the name change need not be part of this patch. But is it necessary for it to be separated out. I am asking this because when I send out the review comments fixed patch set I can send them out as V2 . But if I split this change into a separate patch the patch set will contain 17 patches instead of 16 patches and will have to be submitted as a new patch set not as V2. Do let me know your thoughts on this.

Regards
Thara

>>
>>Kevin
>>
>>> ---
>>>  arch/arm/mach-omap2/pm34xx.c      |    8 +-
>>>  arch/arm/mach-omap2/smartreflex.c |  251 ++++++++++++++++++++----------------
>>>  arch/arm/mach-omap2/smartreflex.h |   48 ++++++--
>>>  3 files changed, 182 insertions(+), 125 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>>> index cf9ca23..ece5195 100644
>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>> @@ -430,9 +430,9 @@ void omap_sram_idle(void)
>>>      * Only needed if we are going to enter retention or off.
>>>      */
>>>     if (mpu_next_state <= PWRDM_POWER_RET)
>>> -           disable_smartreflex(SR1);
>>> +           omap_smartreflex_disable(SR1);
>>>     if (core_next_state <= PWRDM_POWER_RET)
>>> -           disable_smartreflex(SR2);
>>> +           omap_smartreflex_disable(SR2);
>>>
>>>     /* CORE */
>>>     if (core_next_state < PWRDM_POWER_ON) {
>>> @@ -531,9 +531,9 @@ void omap_sram_idle(void)
>>>      * retention or off
>>>      */
>>>     if (mpu_next_state <= PWRDM_POWER_RET)
>>> -           enable_smartreflex(SR1);
>>> +           omap_smartreflex_enable(SR1);
>>>     if (core_next_state <= PWRDM_POWER_RET)
>>> -           enable_smartreflex(SR2);
>>> +           omap_smartreflex_enable(SR2);
>>>
>>>     /* PER */
>>>     if (per_next_state < PWRDM_POWER_ON) {
>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>>> index c00925d..ba9f899 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>> @@ -55,6 +55,7 @@ struct omap_sr {
>>>
>>>  /* sr_list contains all the instances of smartreflex module */
>>>  static LIST_HEAD(sr_list);
>>> +static struct omap_smartreflex_class_data *sr_class;
>>>
>>>  #define SR_REGADDR(offs)   (sr->srbase_addr + offset)
>>>
>>> @@ -388,14 +389,86 @@ static int sr_reset_voltage(int srid)
>>>     return 0;
>>>  }
>>>
>>> -static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
>>> +static void sr_start_vddautocomap(int srid)
>>> +{
>>> +   struct omap_sr *sr = _sr_lookup(srid);
>>> +
>>> +   if (!sr) {
>>> +           pr_warning("omap_sr struct corresponding to SR%d not found\n",
>>> +                                                           srid);
>>> +           return;
>>> +   }
>>> +
>>> +   if (!sr_class || !(sr_class->enable)) {
>>> +           pr_warning("smartreflex class driver not registered\n");
>>> +           return;
>>> +   }
>>> +
>>> +   if (sr->is_sr_reset == 1) {
>>> +           sr_clk_enable(sr);
>>> +           sr_configure(sr);
>>> +   }
>>> +
>>> +   sr->is_autocomp_active = 1;
>>> +   if (!sr_class->enable(srid)) {
>>> +           sr->is_autocomp_active = 0;
>>> +           if (sr->is_sr_reset == 1)
>>> +                   sr_clk_disable(sr);
>>> +   }
>>> +}
>>> +
>>> +static void sr_stop_vddautocomap(int srid)
>>> +{
>>> +   struct omap_sr *sr = _sr_lookup(srid);
>>> +
>>> +   if (!sr) {
>>> +           pr_warning("omap_sr struct corresponding to SR%d not found\n",
>>> +                                                           srid);
>>> +           return;
>>> +   }
>>> +   if (!sr_class || !(sr_class->disable)) {
>>> +           pr_warning("smartreflex class driver not registered\n");
>>> +           return;
>>> +   }
>>> +
>>> +   if (sr->is_autocomp_active == 1) {
>>> +           sr_class->disable(srid);
>>> +           sr_clk_disable(sr);
>>> +           sr->is_autocomp_active = 0;
>>> +           /* Reset the volatage for current OPP */
>>> +           sr_reset_voltage(srid);
>>> +   }
>>> +
>>> +}
>>> +
>>> +/* Public Functions */
>>> +
>>> +/**
>>> + * sr_enable : Enables the smartreflex module.
>>> + * @srid - The id of the sr module to be enabled.
>>> + * @target_opp_no - The OPP at which the Voltage domain associated with
>>> + * the smartreflex module is operating at. This is required only to program
>>> + * the correct Ntarget value.
>>> + *
>>> + * This API is to be called from the smartreflex class driver to
>>> + * enable a smartreflex module. Returns true on success.Returns false if the
>>> + * target opp id passed is wrong or if ntarget value is wrong.
>>> + */
>>> +int sr_enable(int srid, u32 target_opp_no)
>>>  {
>>>     u32 nvalue_reciprocal, v;
>>> +   struct omap_sr *sr = _sr_lookup(srid);
>>>     struct omap_opp *opp;
>>>     struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
>>>     int uvdc;
>>>     char vsel;
>>>
>>> +   if (!sr) {
>>> +           pr_warning("omap_sr struct corresponding to SR%d not found\n",
>>> +                                                           srid);
>>> +           return false;
>>> +   }
>>> +
>>>     if (sr->srid == SR1) {
>>>             opp = opp_find_by_opp_id(OPP_MPU, target_opp_no);
>>>             if (!opp)
>>> @@ -477,8 +550,16 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
>>>     return true;
>>>  }
>>>
>>> -static void sr_disable(struct omap_sr *sr)
>>> +/**
>>> + * sr_disable : Disables the smartreflex module.
>>> + * @srid - The id of the sr module to be disabled.
>>> + *
>>> + * This API is to be called from the smartreflex class driver to
>>> + * disable a smartreflex module.
>>> + */
>>> +void sr_disable(int srid)
>>>  {
>>> +   struct omap_sr *sr = _sr_lookup(srid);
>>>     u32 i = 0;
>>>
>>>     sr->is_sr_reset = 1;
>>> @@ -518,9 +599,19 @@ static void sr_disable(struct omap_sr *sr)
>>>     }
>>>  }
>>>
>>> -
>>> -void sr_start_vddautocomap(int srid, u32 target_opp_no)
>>> +/**
>>> + * omap_smartreflex_enable : API to enable SR clocks and to call into the
>>> + * registered smartreflex class enable API.
>>> + * @srid - The id of the sr module to be enabled.
>>> + *
>>> + * This API is to be called from the kernel in order to enable
>>> + * a particular smartreflex module. This API will do the initial
>>> + * configurations to turn on the smartreflex module and in turn call
>>> + * into the registered smartreflex class enable API.
>>> + */
>>> +void omap_smartreflex_enable(int srid)
>>>  {
>>> +   u32 target_opp_no = 0;
>>>     struct omap_sr *sr = _sr_lookup(srid);
>>>
>>>     if (!sr) {
>>> @@ -528,52 +619,8 @@ void sr_start_vddautocomap(int srid, u32 target_opp_no)
>>>                                                             srid);
>>>             return;
>>>     }
>>> -
>>> -   if (sr->is_sr_reset == 1) {
>>> -           sr_clk_enable(sr);
>>> -           sr_configure(sr);
>>> -   }
>>> -
>>> -   sr->is_autocomp_active = 1;
>>> -   if (!sr_enable(sr, target_opp_no)) {
>>> -           sr->is_autocomp_active = 0;
>>> -           if (sr->is_sr_reset == 1)
>>> -                   sr_clk_disable(sr);
>>> -   }
>>> -}
>>> -EXPORT_SYMBOL(sr_start_vddautocomap);
>>> -
>>> -int sr_stop_vddautocomap(int srid)
>>> -{
>>> -   struct omap_sr *sr = _sr_lookup(srid);
>>> -
>>> -   if (!sr) {
>>> -           pr_warning("omap_sr struct corresponding to SR%d not found\n",
>>> -                                                           srid);
>>> -           return false;
>>> -   }
>>> -
>>> -   if (sr->is_autocomp_active == 1) {
>>> -           sr_disable(sr);
>>> -           sr_clk_disable(sr);
>>> -           sr->is_autocomp_active = 0;
>>> -           /* Reset the volatage for current OPP */
>>> -           sr_reset_voltage(srid);
>>> -           return true;
>>> -   } else
>>> -           return false;
>>> -
>>> -}
>>> -EXPORT_SYMBOL(sr_stop_vddautocomap);
>>> -
>>> -void enable_smartreflex(int srid)
>>> -{
>>> -   u32 target_opp_no = 0;
>>> -   struct omap_sr *sr = _sr_lookup(srid);
>>> -
>>> -   if (!sr) {
>>> -           pr_warning("omap_sr struct corresponding to SR%d not found\n",
>>> -                                                           srid);
>>> +   if (!sr_class || !(sr_class->enable)) {
>>> +           pr_warning("smartreflex class driver not registered\n");
>>>             return;
>>>     }
>>>
>>> @@ -581,26 +628,24 @@ void enable_smartreflex(int srid)
>>>             if (sr->is_sr_reset == 1) {
>>>                     /* Enable SR clks */
>>>                     sr_clk_enable(sr);
>>> -
>>> -                   if (srid == SR1)
>>> -                           target_opp_no = get_vdd1_opp();
>>> -                   else if (srid == SR2)
>>> -                           target_opp_no = get_vdd2_opp();
>>> -
>>> -                   if (!target_opp_no) {
>>> -                           pr_info("Current OPP unknown \
>>> -                                            Cannot configure SR\n");
>>> -                   }
>>> -
>>>                     sr_configure(sr);
>>>
>>> -                   if (!sr_enable(sr, target_opp_no))
>>> +                   if (!sr_class->enable(srid))
>>>                             sr_clk_disable(sr);
>>>             }
>>>     }
>>>  }
>>>
>>> -void disable_smartreflex(int srid)
>>> +/**
>>> + * omap_smartreflex_disable : API to disable SR clocks and to call into the
>>> + * registered smartreflex class disable API.
>>> + * @srid - The id of the sr module to be disabled.
>>> + *
>>> + * This API is to be called from the kernel in order to disable
>>> + * a particular smartreflex module. This API will in turn call
>>> + * into the registered smartreflex class disable API.
>>> + */
>>> +void omap_smartreflex_disable(int srid)
>>>  {
>>>     u32 i = 0;
>>>     struct omap_sr *sr = _sr_lookup(srid);
>>> @@ -610,54 +655,43 @@ void disable_smartreflex(int srid)
>>>                                                             srid);
>>>             return;
>>>     }
>>> +   if (!sr_class || !(sr_class->disable)) {
>>> +           pr_warning("smartreflex class driver not registered\n");
>>> +           return;
>>> +   }
>>>
>>>     if (sr->is_autocomp_active == 1) {
>>>             if (sr->is_sr_reset == 0) {
>>> -
>>> -                   sr->is_sr_reset = 1;
>>> -                   /* SRCONFIG - disable SR */
>>> -                   sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE,
>>> -                                                   ~SRCONFIG_SRENABLE);
>>> -
>>> +                   sr_class->disable(srid);
>>>                     /* Disable SR clk */
>>>                     sr_clk_disable(sr);
>>> -                   if (sr->srid == SR1) {
>>> -                           /* Wait for VP idle before disabling VP */
>>> -                           while ((!prm_read_mod_reg(OMAP3430_GR_MOD,
>>> -                                           OMAP3_PRM_VP1_STATUS_OFFSET))
>>> -                                           && i++ < MAX_TRIES)
>>> -                                   udelay(1);
>>> -
>>> -                           if (i >= MAX_TRIES)
>>> -                                   pr_warning("VP1 not idle, still going \
>>> -                                           ahead with VP1 disable\n");
>>> -
>>> -                           /* Disable VP1 */
>>> -                           prm_clear_mod_reg_bits(PRM_VP1_CONFIG_VPENABLE,
>>> -                                           OMAP3430_GR_MOD,
>>> -                                           OMAP3_PRM_VP1_CONFIG_OFFSET);
>>> -                   } else if (sr->srid == SR2) {
>>> -                           /* Wait for VP idle before disabling VP */
>>> -                           while ((!prm_read_mod_reg(OMAP3430_GR_MOD,
>>> -                                           OMAP3_PRM_VP2_STATUS_OFFSET))
>>> -                                           && i++ < MAX_TRIES)
>>> -                                   udelay(1);
>>> -
>>> -                           if (i >= MAX_TRIES)
>>> -                                   pr_warning("VP2 not idle, still going \
>>> -                                            ahead with VP2 disable\n");
>>> -
>>> -                           /* Disable VP2 */
>>> -                           prm_clear_mod_reg_bits(PRM_VP2_CONFIG_VPENABLE,
>>> -                                           OMAP3430_GR_MOD,
>>> -                                           OMAP3_PRM_VP2_CONFIG_OFFSET);
>>> -                   }
>>>                     /* Reset the volatage for current OPP */
>>>                     sr_reset_voltage(srid);
>>>             }
>>>     }
>>>  }
>>>
>>> +/**
>>> + * omap_sr_register_class : API to register a smartreflex class parameters.
>>> + * @class_data - The structure containing various sr class specific data.
>>> + *
>>> + * This API is to be called by the smartreflex class driver to register itself
>>> + * with the smartreflex driver during init.
>>> + */
>>> +void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
>>> +{
>>> +   if (!class_data) {
>>> +           pr_warning("Smartreflex class data passed is NULL\n");
>>> +           return;
>>> +   }
>>> +
>>> +   if (sr_class) {
>>> +           pr_warning("Smartreflex class driver already registered\n");
>>> +           return;
>>> +   }
>>> +   sr_class = class_data;
>>> +}
>>> +
>>>  /* Voltage Scaling using SR VCBYPASS */
>>>  int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
>>>                                     u8 target_vsel, u8 current_vsel)
>>> @@ -730,9 +764,9 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
>>>
>>>     if (sr_status) {
>>>             if (vdd == VDD1_OPP)
>>> -                   sr_start_vddautocomap(SR1, target_opp_no);
>>> +                   sr_start_vddautocomap(SR1);
>>>             else if (vdd == VDD2_OPP)
>>> -                   sr_start_vddautocomap(SR2, target_opp_no);
>>> +                   sr_start_vddautocomap(SR2);
>>>     }
>>>
>>>     return 0;
>>> @@ -762,17 +796,10 @@ static int omap_sr_autocomp_store(void *data, u64 val)
>>>                                                     sr_info->srid);
>>>             return 0;
>>>     }
>>> -   if (val == 0) {
>>> +   if (val == 0)
>>>             sr_stop_vddautocomap(sr_info->srid);
>>> -   } else {
>>> -           u32 current_opp;
>>> -
>>> -           if (sr_info->srid == SR1)
>>> -                   current_opp = get_vdd1_opp();
>>> -           else
>>> -                   current_opp = get_vdd2_opp();
>>> -           sr_start_vddautocomap(sr_info->srid, current_opp);
>>> -   }
>>> +   else
>>> +           sr_start_vddautocomap(sr_info->srid);
>>>     return 0;
>>>  }
>>>
>>> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
>>> index 572cdca..a59a073 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.h
>>> +++ b/arch/arm/mach-omap2/smartreflex.h
>>> @@ -243,12 +243,27 @@ extern u32 current_vdd2_opp;
>>>  #define SR_TESTING_NVALUES         0
>>>  #endif
>>>
>>> -/*
>>> - * Smartreflex module enable/disable interface.
>>> - * NOTE: if smartreflex is not enabled from sysfs, these functions will not
>>> - * do anything.
>>> - */
>>>  #ifdef CONFIG_OMAP_SMARTREFLEX
>>> +/**
>>> + * omap_smartreflex_class_data : Structure to be populated by
>>> + * Smartreflex class driver with corresponding class enable disable API's
>>> + *
>>> + * @enable - API to enable a particular class smaartreflex.
>>> + * @disable - API to disable a particular class smartreflex.
>>> + * @notify - API to notify the class driver about an event in SR. Not needed
>>> + *         for class3.
>>> + * @notify_flags - specify the events to be notified to the class driver
>>> + * @class_type - specify which smartreflex class. Can be used by the SR driver
>>> + *                 to tkae any class based decisions.
>>> + */
>>> +struct omap_smartreflex_class_data {
>>> +   int (*enable)(int sr_id);
>>> +   int (*disable)(int sr_id);
>>> +   int (*notify)(int sr_id, u32 status);
>>> +   u8 notify_flags;
>>> +   u8 class_type;
>>> +};
>>> +
>>>  /*
>>>   * omap_smartreflex_data - Smartreflex platform data
>>>   *
>>> @@ -274,11 +289,26 @@ struct omap_smartreflex_data {
>>>     int (*device_idle)(struct platform_device *pdev);
>>>  };
>>>
>>> -void enable_smartreflex(int srid);
>>> -void disable_smartreflex(int srid);
>>> +/*
>>> + * Smartreflex module enable/disable interface.
>>> + * NOTE: if smartreflex is not enabled from sysfs, these functions will not
>>> + * do anything.
>>> + */
>>> +void omap_smartreflex_enable(int srid);
>>> +void omap_smartreflex_disable(int srid);
>>> +
>>> +/**
>>> + * Smartreflex driver hooks to be called from Smartreflex class driver
>>> + */
>>> +int sr_enable(int srid, u32 target_opp_no);
>>> +void sr_disable(int srid);
>>> +
>>> +/**
>>> + * API to register the smartreflex class driver with the smartreflex driver
>>> + */
>>> +void omap_sr_register_class(struct omap_smartreflex_class_data *class_data);
>>> +
>>>  int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
>>> -void sr_start_vddautocomap(int srid, u32 target_opp_no);
>>> -int sr_stop_vddautocomap(int srid);
>>>  #else
>>>  static inline void enable_smartreflex(int srid) {}
>>>  static inline void disable_smartreflex(int srid) {}
>>> --
>>> 1.7.0.rc1.33.g07cf0f
