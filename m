From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: 2430SDP booting problem with the latest git
Date: Fri, 09 May 2008 08:42:46 -0500
Message-ID: <30da4de7f0df635e44381efc88211bb4@felipebalbi.com>
References: <c656a4d20805090613l1ecf4201m4385bb4ee75e9d90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34832 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbYEINmt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2008 09:42:49 -0400
In-Reply-To: <c656a4d20805090613l1ecf4201m4385bb4ee75e9d90@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org



On Fri, 9 May 2008 18:43:40 +0530, "arun c"
<arunedarath@mistralsolutions.com> wrote:
> Hi all,
> 
> While booting the 2430sdp with the latest git kernel nothing is
> coming on lcd, omapfb driver fails to initialize the lcd due
> to twl4030 accessing errors.
> 
> I have tested the hardware with the 2.6.14 kernel from ti
> site, its working fine.
> 
> boot log is pasted below below(also attached).
> 
> ##################################################################
> 
> Uncompressing
> Linux.............................................................Linux
> version 2.6.26-rc1-omap1-04724-gcb170dc (arunc@atlas) (gcc version
> 4.2.0 8CPU: ARMv6-compatible processor [4107b365] revision 5
> (ARMv6TEJ), cr=00c5387f
> Machine: OMAP2430 sdp2430 board
> Memory policy: ECC disabled, Data cache writeback
> OMAP2430<6>ES0<6>
> SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
> CPU0: D VIPT write-back cache
> CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
> CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
16256
> Kernel command line: mem=64M console=ttyS0,115200n8 noinitrd
> root=/dev/nfs rw npClocking rate (Crystal/DPLL/MPU): 13.0/532/266 MHz
> clock.c: Enable for gpmc_fck without enable code
> GPMC revision 3.0
> IRQ: Found an INTC at 0xd80fe000 (revision 3.0) with 96 interrupts
> Total of 96 interrupts on 1 active controller
> OMAP243x GPIO hardware version 2.4
> PID hash table entries: 256 (order: 8, 1024 bytes)
> Console: colour dummy device 80x30
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 64MB = 64MB total
> Memory: 61580KB available (2872K code, 285K data, 124K init)
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> net_namespace: 192 bytes
> NET: Registered protocol family 16
> NAND: Found NAND on CS 0
> OMAP DMA hardware revision 4.0
> Initializing OMAP McBSP system
> omap_dsp_init() done
> USB: No board-specific platform config found
> i2c_omap i2c_omap.1: bus 1 rev3.7 at 400 kHz
> i2c_omap i2c_omap.2: bus 2 rev3.7 at 2600 kHz
> TWL4030: TRY attach Slave TWL4030-ID0 on Adapter OMAP I2C adapter [1]
> TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter [1]
> TWL4030: TRY attach Slave TWL4030-ID2 on Adapter OMAP I2C adapter [1]
> TWL4030: TRY attach Slave TWL4030-ID3 on Adapter OMAP I2C adapter [1]
> Unable to register interrupt subsystem[-121][728]
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 2048 (order: 2, 16384 bytes)
> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> TCP reno registered
> NET: Registered protocol family 1
> NetWinder Floating Point Emulator V0.97 (double precision)
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
> msgmni has been set to 120 for ipc namespace c030c208
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> omapfb: configured for panel sdp2430
> omapfb: DISPC version 3.0 initialized
> omap_rng omap_rng: OMAP Random Number Generator ver. 50
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
> console [ttyS0] enabled
> serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
> serial8250.0: ttyS2 at MMIO 0x4806e000 (irq = 74) is a ST16654
> brd: module loaded
> loop: module loaded
> smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
> eth0: SMC91C94 (rev 9) at c4850300 IRQ 309 [nowait]
> eth0: Ethernet addr: 00:80:10:01:02:03
> i2c /dev entries driver
> TWL4030 GPIO Demux: IRQ Range 384 to 402, Initialization Failed
> omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
> omapflash.0: Found 1 x16 devices at 0x2000000 in 16-bit bank
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
> Using buffer write method
> Using auto-unlock on power-up/resume
> cfi_cmdset_0001: Erase suspend on write enabled
> OMAP2 OneNAND driver initializing
> input: omap_twl4030keypad as /class/input/input0
> omap_twl4030keypad omap_twl4030keypad: Could not write TWL4030: 0 -
> ret -121[ff]OMAP Watchdog Timer Rev 0x22: initial timeout 60 sec
> mmci-omap: probe of mmci-omap.1 failed with error -22

Besides the omapfb, this took my attention as well.
MMC is failing on 2430sdp, could anyone take a look at it ?

> TCP cubic registered
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> Power Management for OMAP2 initializing
> PRCM revision 1.0
> eth0: link up
> Sending DHCP requests ., OK
> IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.13.153
> IP-Config: Complete:
>      device=eth0, addr=192.168.13.153, mask=255.255.255.0,
> gw=192.168.13.188,
>      host=192.168.13.153, domain=, nis-domain=(none),
>      bootserver=0.0.0.0, rootserver=192.168.10.135, rootpath=
> Looking up port of RPC 100003/2 on 192.168.10.135
> ###########################################
> 
> Regards,
> Arun C

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

