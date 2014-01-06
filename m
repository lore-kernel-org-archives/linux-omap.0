From: Nishanth Menon <nm@ti.com>
Subject: Re: omap4 and cpufreq
Date: Mon, 6 Jan 2014 16:43:33 -0600
Message-ID: <52CB3195.6030109@ti.com>
References: <CAGhQ9Vzx-WyCHUurK-2vxS0i_T3SCGGnhq3FfKGhGzbMCeYAqA@mail.gmail.com>	<52CAD9C2.2020307@ti.com>	<CAGhQ9Vy1mja7-F0a4v9gBQ5naPmRoxNv6GZgjqZ30dhVfD7q8w@mail.gmail.com>	<52CB27E0.6080408@ti.com> <CAGhQ9VztnCPWpyN-yMkjLMPuW3Nk1PR5mEzVdjaAKbmwkW+3Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37756 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932243AbaAFWnf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jan 2014 17:43:35 -0500
In-Reply-To: <CAGhQ9VztnCPWpyN-yMkjLMPuW3Nk1PR5mEzVdjaAKbmwkW+3Lg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: linux-omap@vger.kernel.org

On 01/06/2014 04:24 PM, Joachim Eastwood wrote:
> On 6 January 2014 23:02, Nishanth Menon <nm@ti.com> wrote:
>> On 01/06/2014 03:51 PM, Joachim Eastwood wrote:
>>> On 6 January 2014 17:28, Nishanth Menon <nm@ti.com> wrote:
>>>> On 01/01/2014 04:37 PM, Joachim Eastwood wrote:
>> [...]
>>>>> I assume this would work but I don't have a 4430 board to test it on.
>>>>> Unsure about voltage range, but at least 1.0 to 1.4V covers the operation
>>>>> points for cpu in omap443xx.dtsi.
>>>> This will not work. 6030 does not allow voltage to be set over i2c1,
>>>> needs voltage controller/processor to work.
>>>
>>> Well, it allows the LDO regulators to be changed over i2c, but I guess
>>> the SMPS regulators are different.
>>
>> yes, they are different control paths. To give a relative history:
>>
>> (OMAP3)TWL5030 -> we can control SMPS from either i2c1 OR i2c_SR by
>> flipping a control bit - but only one path at a time.
>> (OMAP4)TWL6030 -> only i2c_SR control allowed for SMPS
>> (OMAP5)Palmas family -> we can control using i2c1 or i2c_SR -> so no
>> real need for using voltage controller for SMPS.
>>
>> that said, it is necessary to use SR path to ensure that AVS also
>> functions. which requires on OMAP4,3 to use i2c_SR.
> 
> I see.
> 
> Just one question regarding the tps63261 on 4460.
> What good is the gpio pin most boards have connected to the tps
> regulator (vsel1) when it can be controlled with i2c_SR?


TPS63261 has two registers that could be used for voltage selection -
VSEL0, VSEL1. the reason for using GPIO to force select VSEL1 and do
dvfs using that register is as follows:
* MPU supports OPP50 which uses voltage lower than necessary for
booting the device up.
* boot voltage for vdd_mpu is hardcoded by default into VSEL0.
* if we were to use VSEL0 register for DVFS and then do a reboot OR
have a watchdog trigger at OPP50, the device will not boot up since
the voltage will be at OPP50 voltage.
* if we were to use VSEL1 register selected by GPIO for DVFS and then
do a reboot OR have a watchdog trigger at OPP50, GPIO is reset back to
selecting VSEL0 on TPS and the device will boot up since the voltage
will be at OPP_BOOT voltage.

Now, with additional discrete circuitry, it is possible to ensure that
TPS is also reset on a warm_reset trigger, but the additional cost for
discretes were not... umm... attractive for customer board designs.
(yet another instance of "if you can do it in software, why add
hardware cost?)..


> 
> I have seen the pin being used in the u-boot code. So is it just for
> initial boot or would Linux also use it as well?

eventually, yes - our product kernels have these ofcourse for reason
mentioned above - and when we get this code eventually in upstream, it
will have to support VSEL1 based operation.

-- 
Regards,
Nishanth Menon
