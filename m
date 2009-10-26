From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH 2/2 v3] OMAP3: PM: SR: SmartReflex Refactor Rev4.0
Date: Mon, 26 Oct 2009 14:05:00 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9DDDFD029@dnce01.ent.ti.com>
References: <OMAP3:PM:SR: SmartReflex Refactor Rev3.0>
 <1256361352-9968-1-git-send-email-nm@ti.com>
 <1256361352-9968-2-git-send-email-nm@ti.com>
 <1256361352-9968-3-git-send-email-nm@ti.com>
 <74583B8642AB8841B30447520659FCA9DDDFCC3C@dnce01.ent.ti.com>
 <4AE4D85D.8030107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34081 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944AbZJZNFL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 09:05:11 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4AE4D85D.8030107@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imberton Guilhem <guilhem.imberton@motorola.com>, Mike Chan <mikechan@google.com>, "Nayak, Rajendra" <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Reddy, Teerth" <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Hogander Jouni <jouni.hogander@nokia.com>, "Sabatier, Sebastien" <s-sabatier1@ti.com>

> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
>
> Cousson, Benoit said the following on 10/25/2009 05:12 PM:
> >> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-
> >>
> [...]
> >> +     },
> >> +             /* *INDENT-ON* */
> >> +};
> >> +
> >> +/* SR list for 3430 */
> >> +static __initdata struct omap_sr_list omap34xx_srlist = {
> >> +     .num_sr = 2,
> >> +     .sr_list = {&omap34xx_sr1, &omap34xx_sr2}
> >> +};
> >> +
> >> +/* The final SR list */
> >> +static struct omap_sr_list *omap_srlist;
> >>
> >
> > I have a couple a suggestions regarding the code partitioning:
> >
> > - SmartReflex is one IP with several instances; it means that only the
> base address will change between SR1 and SR2. There is no need to
> duplicate the mask and shift defines per SR.
> >
> might have been easier with a standard OCP wrapper and standard
> INT/INTSTATUS regs for SR instead of the current integration.... but
> yeah, I had been thinking of that- if O4/beyond could have the same IP
> wrapped in a different register mapping, i should handle it then, not
> dream about it now.. I get your point here.. there are a few places we
> can kick it out and some places your are stuck with them!

SR is a regular IP, with a dedicated PD, dedicated fclk and bound to the L4...
VP/VC is not, that why I was proposing to separated them.

> > Moreover, SR being an IP, I think we can encode the one IP / several
> instance in a platform_device / platform_driver code. It will allow the
> support of several drivers for the same devices in order to implement for
> example class3, class2 or class1 drivers. SR can even be represented by an
> HWMOD.
> >
> what is your intention in misusing platform_device for a SOC specific
> code? I think you have an idea here that I am completely missing. can
> you care to elaborate?

AFAIK, platform_device is there in order to deal with SoC devices???
Considering that SR is an IP that can be in several SoC, it looks to me the perfect candidate for platform_device/platform_driver.
Am I missing something?

> > - The smartreflex.c file contains 34xx specifics code; it should not be
> there, only SR specific code should be there.
> >
> read the TODO. which specific 3430 code does it have? other than using
> macros which have 34xx prefix - that should be killed -yep.

omap34xx_sr1, omap34xx_sr2, omap34xx_srlist... seem to be quite OMAP34xx specifics...

> > - If we want to go further, I think that the VP/VC code should not be in
> SR code either. It is located in the PRM, and can be used independently of
> SR.
> >   - In a SR class 2 mode, the smartreflex driver will not use the direct
> >     connection to the VP.
> >   - If we don't want SR we can still use the VP/VC for device voltage
> >     control.
> >
>       - How about adding - Smart reflex  should actually fit in a
> voltage control infrastructure so that the system can manipulate and set
> voltage with and without SR..

Fully agree, that was one of the proposals I had in mind, but since it will require some more works, it should be done in a second pass.

> that is what is really missing in our code base today -> SR and VP comes
> plugged in close as buddies in all silicons, so if your recommendation
> has an silicon example where OMAP SR talks not to VP, let me know and I
> will second splitting the code :D. till then sorry.. you dont have a case.

We had the case in several chips that unfortunately are not there anymore
:-(
The SR IP was done to handle several config, having SR tied to VP/VC is a chip dependant implementation.

> now, it is a different case where you want to use SR as a pure
> monitoring engine -> that is not an implementation that is exactly
> better than class 3 operation.. why support it at all?

It is not a matter or being better, it is just having HW vs. SW implementation. The point is Class 3 is not usable with non SR compliant power IC. In that case you should rely on a Class 2 implementation.

> >  [snip]
> >
> >
> >> +/****************** PMIC WEAK FUNCTIONS FOR TWL4030 derivatives
> >> **********/
> >> +
> >> +/**
> >> + * @brief pmic_srinit - Power management IC initialization
> >> + * for smart reflex. The current code is written for TWL4030
> >> + * derivatives, replace in board file if PMIC requires
> >> + * a different sequence
> >> + *
> >> + * @return result of operation
> >> + */
> >> +int __weak __init omap_pmic_srinit(void)
> >> +{
> >> +     int ret = -ENODEV;
> >> +#ifdef CONFIG_TWL4030_CORE
> >> +     u8 reg;
> >> +     /* Enable SR on T2 */
> >> +     ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &reg,
> >> +                               R_DCDC_GLOBAL_CFG);
> >> +
> >> +     reg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
> >> +     ret |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, reg,
> >> +                                 R_DCDC_GLOBAL_CFG);
> >> +#endif                               /* End of CONFIG_TWL4030_CORE */
> >> +     return ret;
> >> +}
> >> +
> >> +/**
> >> + * @brief omap_pmic_voltage_ramp_delay - how much should this pmic
> ramp
> >> delay
> >> + * Various PMICs have different ramp up and down delays. choose to
> >> implement
> >> + * in required pmic file to override this function.
> >> + * On TWL4030 derivatives:
> >> + *  T2 SMPS slew rate (min) 4mV/uS, step size 12.5mV,
> >> + *  2us added as buffer.
> >> + *
> >> + * @param srid - which SR is this for?
> >> + * @param target_vsel - targetted voltage selction
> >> + * @param current_vsel - current voltage selection
> >> + *
> >> + * @return delay in uSeconds
> >> + */
> >> +u32 __weak omap_pmic_voltage_ramp_delay(u8 srid, u8 target_vsel,
> >> +                                     u8 current_vsel)
> >> +{
> >> +     u32 t2_smps_steps = abs(target_vsel - current_vsel);
> >> +     u32 t2_smps_delay = ((t2_smps_steps * 125) / 40) + 2;
> >> +     return t2_smps_delay;
> >> +}
> >> +
> >> +#ifdef CONFIG_OMAP_VC_BYPASS_UPDATE
> >> +/**
> >> + * @brief omap_pmic_voltage_cmds - hook for pmic command sequence
> >> + * to be send out which are specific to pmic to set a specific voltage.
> >> + * this should inturn call vc_send_command with the required sequence
> >> + * The current implementation is for TWL4030 derivatives
> >> + *
> >> + * @param srid - which SR is this for?
> >> + * @param target_vsel - what voltage is desired to be set?
> >> + *
> >> + * @return specific value to set.
> >> + */
> >> +int __weak omap_pmic_voltage_cmds(u8 srid, u8 target_vsel)
> >> +{
> >> +     u8 reg_addr = (srid == SR1) ? R_VDD1_SR_CONTROL :
> R_VDD2_SR_CONTROL;
> >> +     u16 timeout = COUNT_TIMEOUT_TWL4030_VCBYPASS;
> >> +     return vc_send_command(R_SRI2C_SLAVE_ADDR, reg_addr, target_vsel,
> >> +                            &timeout);
> >> +}
> >> +#endif                               /* ifdef
> CONFIG_OMAP_VC_BYPASS_UPDATE */
> >> +
> >>
> >
> > The TWL4030 specific code should not be there even if this is the
> default PMIC, it should be in TWL4030 driver code.
> > The usage of weak functions will prevent a multiple OMAP build with
> different PMIC to work.
> > The mapping between omap and TWL4030 should be done in the board
> specific code.
> >
> hmm good point.. have a recommendation here?

We can define a struct with these methods. The struct will be implemented inside the PMIC code. The binding will be done in the board setup code. The SR driver will use the struct pointer to dereference the methods.


> > [snip]
> >
> >
> >
> >> +/*********************** DVFS Entry POINTS
> >> **********************************/
> >> +
> >> +/**
> >> + * @brief sr_vp_enable_both - enable both vp and sr
> >> + *
> >> + * @param target_opp - targetted op
> >> + * @param current_opp - current opp
> >> + *
> >> + * @return 0 if ok, 1 if not ok
> >> + */
> >> +int sr_vp_enable_both(u32 target_opp, u32 current_opp)
> >>
> >
> > It thinks that it not obvious from the name to understand what this API
> is doing, especially if we consider the other enable_smartreflex API.
> > Maybe smartreflex_change_opp or sr_change_opp will more explicit. In any
> case the vp should be removed. The fact that VP is used internally is
> implementation dependent.
> >
> I dont see a reason why VP should need independent consideration as SR.
> today SR talks to VP and there is no usage of SR sticking it's data else
> where..

VP is used for device voltage control as well from the PRM. If you don't need SR you can still use the PRM control for OFF/RET/IDLE voltage change.
Have a look at the TRM to see how it is connected.

>
> but on the naming -> yeah sr_vp_enable both --> explained in the comment
> above - enable both SR and VP.. now, if you state DVFS entry point
> should state stop_auto_voltage_change() you have a case there.. I
> accept..

Yep, this is the point, that API is exposed to the upper layer, that should not have to know the details of the implementation or having an API that will change in the case of different SR implementation.

> I also point you to my TODO above: a better voltage setting
> infrastructure is needed than hacking our voltage code on top of current
> code.

Sure, but that should not prevent us of providing better naming today if it is easily doable.

Regards,
Benoit

> >
> >> +{
> >> +     struct omap_sr *sr;
> >> +     u32 vdd, target_opp_no;
> >> +     int ret = 0;
> >> +
> >> +     vdd = get_vdd(target_opp);
> >> +     target_opp_no = get_opp_no(target_opp);
> >> +     sr = get_sr_from_vdd(vdd);
> >> +
> >> +     if (sr->is_autocomp_active && sr->is_sr_reset) {
> >> +             ret = srvp_enable(sr, target_opp_no);
> >> +             if (ret) {
> >> +                     pr_err("SR[%d]:enableboth:"
> >> +                            "failed enable SR\n", sr->srid);
> >> +             }
> >> +     }
> >> +     return ret;
> >> +}
> >> +EXPORT_SYMBOL(sr_vp_enable_both);
> >> +
> >> +/**
> >> + * @brief sr_vp_disable_both - disable both vp and sr
> >> + *
> >> + * @param target_opp - targetted opp
> >> + * @param current_opp - current opp
> >> + *
> >> + * @return 0 if ok, 1 if not ok
> >> + */
> >> +int sr_vp_disable_both(u32 target_opp, u32 current_opp)
> >> +{
> >> +     struct omap_sr *sr;
> >> +     u32 vdd;
> >> +     int ret = 0;
> >> +
> >> +     vdd = get_vdd(target_opp);
> >> +     sr = get_sr_from_vdd(vdd);
> >> +
> >> +     if (sr->is_autocomp_active && !sr->is_sr_reset) {
> >> +             ret = srvp_disable(sr);
> >> +             if (ret) {
> >> +                     pr_err("SR[%d]:disableboth:"
> >> +                            "failed disable SR\n", sr->srid);
> >> +             }
> >> +     }
> >> +
> >> +     return ret;
> >> +
> >> +}
> >> +EXPORT_SYMBOL(sr_vp_disable_both);
> >> +
> >> +/**
> >> + * @brief sr_voltage_set - setup a voltage requested
> >> + *
> >> + * @param target_opp - targetted opp
> >> + * @param current_opp  - current opp
> >> + * @param target_vsel - targeted voltage
> >> + * @param current_vsel - current voltage
> >> + *
> >> + * @return  - result of op -0 if ok, else value
> >> + */
> >> +int sr_voltage_set(u32 target_opp, u32 current_opp,
> >> +                u8 target_vsel, u8 current_vsel)
> >> +{
> >> +     struct omap_sr *sr;
> >> +     u8 vdd, target_opp_no;
> >> +     int ret;
> >> +
> >> +     vdd = get_vdd(target_opp);
> >> +     target_opp_no = get_opp_no(target_opp);
> >> +     sr = get_sr_from_vdd(vdd);
> >> +
> >> +     ret =
> >> +         SR_CHOSEN_VOLTAGE_UPDATE_MECH(sr, target_opp_no, target_vsel,
> >> +                                       current_vsel);
> >> +
> >> +     return ret;
> >> +}
> >> +EXPORT_SYMBOL(sr_voltage_set);
> >> +
> >> +/*********************** CPUIDLE ENTRY POINTS
> >> *********************************/
> >> +
> >> +/**
> >> + * @brief disable_smartreflex - disable SmartReflex before WFI
> >> + *
> >> + * @param srid SRID
> >> + */
> >> +void disable_smartreflex(u8 srid)
> >> +{
> >> +     struct omap_sr *sr = NULL;
> >> +     int ret;
> >> +     u32 current_opp_no;
> >> +
> >> +     /* I want to be in irq_disabled context..
> >> +      * else I will die.. find the rootcause and fix it instead
> >> +      */
> >> +     BUG_ON(!irqs_disabled());
> >> +
> >> +     sr = get_sr(srid);
> >> +
> >> +     current_opp_no = get_current_opp_number_from_sr(sr);
> >> +
> >> +     if (sr->is_autocomp_active && !sr->is_sr_reset) {
> >> +             sr->req_opp_no = current_opp_no;
> >> +             ret = srvp_disable(sr);
> >> +             if (ret)
> >> +                     pr_err("SR[%d]:disable_smartreflex:"
> >> +                            "failed disable SR\n", sr->srid);
> >> +     }
> >> +
> >> +     /* Reset the voltage for current OPP to nominal if SR was enabled
> */
> >> +     if (sr->is_autocomp_active)
> >> +             sr_vp_reset_voltage(srid);
> >> +}
> >> +EXPORT_SYMBOL(disable_smartreflex);
> >> +
> >> +/**
> >> + * @brief enable_smartreflex - enable smart reflex after WFI is hit
> >> + *
> >> + * @param srid -SR ID to hit
> >> + */
> >> +void enable_smartreflex(u8 srid)
> >>
> >
> > The naming is not coherent with previous API name sr_vp_enable_both. You
> should use the same denomination for smartreflex everywhere.
> >
> NAK - read the context please before you comment -> the call is from
> cpu_idle perspective..
> >
> >> +{
> >> +     struct omap_sr *sr;
> >> +     int ret;
> >> +     u32 current_opp_no;
> >> +
> >> +     /* I want to be in irq_disabled context..
> >> +      * else I will die.. find the rootcause and fix it instead
> >> +      */
> >> +     BUG_ON(!irqs_disabled());
> >> +
> >> +     sr = get_sr(srid);
> >> +     current_opp_no = get_current_opp_number_from_sr(sr);
> >> +
> >> +     if (sr->is_autocomp_active && sr->is_sr_reset) {
> >> +             ret = srvp_enable(sr, current_opp_no);
> >> +             if (ret)
> >> +                     pr_err("SR[%d]:enable_smartreflex:"
> >> +                            "failed enable SR\n", sr->srid);
> >> +     }
> >> +}
> >> +EXPORT_SYMBOL(enable_smartreflex);
> >> +
> >>
> >
> > [snip]
> >
> > For my point of view, this code should be dispatched into several files:
> smartreflex.c (pure SR IP driver), vp_vc.c (voltage processor and control),
> pmic driver, omap specific code and board initialization code.
> >
> come up with a clean proposal that can have code attached to it, or
> better still a patch and I will gladly back my patch out.
>
> Regards,
> Nishanth Menon


Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



