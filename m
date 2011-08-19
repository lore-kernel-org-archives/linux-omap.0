From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [RFC PATCH 6/6 V2] hwmon: OMAP4: On die temperature sensor driver
Date: Fri, 19 Aug 2011 18:31:53 +0530
Message-ID: <CAJ6a13b17aAyQeumdqjAVR9Fs7mP6J-b9f+bJe+B6Dk0SXw3qg@mail.gmail.com>
References: <1313664735-8917-1-git-send-email-j-keerthy@ti.com>
	<1313664735-8917-7-git-send-email-j-keerthy@ti.com>
	<20110819021333.GA27544@ericsson.com>
	<CAJ6a13b6EQNhkQ+i5vf0kxKJ3RadY7iSCSJwZ5_sd3Y0BydUow@mail.gmail.com>
	<20110819061745.GA28832@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:45186 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751279Ab1HSNBz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Aug 2011 09:01:55 -0400
Received: by mail-yi0-f42.google.com with SMTP id 19so2580778yie.29
        for <linux-omap@vger.kernel.org>; Fri, 19 Aug 2011 06:01:54 -0700 (PDT)
In-Reply-To: <20110819061745.GA28832@ericsson.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Aug 19, 2011 at 11:47 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Fri, Aug 19, 2011 at 02:04:58AM -0400, J, KEERTHY wrote:
>> On Fri, Aug 19, 2011 at 7:43 AM, Guenter Roeck
>> <guenter.roeck@ericsson.com> wrote:
>> > On Thu, Aug 18, 2011 at 06:52:15AM -0400, Keerthy wrote:
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
>> > High level review:
>> >
>> > - too much and too broad mutex locking. show functions should not =
need locks at all,
>> > =A0set functions only while data is written into registers and int=
o platform data.
>>
>> Ok. I will clean this.
>>
>> > - driver is quite noisy. There should definitely not be any log me=
ssages
>> > =A0if a set parameter is wrong. Show functions already return an e=
rror value
>> > =A0to the user; a log message indicating the error again just crea=
tes noise.
>> > =A0For one boolean set during probe (is_efuse_valid), each subsequ=
ent show results
>> > =A0in a log message if it is false. Some errors result in multiple=
 log messages.
>>
>> A user tries to set an invalid temperature threshold. The user shoul=
d
>> be notified about this. The invalid temperature will not be set. The=
 user
>> should not be allowed to set an invalid temperature. It is to inform
>> the user about precisely the problem with the parameter.
>>
> User is notified with -EINVAL. Unless on the console, which is unlike=
ly,
> the user will likely not notice a message in the kernel log.

These messages on console are useful for debug purpose
so can i place it under dev_dbg? Only on explicit enabling
these messages can be seen.

>
>> In some of the samples the bandgap is not trimmed and hence
>> temperature reported will be wrong. So every time a user tries to re=
ad
>> he is alerted that the temperatures are not accurate.
>>
> In the kernel log ? Sorry, that doesn't make sense. You alert the sys=
tem administrator,
> not the user.

Ok. Can this be a dev_dbg message? Only for debug purpose
this can be useful.

>
> Guenter
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
