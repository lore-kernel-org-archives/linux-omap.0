From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP4: Intialize IVA Device in addition to DSP device.
Date: Thu, 10 Mar 2011 19:25:44 +0530
Message-ID: <4D78D860.2050609@ti.com>
References: <1299738148-28557-1-git-send-email-shweta.gulati@ti.com> <fc1162b5d4e1a7deb77aa800a3e8fdb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:33703 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751125Ab1CJNzw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 08:55:52 -0500
Received: by mail-vw0-f42.google.com with SMTP id 10so2984359vws.1
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 05:55:51 -0800 (PST)
In-Reply-To: <fc1162b5d4e1a7deb77aa800a3e8fdb3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Shweta Gulati <shweta.gulati@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Few cosmetic comments follow:
Vishwanath Sripathy wrote, on 03/10/2011 02:36 PM:
>> -----Original Message-----
>> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-
>> kernel-bounces@lists.infradead.org] On Behalf Of Shweta Gulati
>> Sent: Thursday, March 10, 2011 11:52 AM
>> To: linux-omap@vger.kernel.org
>> Cc: Shweta Gulati; linux-arm-kernel@lists.infradead.org
>> Subject: [PATCH] OMAP4: Intialize IVA Device in addition to DSP device.
>>
>> OMAP4 has two different Devices IVA and DSP. DSP is bound
>> with MPU for DVFS and IVA has its own well defined OPPs.
> DSP is not in MPU voltage domain. DSP(Tesla) and IVAHD are in the same
> voltage domain. Pls correct this in the commit log.
True for OMAP4 - DSP and MPU DVFS are independent, in OMAP3, they were 
scaled together ;)

[...]
>> This Patch adds IVA init to 'omap2_init_processor_devices'
>> and make sure that API 'omap2_set_init_voltage' is called
>> for apt dev pointer.

set_init_voltage error is just one symptom of the problem. infact, if we 
wanted to do anything with iva - e.g. dvfs, we would'nt have been able 
to without the device being registered.

>>
>> It fixes Error logs:
"This also fixes the following error seen during boot as 
omap2_set_init_voltage can now find the iva device" is better than the 
"This patch...."?
>>
>> 	omap2_set_init_voltage: Invalid parameters!
>> 	omap2_set_init_voltage: Unable to put vdd_iva to its init voltage

Thanks for catching and fixing this - I had noticed this in my SR 1.5 
testing(should have posted as well), but had'nt tried to dig further.

>>
>> Tested on OMAP4430 SDP Board.
>> Baseline:
>> http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-
>> pm.git
>> Branch :pm-core
Do you really want this information in commit log? I suggest you move 
this to the diffstat section.

>>
>> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
>> ---
>>   arch/arm/mach-omap2/pm.c |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index 30af335..49486f5 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -89,6 +89,7 @@ static void omap2_init_processor_devices(void)
>>   	if (cpu_is_omap44xx()) {
>>   		_init_omap_device("l3_main_1",&l3_dev);
>>   		_init_omap_device("dsp",&dsp_dev);
>> +		_init_omap_device("iva",&iva_dev);
>>   	} else {
>>   		_init_omap_device("l3_main",&l3_dev);
>>   	}



-- 
Regards,
Nishanth Menon
