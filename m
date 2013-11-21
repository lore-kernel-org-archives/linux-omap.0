From: Nishanth Menon <nm@ti.com>
Subject: Re: AM335x board with disabled RTC crashes
Date: Wed, 20 Nov 2013 23:52:21 -0600
Message-ID: <528D9F95.8020403@ti.com>
References: <528CC4CB.4000609@gmail.com> <528CC5C3.2010905@ti.com> <528CDAF6.7070905@ti.com> <528D8C08.1020201@gmail.com> <528D8CF0.1050406@roese.nl> <20131121053006.GA19129@kahuna> <528D9D2A.7040609@roese.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47479 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782Ab3KUFwh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Nov 2013 00:52:37 -0500
In-Reply-To: <528D9D2A.7040609@roese.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <mail@roese.nl>
Cc: Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "tony@atomide.com" <tony@atomide.com>, Suman Anna <s-anna@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On 11/20/2013 11:42 PM, Stefan Roese wrote:
> Thanks Nishanth!
> 
> On 11/21/2013 06:30 AM, Nishanth Menon wrote:
>>> This (hacky) patch works, but I'm not sure if this is acceptable upstream:
>>>
>>> am335x-board_foo.dts:
>>>
>>> ...
>>>
>>> &rtc {
>>> 	reg = <0x0 0x0>;
>>> };
>>>
>> You should be able to achieve the same effect as following (example from
>> BBB) - though I dont see this defined in
>> Documentation/devicetree/bindings/arm/omap/omap.txt
>>
>> I will allow the wisdom of others to comment better here :)
>> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
>> index 6b71ad9..a734ef4 100644
>> --- a/arch/arm/boot/dts/am335x-boneblack.dts
>> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
>> @@ -66,6 +66,11 @@
>>  	status = "okay";
>>  };
>>  
>> +&am335xrtc {
>> +	status = "disabled";
>> +	ti,hwmods="disabled";
>> +};
> 
> Yes, this works too. Thanks.
> 
> Which leaves only the quite ugly WARN() resulting from Suman's patch:
> 
> [    0.230270] omap_hwmod: rtc: Could not ioremap
> [    0.234962] ------------[ cut here ]------------
> [    0.239936] WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2434 _init+0x144/0x310()
> [    0.249054] omap_hwmod: rtc: doesn't have mpu register target base
> [    0.255526] Modules linked in:
> [    0.258845] CPU: 0 PID: 1 Comm: swapper Not tainted 3.12.0-00004-gfcb6c2c-dirty #31
> [    0.266938] [<c00197f4>] (unwind_backtrace+0x0/0xf0) from [<c0016ee8>] (show_stack+0x10/0x14)
> [    0.275916] [<c0016ee8>] (show_stack+0x10/0x14) from [<c003be68>] (warn_slowpath_common+0x6c/0x8c)
> [    0.285284] [<c003be68>] (warn_slowpath_common+0x6c/0x8c) from [<c003bf1c>] (warn_slowpath_fmt+0x30/0x40)
> [    0.295323] [<c003bf1c>] (warn_slowpath_fmt+0x30/0x40) from [<c06fdac8>] (_init+0x144/0x310)
> [    0.304200] [<c06fdac8>] (_init+0x144/0x310) from [<c0029e40>] (omap_hwmod_for_each+0x34/0x5c)
> [    0.313250] [<c0029e40>] (omap_hwmod_for_each+0x34/0x5c) from [<c06fe1fc>] (__omap_hwmod_setup_all+0x24/0x40)
> [    0.323643] [<c06fe1fc>] (__omap_hwmod_setup_all+0x24/0x40) from [<c00087e8>] (do_one_initcall+0x34/0x160)
> [    0.333774] [<c00087e8>] (do_one_initcall+0x34/0x160) from [<c06f3af0>] (kernel_init_freeable+0xe8/0x1b4)
> [    0.343824] [<c06f3af0>] (kernel_init_freeable+0xe8/0x1b4) from [<c04d0ff4>] (kernel_init+0x8/0xe4)
> [    0.353338] [<c04d0ff4>] (kernel_init+0x8/0xe4) from [<c00139e8>] (ret_from_fork+0x14/0x2c)
> [    0.362428] ---[ end trace 1b75b31a2719ed1c ]---
> 
> Do we really need this WARN() here? Or is the "Could not ioremap" line
> enough?

I had seen this too :) - There is a bit of history around this:
- we are in the process of moving functionality from hwmod into dts
since both are meant to describe the hardware and dt is the way to go.
	- at this point - hwmod is supposed to accurately represent SoC
modules and dts is supposed to match up.
- as part of this conversion, one of the first things to move is to
memory range description from hwmod to dts (reg description).
- the WARN() was introduced to catch such instances where hwmod
contain nodes and dts entries dont contain the description.

What we did miss is a valid condition where the generic definitions
for the presence of a SoC peripheral depends on a pin pull on the
board for the same SoC.

What should happen: if maintainers think that 'ti,hwmods="disabled";'
is an sufficient way of describing this current scenario, then we can
intelligently parse the same and avoid the warning for these cases.

-- 
Regards,
Nishanth Menon
