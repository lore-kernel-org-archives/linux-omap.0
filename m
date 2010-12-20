From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 4/7] OMAP3630: PM: Erratum i608: disable RTA
Date: Mon, 20 Dec 2010 08:45:31 -0600
Message-ID: <4D0F6C0B.8010100@ti.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>	<1292712817-24999-5-git-send-email-nm@ti.com> <AANLkTims4Hfzyh-MpTZKpwROwAH5DCGo2FQBJd9DKcQt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53806 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932314Ab0LTOpf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 09:45:35 -0500
Received: by gyf3 with SMTP id 3so1310710gyf.13
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 06:45:34 -0800 (PST)
In-Reply-To: <AANLkTims4Hfzyh-MpTZKpwROwAH5DCGo2FQBJd9DKcQt@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

Jean Pihet had written, on 12/20/2010 04:27 AM, the following:
[..]
>> Workaround is to disable RTA on boot and coming out of core off.
>> For disabling rta coming out of off mode, we do this by overriding the
> Use caps for RTA
Thanks. done.
> 
>> restore pointer for 3630 to allow us restore handler as the first point of
> This is not clear, maybe 'to allow us to restore handler' needs to be removed.
Thanks. done.

> 
>> entry before caches are touched and is common for GP and HS devices.
>> to disable earlier than this could be possible by modifying the ppa for HS
> Same here, it looks like the original sentence has been cut in pieces.
> Use caps for PPA.
Thanks. done.
[..]
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 5702f41..b32a2ed 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
[..]
>> @@ -1067,6 +1069,14 @@ static int __init omap3_pm_init(void)
>>        pm_idle = omap3_pm_idle;
>>        omap3_idle_init();
>>
>> +       /*
>> +        * RTA is disabled during initialization as per erratum i608
>> +        * it is safer to disable rta by the bootloader, but we would like
> Use caps for RTA
thanks. Done.

>> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
>> index 3fbd1e5..cc3507b 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S

[..]
>> +restore_3630:
>> +       /*b restore_es3630*/            @ Enable to debug restore code
>> +       ldr     r1, pm_prepwstst_core_p
>> +       ldr     r2, [r1]
>> +       and     r2, r2, #0x3
>> +       cmp     r2, #0x0        @ Check if previous power state of CORE is OFF
>> +       bne     restore
>> +       /* Disable rta before giving control */
> Use caps for RTA
Thanks. Done.
[..]


-- 
Regards,
Nishanth Menon
