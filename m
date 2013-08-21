From: Gururaja Hebbar <gururaja.hebbar@ti.com>
Subject: Re: [PATCH v4 1/4] ARM: OMAP2+: AM33XX: I2C Sleep/wake sequence support
Date: Wed, 21 Aug 2013 13:59:56 +0530
Message-ID: <52147A84.8030704@ti.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com> <1376432412-8509-2-git-send-email-Russ.Dill@ti.com> <520B595F.2040207@ti.com> <CA+Bv8XZ-QGhVV1mK=rRekOZzaTDN-Y9YkWYYoEc8EtvP0JouEA@mail.gmail.com> <5211B201.2000401@ti.com> <CA+Bv8XaPU6N3KztAPFZb8OMMg8Tc+Kv5hf1Utz7QS=NCRdO3Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33511 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab3HUIa1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Aug 2013 04:30:27 -0400
In-Reply-To: <CA+Bv8XaPU6N3KztAPFZb8OMMg8Tc+Kv5hf1Utz7QS=NCRdO3Rg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, devicetree@vger.kernel.org, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 8/20/2013 10:03 PM, Russ Dill wrote:
> On Sun, Aug 18, 2013 at 10:49 PM, Gururaja Hebbar
> <gururaja.hebbar@ti.com> wrote:
>>
>> On 8/15/2013 4:04 AM, Russ Dill wrote:
>>> On Wed, Aug 14, 2013 at 3:18 AM, Gururaja Hebbar <gururaja.hebbar@ti.com> wrote:
>>>> On 8/14/2013 3:50 AM, Russ Dill wrote:
>>>>> Changes since v1:
>>>>> * Rebased onto new am335x PM branch
>>>>> * Changed to use 5th param register
>>
>>>>
>>
>> [snip]
>> [snip]
>>
>>>>> +
>>>>> +     wkup_m3_reset_data_pos();
>>>>> +     if (am33xx_i2c_sleep_sequence) {
>>>>> +             pos = wkup_m3_copy_data(am33xx_i2c_sleep_sequence,
>>>>> +                                             i2c_sleep_sequence_sz);
>>>>
>>>> Why do we need to copy this data (same constant data) on every iteration?
>>>
>>> Because the CM3 firmware is reset after each suspend/resume cycle. The
>>> firmware reset handler reinitializes the DMEM.
>>
>> Well in that why can't the i2c payload be copied to UMEM?
>>
>> Thanks & regards
>> Gururaja
>>
> 
> I've given this some thought, and gone back and forth a bit. UMEM is a
> bit more complicated because the linker decides what should go where.

but linker doesn't know about the copy and the location we are doing at
runtime.

> Also, it may be that in the future, either the PM for am335x or am43xx
> will be writing different sequences depending on the suspend
> mode/options.

still these info will be coming from DT and can be copied to UMEM. only
issue could be space.

> 
> Is there a specific aspect of copying the data each suspend cycle that
> you are trying to fix? Is it just that the data could only be copied
> once? Or is it the latency of the copy?

Copy latency on every iterations is what worries me. it will surely add
a delay for suspend.

> 
> Thanks!
> 

