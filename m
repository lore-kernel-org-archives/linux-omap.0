From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: am43x: Fix boot with CONFIG_SOC_AM33XX disabled
Date: Thu, 19 Jun 2014 14:33:45 +0300
Message-ID: <53A2CA99.3020609@ti.com>
References: <1403013804-13522-1-git-send-email-rogerq@ti.com> <53A14525.5050208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43438 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757948AbaFSLd3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jun 2014 07:33:29 -0400
In-Reply-To: <53A14525.5050208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, mturquette@linaro.org, tony@atomide.com
Cc: nm@ti.com, linux-omap@vger.kernel.org

On 06/18/2014 10:52 AM, Roger Quadros wrote:
> On 06/17/2014 05:03 PM, Roger Quadros wrote:
>> Define ti_clk_register_dpll_x2() and of_ti_am3_dpll_x2_setup() if
>> AM43XX is defined.
>>
>> Fixes the below boot issue.
>>
>> [    2.157258] gpmc_l3_clk not enabled
>> [    2.161194] gpmc_l3_clk not enabled
>> [    2.164896] Division by zero in kernel.
>> [    2.169055] CPU: 0 PID: 321 Comm: kworker/u2:2 Tainted: G        W     3.16.0-rc1-00008-g4c0e520 #273
>> [    2.178880] Workqueue: deferwq deferred_probe_work_func
>> [    2.184459] [<c001477c>] (unwind_backtrace) from [<c001187c>] (show_stack+0x10/0x14)
>> [    2.192752] [<c001187c>] (show_stack) from [<c0530f28>] (dump_stack+0x80/0x9c)
>> [    2.200486] [<c0530f28>] (dump_stack) from [<c02c867c>] (Ldiv0+0x8/0x10)
>> [    2.207678] [<c02c867c>] (Ldiv0) from [<c0022da0>] (gpmc_calc_divider+0x24/0x40)
>> [    2.215490] [<c0022da0>] (gpmc_calc_divider) from [<c0022e20>] (gpmc_cs_set_timings+0x18/0x474)
>> [    2.224783] [<c0022e20>] (gpmc_cs_set_timings) from [<c003069c>] (gpmc_nand_init+0x74/0x1a8)
>> [    2.233791] [<c003069c>] (gpmc_nand_init) from [<c0024668>] (gpmc_probe+0x52c/0x874)
>> [    2.242089] [<c0024668>] (gpmc_probe) from [<c0349218>] (platform_drv_probe+0x18/0x48)
>> [    2.250534] [<c0349218>] (platform_drv_probe) from [<c0347d88>] (driver_probe_device+0x104/0x22c)
>> [    2.259988] [<c0347d88>] (driver_probe_device) from [<c03464dc>] (bus_for_each_drv+0x44/0x8c)
>> [    2.269087] [<c03464dc>] (bus_for_each_drv) from [<c0347c4c>] (device_attach+0x74/0x8c)
>> [    2.277620] [<c0347c4c>] (device_attach) from [<c0347380>] (bus_probe_device+0x88/0xb0)
>> [    2.286074] [<c0347380>] (bus_probe_device) from [<c0347768>] (deferred_probe_work_func+0x60/0x90)
>> [    2.295611] [<c0347768>] (deferred_probe_work_func) from [<c004ef50>] (process_one_work+0x1b4/0x4bc)
>> [    2.305288] [<c004ef50>] (process_one_work) from [<c004f3d4>] (worker_thread+0x148/0x550)
>> [    2.313954] [<c004f3d4>] (worker_thread) from [<c0055a48>] (kthread+0xc8/0xe4)
>> [    2.321628] [<c0055a48>] (kthread) from [<c000e648>] (ret_from_fork+0x14/0x2c)
>>
>
> Sorry to miss that this was reported by Tony.
>
> Reported-by: Tony Lindgren <tony@atomide.com>

Thanks, queued for 3.16-rc fixes.

-Tero

>
> cheers,
> -roger
>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/clk/ti/dpll.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
>> index abd956d..79791e1 100644
>> --- a/drivers/clk/ti/dpll.c
>> +++ b/drivers/clk/ti/dpll.c
>> @@ -161,7 +161,8 @@ cleanup:
>>   }
>>
>>   #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
>> -	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM33XX)
>> +	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM33XX) || \
>> +	defined(CONFIG_SOC_AM43XX)
>>   /**
>>    * ti_clk_register_dpll_x2 - Registers a DPLLx2 clock
>>    * @node: device node for this clock
>> @@ -322,7 +323,7 @@ CLK_OF_DECLARE(ti_omap4_dpll_x2_clock, "ti,omap4-dpll-x2-clock",
>>   	       of_ti_omap4_dpll_x2_setup);
>>   #endif
>>
>> -#ifdef CONFIG_SOC_AM33XX
>> +#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
>>   static void __init of_ti_am3_dpll_x2_setup(struct device_node *node)
>>   {
>>   	ti_clk_register_dpll_x2(node, &dpll_x2_ck_ops, NULL);
>>
>

