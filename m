From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Thu, 14 Jun 2012 15:51:50 -0500
Message-ID: <4FDA4EE6.1070106@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com> <4FD64D6D.3020401@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com> <4FD77EF1.8000600@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com> <4FD8A906.8080202@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9994A6@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60991 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755442Ab2FNUvt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 16:51:49 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9994A6@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

On 06/14/2012 01:17 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Wed, Jun 13, 2012 at 20:21:50, Hunter, Jon wrote:
> 
>>> I do not think it is practically possible. Please see timing calculations
>>> in arch/arm/mach-omap2/gpmc-*, the way it is done for different
>>> peripherals are different, and we cannot expect gpmc driver to do those as
>>> that would require gpmc driver being aware of type of peripheral connected.
>>>
>>> And all those gpmc-* timing calculation needs to be done before driver
>>> is ready, they rely on functions like gpmc_get_fclk_rate(), which in turn
>>> requires the clk rate to be available before driver is probed.
>>
>> So I see that the various gpmc-*.c files have some form of _retime()
>> function. However, at the end of the day they all call
>> gpmc_cs_set_timings() to convert time into gpmc clocks. Converting time
>> to gpmc clocks is completely independent of the actual device and so
>> this can be performed by the driver. We just need to populate the
>> gpmc_timings struct and pass to the driver to convert to clocks and
>> program into the registers.
> 
> gpmc_cs_set_timings() does currently convert time to clock cycles required,
> and this gpmc driver have the capability to do it.
> 
> What I was saying is a different issue, input to gpmc_cs_set_timings, which
> is time sometimes in turn is a function of time or to be exact depends on
> gpmc clock period also. So timings provided to gpmc_cs_set_timings for a
> particular frequency may not hold good for another frequency, unless we
> change the input time to gpmc_cs_set_timings based on gpmc clock.

Absolutely! No argument there.

> If you see gpmc-* files, many a times, they need to know value of gpmc fclk,
> to calculate the input time to be fed for gpmc_cs_set_timings

I understand, but that is not my point. My point is that timings should
be provided in nanoseconds for all devices. Then the gpmc driver can
query the gpmc fclk and convert to gpmc cycles. This way the gpmc driver
will not care what device is connected in terms of the timings and can
convert them.

What does make this a bit more difficult is the function
gpmc_round_ns_to_ticks(). It appears to convert nanoseconds to ticks and
back to nanoseconds. I am guessing to account for some rounding error. I
am curious what impact this function is having on the timing. Ideally
this should be handle in gpmc_cs_set_timings().

Cheers
Jon
