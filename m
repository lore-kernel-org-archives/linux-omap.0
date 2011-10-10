From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 8/8] OMAP3: powerdomain data: add wake-up latency figures
Date: Mon, 10 Oct 2011 10:19:25 +0200
Message-ID: <CAORVsuUp4duzxw-ux3nj2_yxJvScAEaShviiZh0dreNp=383Tg@mail.gmail.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-9-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1110070923320.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53216 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab1JJIT1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Oct 2011 04:19:27 -0400
Received: by vcbgb30 with SMTP id gb30so474431vcb.19
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 01:19:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110070923320.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Paul,

On Fri, Oct 7, 2011 at 5:26 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Jean
>
> On Wed, 21 Sep 2011, jean.pihet@newoldbits.com wrote:
>
>> Figures are added to the power domains structs for RET and OFF modes=
=2E
>>
>> Note: the latency figures for MPU, PER, CORE, NEON have been obtaine=
d
>> from actual measurements.
>> The latency figures for the other power domains are preliminary and
>> shall be added.
>>
>> Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_=
Measurement
>> for a detailed explanation on where are the numbers magically coming=
 from.
>>
>> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constra=
ints
>> on MPU, CORE and PER.
>
> A few more question about these numbers.
>
> - Are these numbers the ones right off the hardware, or rounded, or
> worst-case plus a certain percentage?
All measurements results are the worst case values right from the
hardware (HW and SW measurements on the target).

>
> - What frequency/voltage were these measured at?
OPP50

>
> - Also, you mention OMAP3 Beagleboard. =A0Is that 34xx or 36xx Beagle=
board?
34xx Beagleboard

Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Mea=
surement#cpuidle_results
for the details.

Regards,
Jean

>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
