From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: cpuidle status in mainline for Beagleboard xM
Date: Fri, 02 Sep 2011 09:05:53 +0300
Message-ID: <4E607241.8000704@bitmer.com>
References: <CACKLOr10aTCwkBZnSinvP4HLPhrJeiBs=6KM2we4DwTT0NJ22A@mail.gmail.com>	<87vctcjo2w.fsf@ti.com>	<CACKLOr0KpCUXrXM7M9YvE3DGPbGjzT4N678eEPfx_GGE7+40-w@mail.gmail.com> <87ei00f94i.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:48596 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758094Ab1IBGGL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 02:06:11 -0400
In-Reply-To: <87ei00f94i.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: javier Martin <javier.martin@vista-silicon.com>, linux-omap@vger.kernel.org, Koen Kooi <koen@beagleboard.org>

On 09/01/2011 08:46 PM, Kevin Hilman wrote:
> javier Martin<javier.martin@vista-silicon.com>  writes:
>
>> Hi Kevin,
>> thanks for your help.
>>
>>> CPU is staying in C0 probably because UARTs are not being idled, so SoC
>>> cannot hit deeper idle states.  Try the following at the command line to
>>> to enable UART idle timeouts, so the SoC can attempt idle after the
>>> timeout period
>>>
>>> # UART timeouts: omap-serial (4th UART only on OMAP36xx and OMAP4)
>>> echo 5>  /sys/devices/platform/omap/omap_uart.0/sleep_timeout
>>> echo 5>  /sys/devices/platform/omap/omap_uart.1/sleep_timeout
>>> echo 5>  /sys/devices/platform/omap/omap_uart.2/sleep_timeout
>>> echo 5>  /sys/devices/platform/omap/omap_uart.3/sleep_timeout
>>>
>>> After 5 seconds of inactivity on the UARTs, you should see the SoC
>>> hitting deeper C-states.
>> I've tried that but it still doesn't hit any C-state deeper than 0.
>> I'll try the same test using your pm branch you pointed me out and
>> post the results.
>>
> The CPUidle stuff works in mainline (after allowing UARTs to idle).
Other usual things to check that display is off (echo 1 > 
/sys/class/graphics/fb0/blank) and no cable to musb/otg port.

Haven't tried myself with recent kernel but does EHCI and hub on XM let 
to idle cpu at all? At least on one board having on-board hub I had to 
disable or unload ehci module in order to hit the retention.

-- 
Jarkko
