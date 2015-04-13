From: Tero Kristo <t-kristo@ti.com>
Subject: Re: am335x crypto module clocks
Date: Mon, 13 Apr 2015 13:27:40 +0300
Message-ID: <552B9A1C.9010802@ti.com>
References: <CAALWOA8Zno6pTfWRZpacgWm83m4=1+uvTmyREG9Nc+C2MZjK1w@mail.gmail.com> <20150409151338.GQ18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37687 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbbDMK0w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Apr 2015 06:26:52 -0400
In-Reply-To: <20150409151338.GQ18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 04/09/2015 06:13 PM, Tony Lindgren wrote:
> * Matthijs van Duin <matthijsvanduin@gmail.com> [150404 21:26]:
>> Hi all,
>>
>> To my surprise, the am335x clock tree (am33xx-clocks.dtsi) currently
>> lists the functional clock of the AES accelerator and other crypto
>> modules to be the (max 26 MHz) main osc. This struck me as rather
>> unlikely, since the AES module is clocked much higher on other
>> devices, and such a slow clock would condemn it to being slower than a
>> software AES implementation.  As usual the TRM is silent on the crypto
>> accelerators and their clock management, but I did some preliminary
>> tests.
>>
>> The AES module turned out far from slow.  I actually had a lot of
>> trouble keeping the module continuously fed with data with a simple
>> non-dma test from userspace, since for most modes of operation the AES
>> module could even keep pace with a tight loop using 128-bit neon
>> load/store without even checking its status register for readiness.
>>
>> Although I haven't been able to get obtain a very reliable measurement
>> yet as a result, it appears to be clocked at ~200 MHz. This also
>> matches the fact that it is hooked up to the L3F (which would be
>> rather pointless if it had a separate low-rate fck).
>>
>> It seems very likely to me the other crypto modules will also have a
>> unified fck/ick (L3F for the hash accelerator, L4LS for the RNG and
>> PKA). This should preferably still be double-checked of course.
>
> Tero, got any ideas about this one?

This seems like just improperly modelled clock data. Looking at some 
PRCM documentation, the proper parent for aes/sha seems to be l3_gclk.
pka/rng/des is using l4ls_gclk.

The separate aes/sha clock nodes should just be deleted from the clock 
data, and instead use the proper main_clk definition under the hwmod data.

-Tero


