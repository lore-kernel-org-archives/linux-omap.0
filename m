From: Kevin Hilman <khilman@ti.com>
Subject: Re: Latest regressions
Date: Fri, 07 Jan 2011 13:56:35 -0800
Message-ID: <8739p4ml7w.fsf@ti.com>
References: <20110107115744.GL1198@n2100.arm.linux.org.uk>
	<20110107165626.GD880@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41916 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754145Ab1AGV4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 16:56:40 -0500
Received: by mail-iy0-f173.google.com with SMTP id 19so18160801iye.32
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 13:56:39 -0800 (PST)
In-Reply-To: <20110107165626.GD880@atomide.com> (Tony Lindgren's message of
	"Fri, 7 Jan 2011 08:56:26 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110107 03:57]:

[...]

>> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
>> index 0ff1233..ffcdff9 100644
>> --- a/arch/arm/plat-omap/include/plat/voltage.h
>> +++ b/arch/arm/plat-omap/include/plat/voltage.h
>> @@ -14,6 +14,8 @@
>>  #ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
>>  #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
>>  
>> +#include <linux/errno.h>
>> +
>>  #define VOLTSCALE_VPFORCEUPDATE		1
>>  #define VOLTSCALE_VCBYPASS		2
>
> This fix is already queued up by Kevin, but missing..

Yeah, the one in my queue uses <linux/err.h> because of usage of
ERR_PTR(), but fixes the same problem.

>> @@ -133,9 +135,9 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
>>  		int voltscale_method);
>>  int omap_voltage_late_init(void);
>>  #else
>> -static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
>> +static inline void omap_voltage_register_pmic(struct voltagedomain *voltdm,
>>  		struct omap_volt_pmic_info *pmic_info) {}
>> -static inline  void omap_change_voltscale_method(struct voltagedomain *voltdm,
>> +static inline void omap_change_voltscale_method(struct voltagedomain *voltdm,
>>  		int voltscale_method) {}
>>  static inline int omap_voltage_late_init(void)
>>  {
>
> ..this change.

And this is fixed in my queue as well, but differently.  Instead of
changing to void, it keeps the int return value and returns -EINVAL.

Will be sending pull request for my queue of fixes shortly, after a
little more build/boot testing.

Kevin
