From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/5] irqchip: kill the GIC routable domain
Date: Wed, 10 Dec 2014 12:21:46 -0600
Message-ID: <54888F3A.5010800@ti.com>
References: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com> <20141207171646.GA12049@kahuna> <20141207180322.GA15688@kahuna> <54856B21.6070104@arm.com> <20141208224116.GA2538@kahuna> <5486C6A6.8060702@arm.com> <20141209181719.GA2569@kahuna> <54874223.2000805@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59139 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414AbaLJSWb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Dec 2014 13:22:31 -0500
In-Reply-To: <54874223.2000805@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stefan Agner <stefan@agner.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 12/09/2014 12:40 PM, Marc Zyngier wrote:
> On 09/12/14 18:17, Nishanth Menon wrote:
>> On 09:53-20141209, Marc Zyngier wrote:
>>> On 08/12/14 22:41, Nishanth Menon wrote:
>>>
>>>> Anyways.. The following diff[1] on top of your branch makes DRA7 work - I
>>>> assume you will squash as needed and repost with linux-omap mailing list
>>>> in CC.
>>>
>>> Brilliant. I'll squash that into my tree and repost at some point.
>>
>> K, it will be nice to have a reflow of the series based on v3.19-rc1
>> since there are dts dependencies and we dont want folks to have
>> regressions on their platforms of choice..
>>
>> Obviously, my tests are basic boot tests and should get a few weeks(as
>> you already mentioned) on linux-next to get properly soaked
>>
>>>
>>>> I increased the scope of testing knowing that WUGEN is present in many
>>>> A9 based TI platforms as well.. and at least OMAP4 showed flakiness in
>>>> my testing.. Also a few notes:
>>>>
>>>> Stuff like: am437x is a bit questionable (interrupt-parent probably should be wugen?)
>>>> 175:          0       GIC  39  tps65218 
>>>>
>>>> OMAP5: (should be wugen?)
>>>> 308:       4323          0       GIC 106  OMAP UART2
>>>> 411:          0          0       GIC 151  twl6040
>>>> 405:          1          0       GIC  39  palmas
>>>
>>> Well, I can't really tell. Someone with access to the documentation
>>> should be able to find out.
>>
>> AM437x: http://www.ti.com/lit/pdf/spruhl7
>> OMAP5: http://www.ti.com/lit/pdf/swpu249
>>
>> yeah, we should be able to do them as well - trivially since they follow
>> the same structure as other SoCs without crossbar.
> 
> Done some stuff in that department.
> 
>>>
>>>> OMAP4 serial port is flaky -> not sure if it is due to routing of GIC to UART2 and not via WUGEN
>>>> IRQ branch: with my fix applied:
>>>> ---------------------------------
>>>
>>> [...]
>>>
>>>> 18: pandaboard-es:  Boot FAIL: http://slexy.org/raw/s20ty0Z6i5 (not expected)
>>>> 19: pandaboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20BYfaMd2 (not expected)
>>>
>>> If I read the log correctly, the serial port stops responding after a while?
>>
>> yeah - dug at the omap4 ones a bit, obviously once the deeper c states
>> are hit, we'd like wakeupgen to wakeup CPU else we will be "sluggish" in
>> the sense that the event is detected when some other wakeupgen enabled
>> interrupt takes place.
> 
> I realised that as well once I got a panda up and running.
> 
>> Adding the following makes my panda work fine.
>> 1: pandaboard-es:  Boot PASS: http://slexy.org/raw/s20o8DaBvh
>> 2: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s222JndDdh
>>
>>
>> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
>> index 1505135..8b6d50e 100644
>> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
>> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
>> @@ -371,8 +371,8 @@
>>  	twl: twl@48 {
>>  		reg = <0x48>;
>>  		/* IRQ# = 7 */
>> -		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
>> -		interrupt-parent = <&gic>;
>> +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to wakeupgen to gic */
>> +		interrupt-parent = <&wakeupgen>;
>>  	};
> 
> [...]
> 
> I already fixed those in my tree, in a slightly different way: no need
> to have an interrupt parent at all, as we're going to inherit the
> default anyway.
> 
> I've pushed another version of the branch, with the crossbar rework
> sitting *before* the WUGEN hacks. That should hopefully make bisection work.
> 
> If you can give it a shake, that'd be most appreciated. I'll repost the
> branch in a couple of days.
> 

Did a quick run.. and thought of testing power management and found
that CPUFreq for my platforms are broken in v3.18-rc7 and my scripts
broke (so much for my cronjob testing daily boot... now I gotta add
some PM test as well.. Sigh..) anyways.. just boot log..

based on
irq/die-gic-arch-extn-die-die-die c0024cb irqchip: gic: Drop support
for gic_arch_extn


 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s201YeK4dW
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s20nydiyVx
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s2aTrenePo
 4:  am437x-sk:  Boot FAIL: http://slexy.org/raw/s20NNiEa4W
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2gghhhyOy
 6: am43xx-gpevm:  Boot PASS: http://slexy.org/raw/s2LY4Cb75N
 7: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2e8iJMUXu
 8: beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s20wqxUmvr
 9: beaglebone-black:  Boot PASS: http://slexy.org/raw/s21I0g2Ba3
10: beaglebone:  Boot PASS: http://slexy.org/raw/s2lpED0qW4
11: craneboard:  Boot PASS: http://slexy.org/raw/s230RKflY3
12: dra72x-evm:  Boot FAIL: http://slexy.org/raw/s21fWVnjaB
13: dra7xx-evm:  Boot PASS: http://slexy.org/raw/s20yEhfruO
14: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s20qZaXwz0
15:       n900:  Boot PASS: http://slexy.org/raw/s21LNTXZP7
16:  omap5-evm:  Boot PASS: http://slexy.org/raw/s2WF8eAcK2
17: pandaboard-es:  Boot PASS: http://slexy.org/raw/s21PVo7ENF
18: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2BcMbSrVF
19:    sdp2430:  Boot PASS: http://slexy.org/raw/s24LgXbav1
20:    sdp3430:  Boot PASS: http://slexy.org/raw/s21IaKdkUs
TOTAL = 20 boards, Booted Boards = 18, No Boot boards = 2


will try to first try and save a bit of cpufreq and reinstate my
scripts and once you post based on 3.19-rc1, will do a retest..

-- 
Regards,
Nishanth Menon
