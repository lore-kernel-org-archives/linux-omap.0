From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: omap2430 kernel bootlog
Date: Wed, 17 May 2006 04:06:00 -0700
Message-ID: <1147863960.2395.261639976@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Here is the minimal kernel conf. bootlog for omap2430.

Before that...

* I would prefer to have CONFIG_ARCH_OMAP242X and CONFIG_ARCH_OMAP243X
  instead of using CONFIG_ARCH_OMAP2420/OMAP2430 in my patch. But as of 
  now there is no such facility in current omap-git tree.

* Previous patch was just to trigger discussion on differences on base
  addresses introduced with omap2430 and how we can reuse existing omap24xx
  code with minimum #ifdefers.

* I still need to work on ethernet support. I will update on it, once
  NFS mount works.

* And to just people get started working on 2430 with omap-git tree, having
  hopefully long linux-2430 roadmaps :)

-------------snip-----------------
<5>Linux version 2.6.17-rc4-omap1-g9254deba-dirty (komal@everest) (gcc version
3.4.0 20040409 (CodeSourcery ARM Q1A 2004)) #270 Wed May 17 15:26:48 IST 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: Generic OMAP24xx
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>  DMA zone: 32768 pages, LIFO batch:7
<6>OMAP2430
<6>SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x1000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists
<5>Kernel command line: console=ttyS0,115200n8 noinitrd root=/dev/nfs r
w nfsroot=10.203.96.33:/pub/fs/oss,wsize=1024 ip=10.203.96.34:10.203.96.33:
255.255.254.0:omap2:eth0:
<6>Clocking rate (Crystal/DPLL/MPU): 13.0/660/330 MHz
<3>clock.c: Enable for dpll_ck without enable code
<6>IRQ: Found an INTC at 0x480fe000 (revision 3.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
PID hash table entries: 1024 (order: 10, 4096 bytes)
<6>OMAP2 GP timer (HW version 1.6)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 128MB = 128MB total
<5>Memory: 128128KB available (1252K code, 324K data, 84K init)
<7>Calibrating delay loop... 329.31 BogoMIPS (lpj=1646592)
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: ok
<6>OMAP DMA hardware revision 3.0
<6>OMAP24xx GPIO hardware version 2.2
<3>omapdsp: unsupported omap architecture.
<3>USB: No board-specific platform config found
<4>NetWinder Floating Point Emulator V0.97 (double precision)
<5>VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>Initializing Cryptographic API
<6>io scheduler noop registered
<6>io scheduler anticipatory registered (default)
<6>io scheduler deadline registered
<6>io scheduler cfq registered
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
<6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
Linux version 2.6.17-rc4-omap1-g9254deba-dirty (trilok@everest) (gcc version 3.4
.0 20040409 (CodeSourcery ARM Q1A 2004)) #270 Wed May 17 15:26:48 IST 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: Generic OMAP24xx
Memory policy: ECC disabled, Data cache writeback
OMAP2430
SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x1000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists
Kernel command line: console=ttyS0,115200n8 noinitrd root=/dev/nfs rw n
fsroot=10.203.96.33:/pub/fs/oss,wsize=1024 ip=10.203.96.34:10.203.96.33:255
.255.254.0:omap2:eth0:
Clocking rate (Crystal/DPLL/MPU): 13.0/660/330 MHz
clock.c: Enable for dpll_ck without enable code
IRQ: Found an INTC at 0x480fe000 (revision 3.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
PID hash table entries: 1024 (order: 10, 4096 bytes)
OMAP2 GP timer (HW version 1.6)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 128128KB available (1252K code, 324K data, 84K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
OMAP DMA hardware revision 3.0
OMAP24xx GPIO hardware version 2.2
omapdsp: unsupported omap architecture.
USB: No board-specific platform config found
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
<6>serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
<6>serial8250.0: ttyS2 at MMIO 0x4806e000 (irq = 74) is a ST16654
serial8250.0: ttyS2 at MMIO 0x4806e000 (irq = 74) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
<6>loop: loaded (max 8 devices)
loop: loaded (max 8 devices)
VFS: No root yet, retrying to mount root on nfs (unknown-block(0,255))
-------------snip-----------------

---Komal Shah

-- 
http://www.fastmail.fm - Email service worth paying for. Try it for free
