From: sourav <sourav.poddar@ti.com>
Subject: Re: AM437x-epos (next-20140409-omap2plus_defconfig) - boot time warning:
 qspi/otg..
Date: Wed, 9 Apr 2014 18:25:23 +0530
Message-ID: <5345433B.3090503@ti.com>
References: <53453FF1.60803@ti.com> <53454207.4070108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46557 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932597AbaDIMz1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Apr 2014 08:55:27 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id s39CtRlm029195
	for <linux-omap@vger.kernel.org>; Wed, 9 Apr 2014 07:55:27 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s39CtQ61010211
	for <linux-omap@vger.kernel.org>; Wed, 9 Apr 2014 07:55:27 -0500
In-Reply-To: <53454207.4070108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, George Cherian <george.cherian@ti.com>

Hi Nishanth,

The dts date were posted but due to some functional changes going in spi 
core,
the dts data were not picked(predictiong some changes in dt parameters). 
I will
send a minimal qspi node during rc cycle to get rid of this warning.

On Wednesday 09 April 2014 06:20 PM, Roger Quadros wrote:
> +George
>
> Hi Nishant,
>
> I remember George had sent patches to add USB DT nodes for am43xx.
> Looks like they didn't get through.
>
> Adding the USB nodes should get rid of the warning.
>
> George,
>
> Can you please resend a minimal set to fix this warning for -rc? Thanks.
>
> cheers,
> -roger
>
> On 04/09/2014 03:41 PM, Nishanth Menon wrote:
>> Hi,
>> http://slexy.org/raw/s2pkLsiFBX
>>
>> I noticed the following sets of warnings with omap2plus_defconfig on
>> next-20140409. As per older logs, next-20140401 had it and v3.14 tag
>> also had it (I have'nt retained older logs).
>>
>>   [    0.226189] ------------[ cut here ]------------
>>   [    0.226258] WARNING: CPU: 0 PID: 1 at
>> arch/arm/mach-omap2/omap_hwmod.c:2538 _init+0x1c0/0x3e0()
>>   [    0.226277] omap_hwmod: qspi: doesn't have mpu register target base
>>   [    0.226290] Modules linked in:
>>   [    0.226317] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>> 3.14.0-next-20140409-00006-g0fbfc2e #1
>>   [    0.226389] [<c0014cd0>] (unwind_backtrace) from [<c001195c>]
>> (show_stack+0x10/0x14)
>>   [    0.226441] [<c001195c>] (show_stack) from [<c053cf68>]
>> (dump_stack+0x78/0x94)
>>   [    0.226478] [<c053cf68>] (dump_stack) from [<c003fc20>]
>> (warn_slowpath_common+0x6c/0x8c)
>>   [    0.226504] [<c003fc20>] (warn_slowpath_common) from [<c003fcd4>]
>> (warn_slowpath_fmt+0x30/0x40)
>>   [    0.226535] [<c003fcd4>] (warn_slowpath_fmt) from [<c07a0b70>]
>> (_init+0x1c0/0x3e0)
>>   [    0.226569] [<c07a0b70>] (_init) from [<c0028068>]
>> (omap_hwmod_for_each+0x34/0x5c)
>>   [    0.226598] [<c0028068>] (omap_hwmod_for_each) from [<c07a12e8>]
>> (__omap_hwmod_setup_all+0x24/0x40)
>>   [    0.226624] [<c07a12e8>] (__omap_hwmod_setup_all) from
>> [<c0008ab8>] (do_one_initcall+0x34/0x15c)
>>   [    0.226659] [<c0008ab8>] (do_one_initcall) from [<c0794bf4>]
>> (kernel_init_freeable+0xfc/0x1cc)
>>   [    0.226687] [<c0794bf4>] (kernel_init_freeable) from [<c05378fc>]
>> (kernel_init+0x8/0xe4)
>>   [    0.226721] [<c05378fc>] (kernel_init) from [<c000e6e8>]
>> (ret_from_fork+0x14/0x2c)
>>   [    0.226930] ---[ end trace 6ef0f5570cfcc358 ]---
>>   [    0.264599] omap_hwmod: tptc0 using broken dt data from edma
>>   [    0.265247] omap_hwmod: tptc1 using broken dt data from edma
>>   [    0.265871] omap_hwmod: tptc2 using broken dt data from edma
>>   [    0.274961] ------------[ cut here ]------------
>>   [    0.275029] WARNING: CPU: 0 PID: 1 at
>> arch/arm/mach-omap2/omap_hwmod.c:2538 _init+0x1c0/0x3e0()
>>   [    0.275048] omap_hwmod: usb_otg_ss0: doesn't have mpu register
>> target base
>>   [    0.275058] Modules linked in:
>>   [    0.275087] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
>> 3.14.0-next-20140409-00006-g0fbfc2e #1
>>   [    0.275158] [<c0014cd0>] (unwind_backtrace) from [<c001195c>]
>> (show_stack+0x10/0x14)
>>   [    0.275209] [<c001195c>] (show_stack) from [<c053cf68>]
>> (dump_stack+0x78/0x94)
>>   [    0.275248] [<c053cf68>] (dump_stack) from [<c003fc20>]
>> (warn_slowpath_common+0x6c/0x8c)
>>   [    0.275274] [<c003fc20>] (warn_slowpath_common) from [<c003fcd4>]
>> (warn_slowpath_fmt+0x30/0x40)
>>   [    0.275307] [<c003fcd4>] (warn_slowpath_fmt) from [<c07a0b70>]
>> (_init+0x1c0/0x3e0)
>>   [    0.275344] [<c07a0b70>] (_init) from [<c0028068>]
>> (omap_hwmod_for_each+0x34/0x5c)
>>   [    0.275376] [<c0028068>] (omap_hwmod_for_each) from [<c07a12e8>]
>> (__omap_hwmod_setup_all+0x24/0x40)
>>   [    0.275405] [<c07a12e8>] (__omap_hwmod_setup_all) from
>> [<c0008ab8>] (do_one_initcall+0x34/0x15c)
>>   [    0.275440] [<c0008ab8>] (do_one_initcall) from [<c0794bf4>]
>> (kernel_init_freeable+0xfc/0x1cc)
>>   [    0.275468] [<c0794bf4>] (kernel_init_freeable) from [<c05378fc>]
>> (kernel_init+0x8/0xe4)
>>   [    0.275501] [<c05378fc>] (kernel_init) from [<c000e6e8>]
>> (ret_from_fork+0x14/0x2c)
>>   [    0.275517] ---[ end trace 6ef0f5570cfcc359 ]---
>>   [    0.276726] ------------[ cut here ]------------
>>   [    0.276777] WARNING: CPU: 0 PID: 1 at
>> arch/arm/mach-omap2/omap_hwmod.c:2538 _init+0x1c0/0x3e0()
>>   [    0.276791] omap_hwmod: usb_otg_ss1: doesn't have mpu register
>> target base
>>   [    0.276802] Modules linked in:
>>   [    0.276826] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
>> 3.14.0-next-20140409-00006-g0fbfc2e #1
>>   [    0.276891] [<c0014cd0>] (unwind_backtrace) from [<c001195c>]
>> (show_stack+0x10/0x14)
>>   [    0.276938] [<c001195c>] (show_stack) from [<c053cf68>]
>> (dump_stack+0x78/0x94)
>>   [    0.276974] [<c053cf68>] (dump_stack) from [<c003fc20>]
>> (warn_slowpath_common+0x6c/0x8c)
>>   [    0.276999] [<c003fc20>] (warn_slowpath_common) from [<c003fcd4>]
>> (warn_slowpath_fmt+0x30/0x40)
>>   [    0.277030] [<c003fcd4>] (warn_slowpath_fmt) from [<c07a0b70>]
>> (_init+0x1c0/0x3e0)
>>   [    0.277064] [<c07a0b70>] (_init) from [<c0028068>]
>> (omap_hwmod_for_each+0x34/0x5c)
>>   [    0.277095] [<c0028068>] (omap_hwmod_for_each) from [<c07a12e8>]
>> (__omap_hwmod_setup_all+0x24/0x40)
>>   [    0.277121] [<c07a12e8>] (__omap_hwmod_setup_all) from
>> [<c0008ab8>] (do_one_initcall+0x34/0x15c)
>>   [    0.277158] [<c0008ab8>] (do_one_initcall) from [<c0794bf4>]
>> (kernel_init_freeable+0xfc/0x1cc)
>>   [    0.277186] [<c0794bf4>] (kernel_init_freeable) from [<c05378fc>]
>> (kernel_init+0x8/0xe4)
>>   [    0.277219] [<c05378fc>] (kernel_init) from [<c000e6e8>]
>> (ret_from_fork+0x14/0x2c)
>>   [    0.277234] ---[ end trace 6ef0f5570cfcc35a ]---
>>

