From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
Date: Tue, 08 Mar 2011 18:16:10 +0530
Message-ID: <4D762512.6060503@ti.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com> <1298483913-20344-4-git-send-email-premi@ti.com> <6356620acee7ee78af7da3906b0ea78a@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593024C0E5D33@dbde02.ent.ti.com> <c8691dfff1a8ded9676c2f63d8e896c0@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593024C0E6349@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:37545 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753589Ab1CHMqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 07:46:16 -0500
Received: by mail-yi0-f47.google.com with SMTP id 13so2009078yia.6
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 04:46:15 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C0E6349@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev wrote, on 03/08/2011 05:56 PM:
[...]
>>>>>
>>>>> Add glue logic to hook-up AM35x processors
>>>>> with TPS65023.
>>>> It seems that you are not really using Voltage layer for any
>> interaction
>>>> with TPS65023 as you are not using VP and VC. Then what is the
>>> purpose of
>>>> registering this PMIC with Voltage layer. I fail to understand the
>>> purpose
>>>> of this patch series.
>>>
>>> [sp] Then, can you suggest how do I get the AM35x EVM to boot? Given
>>> the
>>>       current limitation of all voltage related data being "extracted"
>> from
>>>       the voltage layer - which expects only TWLx0y0 PMICs.
>> Pls use regulator framework for setting the voltage for your PMIC.
>
> [sp] If you follow the current framework, voltage.c is ingrained with
> OMAP3 initialization and same holds good for opp[_3xxx_data].c.
>
> It would have been great if current implementation allowed pluggable
> interface to a PMIC. As it stands today, it isn't.
Partly true - there are PMIC abstractions that have been attempted in 
current voltage layer - but only TWL is used - so yep, implementation 
probably needs evolution and yes again that TPS here is a perfect choice 
to make the implementation generic and scalable.

>
> Until implemented, workarounds have to be put in place to get platform(s)
> working. Though patch series is being done for AM35x with TPS65023. The
> similar workaround would be required for OMAP3 with TPS65023 (for example).
>
> ...and I expect workaround to be simple and unobtrusive.
>
> See:
> core_initcall(omap_voltage_early_init);
> device_initcall(omap3_opp_init);
> late_initcall(omap2_common_pm_late_init);

Thinking from a generic soln perspective, lets try and split this into 
multiple issues:
a) OPP and Voltage layer voltages - these need to be PMIC aware as well. 
See my comment on http://marc.info/?l=linux-omap&m=129955003611548&w=2 
-> essentially means that pmic_voltage information should be registered 
earlier to opp init

b) split up structure information for voltage layer - this should be 
done in a manner to make PMIC, Board and OMAP SoC information independent.

c) Ability to plug in multiple PMICs in two manners:
    i) use PMIC with VC/VP/SR combinations.
    ii) use PMIC which is plugged on regulator frameworks.

If anyone is attempting cleanups, it might be a good idea to base on the 
accepted cleanups from pm-core branch which is planned for 39-rc1 to 
prevent any surprises ;)

-- 
Regards,
Nishanth Menon
