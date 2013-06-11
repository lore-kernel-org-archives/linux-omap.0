From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v3] ARM: DTS: TWL4030: fix mux and wakeup for SYS_NIRQ line
Date: Tue, 11 Jun 2013 07:30:35 -0700
Message-ID: <874nd4d8j8.fsf@linaro.org>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org>
	<1370629886-14170-1-git-send-email-khilman@linaro.org>
	<20130607193130.GA13205@kahuna> <51B59AC3.2080900@ti.com>
	<87fvwpex6k.fsf@linaro.org> <51B70B08.9030208@ti.com>
	<51B70D57.4010208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:54792 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab3FKOaj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jun 2013 10:30:39 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so3097652pbc.35
        for <linux-omap@vger.kernel.org>; Tue, 11 Jun 2013 07:30:39 -0700 (PDT)
In-Reply-To: <51B70D57.4010208@ti.com> (Benoit Cousson's message of "Tue, 11
	Jun 2013 13:43:19 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Benoit Cousson <b-cousson@ti.com> writes:

> On 06/11/2013 01:33 PM, Cousson, Benoit wrote:
>> On 6/10/2013 6:40 PM, Kevin Hilman wrote:
>>> Benoit Cousson <b-cousson@ti.com> writes:
>>>
>>>> Hi Kevin,
>>>>
>>>> On 06/07/2013 09:31 PM, Nishanth Menon wrote:
>>>>> On 11:31-20130607, Kevin Hilman wrote:
>>>>>> On most OMAP3 platforms, the twl4030 IRQ line is connected to the
>>>>>> SYS_NIRQ line on OMAP.  Add another DTS include file
>>>>>> (twl4030_omap3.dtsi) for boards that hook up the twl4030 this way
>>>>>> to include.
>>>>>>
>>>>>> This allows RTC wake from off-mode to work again on OMAP3-based
>>>>>> platforms with twl4030.  Tested on 3530/Beagle, 3730/Beagle-xM,
>>>>>> 3530/Overo, 3730/Overo-STORM.
>>>>>>
>>>>>> Special thanks to Florian Vaussard for suggesting use of preprocessor
>>>>>> feature.
>>>>>>
>>>>>> Cc: Florian Vaussard <florian.vaussard@epfl.ch>
>>>>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>>>>> Cc: Nishanth Menon <nm@ti.com>
>>>>>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>>>>> Thanks,
>>>>> Reviewed-by: Nishanth Menon <nm@ti.com>
>>>>
>>>> Thanks, I've just applied it in for_3.11/dts.
>>>
>>> Thanks,
>>>
>>> Will you apply the first 2 from the series too?
>>>
>>>    ARM: DTS: OMAP3: beagle/overo: mux console UART, enable wakeup
>>>    ARM: DTS: OMAP3: beagle: enable user button via gpio_keys, enable
>>> wakeup
>> 
>> Thanks for the reminder, I kind of forgot these ones :-)
>
> BTW, do you have any v2 for these ones? This version does not use the
> macros.
> Moreover I cannot apply them on top of Florian's series :-(

Oops,  I thought I reposted those too.   All three are here:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git  for_3.11/dt

which is based on top of your for_3.11/dts branch.

Kevin
