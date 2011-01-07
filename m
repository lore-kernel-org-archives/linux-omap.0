From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030 madc module
Date: Fri, 7 Jan 2011 17:42:13 +0530
Message-ID: <AANLkTinkNNhrq+b5eiE7XrYQUsR2-vVD08btqM81KJA1@mail.gmail.com>
References: <1294287457-2438-1-git-send-email-j-keerthy@ti.com>
	<20110106053328.GA7489@ericsson.com>
	<20110106120713.GD17184@sirena.org.uk>
	<20110106150430.GA9053@ericsson.com>
	<20110106202142.GC8018@opensource.wolfsonmicro.com>
	<1294350903.9786.103.camel@groeck-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:42841 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751686Ab1AGMMO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 07:12:14 -0500
Received: by gyg13 with SMTP id 13so6405878gyg.16
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 04:12:13 -0800 (PST)
In-Reply-To: <1294350903.9786.103.camel@groeck-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: guenter.roeck@ericsson.com, sameo@linux.intel.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "balajitk@ti.com" <balajitk@ti.com>

On Fri, Jan 7, 2011 at 3:25 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Thu, 2011-01-06 at 15:21 -0500, Mark Brown wrote:
>> On Thu, Jan 06, 2011 at 07:04:30AM -0800, Guenter Roeck wrote:
>> > On Thu, Jan 06, 2011 at 07:07:13AM -0500, Mark Brown wrote:
>>
>> > > Why? =A0It's not like hwmon has an unreasonably large core or si=
milar.
>>
>> > Because it creates an unnecessary dependency, and because it is no=
t hwmon's
>> > responsibility to provide infrastructure for other subsystems or d=
rivers.
>>
>> hwmon isn't really doing anything, though. =A0The *driver* is doing
>> something but it doesn't really impact the core that much. =A0Not th=
at I'm
>> particularly sold on putting the ADC core in here, but total NACK ba=
sed
>> on that alone seems rather harsh.
>
> Possibly. However, I had suggested the following earlier (to the 1st
> version of the patch):
>
>> I commented on this a couple of times below - the driver mixes gener=
ic
>> ADC reading functions with hwmon functionality. Generic ADC reading
>> functionality should be moved into another driver, possibly to mfd.
>
> Obviously that was ignored. Maybe someone is willing to listen this t=
ime
> around.
>
I am sorry for not responding on the generic ADC handling part. Since m=
any
other ADC drivers are part of hwmon i thought hwmon was the appropriate
place. However I can surely split the generic ADC handling part in mfd =
and
only hardware monitoring part in hwmon as suggested.

> I won't let people break modularity just for convenience in a subsyst=
em
> I am responsible for. And forcing the hwmon subsystem, and with it a
> specific hwmon driver, to exist just because the adc functionality it
> provides is needed by some other (most likely unrelated) subsystem /
> driver _does_ break modularity. Worse, it is completely unnecessary t=
o
> do so. Other twl4030 functionality was extracted into generic code.
> twl-core.c, twl4030-codec.c, twl4030-irq.c, twl4030-power.c are all i=
n
> mfd. I fail to see the problem with mfd/twl4030-adc.c.
>
> Guenter
>
>
>

Hello Samuel,

Is it ok to have the generic ADC functionality in mfd as a separate fil=
e?

Regards,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
