From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 6/6 V4] hwmon: OMAP4: On die temperature sensor driver
Date: Tue, 6 Sep 2011 17:19:39 +0530
Message-ID: <CAJ6a13ZbYpHNEpyPJ_pe73z5uEb70xZq4umb78Uxf0rtCZpxJw@mail.gmail.com>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
	<1314811510-15595-7-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1108311721460.26173@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:35157 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753424Ab1IFLtk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 07:49:40 -0400
Received: by mail-yi0-f49.google.com with SMTP id 13so5434440yic.22
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 04:49:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1108311721460.26173@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

On Thu, Sep 1, 2011 at 5:26 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi,
>
> On Wed, 31 Aug 2011, Keerthy wrote:
>
>> On chip temperature sensor driver. The driver monitors the temperatu=
re of
>> the MPU subsystem of the OMAP4. It sends notifications to the user s=
pace if
>> the temperature crosses user defined thresholds via kobject_uevent i=
nterface.
>> The user is allowed to configure the temperature thresholds vis sysf=
s nodes
>> exposed using hwmon interface.
>
> I commented in a separate post that this driver should probably use a=
n MFD
> driver for the System Control Module accesses, and then this hwmon dr=
iver
> should use functions from that to access the BANDGAP temperature sens=
or
> registers[1].
>
> But I had another comment on this driver.
>
> A similar sensor is available on the OMAP34xx[2], OMAP36xx[3], and
> OMAP4430[4] chips. =A0There are some register layout differences; the
> thermal shutdown threshold is configurable on the 4460 but fixed on t=
he
> 4430; and also I'd assume, without looking, that the temperature mapp=
ing
> table is different on different chips.
>
> So it would seem to make sense to move the chip-specific code and
> data into chip-specific source files.
>
> I could see keeping a generic filename like "omap_temp_sensor.c" if y=
ou
> implemented a common interface to the bandgap sensors, ADCs and
> comparators, across all those different chips. =A0That might be worth
> thinking about. =A0But at least, this should probably be named
> drivers/hwmon/omap4460_temp_sensor.c, or something similar.

The same driver can be used for OMAP5 too.
That has 3 instances of the same sensor. So omap4460+?

>
>
> - Paul
>
> 1. Walmsley, Paul. =A0_Re: [PATCH 4/6 V4] OMAP4: Hwmod: OMAP temperat=
ure
> =A0 sensor_. =A0Posted to the linux-omap@vger.kernel.org list on Wed,=
 31 Aug
> =A0 2011 17:16:44 -0600. =A0Available from (among others):
> =A0 http://marc.info/?l=3Dlinux-omap&m=3D131483260632685&w=3D2
>
> 2. Section 7.4.6 "Band Gap Voltage and Temperature Sensor". _OMAP34xx
> =A0 Multimedia Device Silicon Revision 3.1.x Version R (SWPU223R)_ (p=
ublic
> =A0 version). =A0Available from
> =A0 http://focus.ti.com/pdfs/wtbu/OMAP34xx_ES3.1.x_PUBLIC_TRM_vZR.zip
>
> 3. Section 13.4.6 "Band Gap Voltage and Temperature Sensor". _OMAP36x=
x
> =A0 Multimedia Device Silicon Revision 1.x Version V (SWPU177V)_ (pub=
lic
> =A0 version). =A0Available from
> =A0 http://focus.ti.com/pdfs/wtbu/OMAP36xx_ES1.x_PUBLIC_TRM_vV.zip
>
> 4. Section 18.4.10 "Band Gap Voltage and Temperature Sensor". _OMAP44=
30
> =A0 Multimedia Device Silicon Revision 2.x Version V (SWPU231V)_ (pub=
lic
> =A0 version). =A0Available from
> =A0 http://focus.ti.com/pdfs/wtbu/OMAP4430_ES2.x_PUBLIC_TRM_vV.zip
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
