From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v2 2/2] OMAP: omap_device: API to modify AUTOIDLE and
 SMARTIDLE bits
Date: Tue, 1 Mar 2011 16:57:21 +0530
Message-ID: <AANLkTinF1DAtMLUU0ko4GEbf_OaWpHepXdY_m9E0dhuZ@mail.gmail.com>
References: <1296477288-26253-1-git-send-email-kishon@ti.com>
	<1296477288-26253-3-git-send-email-kishon@ti.com>
	<4D6CD5D8.6010006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:53413 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755420Ab1CAL1W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 06:27:22 -0500
Received: by mail-yw0-f50.google.com with SMTP id 8so1564932ywa.9
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 03:27:21 -0800 (PST)
In-Reply-To: <4D6CD5D8.6010006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Basak, Partha" <p-basak2@ti.com>

On Tue, Mar 1, 2011 at 4:47 PM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> Hi Kishon,
>
> Sorry for this late reply.
>
> I'm fine with this omap_device API which is well aligned with the dis=
cussion
> we had. I just have few minor comments about the split omap_hwmod /
> omap_device.
>
> To summarize, you should not hack directly hwmod internal attributes =
from
> the upper layer.
>
> You should simply expose the same number of API at hwmod level instea=
d of
> relying on a single omap_hwmod_set_slave_idlemode with miscellaneous
> parameters.

  Should it then be like one-one mapping between omap_device APIs and
  omap_hwmod APIs, or have a single omap_device API, that takes a addit=
ional
  parameter and based on the parameter, call the appropriate omap_hwmod=
 API?

>
> On 1/31/2011 1:34 PM, ABRAHAM, KISHON VIJAY wrote:
>>
>> Provide APIs to be used by the driver in order to modify AUTOIDLE
>> and SIDLE bits. These APIs in turn call hwmod APIs to modify the
>> SYSCONFIG register.
>>
>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> ---
>> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 =A06 +
>> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
176
>> +++++++++++++++++++++++++
>> =A02 files changed, 182 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h
>> b/arch/arm/plat-omap/include/plat/omap_device.h
>> index e4c349f..47ad0ab 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_device.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
>> @@ -110,6 +110,12 @@ struct powerdomain *omap_device_get_pwrdm(struc=
t
>> omap_device *od);
>> =A0u32 omap_device_get_context_loss_count(struct platform_device *pd=
ev);
>>
>> =A0/* Other */
>> +int omap_device_noidle(struct omap_device *od);
>> +int omap_device_smartidle(struct omap_device *od);
>> +int omap_device_forceidle(struct omap_device *od);
>> +int omap_device_default_idle(struct omap_device *od);
>> +int omap_device_enable_autoidle(struct omap_device *od);
>> +int omap_device_disable_autoidle(struct omap_device *od);
>>
>> =A0int omap_device_idle_hwmods(struct omap_device *od);
>> =A0int omap_device_enable_hwmods(struct omap_device *od);
>> diff --git a/arch/arm/plat-omap/omap_device.c
>> b/arch/arm/plat-omap/omap_device.c
>> index 57adb27..da8609a 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -726,6 +726,182 @@ void __iomem *omap_device_get_rt_va(struct
>> omap_device *od)
>> =A0 =A0 =A0 =A0return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
>> =A0}
>>
>> +/**
>> + * omap_device_noidle - set the device's slave idlemode to no idle
>> + * @od: struct omap_device *
>> + *
>> + * Sets the IP block's OCP slave idlemode in hardware to no idle.
>> + * Intended to be used by drivers that have some erratum that requi=
res
>> direct
>> + * manipulation of the SIDLEMODE bits. =A0Returns -EINVAL if @od is=
 in
>> invalid
>> + * state, or passes along the return value from
>> + * omap_hwmod_set_slave_idlemode().
>> + */
>> +int omap_device_noidle(struct omap_device *od)
>> +{
>> + =A0 =A0 =A0 int retval =3D 0, i;
>> +
>> + =A0 =A0 =A0 if (od->_state !=3D OMAP_DEVICE_STATE_ENABLED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "omap_device: %s.%d: %s() call=
ed from invalid
>> state "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%d\n", od->pdev.name,=
 od->pdev.id, __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 od->_state);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i< =A0od->hwmods_cnt; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D omap_hwmod_set_slave_idlem=
ode(od->hwmods[i],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 HWMOD_IDLEMODE_NO);
>> +
>> + =A0 =A0 =A0 return retval;
>> +}
>> +
>> +
>> +/**
>> + * omap_device_smartidle - set the device's slave idlemode to smart=
 idle
>> + * @od: struct omap_device *
>> + *
>> + * Sets the IP block's OCP slave idlemode in hardware to smart idle=
=2E
>> + * Intended to be used by drivers that have some erratum that requi=
res
>> direct
>> + * manipulation of the SIDLEMODE bits. =A0Returns -EINVAL if @od is=
 in
>> invalid
>> + * state, or passes along the return value from
>> + * omap_hwmod_set_slave_idlemode().
>> + */
>> +int omap_device_smartidle(struct omap_device *od)
>> +{
>> + =A0 =A0 =A0 int retval =3D 0, i;
>> +
>> + =A0 =A0 =A0 if (od->_state !=3D OMAP_DEVICE_STATE_ENABLED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "omap_device: %s.%d: %s() call=
ed from invalid
>> state "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%d\n", od->pdev.name,=
 od->pdev.id, __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 od->_state);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i< =A0od->hwmods_cnt; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D omap_hwmod_set_slave_idlem=
ode(od->hwmods[i],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 HWMOD_IDLEMODE_SMART);
>> +
>> + =A0 =A0 =A0 return retval;
>> +}
>> +
>> +
>> +/**
>> + * omap_device_forceidle - set the device's slave idlemode to force=
 idle
>> + * @od: struct omap_device *
>> + *
>> + * Sets the IP block's OCP slave idlemode in hardware to force idle=
=2E
>> + * Intended to be used by drivers that have some erratum that requi=
res
>> direct
>> + * manipulation of the SIDLEMODE bits. =A0Returns -EINVAL if @od is=
 in
>> invalid
>> + * state, or passes along the return value from
>> + * omap_hwmod_set_slave_idlemode().
>> + */
>> +int omap_device_forceidle(struct omap_device *od)
>> +{
>> + =A0 =A0 =A0 int retval =3D 0, i;
>> +
>> + =A0 =A0 =A0 if (od->_state !=3D OMAP_DEVICE_STATE_ENABLED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "omap_device: %s.%d: %s() call=
ed from invalid
>> state "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%d\n", od->pdev.name,=
 od->pdev.id, __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 od->_state);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i< =A0od->hwmods_cnt; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D omap_hwmod_set_slave_idlem=
ode(od->hwmods[i],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 HWMOD_IDLEMODE_FORCE);
>> +
>> + =A0 =A0 =A0 return retval;
>> +}
>> +
>> +/**
>> + * omap_device_default_idle - set the device's slave idlemode to no=
 idle
>> or
>> + * smart idle based on the hwmod flag
>> + * @od: struct omap_device *
>> + *
>> + * Sets the IP block's OCP slave idlemode in hardware to no idle or=
 smart
>> idle
>> + * depending on status of the flag HWMOD_SWSUP_SIDLE.
>> + * Intended to be used by drivers that have some erratum that requi=
res
>> direct
>> + * manipulation of the SIDLEMODE bits. =A0Returns -EINVAL if @od is=
 in
>> invalid
>> + * state, or passes along the return value from
>> + * omap_hwmod_set_slave_idlemode().
>> + */
>> +int omap_device_default_idle(struct omap_device *od)
>> +{
>> + =A0 =A0 =A0 int retval =3D 0, i;
>> + =A0 =A0 =A0 u8 idlemode;
>> +
>> + =A0 =A0 =A0 if (od->_state !=3D OMAP_DEVICE_STATE_ENABLED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "omap_device: %s.%d: %s() call=
ed from invalid
>> state "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%d\n", od->pdev.name,=
 od->pdev.id, __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 od->_state);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i< =A0od->hwmods_cnt; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 idlemode =3D (od->hwmods[i]->flags& =A0=
HWMOD_SWSUP_SIDLE) ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HWMOD_=
IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D omap_hwmod_set_slave_idlem=
ode(od->hwmods[i],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 idlemo=
de);
>
> That one is the worst :-) You should definitively not hack directly h=
wmod
> internal attributes from the upper layer.
>
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return retval;
>> +}
>> +
>> +/*
>> + * omap_device_enable_autoidle - enable the device's OCP slave auto=
idle
>> + * @od: struct omap_device *
>> + *
>> + * Sets the IP block's OCP slave autoidle in hardware.
>> + * Intended to be used by drivers that have some erratum that requi=
res
>> direct
>> + * manipulation of the AUTOIDLE bits. =A0Returns -EINVAL if @od is =
in
>> invalid
>> + * state, or passes along the return value from
>> + * omap_hwmod_set_slave_autoidle().
>> + */
>> +int omap_device_enable_autoidle(struct omap_device *od)
>> +{
>> + =A0 =A0 =A0 int retval =3D 0, i;
>> +
>> + =A0 =A0 =A0 if (od->_state !=3D OMAP_DEVICE_STATE_ENABLED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "omap_device: %s.%d: %s() call=
ed from invalid
>> state "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%d\n", od->pdev.name,=
 od->pdev.id, __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 od->_state);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i< =A0od->hwmods_cnt; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D omap_hwmod_set_slave_autoi=
dle(od->hwmods[i],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 true);
>
> You are using the same API to send either HWMOD_XXX flags or boolean,=
 and
> that's quite confusing.
>
> As I said, you'd better duplicate these APIs at hwmod level.

  OK.

>
> Benoit
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
