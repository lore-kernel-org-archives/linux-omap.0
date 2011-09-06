From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 6/6 V4] hwmon: OMAP4: On die temperature sensor driver
Date: Tue, 6 Sep 2011 23:27:25 +0530
Message-ID: <CAJ6a13a6=o3+6Kg5+PiaPPANa=vOA_BfY-6LGWLHb-s4-wbdsw@mail.gmail.com>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
	<1314811510-15595-7-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1108311810280.26173@utopia.booyaka.com>
	<20110901014939.GB21986@ericsson.com>
	<alpine.DEB.2.00.1108312200260.26173@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:50920 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751585Ab1IFR51 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 13:57:27 -0400
Received: by mail-iy0-f182.google.com with SMTP id x2so12639iad.41
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 10:57:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1108312200260.26173@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Sep 1, 2011 at 9:39 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 31 Aug 2011, Guenter Roeck wrote:
>
>> On Wed, Aug 31, 2011 at 08:36:43PM -0400, Paul Walmsley wrote:
>> > Hi
>> >
>> > Some comments.
>> >
>> > On Wed, 31 Aug 2011, Keerthy wrote:
>> >
>> [ ... ]
>> >
>> > > +}
>> > > +
>> > > +/* Sysfs hook functions */
>> >
>> > These should be conditionally compiled out if sysfs isn't compiled=
 in.
>> >
>> The whole point of the hwmon subsystem is to expose hardware monitor=
ing information
>> to userland using sysfs. hwmon without sysfs doesn't make sense.
>>
>> So, if anything, it might make sense to disable the entire hwmon tre=
e if sysfs is disabled.
>> But please no conditionals in the code.
>
> Hmm. =A0This IP block is more than just a sensor. =A0It also can inte=
rrupt the
> CPU and/or trigger a GPIO line (to shut down the chip) if the chip
> temperature crosses some thresholds. =A0On some OMAPs, the thresholds=
 are
> fixed; on others, they are software-programmable. =A0That functionali=
ty
> shouldn't require sysfs; it's almost closer to an x86 MCE.

The TSHUT thresholds are not even exposed through the sysfs nodes.
This driver only creates sysfs nodes for TALERT  thresholds.

>
> So based on your comments, it sounds like we should move that part of=
 the
> code to a different driver, and just leave the basic software thermal
> monitoring here?

What part of code should be moved?
This driver does just the basic hardware monitoring and exposes
configurable thresholds for t_hot and t_cold.
This does not include t_shut configuration and handling. This is
a simple hardware monitoring driver which does not cater to
Thermal management. That is being discussed separately in other
thread.

>
>
> - Paul
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
