From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 6/6 V4] hwmon: OMAP4: On die temperature sensor driver
Date: Tue, 6 Sep 2011 23:32:06 +0530
Message-ID: <CAJ6a13ZT_q1XYPebSLyLh7a7k6KeOsyERHfx+EKo+_u9bjxxMg@mail.gmail.com>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
	<1314811510-15595-7-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1108311810280.26173@utopia.booyaka.com>
	<20110901014939.GB21986@ericsson.com>
	<alpine.DEB.2.00.1108312200260.26173@utopia.booyaka.com>
	<20110901044047.GB25878@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:39154 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751585Ab1IFSCN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 14:02:13 -0400
Received: by mail-yi0-f45.google.com with SMTP id 10so5336918yih.32
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 11:02:12 -0700 (PDT)
In-Reply-To: <20110901044047.GB25878@ericsson.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Sep 1, 2011 at 10:10 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Thu, Sep 01, 2011 at 12:09:14AM -0400, Paul Walmsley wrote:
>> On Wed, 31 Aug 2011, Guenter Roeck wrote:
>>
>> > On Wed, Aug 31, 2011 at 08:36:43PM -0400, Paul Walmsley wrote:
>> > > Hi
>> > >
>> > > Some comments.
>> > >
>> > > On Wed, 31 Aug 2011, Keerthy wrote:
>> > >
>> > [ ... ]
>> > >
>> > > > +}
>> > > > +
>> > > > +/* Sysfs hook functions */
>> > >
>> > > These should be conditionally compiled out if sysfs isn't compil=
ed in.
>> > >
>> > The whole point of the hwmon subsystem is to expose hardware monit=
oring information
>> > to userland using sysfs. hwmon without sysfs doesn't make sense.
>> >
>> > So, if anything, it might make sense to disable the entire hwmon t=
ree if sysfs is disabled.
>> > But please no conditionals in the code.
>>
>> Hmm. =A0This IP block is more than just a sensor. =A0It also can int=
errupt the
>> CPU and/or trigger a GPIO line (to shut down the chip) if the chip
>> temperature crosses some thresholds. =A0On some OMAPs, the threshold=
s are
>> fixed; on others, they are software-programmable. =A0That functional=
ity
>> shouldn't require sysfs; it's almost closer to an x86 MCE.
>>
>> So based on your comments, it sounds like we should move that part o=
f the
>> code to a different driver, and just leave the basic software therma=
l
>> monitoring here?
>>
> Good point. This definitely requires some thought. hwmon is meant to =
be hw monitoring,
> as the name says, not thermal management. Maybe this entire driver sh=
ould be a thermal driver
> instead ?

This driver is not taking any action on THSUT. This is not doing the th=
ermal
management. It is a driver exposing configurable temperature thresholds=
=2E

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
