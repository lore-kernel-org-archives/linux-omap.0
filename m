From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
Date: Tue, 13 Sep 2011 11:09:47 +0530
Message-ID: <4E6EECA3.4040704@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com> <87y5xteahc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33410 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754140Ab1IMFjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Sep 2011 01:39:54 -0400
Received: by gyf2 with SMTP id 2so171775gyf.41
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 22:39:52 -0700 (PDT)
In-Reply-To: <87y5xteahc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

On Tuesday 13 September 2011 02:36 AM, Kevin Hilman wrote:
> Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
>
>> This patch adds the CPU0 and CPU1 off mode support. CPUX close switch
>> retention (CSWR) is not supported by hardware design.
>>
>> The CPUx OFF mode isn't supported on OMAP4430 ES1.0
>>
>> CPUx sleep code is common for hotplug, suspend and CPUilde.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>
> [...]
>
>> @@ -38,6 +39,11 @@ void __iomem *omap4_get_scu_base(void)
>>
>>   void __cpuinit platform_secondary_init(unsigned int cpu)
>>   {
>> +	/* Enable NS access to SMP bit for this CPU on EMU/HS devices */
>> +	if (cpu_is_omap443x()&&  (omap_type() != OMAP2_DEVICE_TYPE_GP))
>
> A comment here about why this is 443x specific would be helpful.
>
> I see a comment in omap4_cpu_resume() that seems to indicate that SMP
> bit is accessible on 446x NS devices, but repeating that commen here
> would help future readability.
>
Ok. Will add comments here too. Was just trying to save some lines :)

Regards
Santosh
