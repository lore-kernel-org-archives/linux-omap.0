From: Kevin Hilman <khilman@ti.com>
Subject: Re: cpuidle status in mainline for Beagleboard xM
Date: Thu, 01 Sep 2011 10:46:53 -0700
Message-ID: <87ei00f94i.fsf@ti.com>
References: <CACKLOr10aTCwkBZnSinvP4HLPhrJeiBs=6KM2we4DwTT0NJ22A@mail.gmail.com>
	<87vctcjo2w.fsf@ti.com>
	<CACKLOr0KpCUXrXM7M9YvE3DGPbGjzT4N678eEPfx_GGE7+40-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:56270 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756448Ab1IARq5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 13:46:57 -0400
Received: by mail-yx0-f175.google.com with SMTP id 11so566201yxl.20
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 10:46:56 -0700 (PDT)
In-Reply-To: <CACKLOr0KpCUXrXM7M9YvE3DGPbGjzT4N678eEPfx_GGE7+40-w@mail.gmail.com>
	(javier Martin's message of "Thu, 1 Sep 2011 17:33:31 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: linux-omap@vger.kernel.org, Koen Kooi <koen@beagleboard.org>

javier Martin <javier.martin@vista-silicon.com> writes:

> Hi Kevin,
> thanks for your help.
>
>> CPU is staying in C0 probably because UARTs are not being idled, so =
SoC
>> cannot hit deeper idle states. =C2=A0Try the following at the comman=
d line to
>> to enable UART idle timeouts, so the SoC can attempt idle after the
>> timeout period
>>
>> # UART timeouts: omap-serial (4th UART only on OMAP36xx and OMAP4)
>> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
>> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
>> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
>> echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout
>>
>> After 5 seconds of inactivity on the UARTs, you should see the SoC
>> hitting deeper C-states.
>
> I've tried that but it still doesn't hit any C-state deeper than 0.
> I'll try the same test using your pm branch you pointed me out and
> post the results.
>

The CPUidle stuff works in mainline (after allowing UARTs to idle).

You only need my pm-wip/cpufreq branch for testing CPUfreq.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
