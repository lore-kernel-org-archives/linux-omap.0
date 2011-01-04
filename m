From: "David Lynch Jr." <dhlii@dlasys.net>
Subject: I2C Touchscreen OMAP OOPS
Date: Tue, 04 Jan 2011 01:56:23 -0500
Message-ID: <1294124183.6822.335.camel@t-dhlii>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I am trying to get a vendor provided I2C touchscreen driver working with
android froyo with a 2.6.32 linux kernel for a client. I have fixed alot
of things and I am down to one serious problem remaining. 

The driver is oops'ing reading the touchscreen data in omap_i2c_xfer.
I tried to figure out what was going on by printk tracing omap_i2c_xfer,
but the problem goes away - mostly with a few judiciously inserted
printk's

I tried backporting the 2.6.37 i2c-omap code, but that does nto change
behavior. 

What is "scheduling while atomic" ? and what am I trying to look for ?
Is the root of this problem in the touchscreen driver ? omap_i2c or
should I be looking elsewhere ?


root@beagleboard:~# evtest /dev/input/event1
Input driver version is 1.0.0evdev.c(EVIOCGBIT): Suspicious buffer size
511, limiting output to 64 bytes. See
http://userweb.kernel.org/~dtor/eviocgbit-bug.html

Input device ID: bus 0x18 vendor 0xdead product 0x534 version 0x1
Input device name: "sitronix_ts"
Supported events:
  Event type 0 (Sync)
  Event type 1 (Key)
    Event code 330 (Touch)
  Event type 3 (Absolute)
    Event code 0 (X)
      Value      0
      Min        0
      Max      480
    Event code 1 (Y)
      Value      0
      Min        0
      Max      256
Testing ... (interrupt to exit)
BUG: scheduling while atomic: swapper/0/0x00010003
Unable to handle kernel NULL pointer dereference at virtual address
00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 80000007 [#1] PREEMPT
last sysfs
file: /sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:aaaa/block/mmcblk0/size
Modules linked in:
CPU: 0    Not tainted  (2.6.32 #98)
PC is at 0x0
LR is at enqueue_task+0x28/0x34
pc : [<00000000>]    lr : [<c005aaac>]    psr: 20000193
sp : c04dbc30  ip : 00000016  fp : c04dbc44
r10: 00000000  r9 : 00000000  r8 : 00000002
r7 : 00000000  r6 : 00000000  r5 : c04e8cc8  r4 : c04dcfa8
r3 : 00000000  r2 : 00000001  r1 : c04dcfa8  r0 : c04e8cc8
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 8c8c8019  DAC: 00000017

LR: 0xc005aa2c:
aa2c  e8bd8800 e92d4800 e59100c4 e28db004 e3500002 03a0000c 13a00000
e8bd8800
aa4c  e92d48f0 e1c040d0 e1a06002 e1a07003 e0566004 e0c77005 e28db014
e1a021a6
aa6c  e1a031c7 e1822e87 e0944002 e0a55003 e1c040f0 e8bd88f0 e3520000
e92d48d8
aa8c  e1a04001 e28db014 11c165d8 11c168f8 e5943028 e1a01004 e5933004
e12fff33
aaac  e3a03001 e584304c e8bd88d8 e92d4b78 e2525000 e28db01c e1a06000
e1a04001
aacc  0a000010 e1c127d0 e1921003 0a000008 e1c485d8 e2840078 e0582002
e0c93003
aaec  ebffffd6 e3a02000 e3a03000 e1c427f0 ea000004 e59f3030 e2840090
e5932000
ab0c  e3a03000 ebffffcd e5943028 e1a00006 e1a01004 e1a02005 e5933008
e12fff33

SP: 0xc04dbbb0:
bbb0  0000000f 00000010 00000000 30303033 00000031 00000000 00000000
00000000
bbd0  00000000 ffffffff c04dbc1c 00000000 00000000 c0034bf0 c04e8cc8
c04dcfa8
bbf0  00000001 00000000 c04dcfa8 c04e8cc8 00000000 00000000 00000002
00000000
bc10  00000000 c04dbc44 00000016 c04dbc30 c005aaac 00000000 20000193
ffffffff
bc30  ffffffff c04e8cc8 00000000 c04da000 c04dbc54 c005ab70 00000000
c04dcfa8
bc50  c04dbc7c c005e9b8 c044d812 80000193 c05257f0 cf91e010 00000001
cf91e01c
bc70  00000001 00000003 c04dbca4 c005aef0 00000000 00000113 00001004
00000000
bc90  00000039 00000001 0000601f c04e92d4 c04dbcbc c005cf14 00000000
35303135

FP: 0xc04dbbc4:
bbc4  00000000 00000000 00000000 00000000 ffffffff c04dbc1c 00000000
00000000
bbe4  c0034bf0 c04e8cc8 c04dcfa8 00000001 00000000 c04dcfa8 c04e8cc8
00000000
bc04  00000000 00000002 00000000 00000000 c04dbc44 00000016 c04dbc30
c005aaac
bc24  00000000 20000193 ffffffff ffffffff c04e8cc8 00000000 c04da000
c04dbc54
bc44  c005ab70 00000000 c04dcfa8 c04dbc7c c005e9b8 c044d812 80000193
c05257f0
bc64  cf91e010 00000001 cf91e01c 00000001 00000003 c04dbca4 c005aef0
00000000
bc84  00000113 00001004 00000000 00000039 00000001 0000601f c04e92d4
c04dbcbc
bca4  c005cf14 00000000 35303135 63303536 cf91e000 c04dbdec c024626c
cf85bb00

R0: 0xc04e8c48:
8c48  00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
8c68  00000000 00000000 00000000 00000000 000f4240 000f4240 000f4240
004c4b40
8c88  004c4b40 000f4240 0003d090 0003d090 00000001 c04e8c9c c04e8c9c
000f4240
8ca8  000e7ef0 00000001 c04e8cb0 c04e8cb0 cc901b18 c0525278 00000004
00000001
8cc8  00000000 00000000 00000070 00000176 0000018b 0000013b 00000000
00000000
8ce8  00000000 0000268a 00009fd5 00000000 00000000 00000000 00000000
00000000
8d08  00000000 00000000 cd9c987c 00000008 00000000 00000000 c04e8d20
c04e8d20
8d28  00000000 00000000 00000000 00000000 00000000 c04e8cc8 00000000
00000000

R1: 0xc04dcf28:
cf28  c01bf6e4 c037cf08 c01bf70c c037cf10 c01bf748 c037cf18 c01da958
c037cf20
cf48  c01da968 c037cf28 c02a4854 c037cf30 c02a4924 c037cf38 c02a4a84
c037cf40
cf68  c02a4bdc c037cf48 c02a4d00 c037cf50 c02a4dd0 c037cf58 c02a4f40
c037cf60
cf88  c02a50ac c037cf68 c02c74b0 c037cf70 c02c7a84 c037cf78 c02c7aa0
c037cf80
cfa8  00000002 c04da000 00000002 00200000 00000000 ffffffff 00000078
00000078
cfc8  00000078 00000000 c037e5f0 00000000 00000400 00400000 00000000
00000000
cfe8  00000000 c04dcfec c04dcfec 00000000 00000000 00000000 00000000
00000000
d008  00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000

R4: 0xc04dcf28:
cf28  c01bf6e4 c037cf08 c01bf70c c037cf10 c01bf748 c037cf18 c01da958
c037cf20
cf48  c01da968 c037cf28 c02a4854 c037cf30 c02a4924 c037cf38 c02a4a84
c037cf40
cf68  c02a4bdc c037cf48 c02a4d00 c037cf50 c02a4dd0 c037cf58 c02a4f40
c037cf60
cf88  c02a50ac c037cf68 c02c74b0 c037cf70 c02c7a84 c037cf78 c02c7aa0
c037cf80
cfa8  00000002 c04da000 00000002 00200000 00000000 ffffffff 00000078
00000078
cfc8  00000078 00000000 c037e5f0 00000000 00000400 00400000 00000000
00000000
cfe8  00000000 c04dcfec c04dcfec 00000000 00000000 00000000 00000000
00000000
d008  00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000

R5: 0xc04e8c48:
8c48  00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
8c68  00000000 00000000 00000000 00000000 000f4240 000f4240 000f4240
004c4b40
8c88  004c4b40 000f4240 0003d090 0003d090 00000001 c04e8c9c c04e8c9c
000f4240
8ca8  000e7ef0 00000001 c04e8cb0 c04e8cb0 cc901b18 c0525278 00000004
00000001
8cc8  00000000 00000000 00000070 00000176 0000018b 0000013b 00000000
00000000
8ce8  00000000 0000268a 00009fd5 00000000 00000000 00000000 00000000
00000000
8d08  00000000 00000000 cd9c987c 00000008 00000000 00000000 c04e8d20
c04e8d20
8d28  00000000 00000000 00000000 00000000 00000000 c04e8cc8 00000000
00000000
Process swapper (pid: 0, stack limit = 0xc04da2e8)
Stack: (0xc04dbc30 to 0xc04dc000)
bc20:                                     ffffffff c04e8cc8 00000000
c04da000
bc40: c04dbc54 c005ab70 00000000 c04dcfa8 c04dbc7c c005e9b8 c044d812
80000193
bc60: c05257f0 cf91e010 00000001 cf91e01c 00000001 00000003 c04dbca4
c005aef0
bc80: 00000000 00000113 00001004 00000000 00000039 00000001 0000601f
c04e92d4
bca0: c04dbcbc c005cf14 00000000 35303135 63303536 cf91e000 c04dbdec
c024626c
bcc0: cf85bb00 00000000 00000000 00000039 00010004 c04da000 c04e92d4
c008e514
bce0: 00000000 c04ec2f0 00000039 cf85bb00 00010005 c009039c 00000039
c04dbf88
bd00: 00000033 c003406c 20000113 ffffffff fa200000 c0034ac4 c04e930c
c04e9310
bd20: 00000001 c04e9330 00000000 00000039 00000033 00000000 00000003
60000113
bd40: c04e92d4 c04dbdec 00003bc1 c04dbd60 c0062ae4 c0062ae8 20000113
ffffffff
bd60: ffffffff c04da000 00000000 c00985c0 00000041 c0525808 c07a2000
c04da000
bd80: 00000001 ffffffff c04e91a0 c04e8cf8 00000001 c04e91a0 00000001
c04dbf88
bda0: c04da000 c04dd140 c04dd13c c04dbe60 00000000 c04dcfa8 c04dbdec
c037a1dc
bdc0: c044d7e4 c04dbdd4 00000000 c005ba0c c044d7e4 c04dd1a0 00000000
00010003
bde0: c04dcfa8 c04da000 c04dbe1c c037a364 00000000 c04dd020 00010002
ffffb8ed
be00: c0535e40 ffffb86d 00000002 c04dbe60 00000000 c04dcfa8 c04dbe84
c037ada4
be20: cf91e078 c05365b4 c05365b4 ffffb8ed c006b738 c04dcfa8 c0535e40
a0000113
be40: c04da000 00000080 cf91e018 c037aa84 cf91e000 00000001 c04dcfa8
c005ea84
be60: cf91e01c cf91e01c cf91e000 cf91e000 00008601 c04dbedc 00000000
00000002
be80: cf91e078 c0246040 cf91e048 c04dbedc 00000002 cf91e048 00000000
ffffb86d
bea0: c04dbedc 00000002 00000000 00000000 fb058018 c024335c cf884dc0
cf99bdc0
bec0: c04dbef4 00000000 cf99bde8 00000000 00000143 c023ad18 c00412a4
00000038
bee0: c04d0001 c04dbeff 00010038 c008000a c04dbef4 0000009c 32d6627d
1000009c
bf00: 22757cc8 cf9a1ac0 00000000 00000000 00000143 00000000 00000000
00000143
bf20: fb058018 c008e514 00000000 c04f1610 00000143 cf9a1ac0 c04ebbc0
c009039c
bf40: c04e8088 00000001 00000022 c004ca3c c004c944 00000022 00000000
c002b014
bf60: 00000002 00000001 c04da000 0000001f 00000000 c003406c 60000013
ffffffff
bf80: fa200000 c0034ac4 00000000 00000000 c04eacf8 c0046a88 c04da000
c002b018
bfa0: c002b014 c04ddc60 80028d24 411fc083 0000001f 00000000 c04dbf38
c04dbfd0
bfc0: c00462e8 c0036434 60000013 ffffffff c0538b80 c0008918 c0008480
00000000
bfe0: 00000000 c002b018 00000000 10c53c7d c0523fd8 80008034 00000000
00000000
Code: bad PC value
---[ end trace 5f1d6aa71e65dba4 ]---
Kernel panic - not syncing: Fatal exception in interrupt
[<c003b550>] (unwind_backtrace+0x0/0xd0) from [<c037a100>] (panic
+0x54/0x118)
[<c037a100>] (panic+0x54/0x118) from [<c0039380>] (die+0x278/0x2b4)
[<c0039380>] (die+0x278/0x2b4) from [<c003c398>] (__do_kernel_fault
+0x64/0x74)
[<c003c398>] (__do_kernel_fault+0x64/0x74) from [<c003c56c>]
(do_page_fault+0x1c4/0x1d8)
[<c003c56c>] (do_page_fault+0x1c4/0x1d8) from [<c003421c>]
(do_PrefetchAbort+0x34/0x98)
[<c003421c>] (do_PrefetchAbort+0x34/0x98) from [<c0034bf0>] (__pabt_svc
+0x50/0xa0)
Exception stack(0xc04dbbe8 to 0xc04dbc30)
bbe0:                   c04e8cc8 c04dcfa8 00000001 00000000 c04dcfa8
c04e8cc8
bc00: 00000000 00000000 00000002 00000000 00000000 c04dbc44 00000016
c04dbc30
bc20: c005aaac 00000000 20000193 ffffffff
[<c0034bf0>] (__pabt_svc+0x50/0xa0) from [<c005aaac>] (enqueue_task
+0x28/0x34)
[<c005aaac>] (enqueue_task+0x28/0x34) from [<c005ab70>] (activate_task
+0x34/0x44)
[<c005ab70>] (activate_task+0x34/0x44) from [<c005e9b8>] (try_to_wake_up
+0x7c/0x148)
[<c005e9b8>] (try_to_wake_up+0x7c/0x148) from [<c005aef0>]
(__wake_up_common+0x44/0x78)
[<c005aef0>] (__wake_up_common+0x44/0x78) from [<c005cf14>] (complete
+0x4c/0x88)
[<c005cf14>] (complete+0x4c/0x88) from [<c024626c>] (omap_i2c_isr
+0x118/0x4b0)
[<c024626c>] (omap_i2c_isr+0x118/0x4b0) from [<c008e514>]
(handle_IRQ_event+0x34/0xf0)
[<c008e514>] (handle_IRQ_event+0x34/0xf0) from [<c009039c>]
(handle_level_irq+0xcc/0x170)
[<c009039c>] (handle_level_irq+0xcc/0x170) from [<c003406c>] (asm_do_IRQ
+0x6c/0x8c)
[<c003406c>] (asm_do_IRQ+0x6c/0x8c) from [<c0034ac4>] (__irq_svc
+0x44/0xa8)
Exception stack(0xc04dbd18 to 0xc04dbd60)
bd00:                                                       c04e930c
c04e9310
bd20: 00000001 c04e9330 00000000 00000039 00000033 00000000 00000003
60000113
bd40: c04e92d4 c04dbdec 00003bc1 c04dbd60 c0062ae4 c0062ae8 20000113
ffffffff
[<c0034ac4>] (__irq_svc+0x44/0xa8) from [<c0062ae8>] (vprintk
+0x328/0x388)
[<c0062ae8>] (vprintk+0x328/0x388) from [<c037a1dc>] (printk+0x18/0x24)
[<c037a1dc>] (printk+0x18/0x24) from [<c005ba0c>] (__schedule_bug
+0x34/0x60)
[<c005ba0c>] (__schedule_bug+0x34/0x60) from [<c037a364>] (schedule
+0x78/0x344)
[<c037a364>] (schedule+0x78/0x344) from [<c037ada4>] (schedule_timeout
+0x1c8/0x200)
[<c037ada4>] (schedule_timeout+0x1c8/0x200) from [<c037aa84>]
(wait_for_common+0xe8/0x1a8)
[<c037aa84>] (wait_for_common+0xe8/0x1a8) from [<c0246040>]
(omap_i2c_xfer+0x218/0x32c)
[<c0246040>] (omap_i2c_xfer+0x218/0x32c) from [<c024335c>] (i2c_transfer
+0xa8/0xf4)
[<c024335c>] (i2c_transfer+0xa8/0xf4) from [<c023ad18>] (sitronix_ts_isr
+0x74/0x1ac)
[<c023ad18>] (sitronix_ts_isr+0x74/0x1ac) from [<c008e514>]
(handle_IRQ_event+0x34/0xf0)
[<c008e514>] (handle_IRQ_event+0x34/0xf0) from [<c009039c>]
(handle_level_irq+0xcc/0x170)
[<c009039c>] (handle_level_irq+0xcc/0x170) from [<c004ca3c>]
(gpio_irq_handler+0xf8/0x128)
[<c004ca3c>] (gpio_irq_handler+0xf8/0x128) from [<c003406c>] (asm_do_IRQ
+0x6c/0x8c)
[<c003406c>] (asm_do_IRQ+0x6c/0x8c) from [<c0034ac4>] (__irq_svc
+0x44/0xa8)
Exception stack(0xc04dbf88 to 0xc04dbfd0)
bf80:                   00000000 00000000 c04eacf8 c0046a88 c04da000
c002b018
bfa0: c002b014 c04ddc60 80028d24 411fc083 0000001f 00000000 c04dbf38
c04dbfd0
bfc0: c00462e8 c0036434 60000013 ffffffff
[<c0034ac4>] (__irq_svc+0x44/0xa8) from [<c0036434>] (cpu_idle
+0x58/0xc4)
[<c0036434>] (cpu_idle+0x58/0xc4) from [<c0008918>] (start_kernel
+0x25c/0x2bc)
[<c0008918>] (start_kernel+0x25c/0x2bc) from [<80008034>] (0x80008034)
Rebooting in 10 seconds..

-- 
Dave Lynch                                                  DLA Systems
Software Development:                                    Embedded Linux
717.587.7774           dhlii@dlasys.net    http://www.dlasys.net
Over 25 years' experience in platforms, languages, and technologies too
numerous to list.

"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction."
Albert Einstein



