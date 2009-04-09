From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: 2.6.29 and SDP3430
Date: Thu, 9 Apr 2009 12:35:37 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB1A117B@dbde02.ent.ti.com>
References: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47219 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753582AbZDIHFq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2009 03:05:46 -0400
In-Reply-To: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Check this up.. 
http://marc.info/?t=123698463000001&r=1&w=2 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Nishanth Menon
> Sent: Thursday, April 09, 2009 12:15 PM
> To: linux-omap
> Subject: 2.6.29 and SDP3430
> 
> Hi Folks,
> 
> just messing around with tony's master branch on SDP3430, just did a
> defconfig and a build with  2007q3-51 codesourcery compiler, I see it
> hang around:
> 
> ## Booting image at 80000000 ...
>    Image Name:   Linux-2.6.30-rc1-omap1-05613-g30
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    1909108 Bytes =  1.8 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
> OK
> 
> Starting kernel ...
> 
> Uncompressing 
> Linux.........................................................
> ................................................................
> done, booting th
> e kernel.
> <5>Linux version 2.6.30-rc1-omap1-05613-g30128fb (asda) (gcc version
> 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)) #1 Thu Apr 9
> 01:30:30 CDT 2
> 009
> CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c5387f
> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: OMAP3430 3430SDP board
> Memory policy: ECC disabled, Data cache writeback
> <7>On node 0 totalpages: 32768
> <7>free_area_init_node: node 0, pgdat c03b4f64, node_mem_map c03d0000
> <7>  Normal zone: 256 pages used for memmap
> <7>  Normal zone: 0 pages reserved
> <7>  Normal zone: 32512 pages, LIFO batch:7
> <6>OMAP3430 ES3.0
> <6>SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
> Built 1 zonelists in Zone order, mobility grouping on.  Total 
> pages: 32512
> <5>Kernel command line: console=ttyS0,115200n8 noinitrd ip=dhcp
> root=/dev/nfs rw nfsroot=IP:PATH,nolock,wsize=1024,rsize=1024
> <6>NR_IRQS:402
> <6>Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
> <6>GPMC revision 5.0
> <6>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
> <6>Total of 96 interrupts on 1 active controller
> <6>OMAP34xx GPIO hardware version 2.5
> PID hash table entries: 512 (order: 9, 2048 bytes)
> Console: colour dummy device 80x30
> <6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> <6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> <6>Memory: 128MB = 128MB total
> <5>Memory: 125880KB available (3304K code, 307K data, 140K 
> init, 0K highmem)
> <6>Calibrating delay loop...
> 
> Has anyone tried this recently?
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 