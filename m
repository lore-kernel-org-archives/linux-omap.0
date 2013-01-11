From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH v4 0/4] pm: Add power off control
Date: Fri, 11 Jan 2013 00:09:56 -0800
Message-ID: <CA+Bv8XbUa7xPd8V7LQCmFbbdQvORUK1X0xBPzAhKUFFjjho2jw@mail.gmail.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13EAD58C2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:50090 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab3AKIJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 03:09:57 -0500
Received: by mail-qc0-f172.google.com with SMTP id b25so945155qca.17
        for <linux-omap@vger.kernel.org>; Fri, 11 Jan 2013 00:09:56 -0800 (PST)
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EAD58C2@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Wed, Jan 2, 2013 at 2:15 AM, AnilKumar, Chimata <anilkumar@ti.com> wrote:
> On Fri, Dec 14, 2012 at 11:33:13, AnilKumar, Chimata wrote:
>> Add PM power_off control to rtc driver and PMIC status is set to
>> STATUS_OFF to shutdown PMIC if PWR_EN is toggled by RTC module.
>>
>> System power off sequence:-
>> * Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
>> * Enable PMIC_POWER_EN in rtc module
>> * Set rtc ALARM2 time
>> * Enable ALARM2 interrupt
>>
>> These patches were tested on am335x-bone (BeagleBone). These patchs
>> are based on linux-next.
>
> Hi All,
>
> Happy New Year
>
> Gentle ping to this series

I personally like the series, it certainly adds needed functionality.
I just wish there was a way to get it without a possible 4 second
delay.

> Thanks
> AnilKumar
>
>> Changes from v3:
>>       - TPS65217 mfd driver changes are accepted so dropped
>>         from this series.
>>       - With recent changes in the kernel, reboot_mutex held BUG()
>>         is not seen so removed while(1); from rtc_power_off.
>>       - Removed spinlock before while(1); which is not necessary.
>>
>> Changes from v2:
>>       - Incorporated Kevin's comment on v2
>>         * Enabled RTC in ompa2plus_defconfig
>>
>> Changes from v1:
>>       - Incorporated Vaibhav's comments on v1
>>         * Changed the time rollover logic with the help of
>>           rtc-lib APIs
>>
>> AnilKumar Ch (3):
>>   ARM: dts: AM33XX: Set pmic-shutdown-controller for BeagleBone
>>   ARM: dts: AM33XX: Enable system power off control in am335x-bone
>>   ARM: OMAP2+: omap2plus_defconfig: Enable RTC support
>>
>> Colin Foe-Parker (1):
>>   rtc: OMAP: Add system pm_power_off to rtc driver
>>
>>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
>>  arch/arm/boot/dts/am335x-bone.dts                  |    6 ++
>>  arch/arm/configs/omap2plus_defconfig               |    1 +
>>  drivers/rtc/rtc-omap.c                             |   74 +++++++++++++++++++-
>>  4 files changed, 85 insertions(+), 1 deletion(-)
>>
>> --
>> 1.7.9.5
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
