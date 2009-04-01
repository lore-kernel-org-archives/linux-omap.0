From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 3/4] ARM: OMAP3: Add support for 3430 SDP, v3
Date: Wed, 1 Apr 2009 13:55:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB086086@dbde02.ent.ti.com>
References: <20090331184802.GA27745@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39241 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbZDAIZt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 04:25:49 -0400
In-Reply-To: <20090331184802.GA27745@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Apr 01, 2009 at 12:18 AM, Russell King - ARM Linux wrote:
> On Tue, Mar 31, 2009 at 05:12:18PM +0530, Gadiyar, Anand wrote:
> > I could not run the 3430 SDP defconfig from mainline. The image hangs at
> > "Starting kernel ...". Enabling CONFIG_DEBUG_LL does not help.
> 
> Did you add the necessary patch to kernel/printk.c ?
> 

Silly me, I had not done this (despite having read this so many times on this list).

Here's what I get now after adding the patch.

- Anand

Uncompressing Linux.................................................................................................................... done, booting the kernel.
<5>Linux version 2.6.29-06608-g15f7176-dirty (a0393673@omaplbp.india.ti.com) (gcc version 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)) #4 Wed Apr 1 13:26:59 IST 2009
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3430 3430SDP board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>free_area_init_node: node 0, pgdat c038c8a4, node_mem_map c03a6000
<7>  Normal zone: 256 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 32512 pages, LIFO batch:7
<6>OMAP3430 ES3.0
<6>SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
<5>Kernel command line: mem=128M console=ttyS0,115200n8 noinitrd root=/dev/nfs rw nfsroot=172.24.162.66:/vol/vol2/swcoe_omapsw_linux1/anand/target,nolock,tcp ip=172.24.190.229:172.24.162.66:172.24.188.1:255.255.252.0:myomap::off
<6>NR_IRQS:402
<6>Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
<6>GPMC revision 5.0
<6>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<6>OMAP34xx GPIO hardware version 2.5
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x30
<6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 128MB = 128MB total
<5>Memory: 126064KB available (3188K code, 289K data, 112K init, 0K highmem)
<6>Calibrating delay loop...

