From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 12/15] ARM: OMAP4+: CPUidle: Cleanup idle driver for OMAP5
 support
Date: Sat, 2 Mar 2013 11:55:52 +0530
Message-ID: <51319B70.4090306@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com> <1362139864-9233-13-git-send-email-santosh.shilimkar@ti.com> <20130301235658.GD23856@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44264 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab3CBGYX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Mar 2013 01:24:23 -0500
In-Reply-To: <20130301235658.GD23856@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On Saturday 02 March 2013 05:26 AM, Nishanth Menon wrote:
> On 17:41-20130301, Santosh Shilimkar wrote:
>> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
>> index 9de47a7..df81243 100644
>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> [...]
>> @@ -234,11 +237,12 @@ int __init omap4_idle_init(void)
>>  	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
>>  
>>  	for_each_cpu(cpu_id, cpu_online_mask) {
>> -		dev = &per_cpu(omap4_idle_dev, cpu_id);
>> +		dev = &per_cpu(omap_idle_dev, cpu_id);
>>  		dev->cpu = cpu_id;
>>  #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>>  		dev->coupled_cpus = *cpu_online_mask;
>>  #endif
>> +		state_ptr = &omap4_idle_data[0];
> minor:
> why initialize it twice (cpu0 and cpu1) to the same pointer in each of
> the for_each_cpu loop? you could move it maybe just before the loop?
Good point 
>>  		cpuidle_register_driver(&omap4_idle_driver);
>>  
>>  		if (cpuidle_register_device(dev)) {
> Otherwise,
> Acked-by: Nishanth Menon <nm@ti.com>
> 
Thanks
