From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 6/6 V3] hwmon: OMAP4: On die temperature sensor driver
Date: Thu, 25 Aug 2011 21:34:21 +0530
Message-ID: <CAJ6a13Y0BERGmxSZR=H5h0+8z-UDUp0ZoUwdE+nH2KX7Li0c-Q@mail.gmail.com>
References: <20110824171612.GA8160@ericsson.com>
	<CAJ6a13b-0TPwqRku5_72B3Sa0gRyZOrYp-qAOuTvB5Q+G-x3Bg@mail.gmail.com>
	<20110825140630.GB8684@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:34879 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750994Ab1HYQEW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Aug 2011 12:04:22 -0400
Received: by mail-gw0-f41.google.com with SMTP id a20so1853689gwa.28
        for <linux-omap@vger.kernel.org>; Thu, 25 Aug 2011 09:04:21 -0700 (PDT)
In-Reply-To: <20110825140630.GB8684@ericsson.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Aug 25, 2011 at 7:36 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Thu, Aug 25, 2011 at 06:30:07AM -0400, J, KEERTHY wrote:
>> On Wed, Aug 24, 2011 at 10:46 PM, Guenter Roeck
>> <guenter.roeck@ericsson.com> wrote:
>> > On Wed, Aug 24, 2011 at 10:37:12AM -0400, Keerthy wrote:
>> >> On chip temperature sensor driver. The driver monitors the temper=
ature of
>> >> the MPU subsystem of the OMAP4. It sends notifications to the use=
r space if
>> >> the temperature crosses user defined thresholds via kobject_ueven=
t interface.
>> >> The user is allowed to configure the temperature thresholds vis s=
ysfs nodes
>> >> exposed using hwmon interface.
>> >>
>> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> >> Cc: Jean Delvare <khali@linux-fr.org>
>> >> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
>> >> Cc: lm-sensors@lm-sensors.org
>> >
>> > Partial review only. Too many concerns, and after a while I tend t=
o loose track.
>> >
>> >> ---
>> >> =A0Documentation/hwmon/omap_temp_sensor | =A0 27 +
>> >> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 =
+
>> >> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 =
+
>> >> =A0drivers/hwmon/omap_temp_sensor.c =A0 =A0 | =A0933 ++++++++++++=
++++++++++++++++++++++
>> >> =A04 files changed, 972 insertions(+), 0 deletions(-)
>> >> =A0create mode 100644 Documentation/hwmon/omap_temp_sensor
>> >> =A0create mode 100644 drivers/hwmon/omap_temp_sensor.c
>> >>
>
> [ ... ]
>
>> >> +/* Sysfs hook functions */
>> >> +
>> >> +static ssize_t show_temp_max(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attri=
bute *devattr, char *buf)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_dr=
vdata(dev);
>> >> + =A0 =A0 =A0 int temp;
>> >> +
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_threshold);
>> >> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_=
thot_mask)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> __ffs(temp_senso=
r->registers->threshold_thot_mask);
>> >> +
>> >> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_=
END_VALUE) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EDOM;
>> >
>> > Please don't use EDOM, and drop the error message.
>>
>> The temperature is out of range. Should i use EIO?
>>
> It is out of range, but not due to a math error, but due to a bad rea=
ding from the chip
> or due to a chip failure. EIO is ok.

Ok

>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>> >> +
>> >> + =A0 =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>> >> +}
>> >> +
>> >> +static ssize_t set_temp_max(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devi=
ce_attribute *devattr,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char =
*buf, size_t count)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_dr=
vdata(dev);
>> >> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val=
, t_cold, t_hot, temp;
>> >> +
>> >> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >
>> > This will try to release the not-acquired lock.
>>
>> I will correct this.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 t_hot =3D temp_to_adc_conversion(val);
>> >
>> > Bad error return check. Negative on error. Should be
>> > =A0 =A0 =A0 =A0if (t_hot < 0)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return t_hot;
>>
>> Ok.
>>
>> >
>> >> + =A0 =A0 =A0 if ((t_hot < OMAP_ADC_START_VALUE || t_hot > OMAP_A=
DC_END_VALUE)) {
>> >
>> > Unnecessary (( ))
>>
>> This check is unnecessary with the negative check. I will remove.
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >
>> > This will try to release the not-acquired lock.
>>
>> I will correct this.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 /* obtain the T cold value */
>> >> + =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_threshold);
>> >> + =A0 =A0 =A0 t_cold =3D (t_cold & temp_sensor->registers->thresh=
old_tcold_mask) >>
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->=
registers->threshold_tcold_mask);
>> >> +
>> >> + =A0 =A0 =A0 if (t_hot < t_cold) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >
>> > Context specific limitations like this one are not a good idea, si=
nce it assumes an order of changing max
>> > and max_hysteresis which is not necessarily guaranteed by the appl=
ication making the change, nor is a
>> > change order order well defined or even possible. Applications sho=
uld not have to bother about this.
>>
>> The hardware behavior is like this. As long as the temperature is be=
low
>> t_hot no interrupts are fired. Once the temperature increases above
>> t_hot we get an
>> interrupt. In order to avoid repeated interrupts we mask the t_hot i=
nterrupt
>> in the interrupt handler and enable the t_cold interrupts. So we get=
 a t_cold
>> interrupt only when the temperature drops below the t_cold value. He=
nce
>> setting the t_cold higher than t_hot will mess up the state machine.
>>
>> t_hot value should be greater than t_cold value.
>>
> One option would be to update t_cold (max_hyst) automatically in that=
 case.

updating the t_cold without application's knowledge?

>
> Problem here is that you expect the aplication to know, depending on =
the current
> values of (max, max_hyst), how to update both limits in order. That i=
s not a reasonable
> expectation.

The thermal application which is configuring the thresholds must be
intelligent enough to configure the thresholds in the right order. Conf=
iguring
the thresholds wrongly and missing the interrupt may even result in bur=
ning
the chip.

>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /* write the new t_hot value */
>> >> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_threshold);
>> >> + =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->threshold_tho=
t_mask;
>> >> + =A0 =A0 =A0 reg_val |=3D (t_hot <<
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->=
registers->threshold_thot_mask));
>> >> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_threshold);
>> >> +
>> >> + =A0 =A0 =A0 /* Read the current temperature */
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->temp_sensor_ctrl);
>> >> + =A0 =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> >> +
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* If user sets the HIGH threshold(t_hot) greater=
 than the current
>> >> + =A0 =A0 =A0 =A0* temperature(temp) unmask the HOT interrupts
>> >> + =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 if (t_hot > temp) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(=
temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tem=
p_sensor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~temp_sensor->register=
s->mask_cold_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers=
->mask_hot_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor=
, reg_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tem=
p_sensor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* If current temperature is in-between the hot a=
nd cold thresholds,
>> >> + =A0 =A0 =A0 =A0* Enable both masks.
>> >> + =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 if (temp > t_cold && temp < t_hot) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(=
temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tem=
p_sensor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers=
->mask_cold_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers=
->mask_hot_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor=
, reg_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMA=
P4460_BGAP_CTRL_OFFSET);
>> >
>> > Why use OMAP4460_BGAP_CTRL_OFFSET here but bgap_mask_ctrl elsewher=
e ?
>>
>> Ok. I will change this.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* else no need to do anything since HW will imme=
diately compare
>> >> + =A0 =A0 =A0 =A0* the new threshold and generate interrupt accor=
dingly
>> >> + =A0 =A0 =A0 =A0*/
>> >> +out:
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >> + =A0 =A0 =A0 return count;
>> >> +}
>> >> +
>> >> +static ssize_t show_temp_max_hyst(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devattr, c=
har *buf)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_dr=
vdata(dev);
>> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp;
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >
>> > This lock would only make sense if threshold_tcold_mask can change=
, and if that change
>> > would be protected by the mutex. I don't see that to be the case, =
thus the lock is unnecessary.
>> > Besides, the code in show_temp_max() is almost the same and does n=
ot use the lock.
>>
>> The masks are getting changed in show_temp_max() show_temp_max_hyst(=
) and the
>> ISR function. It is better to protect with mutex. I will add that in
>> required places.
>>
> Reeally ? I seem to be blind. I searched for threshold_tcold_mask in =
the patch but
> did not see where it is changed. Can you point me to the code ?

I misread it. Yes threshold_tcold_mask is used only in show_temp_max_hy=
st(),
set_temp_max(), set_temp_max_hyst() functions. It is set only in the
set_temp_max_hyst()
function.

>
> If it is changed outside the driver, you have a real problem, since t=
here is no guarantee
> that the mask is not changed from outside the driver, by code not pro=
tected by the mutex.
> And if read functions have the side effect of changing such values, t=
here should really
> be a note somewhere to make people aware of it. I'd call that side ef=
fect programming,
> and would argue it is a really bad idea.

It is not changed anywhere outside the driver.

>
>> >
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_thresh=
old);
>> >> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_=
tcold_mask) >>
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->thres=
hold_tcold_mask);
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_=
END_VALUE) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EDOM;
>> >
>> > "Math argument out of domain of func" does not make sense.
>> > Unless you don't know anything better, use EIO (I/O Error). Not ve=
ry specific,
>> > but at least not misleading.
>>
>> Out of range i assumed this was the closest error value. I will use =
EIO.
>>
> It is not a math error, though.

Ok

>
>> >
>> > Besides, the log message is unnecessary. The user is informed with=
 -EIO, and the admin
>> > won't be able to do anything useful with "invalid value".
>>
>> Ok. I will return -EIO and eliminate the log message.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>> >> +
>> >> + =A0 =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>> >> +}
>> >> +
>> >> +static ssize_t set_temp_max_hyst(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct device_attribute *devattr,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
const char *buf, size_t count)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_senso=
r =3D dev_get_drvdata(dev);
>> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 reg_val, t_hot, t_cold, temp;
>> >> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0val;
>> >> +
>> >> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >
>> > This will try to release the not acquired lock.
>>
>> I will correct this.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 t_cold =3D temp_to_adc_conversion(val);
>> >
>> > Bad error return check; same as above.
>>
>> Ok. I will correct this.
>>
>> >
>> >> + =A0 =A0 =A0 if (t_cold < OMAP_ADC_START_VALUE || t_cold > OMAP_=
ADC_END_VALUE) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 /* obtain the T HOT value */
>> >> + =A0 =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_threshold);
>> >> + =A0 =A0 =A0 t_hot =3D (t_hot & temp_sensor->registers->threshol=
d_thot_mask) >>
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->=
registers->threshold_thot_mask);
>> >> +
>> >> + =A0 =A0 =A0 if (t_cold > t_hot) {
>> >
>> > Same concern as above. Change order is left to application which s=
hould not be bothered.
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /* write the new t_cold value */
>> >> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_threshold);
>> >> + =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->threshold_tco=
ld_mask;
>> >> + =A0 =A0 =A0 reg_val |=3D t_cold <<
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->=
registers->threshold_tcold_mask);
>> >> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_threshold);
>> >> +
>> >> + =A0 =A0 =A0 /* Read the current temperature */
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor=
_ctrl);
>> >> + =A0 =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> >> +
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* If user sets the LOW threshold(t_cold) lower t=
han the current
>> >> + =A0 =A0 =A0 =A0* temperature(temp) unmask the COLD interrupts
>> >> + =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 if (t_cold < temp) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(=
temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tem=
p_sensor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~temp_sensor->register=
s->mask_hot_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers=
->mask_cold_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor=
, reg_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* If current temperature is in-between the hot a=
nd cold thresholds,
>> >> + =A0 =A0 =A0 =A0* Enable both masks.
>> >> + =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 if (temp < t_hot && temp > t_cold) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(=
temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tem=
p_sensor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers=
->mask_cold_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers=
->mask_hot_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor=
, reg_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tem=
p_sensor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* else no need to do anything since HW will imme=
diately compare
>> >> + =A0 =A0 =A0 =A0* the new threshold and generate interrupt accor=
dingly
>> >> + =A0 =A0 =A0 =A0*/
>> >
>> > Would be nice if you could unify the interrupt enable code in a si=
ngle function.
>>
>> Ok. I will have a function for this.
>>
>> >
>> >> +
>> >> +out:
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >> + =A0 =A0 =A0 return count;
>> >> +}
>> >> +
>> >> +static ssize_t show_update_rate(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attri=
bute *devattr, char *buf)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_dr=
vdata(dev);
>> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D=
 0, ret =3D 0;
>> >> +
>> > No need to initialize temp.
>> > ret is u32, which doesn't seem to be a good type to use for negati=
ve values.
>>
>> Oops yes. I will correct this.
>>
>> >
>> >> +
>> >> + =A0 =A0 =A0 if (!temp_sensor->clk_rate) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "clk_rate is NULL\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;
>> >
>> > Same comment as above (this is not a math error). And you don't ha=
ve to check clk_rate anyway,
>> > since it is set in probe, and probe bails out if it is not set.
>>
>> Ok
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >
>> > As with other show locks, this one would only make sense if counte=
r_mask can change during runtime,
>> > and if that change would be protected by the mutex. This is not th=
e case, thus the lock is unnecessary.
>>
>> Counter value can be altered runtime. A lock is needed in both the c=
ases.
>> I will add it.
>>
> clk_rate does not change, counter_mask does not change, and reading a=
 single value
> doesn't need a mutex. Am I missing something ?

Ok. I will remove the lock from show function.

>
>> >
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_counter);
>> >> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->counter_ma=
sk) >>
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->=
registers->counter_mask);
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 temp =3D temp * 1000 / temp_sensor->clk_rate;
>> >> +
>> >> +out:
>> >> + =A0 =A0 =A0 if (!ret)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", temp);
>> >> +
>> >> + =A0 =A0 =A0 return ret;
>> >> +}
>> >> +
>> >> +static ssize_t set_update_rate(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct device_attribute *devattr,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cons=
t char *buf, size_t count)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_dr=
vdata(dev);
>> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val=
;
>> >> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>> >> +
>> >> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 val *=3D temp_sensor->clk_rate / 1000;
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_counter);
>> >> +
>> >> + =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->counter_mask;
>> >> + =A0 =A0 =A0 reg_val |=3D val;
>> >
>> > Sure you want to accept any value (including negative ones) here ?
>> > val is not shifted, and not masked against counter_mask, meaning i=
t can write
>> > all bits of the register. That doesn't sound right.
>>
>> I will have a check.
>>
>> >
>> > It would make sense to call omap_configure_temp_sensor_counter() i=
nstead of duplicating
>> > the set functionality.
>>
>> Yes I will make use of that.
>>
>> >
>> >> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_counter);
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >> +out:
>> >> + =A0 =A0 =A0 return count;
>> >> +}
>> >> +
>> >> +static int omap_temp_sensor_read_temp(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct device_attribute *devattr,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 char *buf)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_dr=
vdata(dev);
>> >> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp, r=
et =3D 0;
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >
>> > Unless bgap_dtemp_mask can change during runtime, and that change =
is protected by the mutex,
>> > this lock is unnecessary.
>>
>> It is read only and is updated by hardware. Change cannot be protect=
ed by mutex.
>>
>> >
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor=
_ctrl);
>> >> + =A0 =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> >> +
>> >> + =A0 =A0 =A0 /* look up for temperature in the table and return =
the temperature */
>> >> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_=
END_VALUE) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid adc code repo=
rted %d", temp);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;
>> >
>> > Another wrong use of EDOM, and another value-free error message.
>>
>> Ok. I will use -EIO and drop the error message.
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 temp =3D adc_to_temp[temp - OMAP_ADC_START_VALUE];
>> >> +
>> >> +out:
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 if (!ret)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", temp);
>> >> +
>> >> + =A0 =A0 =A0 return ret;
>> >> +}
>> >> +
>> >> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, omap_temp_sensor=
_read_temp,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, 0);
>> >> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_tem=
p_max,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max, 0=
);
>> >> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, sho=
w_temp_max_hyst,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max_hy=
st, 0);
>> >> +static SENSOR_DEVICE_ATTR(update_rate, S_IWUSR | S_IRUGO, show_u=
pdate_rate,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_update_rate=
, 0);
>> >> +
>> >
>> > ABI is update_interval. Please use it.
>>
>> Ok.
>>
>> >
>> >> +static struct attribute *omap_temp_sensor_attributes[] =3D {
>> >> + =A0 =A0 =A0 &sensor_dev_attr_temp1_input.dev_attr.attr,
>> >> + =A0 =A0 =A0 &sensor_dev_attr_temp1_max.dev_attr.attr,
>> >> + =A0 =A0 =A0 &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>> >> + =A0 =A0 =A0 &sensor_dev_attr_update_rate.dev_attr.attr,
>> >> + =A0 =A0 =A0 NULL
>> >> +};
>> >> +
>> >> +static const struct attribute_group omap_temp_sensor_group =3D {
>> >> + =A0 =A0 =A0 .attrs =3D omap_temp_sensor_attributes,
>> >> +};
>> >> +
>> >> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor *=
temp_sensor)
>> >> +{
>> >> + =A0 =A0 =A0 u32 ret =3D 0;
>> >> +
>> >> + =A0 =A0 =A0 if (temp_sensor->clk_on) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "cl=
ock already on\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 ret =3D pm_runtime_get_sync(temp_sensor->hwmon_dev)=
;
>> >> + =A0 =A0 =A0 if (ret < 0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "ge=
t sync failed\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 temp_sensor->clk_on =3D 1;
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >
>> > Completely unnecessary lock.
>>
>> Ok
>>
>> >
>> >> +out:
>> >> + =A0 =A0 =A0 return ret;
>> >> +}
>> >> +
>> >> +static int omap_temp_sensor_clk_disable(struct omap_temp_sensor =
*temp_sensor)
>> >
>> > Return code is not used anywhere, why bother providing one ?
>>
>> It is not checked in the error path. I can make it void.
>>
>> >
>> >> +{
>> >> + =A0 =A0 =A0 u32 ret =3D 0;
>> >> +
>> >> + =A0 =A0 =A0 if (!temp_sensor->clk_on) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "cl=
ock already off\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >
>> > ... and since you ignore the error anyway, why log it ?
>>
>> Ok. I will remove the log message.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /* Gate the clock */
>> >> + =A0 =A0 =A0 ret =3D pm_runtime_put_sync(temp_sensor->hwmon_dev)=
;
>> >> + =A0 =A0 =A0 if (ret < 0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "pu=
t sync failed\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 temp_sensor->clk_on =3D 0;
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >
>> > Completely unnecessary lock.
>>
>> Ok
>>
>> >
>> >> +out:
>> >> + =A0 =A0 =A0 return ret;
>> >> +}
>> >> +
>> >> +static irqreturn_t omap_talert_irq_handler(int irq, void *data)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_senso=
r;
>> >> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 t_hot, t_cold, temp;
>> >> +
>> >> + =A0 =A0 =A0 temp_sensor =3D data;
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> +
>> >> + =A0 =A0 =A0 /* Read the status of t_hot */
>> >> + =A0 =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_status)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & temp_sensor->regi=
sters->status_hot_mask;
>> >> +
>> >> + =A0 =A0 =A0 /* Read the status of t_cold */
>> >> + =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_status)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & temp_sensor->regi=
sters->status_cold_mask;
>> >> +
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* One TALERT interrupt: Two sources
>> >> + =A0 =A0 =A0 =A0* If the interrupt is due to t_hot then mask t_h=
ot and
>> >> + =A0 =A0 =A0 =A0* and unmask t_cold else mask t_cold and unmask =
t_hot
>> >> + =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 if (t_hot) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~temp_sensor->registers->=
mask_hot_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor->registers->m=
ask_cold_mask;
>> >> + =A0 =A0 =A0 } else if (t_cold) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~temp_sensor->registers->=
mask_cold_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor->registers->m=
ask_hot_mask;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_c=
trl);
>> >> +
>> >> + =A0 =A0 =A0 /* kobject_uvent to user space telling thermal thre=
shold crossed */
>> >> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_=
CHANGE);
>> >> +
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >> + =A0 =A0 =A0 return IRQ_HANDLED;
>> >> +}
>> >> +
>> >> +static int __devinit omap_temp_sensor_probe(struct platform_devi=
ce *pdev)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor_pdata =A0 *pdata =A0=3D pde=
v->dev.platform_data;
>> >> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_senso=
r;
>> >> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *me=
m;
>> >> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ret =3D 0;
>> >> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 val, clk_rate;
>> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 max_freq, min_freq;
>> >> +
>> >> + =A0 =A0 =A0 if (!pdata) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "platform data =
missing\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 temp_sensor =3D kzalloc(sizeof(*temp_sensor), GFP_K=
ERNEL);
>> >> + =A0 =A0 =A0 if (!temp_sensor)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> >> +
>> >
>> > You have error messages all over the place, Why not here ?
>>
>> Ok. I will add an error message here.
>>
>> >
>> >> + =A0 =A0 =A0 mutex_init(&temp_sensor->sensor_mutex);
>> >> +
>> >> + =A0 =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM,=
 0);
>> >> + =A0 =A0 =A0 if (!mem) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resourc=
e\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >
>> > If you try to get the resource before allocating the memory, you d=
on't have to release
>> > the memory if the platform resource is missing.
>>
>> Ok. Here if i fail i am releasing temp_sensor memory which
>> has been allocated.
>>
>> >
>> >> + =A0 =A0 =A0 temp_sensor->irq =3D platform_get_irq_byname(pdev, =
"thermal_alert");
>> >> + =A0 =A0 =A0 if (temp_sensor->irq < 0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "get_irq_byname=
 failed\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D temp_sensor->irq;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 temp_sensor->phy_base =3D ioremap(mem->start, resou=
rce_size(mem));
>> >> + =A0 =A0 =A0 temp_sensor->clock =3D NULL;
>> >> + =A0 =A0 =A0 temp_sensor->registers =3D pdata->registers;
>> >> + =A0 =A0 =A0 temp_sensor->hwmon_dev =3D &pdev->dev;
>> >> +
>> >> + =A0 =A0 =A0 if (pdata->max_freq && pdata->min_freq) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D pdata->max_freq;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D pdata->min_freq;
>> >> + =A0 =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D MAX_FREQ;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D MIN_FREQ;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>> >> + =A0 =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>> >> +
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* check if the efuse has a non-zero value if not
>> >> + =A0 =A0 =A0 =A0* it is an untrimmed sample and the temperatures
>> >> + =A0 =A0 =A0 =A0* may not be accurate
>> >> + =A0 =A0 =A0 =A0*/
>> >> +
>> >> + =A0 =A0 =A0 if (omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->bgap_efuse)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->is_efuse_valid =3D 1;
>> >
>> > is_efuse_valid is not used anywhere. Might as well drop it.
>>
>> Ok
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(temp_sensor->hwmon_dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Invalid EFUSE, Non=
-trimmed BGAP, Temp not accurate\n");
>> >
>> > dev_info might be better here.
>>
>> Ok.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, temp_sensor);
>> >> + =A0 =A0 =A0 temp_sensor->clock =3D clk_get(temp_sensor->hwmon_d=
ev, "fck");
>> >> + =A0 =A0 =A0 if (IS_ERR(temp_sensor->clock)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->clock)=
;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to get fclk=
: %d\n", ret);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 ret =3D omap_temp_sensor_clk_enable(temp_sensor);
>> >> + =A0 =A0 =A0 if (ret) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot enable =
temp sensor\n");
>> >
>> > omap_temp_sensor_clk_enable() already generates error messages.
>>
>> Ok. I will remove this.
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 clk_rate =3D clk_round_rate(temp_sensor->clock, max=
_freq);
>> >> + =A0 =A0 =A0 if (clk_rate < min_freq || clk_rate =3D=3D 0xffffff=
ff) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Error round ra=
te\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;
>> >
>> > EDOM is wrong. Please use ENODEV.
>>
>> Ok
>>
>> >
>> > The error log doesn't really provide anything useful to the admini=
strator.
>> > Either add parameters, or drop it.
>>
>> Ok
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 ret =3D clk_set_rate(temp_sensor->clock, clk_rate);
>> >> + =A0 =A0 =A0 if (ret) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set clo=
ck rate\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 temp_sensor->clk_rate =3D clk_rate;
>> >> + =A0 =A0 =A0 omap_enable_continuous_mode(temp_sensor, 1);
>> >> + =A0 =A0 =A0 omap_configure_temp_sensor_thresholds(temp_sensor);
>> >> + =A0 =A0 =A0 /* 1 ms */
>> >> + =A0 =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor, 1);
>> >
>> > If temp_sensor->clk_rate * 2 is two seconds, as suggested below, 1=
 is not 1ms.
>> > 1ms would be temp_sensor->clk_rate / 1000.
>>
>> Yes! Wrong comment. It is configured to start the temperature conver=
sion.
>> It represents 1 clock cycle of the temperature sensor fclk. I will c=
orrect this.
>>
>> >
>> >> +
>> >> + =A0 =A0 =A0 /* Wait till the first conversion is done wait for =
at least 1ms */
>> >> + =A0 =A0 =A0 usleep_range(1000, 2000);
>> >> +
>> >> + =A0 =A0 =A0 /* Read the temperature once due to hw issue*/
>> >> + =A0 =A0 =A0 omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regist=
ers->temp_sensor_ctrl);
>> >> +
>> >> + =A0 =A0 =A0 /* Set 2 seconds time as default counter */
>> >> + =A0 =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->clk_rate * 2);
>> >> +
>> >> + =A0 =A0 =A0 temp_sensor->hwmon_dev =3D hwmon_device_register(&p=
dev->dev);
>> >> + =A0 =A0 =A0 if (IS_ERR(temp_sensor->hwmon_dev)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "hwmon_device_r=
egister failed.\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->hwmon_=
dev);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto hwmon_reg_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 ret =3D sysfs_create_group(&pdev->dev.kobj,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&oma=
p_temp_sensor_group);
>> >
>> > one line is sufficient here.
>>
>> Ok.
>>
>> >
>> >> + =A0 =A0 =A0 if (ret) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "could not crea=
te sysfs files\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto sysfs_create_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_=
ADD);
>> >> +
>> >
>> > No other hwmon driver needs this. Doesn't the sysfs code take care=
 of this ?
>>
>> Yes i will remove this.
>>
>> >
>> >> + =A0 =A0 =A0 ret =3D request_threaded_irq(temp_sensor->irq, NULL=
,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_talert_irq_handler, IRQF_TRIGG=
ER_RISING | IRQF_ONESHOT,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "temp_sensor", temp=
_sensor);
>> >> + =A0 =A0 =A0 if (ret) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Request thread=
ed irq failed.\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto req_irq_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /* unmask the T_COLD and unmask T_HOT at init */
>> >> + =A0 =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_c=
trl);
>> >> + =A0 =A0 =A0 val |=3D temp_sensor->registers->mask_cold_mask
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | temp_sensor->registers->mask_hot_=
mask;
>> >> +
>> >> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_c=
trl);
>> >> +
>> > This is racy. From Documentation/hwmon/submitting-patches:
>>
>> I read it. If i enable the interrupts before i have the sysfs
>> infrastructure ready.
>> I am likely to miss out on the uevent notification if the interrupt
>> occurs as soon as
>> i unmask. Correct me if my understanding is wrong.
>>
> See other email on sequence subject. I'll have to look into it in mor=
e detail.
> later - no time right now ...

Ok

>
> Guenter
>
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
