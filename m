From: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Subject: Re: Kernel Boot Problem - OMAP 730 P2 - v2.6.9-rc1-omap1
Date: Fri, 21 Apr 2006 13:32:16 +0530
Message-ID: <OFB11CB3E7.FA5ED181-ON65257157.002A9E00-65257157.002C2D03@flextronicssoftware.com>
References: <d911ca650604210025k34643318o615b5212a7a916b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <d911ca650604210025k34643318o615b5212a7a916b1@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Qi <linux0x0@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello

Thanks for the reply.

Yes, we tried out downloading the zImage to the SDRAM & executing it using 
'go' command. And, we did get the kernel boot traces on the terminal. But, 
the uImage still doesn't seem to execute. uImage was created using the 
mkimage utility. The command issued (on the development host) to create 
uImage is:

mkimage -n 'Linux Kernel Image 2.6.9-rc1-omap1' -A arm -O linux -T kernel 
-C none -a 0x10008000 -e 0x10008000 -d zImage uImage

the u-boot image info command 'iminfo' seems to understand the image 
correctly & prints the image information on the terminal. However, doing a 
bootm 0x(load_addr) doesn't work for us. The execution seems to be stuck 
at the point "Starting kernel ...".

To our surprise, the zImage seems to execute & outputs kernel boot traces 
on the terminal. However, it still doesn't pick up the u-boot 'bootargs' 
environment variable correctly & is not able to locate RAMDISK image.

Here are the logs for the zImage execution:

OMAP730 P2 # go 0x10008000

## Starting application at 0x10008000 ...
Uncompressing 
Linux............................................................
done, booting the kernel.
Linux version 2.6.9-rc1-omap1 (stevej@omap-linux2) (gcc version 3.4.0 
20040409 (
CodeSourcery ARM Q1A 2004)) #1 Thu Sep 2 12:14:20 CDT 2004
CPU: ARM926EJ-Sid(wb) [41069263] revision 3 (ARMv5TEJ)
CPU: D VIPT write-back cache
CPU: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
Machine: OMAP730 Perseus2
Memory policy: ECC disabled, Data cache writeback
OMAP_DIE_ID_0: 0x00000000
OMAP_DIE_ID_1: 0x00000000 DIE_REV: 0
OMAP_PRODUCTION_ID_0: 0x03320300
OMAP_PRODUCTION_ID_1: 0x1b55f02f JTAG_ID: 0xf02f
OMAP32_ID_0: 0x03320300
OMAP32_ID_1: 0x1b55f02f
JTAG_ID: 0xb55f DIE_REV: 1
OMAP07303 revision 1 handled as 07xx id: 0000000000000000
Built 1 zonelists
Kernel command line: mem=32M console=ttyS0,115200n8 noinitrd root=/dev/nfs 
rw ip
=bootp
Total of 96 interrupts in 3 interrupt banks
PID hash table entries: 256 (order 8: 2048 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 32MB = 32MB total
Memory: 30448KB available (1429K code, 395K data, 80K init)
Calibrating delay loop... 90.72 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
OMAP DMA hardware version 1
DMA capabilities: 000c0000:00000000:01ff:003f:007f
OMAP730 GPIO hardware
Initializing OMAP McBSP system
USB: No board-specific platform config found
get_random_bytes called before random driver initialization
NetWinder Floating Point Emulator V0.97 (double precision)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
omap-rtc: Enabling RTC.
Real Time Clock Driver v1.0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at MMIO 0xfefb0000 (irq = 47) is a OMAP UART
ttyS1 at MMIO 0xfefb0800 (irq = 46) is a OMAP UART
OMAP serial: activated 2 ports
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
smc91x: not found (-19).
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: No network devices available.
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: No root yet, retrying to mount root on nfs (unknown-block(2,0))
VFS: No root yet, retrying to mount root on nfs (unknown-block(2,0))
VFS: No root yet, retrying to mount root on nfs (unknown-block(2,0))
VFS: No root yet, retrying to mount root on nfs (unknown-block(2,0))
VFS: No root yet, retrying to mount root on nfs (unknown-block(2,0))
VFS: No root yet, retrying to mount root on nfs (unknown-block(2,0))
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(2,0)



Any ideas what we are doing wrong that we are not able to execute/boot the 
uImage? It doesn't seem to run at all.


Thanks

Chetan






There no enough information to find out the problem .
So, I suggest you:
1st, download zImage or Image to SDRAM, and run it. If your serial is 
correct configurated, you will see the serial output you expected. 
 
If not, then report the output of serial.
 

 
2006/4/20, Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>: 
Hello

I am trying to boot kernel version 2.6.9-rc1-omap1 on my OMAP P2 730
target board, but am facing problems in the kernel boot process. I am 
using u-boot version 1.0.1, which has been burnt to the target's NOR
flash.

u-boot 1.0.1 is up and running on the target, and I use the command 'loadb
0x(addr)' along with triggering a send file (protocol->kermit) on the 
hyperterminal to download the kernel image 'uImage' on to the target's
RAM. 'uImage' is created using a utility 'mkimage' which is created by
u-boot build process. I specified the load address & entry point as 
0x10008000 while creating the uImage.

I also made sure that I properly specify the environment variables for
u-boot, the most important one being 'bootargs'. The following command was
given at the u-boot prompt to specify 'bootargs'. 

OMAP730 P2 # setenv bootargs mem=32M console=ttyS0,115200n8 root=/dev/ram0
rw initrd=0x10400000,1M devfs=mount

The ramdisk image was then downloaded to the target's RAM over the serial
line at the 'initrd' address - 0x10400000. Having done everything by the 
book, I now issue the following command to boot the kernel:

OMAP730 P2 # bootm 0x10008000 0x10400000

The traces received on the hyperterminal are:


## Booting image at 10008000 ...
  Image Name:   Linux-2.6.9-rc1-omap1
  Image Type:   ARM Linux Kernel Image (uncompressed)
  Data Size:    864600 Bytes = 844.3 kB
  Load Address: 10008000
  Entry Point:  10008000
  Verifying Checksum ... OK
  XIP Kernel Image ... OK 

Starting kernel ...

               -----> and the execution stucks beyond this point. The
system freezes right after u-boot finishes uncompressing the image for
startup. Nothing is output after that & there are no responses to any 
input from the terminal.

I am not very sure if there is any missing step which is needed to make
the kernel boot or maybe I am giving the load-address/entry-point wrongly
while building the kernel images. 

Also, I tried changing the filed textaddr-y in the kernel makefile while
building the kernel zImage. Does any one have any idea that what does this
address signify & does it effect the kernel images created by the build 
process. The original entry against the textaddr-y field in the kernel
Makefile was 0xC0008000 which was changed to 0x10008000 by me as the
former address looked a bit obscure & did not relate to the target's 
memory map.

Please help me if anyone has faced the similar problem before or if anyone
can make out the missing link in the steps which I am doing in order to
boot the kernel image.

Your reply & suggestion will be of great help. 

Chetan

***********************  FSS-Unclassified   ***********************
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source



-- 
q.h.



***********************  FSS-Unclassified   ***********************
