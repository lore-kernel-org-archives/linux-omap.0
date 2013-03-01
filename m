From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: DT GPMC SRAM and NOR flash support ?
Date: Fri, 1 Mar 2013 16:23:22 -0600
Message-ID: <51312A5A.8020609@ti.com>
References: <510BF3D3.3000304@mimc.co.uk> <510BF766.5090608@ti.com> <510C19FC.8090906@mimc.co.uk> <5111304C.7090706@mimc.co.uk> <511134C8.8000008@ti.com> <511137CF.1090706@mimc.co.uk> <51113C74.4070607@ti.com> <51137923.4070301@mimc.co.uk> <511C007A.7080103@ti.com> <CALF0-+U6ynTvM0wzBnz2oWDSWQnZ_+1u44Wd-rLL+3qFEt8-2Q@mail.gmail.com> <CALF0-+WqTwCErUdbTg-Spp6Z6BGXfZzPepgcAVTJwqup8mSdoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36324 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3CAWX1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 17:23:27 -0500
In-Reply-To: <CALF0-+WqTwCErUdbTg-Spp6Z6BGXfZzPepgcAVTJwqup8mSdoQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Afzal Mohammed <afzal@ti.com>


On 03/01/2013 03:42 PM, Ezequiel Garcia wrote:
> On Fri, Mar 1, 2013 at 6:08 PM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
>> Hi Jon,
>>
>> Yet more questions :-) See below...
>>
>> On Wed, Feb 13, 2013 at 7:07 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>>
>>>
>>> You don't need this extra entry if you add "simple-bus" to
>>> the gpmc node compatible string.
>>>
>>> +               gpmc: gpmc@6800a000 {
>>> +                       compatible = "ti,omap2420-gpmc", "simple-bus";
>>> +                       ti,hwmods = "gpmc";
>>> +                       reg = <0x6800a000 0x1000>;
>>> +                       interrupts = <20>;
>>> +
>>
>> This "simple-bus" trick is great and very clean!
>>
>> I'm working on a new driver, similar to gpmc, called device-bus for Marvell SoC.
>> One remarkable difference is that I need to *setup* the address space
>> (sort of allocate the address region) for a child device, before I can
>> access it.
>>
>> Using simple-bus is a very clean solution. However I'm facing a strange issue:
>> the child (physmap driver) probe() is being called *before* the parent
>> (device-bus driver)
>> probe(), and so the flash device address space cannot get accessed because
>> it hasn't been setup yet.
>>
> 
> Ok, now I think I understand that my problem has nothing to do with simple-bus,
> but instead related to the driver probing order.
> 
> The physmap driver is just being probed before the device bus driver, and so it
> won't work.
> 
> Now: is there any clean solution?

I can't say I understand why if it is a child device. I have just posted
a series this week to enable NOR support for OMAP with DT [1].

Cheers
Jon

[1] http://permalink.gmane.org/gmane.linux.ports.arm.omap/94378

