From: sree <sreesamb@gmail.com>
Subject: OMAP2430sdp MMC driver for 2.6.21
Date: Mon, 23 Jul 2007 19:01:28 -0700
Message-ID: <80f873930707231901k540f1c31o299a90cf007e8d64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi
Regarding MMC/SD drivers
There is no need of porting the old TWL4030 drivers,
But I took the virtual Bus support from the 2.6.14 kernel
and able to read the data in SD card, and write the SD card with the new git
kernel
and my dmesg looks like

mmc0: starting CMD6 arg 00000002 flags 00000009
mmc0: set_ios: clock 400000Hz busmode 2 powermode 2 Vdd 14 Bus Width 2
MMC/SD card has been selected
mmc0: starting CMD16 arg 00000200 flags 00000009
mmc0: starting CMD16 arg 00000200 flags 00000009
<6>mmcblk0: mmc0:2199 SD512 500224KiB
<6> mmcblk0: mmcblk0:mmc0: starting CMD18 arg 00000000 flags 00000009
mmc0: starting CMD13 arg 21990000 flags 00000009

and I have to clean the driver and also I am having problem with the card
insertion and removal with the IRQ handling
the kernel crashes whenever I remove the card or Insert the card.I am
digging the problem
As soon as I do that I will get back again

the kernel crash :
PC is at queue_delayed_work+0x64/0xd8
PC is at queue_delayed_work+0x64/0xd8
LR is at 0xc1c67fe0
LR is at 0xc1c67fe0
pc : [<c004ed88>]    lr : [<c1c67fe0>]    Not tainted
sp : c0359f10  ip : c1c67fd0  fp : c0359f24
pc : [<c004ed88>]    lr : [<c1c67fe0>]    Not tainted
sp : c0359f10  ip : c1c67fd0  fp : c0359f24
r10: 00000000  r9 : 00000000  r8 : c033fda0
r10: 00000000  r9 : 00000000  r8 : c033fda0
r7 : c019d5b4  r6 : c0358000  r5 : 00000014  r4 : c0336960
r7 : c019d5b4  r6 : c0358000  r5 : 00000014  r4 : c0336960
r3 : c1c67fd4  r2 : 00000000  r1 : 00000000  r0 : c0336960
r3 : c1c67fd4  r2 : 00000000  r1 : 00000000  r0 : c0336960
Flags: nzcvFlags: nzcv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: C5387F
Control: C5387F
Table: 8186C000  DAC: 00000017
Table: 8186C000  DAC: 00000017
Process events/0 (pid: 4, stack limit = 0xc0358248)
Process events/0 (pid: 4, stack limit = 0xc0358248)
Stack: (0xc0359f10 to 0xc035a000)
Stack: (0xc0359f10 to 0xc035a000)

It might be because of the different work scheduling in the new kernel
thanks
-sree
