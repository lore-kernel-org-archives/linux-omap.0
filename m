From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [lm-sensors] [PATCH 6/6 V3] hwmon: OMAP4: On die temperature
 sensor driver
Date: Sat, 27 Aug 2011 22:07:30 +0530
Message-ID: <CAJ6a13ZGhzj4N63YGfFTG37LBaQrEQMmcjTssi5azcFYKLqaHA@mail.gmail.com>
References: <20110824171612.GA8160@ericsson.com>
	<CAJ6a13b-0TPwqRku5_72B3Sa0gRyZOrYp-qAOuTvB5Q+G-x3Bg@mail.gmail.com>
	<20110825140630.GB8684@ericsson.com>
	<1314287771.2796.40.camel@groeck-laptop>
	<CAJ6a13YcmJCHPOVvgUfV6-LB3+MCGjgbGv=9Ks3Rv5gRvr=r1A@mail.gmail.com>
	<1314375395.2796.82.camel@groeck-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:59767 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750989Ab1H0Qhc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Aug 2011 12:37:32 -0400
Received: by mail-ww0-f47.google.com with SMTP id 4so4562372wwf.4
        for <linux-omap@vger.kernel.org>; Sat, 27 Aug 2011 09:37:30 -0700 (PDT)
In-Reply-To: <1314375395.2796.82.camel@groeck-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: guenter.roeck@ericsson.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Aug 26, 2011 at 9:46 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Fri, 2011-08-26 at 07:17 -0400, J, KEERTHY wrote:
>> On Thu, Aug 25, 2011 at 9:26 PM, Guenter Roeck
>> <guenter.roeck@ericsson.com> wrote:
>> > On Thu, 2011-08-25 at 10:06 -0400, Guenter Roeck wrote:
>> >> On Thu, Aug 25, 2011 at 06:30:07AM -0400, J, KEERTHY wrote:
>> >> > On Wed, Aug 24, 2011 at 10:46 PM, Guenter Roeck
>> >> > <guenter.roeck@ericsson.com> wrote:
>> >> > > On Wed, Aug 24, 2011 at 10:37:12AM -0400, Keerthy wrote:
>> >> > >> On chip temperature sensor driver. The driver monitors the t=
emperature of
>> >> > >> the MPU subsystem of the OMAP4. It sends notifications to th=
e user space if
>> >> > >> the temperature crosses user defined thresholds via kobject_=
uevent interface.
>> >> > >> The user is allowed to configure the temperature thresholds =
vis sysfs nodes
>> >> > >> exposed using hwmon interface.
>> >> > >>
>> >> > >> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> >> > >> Cc: Jean Delvare <khali@linux-fr.org>
>> >> > >> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
>> >> > >> Cc: lm-sensors@lm-sensors.org
>> >> > >
>> >
>> > [ ... ]
>> >
>> >
>> >> >
>> >> > >
>> >> > >> + =A0 =A0 =A0 }
>> >> > >> +
>> >> > >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> > >> + =A0 =A0 =A0 /* obtain the T cold value */
>> >> > >> + =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> >> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->r=
egisters->bgap_threshold);
>> >> > >> + =A0 =A0 =A0 t_cold =3D (t_cold & temp_sensor->registers->t=
hreshold_tcold_mask) >>
>> >> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sen=
sor->registers->threshold_tcold_mask);
>> >> > >> +
>> >> > >> + =A0 =A0 =A0 if (t_hot < t_cold) {
>> >> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> > >
>> >> > > Context specific limitations like this one are not a good ide=
a, since it assumes an order of changing max
>> >> > > and max_hysteresis which is not necessarily guaranteed by the=
 application making the change, nor is a
>> >> > > change order order well defined or even possible. Application=
s should not have to bother about this.
>> >> >
>> >> > The hardware behavior is like this. As long as the temperature =
is below
>> >> > t_hot no interrupts are fired. Once the temperature increases a=
bove
>> >> > t_hot we get an
>> >> > interrupt. In order to avoid repeated interrupts we mask the t_=
hot interrupt
>> >> > in the interrupt handler and enable the t_cold interrupts. So w=
e get a t_cold
>> >> > interrupt only when the temperature drops below the t_cold valu=
e. Hence
>> >> > setting the t_cold higher than t_hot will mess up the state mac=
hine.
>> >> >
>> >> > t_hot value should be greater than t_cold value.
>> >> >
>> >> One option would be to update t_cold (max_hyst) automatically in =
that case.
>> >>
>> >> Problem here is that you expect the application to know, dependin=
g on the current
>> >> values of (max, max_hyst), how to update both limits in order. Th=
at is not a reasonable
>> >> expectation.
>> >>
>> > One possible solution would be to have a single function to set bo=
th
>> > t_cold and t_hot, and call it from both initialization code and fr=
om the
>> > set functions. That would unify all the register setting and inter=
rupt
>> > enable code.
>> >
>> > Regarding the actual values to set, you can (as an example) use th=
e
>> > following approach:
>> >
>> > - If max is set, and t_hot < t_cold, adjust t_cold to the new valu=
e of
>> > t_hot.
>> >
>> > - if max_hyst is set, and t_cold > t_hot, set t_cold to the new va=
lue of
>> > t_hot.
>> >
>> > So, in other words, your new unified function would only need the
>> > following simple validation:
>> >
>> > =A0 =A0 =A0 =A0if (t_cold > t_hot)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t_cold =3D t_hot;
>>
>> One concern here. There should be a hysteresis
>> difference between the two and can not be equal.
>> I need to add a hysteresis value to t_hot so as
>> to maintain t_hot > t_cold condition.
>>
> Sure, makes sense. Was that in your original patch ? Just wondering.

Original patch never let the user set thresholds which failed to
satisfy the condition t_hot > t_cold. The original patch threw up
error if this condition was violated.

>
> Thanks,
> Guenter
>
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
