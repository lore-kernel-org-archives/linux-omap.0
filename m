From: Grazvydas Ignotas <notasas@gmail.com>
Subject: PM related performance degradation on OMAP3
Date: Sat, 7 Apr 2012 01:50:19 +0300
Message-ID: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60605 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420Ab2DFWuV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Apr 2012 18:50:21 -0400
Received: by lbbgg6 with SMTP id gg6so918411lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Apr 2012 15:50:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

Hello,

I'm DMA seeing performance loss related to CONFIG_PM on OMAP3.

# CONFIG_PM is set:
echo 3 > /proc/sys/vm/drop_caches
# file copy from NAND (using NAND driver in DMA mode)
dd if=3D/mnt/tmp/a of=3D/dev/null bs=3D1M count=3D32
33554432 bytes (32.0MB) copied, 9.088714 seconds, 3.5MB/s
# file read from SD (hsmmc uses DMA)
dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D1M count=3D32
33554432 bytes (32.0MB) copied, 2.065460 seconds, 15.5MB/s

# CONFIG_PM not set:
# NAND
dd if=3D/mnt/tmp/a of=3D/dev/null bs=3D1M count=3D32
33554432 bytes (32.0MB) copied, 5.653534 seconds, 5.7MB/s
# SD
dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D1M count=3D32
33554432 bytes (32.0MB) copied, 1.919007 seconds, 16.7MB/s

While SD card performance loss is not that bad (~7%), NAND one is
worrying (~39%). I've tried disabling/enabling CONFIG_CPU_IDLE, also
cpuidle states over sysfs, it did not have any significant effect. Is
there something else to try?

I'm guessing this is caused by CPU wakeup latency to service DMA
interrupts? I've noticed that if I keep CPU busy, the loss is reduced
almost completely.
Talking about cpuidle, what's the difference between C1 and C2 states?
They look mostly the same.
Then there is omap3_do_wfi, it seems to be unconditionally putting
SDRC on self-refresh, would it make sense to just do wfi in higher
power states, like OMAP4 seems to be doing?

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
