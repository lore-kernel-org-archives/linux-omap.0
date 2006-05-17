From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: Update: 2430 kernel booting
Date: Wed, 17 May 2006 09:51:33 -0700
Message-ID: <1147884693.20367.261671114@webmail.messagingengine.com>
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

* Intel strata flash detected
* smc91x.c detected - first patch was having wrong gpio5 bank base address,
  and clock was not enabled for gpio5 block.
* I don't know but platform_add_devices() from omap_sdp2430_init()
board-sdp2430.c. So forcefully registering devices at arch_init for flash
and smc91x.

Still, NFS is not working and same old watchdog timeout messages are coming,
as was in the case of omap2420. Need to optimize GPMC values.

Linux version 2.6.17-rc4-omap1-g9254deba-dirty (komal@everest) (gcc version 3.4.
0 20040409 (CodeSourcery ARM Q1A 2004)) #292 Wed May 17 22:13:09 IST 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: Generic OMAP24xx
Memory policy: ECC disabled, Data cache writeback
OMAP2430
SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x1000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists
Kernel command line: console=ttyS0,115200n8 noinitrd root=/dev/nfs rw nfsroot=10
.203.96.33:/pub/fs/oss,wsize=1024 ip=dhcp
Clocking rate (Crystal/DPLL/MPU): 13.0/660/330 MHz
clock.c: Enable for dpll_ck without enable code
IRQ: Found an INTC at 0x480fe000 (revision 3.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
PID hash table entries: 1024 (order: 10, 4096 bytes)
OMAP2 GP timer (HW version 1.6)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB 0MB = 128MB total
Memory: 127488KB available (1852K code, 452K data, 92K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
Registering devices
OMAP DMA hardware revision 3.0
OMAP24xx GPIO hardware version 2.2
omapdsp: unsupported omap architecture.
USB: No board-specific platform config found
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
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
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x4806e000 (irq = 74) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c8800300 IRQ 309 [nowait]
eth0: Ethernet addr: 08:00:28:01:00:78
omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
omapflash.0: Found 1 x16 devices at 0x2000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 4 MTD partitions on "omapflash.0":
0x00000000-0x00040000 : "bootloader"
0x00040000-0x00060000 : "params"
0x00060000-0x00260000 : "kernel"
0x00260000-0x04000000 : "filesystem"
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
eth0: link up
Sending DHCP requests ...<6>NETDEV WATCHDOG: eth0: transmit timed out
.<6>NETDEV WATCHDOG: eth0: transmit timed out
.<6>NETDEV WATCHDOG: eth0: transmit timed out

I will submit patch (evenif nfs doesn't work) tomorrow to mailinglist
for review.

-- 
http://www.fastmail.fm - Choose from over 50 domains or use your own
