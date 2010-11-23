From: Peter Barada <peterb@logicpd.com>
Subject: Re: Trouble getting Logic OMAp35x modules to boot
Date: Tue, 23 Nov 2010 01:18:10 -0500
Message-ID: <4CEB5CA2.40004@logicpd.com>
References: <4CEB2502.9000300@logicpd.com> <AANLkTi=vF-b+T59wOmg+aUARvC5wkq8ZCfYJ0LNhZJx7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 174-46-170-154.static.twtelecom.net ([174.46.170.154]:46445
	"EHLO edprlnx06.logicpd.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751707Ab0KWGRm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Nov 2010 01:17:42 -0500
In-Reply-To: <AANLkTi=vF-b+T59wOmg+aUARvC5wkq8ZCfYJ0LNhZJx7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Peter Barada <peter.barada@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 11/23/2010 12:05 AM, Gadiyar, Anand wrote:
> On Tue, Nov 23, 2010 at 7:50 AM, Peter Barada<peterb@logicpd.com>  wrote:
>    
>> I've pulled the latest linux-2.6.37-rc3 kernel from kernel.org, and using
>> the arch/arm/configs/omap3plus_defconfig as .config, and turning on:
>>
>> CONFIG_MACH_OMAP35CONFIG_MACH_OMAP3530_LV_SOM=y
>> CONFIG_MACH_OMAP3_TORPEDO=y
>>
>> to run on the Logic OMAP35x boards, it failed to boot (no output from the
>> serial console).
>>
>> I added:
>>
>> CONFIG_DEBUG_LL=y
>> CONFIG_EARLY_PRINTK=y
>>
>> to turn on early debigging (and adding earlyprintk to the command line), and
>> see all looks fine up to the end of:
>>
>> Starting kernel ...
>>
>> Uncompressing Linux... done, booting the kernel.
>> Linux version 2.6.37-rc3-svn12998 (peter@blitz) (gcc version 4.3.3 (Sourcery
>> G++
>>   Lite 2009q1-203) ) #5 SMP Mon Nov 22 17:09:07 EST 2010
>> CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
>> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
>> Machine: Logic OMAP3 Torpedo board
>> debug: ignoring loglevel setting.
>> bootconsole [earlycon0] enabled
>> Memory policy: ECC disabled, Data cache writeback
>> OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
>> SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
>> On node 0 totalpages: 65536
>> free_area_init_node: node 0, pgdat c05450a0, node_mem_map c0579000
>>   Normal zone: 512 pages used for memmap
>>   Normal zone: 0 pages reserved
>>   Normal zone: 65024 pages, LIFO batch:15
>> PERCPU: Embedded 7 pages/cpu @c077c000 s4928 r8192 d15552 u32768
>> pcpu-alloc: s4928 r8192 d15552 u32768 alloc=8*4096
>> pcpu-alloc: [0] 0
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
>> Kernel command line: display=15 console=ttyS0,115200 root=/dev/nfs rw
>> nfsroot=19
>> 2.168.3.5:/opt/nfs-exports/ltib-omap,wsize=1500,rsize=1500 ip=dhcp
>> no_console_su
>>      
> ...
>
>    
>> io scheduler noop registered
>> io scheduler deadline registered
>>
>> where the output turns to trash on the serial console.
>>
>> 1) Is omap2plus_defconfig the default kernel configuration I should use for
>> the Logic OMAP35x boards?
>> 2) If so, any suggestions on where/why the console serial port is going
>> south?
>>
>>      
> If you have CONFIG_SERIAL_OMAP enabled (which should be enabled with
> the omap2plus_defconfig, then the serial port would now be ttyO0 instead
> of ttyS0. Try changing this.
>    

That worked a lot better, things came up to the point I was able to SSH 
into the board and do my testing;  I need to fixup my /etc/inittab, etc. 
to use /dev/ttyOx instead of /dev/ttyOx...

However, I'm seeing the same corruption on UART3 at 115200 I mentioned 
previously in:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38861.html 
(and why I'm investigating 2.6.32-rc7).

Any ideas why 2.6.37-rc3 exhibits the same behavior?

Also, where in the kernel is the mux setup for the UARTs done?  I'd like 
to use UART2 and am not sure how to wire it into the kernel(i.e. setup 
the mux for it as those pins are in mode 7) and want to follow the same 
style as that for UART1/3..

Thanks in advance!

> - Anand
>    


-- 
Peter Barada
peterb@logicpd.com

