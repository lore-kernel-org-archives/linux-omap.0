From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 8/8] OMAP3: powerdomain data: add wake-up latency figures
Date: Mon, 10 Oct 2011 10:17:14 +0200
Message-ID: <CAORVsuX2PUubPzO3mWTaO0Lg6Mdog8wjDY6hm93qheMwoz27CA@mail.gmail.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-9-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1110062215270.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58796 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab1JJIRP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Oct 2011 04:17:15 -0400
Received: by vcbgb30 with SMTP id gb30so473510vcb.19
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 01:17:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110062215270.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi Paul,

On Fri, Oct 7, 2011 at 6:17 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Jean
>
> On Wed, 21 Sep 2011, jean.pihet@newoldbits.com wrote:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Figures are added to the power domains structs for RET and OFF modes.
>>
>> Note: the latency figures for MPU, PER, CORE, NEON have been obtained
>> from actual measurements.
>> The latency figures for the other power domains are preliminary and
>> shall be added.
>>
>> Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
>> for a detailed explanation on where are the numbers magically coming from.
>>
>> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
>> on MPU, CORE and PER.
>
> Do the CSWR measurements include the time for the PMIC to scale the
> voltage, or do they just represent the time to enter and exit clock stop
> (presumably with DPLL idling)?

As described at [1] the measurements have not been performed with
sys_offmode and sys_clkreq signals toggling correctly, because of the
lack of support for it in the kernel.
However the results are including a correction for the sys_offmode
transition time (11.5ms), but no correction for the sys_clkreq signal
(which should be 1ms for sysclk on, 2.5ms for sysclk off).

[1] http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement#cpuidle_results

Regards,
Jean

>
>
> - Paul
>
