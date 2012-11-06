From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 2/4] rtc: OMAP: Add system pm_power_off to rtc driver
Date: Tue, 6 Nov 2012 17:56:54 +0100
Message-ID: <50994156.4080305@ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com> <1352108549-9341-3-git-send-email-anilkumar@ti.com> <5097ECAD.9010101@ti.com> <331ABD5ECB02734CA317220B2BBEABC13EA64F14@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38385 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387Ab2KFQ5q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 11:57:46 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA64F14@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Colin Foe-Parker <colin.foeparker@logicpd.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

Hi Anil,

On 11/06/2012 06:07 AM, AnilKumar, Chimata wrote:
> On Mon, Nov 05, 2012 at 22:13:25, Cousson, Benoit wrote:
>> Hi Anil / Colin,
>>
>> On 11/05/2012 10:42 AM, AnilKumar Ch wrote:
>>> From: Colin Foe-Parker <colin.foeparker@logicpd.com>
>>>
>>> Add system power off control to rtc driver which is the in-charge
>>> of controlling the BeagleBone system power. The power_off routine
>>> can be hooked up to "pm_power_off" system call.
>>>
>>> System power off sequence:-
>>> * Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
>>> * Enable PMIC_POWER_EN in rtc module
>>> * Set rtc ALARM2 time
>>> * Enable ALARM2 interrupt
>>>
>>> Added while (1); after the above steps to make sure that no other
>>> process acquire cpu. Otherwise we might see an unexpected behaviour
>>> because we are shutting down all the power rails of SoC except RTC.
>>>
>>> Signed-off-by: Colin Foe-Parker <colin.foeparker@logicpd.com>
>>> [anilkumar@ti.com: move poweroff additions to rtc driver]
>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
>>>  drivers/rtc/rtc-omap.c                             |   79 +++++++++++++++++++-
>>>  2 files changed, 83 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>>> index b47aa41..8d9f4f9 100644
>>> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>>> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>>> @@ -6,6 +6,10 @@ Required properties:
>>>  - interrupts: rtc timer, alarm interrupts in order
>>>  - interrupt-parent: phandle for the interrupt controller
>>>  
>>> +Optional properties:
>>> +- ti,system-power-controller: Telling whether or not rtc is controlling
>>> +  the system power.
>>
>> I don't know how it is connected at board level, but I'm not sure the
>> binding is the proper one.
> 
> Hi Benoit,
>  ________________________________
> |   ______          _______      |
> |  |      |        |       |     |
> |  |RTC   |        |       |     |
> |  |PMIC  |  Line  |       |     |
> |  |PWR_EN|=======>|PWR_EN |     |
> |  |______|        |_______|     |
> |  AM335x SoC       TPS65217     |
> |                                |
> |________________________________|
>           BeagleBone
> 
> This is how RTC PMIC_PWR_EN is connected to PWR_EN of TPS65217 PMIC. Only when
> RTC pull low in PMIC_PWR_EN then PMIC will go to power off state provided TPS65217
> status should be changed to STATUS_OFF.
> 
> ALARM2 event should be trigger to configure PMIC_PWR_EN properly then the "Line"
> driven low so that PMIC will go to shutdown mode.

Thanks for the nice diagram :-)

I'm wondering if we cannot abuse the gpio binding to describe that
connection instead of creating two custom attributes (PMIC + RTC).

Ideally we should do that without having to change the RTC to use the
gpiolib at all.


rtc: rtc@44e3e000 {
	compatible = "ti,da830-rtc";
	reg = <0x44e3e000 0x1000>;
	interrupts = <75, 76>;
	ti,hwmods = "rtc";

	/* expose the PWR_EN functionality of this RTC*/
	gpio-controller;
	#gpio-cells = <0>; /* assuming we can use 0 ??? */
};

...

tps: tps@24 {
 	compatible = "ti,tps65217";
	/*
         * Enable the power enable feature from
         * the input line if that attribute is there.
         */
	gpio-power-en = <&rtc>; /* PWR_EN */

	...
}	

Any thought?

Regards,
Benoit



