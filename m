From: "Simon Braunschmidt" <sbraunschmidt.linuxlists@googlemail.com>
Subject: framebuffer on 2430sdp, configuration and bug
Date: Thu, 24 Apr 2008 18:57:48 +0200
Message-ID: <1ee641e10804240957o1bbc0011te4af31e1c15d6a4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:59102 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbYDXQ5w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 12:57:52 -0400
Received: by an-out-0708.google.com with SMTP id d31so856304and.103
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2008 09:57:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: arthur.mielimonka@teleca.com, Ronny.Lampert@teleca.com

Hi all

We are running 2.6.24-omap1.

We have problems to get the framebuffer driver running on a
SDP2430-VG5.0.1 board. At the moment the LCD stays dark, no penguin to
be seen, test program not displaying anything, nothing. We tried
different configurations already but we are not exactly sure which
Kconfig options are relevant. The sdp2430 defconfig does not work for
us.

A .config for a known to be working framebuffer configuration would be
very helpfull, together with kernel version or git tag.

Also we are seeing a bug, instability, whatever coming from :

drivers/video/omap/dispc.c

in function:

static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)

This patch adds extra debug output:




Index: drivers/video/omap/dispc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/video/omap/dispc.c  (revision 325)
+++ drivers/video/omap/dispc.c  (working copy)
@@ -864,8 +864,13 @@

        if (stat & DISPC_IRQ_MASK_ERROR) {
                if (printk_ratelimit()) {
-                       dev_err(dispc.fbdev->dev, "irq error status %04=
x\n",
+                       dev_err(dispc.fbdev->dev, "irq error status %04=
x",
                                stat & 0x7fff);
+                       printk("%s",(stat & DISPC_IRQ_SYNC_LOST)? "
DISPC_IRQ_SYNC_LOST " : " ");
+                       printk("%s",(stat &
DISPC_IRQ_VID2_FIFO_UNDERFLOW)? "DISPC_IRQ_VID2_FIFO_UNDERFLOW " : "
");
+                       printk("%s",(stat &
DISPC_IRQ_VID1_FIFO_UNDERFLOW)? "DISPC_IRQ_VID1_FIFO_UNDERFLOW " : "
");
+                       printk("%s",(stat &
DISPC_IRQ_GFX_FIFO_UNDERFLOW)? "DISPC_IRQ_GFX_FIFO_UNDERFLOW\n" :
"\n");
+
                }
        }




Resulting console output is :

omapfb omapfb: irq error status 40e2DISPC_IRQ_SYNC_LOST
DISPC_IRQ_GFX_FIFO_UNDERFLOW=B4
omapfb omapfb: irq error status 0040   DISPC_IRQ_GFX_FIFO_UNDERFLOW=B4
omapfb omapfb: irq error status 4022DISPC_IRQ_SYNC_LOST   =B4
omapfb omapfb: irq error status 4000DISPC_IRQ_SYNC_LOST   =B4
omapfb omapfb: irq error status 4000DISPC_IRQ_SYNC_LOST   =B4
omapfb omapfb: irq error status 4022DISPC_IRQ_SYNC_LOST   =B4
omapfb omapfb: irq error status 4000DISPC_IRQ_SYNC_LOST   =B4
omapfb omapfb: irq error status 4000DISPC_IRQ_SYNC_LOST   =B4
omapfb omapfb: irq error status 4022DISPC_IRQ_SYNC_LOST   =B4
omapfb omapfb: irq error status 4000DISPC_IRQ_SYNC_LOST   =B4

omapfb omapfb: irq error status 4000DISPC_IRQ_SYNC_LOST   =B4
printk: 1487165 messages suppressed.=B4

Can someone please provide insight on whats happening here?

Maybe the sync lost signal coming from dispc (display controller) has
to be handled properly, its only reported in the current code.

In the very old kernel snapshots on linux.omap.com, these kinds of
messages were counted and suppressed after 5 occurences, so it seems
like they were know at some stage in the development. The old
snapshots do not compile with our toolchain (codesourcery 2007 and
2008), suggestions for this?
I know that the hardware is working in principle, a precompiled
kernel, 2.6.10, maybe montavista or something TI developed internally,
is running succesfully with framebuffer.

Help, a working .config, some insight would be much appreciated...

Regards, Gruessla
Simon Braunschmidt


The errors start right after powermanagment init according to bootlog,
maybe related?
Below is partial bootlog, notice omapfb device registration and
following omapfb error messages:

---snip---
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel sdp2430
omapfb: DISPC version 3.0 initialized
Console: switching to colour frame buffer device 30x40
omapfb: Framebuffer initialized. Total vram 155648 planes 1
omapfb: Pixclock 5156 kHz hfreq 18.2 kHz vfreq 54.8 Hz
omap_rng omap_rng: OMAP Random Number Generator ver. 50
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enable=
d
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x4806e000 (irq =3D 74) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: module loaded
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c2850300 IRQ 309 [nowait]
eth0: Ethernet addr: 08:00:28:01:17:d1
i2c /dev entries driver
TWL4030 GPIO Demux: IRQ Range 376 to 386, Initialization Failed
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
OMAP2 OneNAND driver initializing
input: omap_twl4030keypad as /class/input/input0
omap_twl4030keypad omap_twl4030keypad: Could not write TWL4030
register 3 - ret -121[ffffff87]
OMAP Watchdog Timer Rev 0x22: initial timeout 60 sec
mmci-omap mmci-omap.1: Failed to configure TWL4030 GPIO IRQ
logger: created 64K log 'log_main'
logger: created 64K log 'log_events'
logger: created 64K log 'log_radio'
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Power Management for OMAP2 initializing
PRCM revision 1.0
omapfb omapfb: irq error status 40e2DISPC_IRQ_SYNC_LOST
DISPC_IRQ_GFX_FIFO_UNDERFLOW
omapfb omapfb: irq error status 0040   DISPC_IRQ_GFX_FIFO_UNDERFLOW
omapfb omapfb: irq error status 4022DISPC_IRQ_SYNC_LOST
omapfb omapfb: irq error status 4000DISPC_IRQ_SYNC_LOST
omapfb omapfb: irq error status 4000DISPC_IRQ_SYNC_LOST
omapfb omapfb: irq error status 4022DISPC_IRQ_SYNC_LOST
omapfb omapfb: irq error status 4000DISPC_IRQ_SYNC_LOST
omapfb omapfb: irq error status 4000DISPC_IRQ_SYNC_LOST
omapfb omapfb: irq error status 4022DISPC_IRQ_SYNC_LOST
omapfb omapfb: irq error status 4000DISPC_IRQ_SYNC_LOST
eth0: link up
IP-Config: Guessing netmask 255.0.0.0
IP-Config: Complete:
      device=3Deth0, addr=3D10.20.6.22, mask=3D255.0.0.0, gw=3D255.255.=
255.255,
     host=3D10.20.6.22, domain=3D, nis-domain=3D(none),
     bootserver=3D255.255.255.255, rootserver=3D10.20.3.2, rootpath=3D
Looking up port of RPC 100003/2 on 10.20.3.2
Looking up port of RPC 100005/1 on 10.20.3.2
VFS: Mounted root (nfs filesystem).
=46reeing init memory: 124K
/bin/init: can't access tty; job control turned off
# printk: 1444798 messages suppressed.
omapfb omapfb: irq error status 4000DISPC_IRQ_SYNC_LOST
---snip---
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
