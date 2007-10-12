From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [PATCH] Make dyntick work again
Date: Fri, 12 Oct 2007 11:05:58 +0900
Message-ID: <002c01c80c74$9f0f5160$e1ac580a@swcenter.sec.samsung.co.kr>
References: <20071011203240.GL503@atomide.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <20071011203240.GL503@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Tony Lindgren' <tony@atomide.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Umm, there's a problem, I can't boot with timer32k.
It halts at here.

<5>Linux version 2.6.23-omap1 (kmpark@party) (gcc version 3.4.4 (release) (Code7
CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ), cr=00c5387f
Machine: OMAP24xx Apollon
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>  DMA zone: 256 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 32512 pages, LIFO batch:7
<7>  Normal zone: 0 pages used for memmap
<7>  Movable zone: 0 pages used for memmap
<6>OMAP24204
<6>SRAM: Mapped pa 0x40200000 to va 0xd0000000 size: 0x100000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists in Zone order.  Total pages: 32512
<5>Kernel command line: root=/dev/nfs rw mem=128M console=ttyS0,115200n8 ip=1922
<6>kernel profiling enabled (shift: 2)
<6>Clocking rate (Crystal/DPLL/MPU): 12.0/660/330 MHz
<6>GPMC revision 2.0
<6>IRQ: Found an INTC at 0xd80fe000 (revision 2.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<6>OMAP242x GPIO hardware version 1.8
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x30
<6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 128MB = 128MB total
<5>Memory: 124160KB available (2580K code, 303K data, 92K init)
<7>Calibrating delay loop... 1.05 BogoMIPS (lpj=4096)
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency:

It's also can't boot 2.6.22, umm I will track this one.

Anyway, I used the mpu timer and here's the dyntick result. (mpu also support the oneshot in the code)
Is it the right results?

/ # grep time /proc/interrupts ; sleep 10; grep time /proc/interrupts
 37:        714        INTC  gp timer
 37:        787        INTC  gp timer
/ # grep time /proc/interrupts ; sleep 10; grep time /proc/interrupts
 37:        880        INTC  gp timer
 37:        959        INTC  gp timer

Thank you,
Kyungmin Park

P.S., here's the current kernel configuration (timer 32k)
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_OMAP_32K_TIMER=y
CONFIG_OMAP_32K_TIMER_HZ=128
CONFIG_OMAP_DM_TIMER=y
# Kernel Features
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT=y
CONFIG_HZ=128

> -----Original Message-----
> From: linux-omap-open-source-bounces+kyungmin.park=samsung.com@linux.omap.com [mailto:linux-omap-
> open-source-bounces+kyungmin.park=samsung.com@linux.omap.com] On Behalf Of Tony Lindgren
> Sent: Friday, October 12, 2007 5:33 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: [PATCH] Make dyntick work again
> 
> Hi all,
> 
> Here's a quick patch to make dyntick work on omap again
> after the clocksource changes. It now uses the Linux
> common implementation instead of the ARM specific one.
> 
> I haven't tested this patch much yet, except:
> 
> # grep time /proc/interrupts; sleep 10; grep time /proc/interrupts
> 
> Drops the ticks to below 10.
> 
> Regards,
> 
> Tony
