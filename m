From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM
 MDK (Re: LDP support)
Date: Fri, 08 May 2009 11:26:05 +0800
Message-ID: <4A03A64D.2000809@windriver.com>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090505195231.GB8004@n2100.arm.linux.org.uk> <20090506040015.GM5593@atomide.com> <20090506224917.GS5593@atomide.com> <4A02F7CF.1050803@windriver.com> <20090507161936.GA26106@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000706060305030708090006"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:43091 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538AbZEHDXr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 May 2009 23:23:47 -0400
In-Reply-To: <20090507161936.GA26106@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

This is a multi-part message in MIME format.
--------------000706060305030708090006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Russell King - ARM Linux wrote:
> On Thu, May 07, 2009 at 11:01:35PM +0800, stanley.miao wrote:
>   
>> Hi, Tony,
>>
>> Now the kernel can't boot on LDP. The attached file is the boot log.
>>     
>
> No boot log found.
>
>
>   
Sorry, forgot to attach the boot log.

It is linux-omap master branch.

Stanley.



--------------000706060305030708090006
Content-Type: text/plain;
 name="ldp_boot_log.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ldp_boot_log.txt"

Uncompressing Linux.................................................................................................................... done, booting the kernel.
<5>Linux version 2.6.30-rc4-omap1-05873-g2489dcb (stanley@stanley-desktop) (gcc version 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-53)) #1 Thu May 7 22:52:12 CST9
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP LDP board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>free_area_init_node: node 0, pgdat c038db50, node_mem_map c03a9000
<7>  Normal zone: 256 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 32512 pages, LIFO batch:7
<6>OMAP3430 ES2.1
<6>SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
<5>Kernel command line: root=/dev/nfs rw nfsroot=128.224.163.169:/export/rootfs console=ttyS2,115200n8 mem=128M ip=128.224.163.125:128.224.163.169:128.224.162.1:25}
<6>NR_IRQS:402
<6>Clocking rate (Crystal/DPLL/ARM core): 26.0/266/500 MHz
<6>GPMC revision 5.0
<6>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<6>OMAP34xx GPIO hardware version 2.5
PID hash table entries: 512 (order: 9, 2048 bytes)
<6>OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
<6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 128MB = 128MB total
<5>Memory: 126036KB available (3176K code, 292K data, 132K init, 0K highmem)
<6>Calibrating delay loop... 


--------------000706060305030708090006--
