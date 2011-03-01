From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 2/2] OMAP: omap_device: API to modify AUTOIDLE and
 SMARTIDLE bits
Date: Tue, 1 Mar 2011 14:02:11 +0100
Message-ID: <4D6CEE53.5070709@ti.com>
References: <1296477288-26253-1-git-send-email-kishon@ti.com>	<1296477288-26253-3-git-send-email-kishon@ti.com>	<4D6CD5D8.6010006@ti.com> <AANLkTinF1DAtMLUU0ko4GEbf_OaWpHepXdY_m9E0dhuZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51535 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab1CANCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 08:02:16 -0500
In-Reply-To: <AANLkTinF1DAtMLUU0ko4GEbf_OaWpHepXdY_m9E0dhuZ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Basak, Partha" <p-basak2@ti.com>

On 3/1/2011 12:27 PM, ABRAHAM, KISHON VIJAY wrote:
> On Tue, Mar 1, 2011 at 4:47 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> Hi Kishon,
>>
>> Sorry for this late reply.
>>
>> I'm fine with this omap_device API which is well aligned with the discussion
>> we had. I just have few minor comments about the split omap_hwmod /
>> omap_device.
>>
>> To summarize, you should not hack directly hwmod internal attributes from
>> the upper layer.
>>
>> You should simply expose the same number of API at hwmod level instead of
>> relying on a single omap_hwmod_set_slave_idlemode with miscellaneous
>> parameters.
>
>    Should it then be like one-one mapping between omap_device APIs and
>    omap_hwmod APIs, or have a single omap_device API, that takes a additional
>    parameter and based on the parameter, call the appropriate omap_hwmod API?

A one-to-one is the best thing to do for my point of view.

Benoit

>
>>
>> On 1/31/2011 1:34 PM, ABRAHAM, KISHON VIJAY wrote:
>>>
>>> Provide APIs to be used by the driver in order to modify AUTOIDLE
>>> and SIDLE bits. These APIs in turn call hwmod APIs to modify the
>>> SYSCONFIG register.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>> Cc: Paul Walmsley<paul@pwsan.com>
>>> ---
>>>   arch/arm/plat-omap/include/plat/omap_device.h |    6 +
>>>   arch/arm/plat-omap/omap_device.c              |  176
>>> +++++++++++++++++++++++++
>>>   2 files changed, 182 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h
>>> b/arch/arm/plat-omap/include/plat/omap_device.h
>>> index e4c349f..47ad0ab 100644
>>> --- a/arch/arm/plat-omap/include/plat/omap_device.h
>>> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
>>> @@ -110,6 +110,12 @@ struct powerdomain *omap_device_get_pwrdm(struct
>>> omap_device *od);
>>>   u32 omap_device_get_context_loss_count(struct platform_device *pdev);
>>>
>>>   /* Other */
>>> +int omap_device_noidle(struct omap_device *od);
>>> +int omap_device_smartidle(struct omap_device *od);
>>> +int omap_device_forceidle(struct omap_device *od);
>>> +int omap_device_default_idle(struct omap_device *od);
>>> +int omap_device_enable_autoidle(struct omap_device *od);
>>> +int omap_device_disable_autoidle(struct omap_device *od);
>>>
>>>   int omap_device_idle_hwmods(struct omap_device *od);
>>>   int omap_device_enable_hwmods(struct omap_device *od);
>>> diff --git a/arch/arm/plat-omap/omap_device.c
>>> b/arch/arm/plat-omap/omap_device.c
>>> index 57adb27..da8609a 100644
>>> --- a/arch/arm/plat-omap/omap_device.c
>>> +++ b/arch/arm/plat-omap/omap_device.c
>>> @@ -726,6 +726,182 @@ void __iomem *omap_device_get_rt_va(struct
>>> omap_device *od)
>>>         return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
>>>   }
>>>
>>> +/**
>>> + * omap_device_noidle - set the device's slave idlemode to no idle
>>> + * @od: struct omap_device *
>>> + *
>>> + * Sets the IP block's OCP slave idlemode in hardware to no idle.
>>> + * Intended to be used by drivers that have some erratum that requires
>>> direct
>>> + * manipulation of the SIDLEMODE bits.  Returns -EINVAL if @od is in
>>> invalid
>>> + * state, or passes along the return value from
>>> + * omap_hwmod_set_slave_idlemode().
>>> + */
>>> +int omap_device_noidle(struct omap_device *od)
>>> +{
>>> +       int retval = 0, i;
>>> +
>>> +       if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
>>> +               WARN(1, "omap_device: %s.%d: %s() called from invalid
>>> state "
>>> +                       "%d\n", od->pdev.name, od->pdev.id, __func__,
>>> +                       od->_state);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       for (i = 0; i<    od->hwmods_cnt; i++)
>>> +               retval |= omap_hwmod_set_slave_idlemode(od->hwmods[i],
>>> +                                       HWMOD_IDLEMODE_NO);
>>> +
>>> +       return retval;
>>> +}
>>> +
>>> +
>>> +/**
>>> + * omap_device_smartidle - set the device's slave idlemode to smart idle
>>> + * @od: struct omap_device *
>>> + *
>>> + * Sets the IP block's OCP slave idlemode in hardware to smart idle.
>>> + * Intended to be used by drivers that have some erratum that requires
>>> direct
>>> + * manipulation of the SIDLEMODE bits.  Returns -EINVAL if @od is in
>>> invalid
>>> + * state, or passes along the return value from
>>> + * omap_hwmod_set_slave_idlemode().
>>> + */
>>> +int omap_device_smartidle(struct omap_device *od)
>>> +{
>>> +       int retval = 0, i;
>>> +
>>> +       if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
>>> +               WARN(1, "omap_device: %s.%d: %s() called from invalid
>>> state "
>>> +                       "%d\n", od->pdev.name, od->pdev.id, __func__,
>>> +                       od->_state);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       for (i = 0; i<    od->hwmods_cnt; i++)
>>> +               retval |= omap_hwmod_set_slave_idlemode(od->hwmods[i],
>>> +                                       HWMOD_IDLEMODE_SMART);
>>> +
>>> +       return retval;
>>> +}
>>> +
>>> +
>>> +/**
>>> + * omap_device_forceidle - set the device's slave idlemode to force idle
>>> + * @od: struct omap_device *
>>> + *
>>> + * Sets the IP block's OCP slave idlemode in hardware to force idle.
>>> + * Intended to be used by drivers that have some erratum that requires
>>> direct
>>> + * manipulation of the SIDLEMODE bits.  Returns -EINVAL if @od is in
>>> invalid
>>> + * state, or passes along the return value from
>>> + * omap_hwmod_set_slave_idlemode().
>>> + */
>>> +int omap_device_forceidle(struct omap_device *od)
>>> +{
>>> +       int retval = 0, i;
>>> +
>>> +       if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
>>> +               WARN(1, "omap_device: %s.%d: %s() called from invalid
>>> state "
>>> +                       "%d\n", od->pdev.name, od->pdev.id, __func__,
>>> +                       od->_state);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       for (i = 0; i<    od->hwmods_cnt; i++)
>>> +               retval |= omap_hwmod_set_slave_idlemode(od->hwmods[i],
>>> +                                       HWMOD_IDLEMODE_FORCE);
>>> +
>>> +       return retval;
>>> +}
>>> +
>>> +/**
>>> + * omap_device_default_idle - set the device's slave idlemode to no idle
>>> or
>>> + * smart idle based on the hwmod flag
>>> + * @od: struct omap_device *
>>> + *
>>> + * Sets the IP block's OCP slave idlemode in hardware to no idle or smart
>>> idle
>>> + * depending on status of the flag HWMOD_SWSUP_SIDLE.
>>> + * Intended to be used by drivers that have some erratum that requires
>>> direct
>>> + * manipulation of the SIDLEMODE bits.  Returns -EINVAL if @od is in
>>> invalid
>>> + * state, or passes along the return value from
>>> + * omap_hwmod_set_slave_idlemode().
>>> + */
>>> +int omap_device_default_idle(struct omap_device *od)
>>> +{
>>> +       int retval = 0, i;
>>> +       u8 idlemode;
>>> +
>>> +       if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
>>> +               WARN(1, "omap_device: %s.%d: %s() called from invalid
>>> state "
>>> +                       "%d\n", od->pdev.name, od->pdev.id, __func__,
>>> +               od->_state);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       for (i = 0; i<    od->hwmods_cnt; i++) {
>>> +               idlemode = (od->hwmods[i]->flags&    HWMOD_SWSUP_SIDLE) ?
>>> +                               HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
>>> +               retval |= omap_hwmod_set_slave_idlemode(od->hwmods[i],
>>> +                               idlemode);
>>
>> That one is the worst :-) You should definitively not hack directly hwmod
>> internal attributes from the upper layer.
>>
>>> +       }
>>> +
>>> +       return retval;
>>> +}
>>> +
>>> +/*
>>> + * omap_device_enable_autoidle - enable the device's OCP slave autoidle
>>> + * @od: struct omap_device *
>>> + *
>>> + * Sets the IP block's OCP slave autoidle in hardware.
>>> + * Intended to be used by drivers that have some erratum that requires
>>> direct
>>> + * manipulation of the AUTOIDLE bits.  Returns -EINVAL if @od is in
>>> invalid
>>> + * state, or passes along the return value from
>>> + * omap_hwmod_set_slave_autoidle().
>>> + */
>>> +int omap_device_enable_autoidle(struct omap_device *od)
>>> +{
>>> +       int retval = 0, i;
>>> +
>>> +       if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
>>> +               WARN(1, "omap_device: %s.%d: %s() called from invalid
>>> state "
>>> +                       "%d\n", od->pdev.name, od->pdev.id, __func__,
>>> +                       od->_state);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       for (i = 0; i<    od->hwmods_cnt; i++)
>>> +               retval |= omap_hwmod_set_slave_autoidle(od->hwmods[i],
>>> +                                       true);
>>
>> You are using the same API to send either HWMOD_XXX flags or boolean, and
>> that's quite confusing.
>>
>> As I said, you'd better duplicate these APIs at hwmod level.
>
>    OK.
>
>>
>> Benoit
>>
>>
>

