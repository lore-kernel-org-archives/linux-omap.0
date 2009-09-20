From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [RFC] OMAP1: Massive clean up of omap730/omap850 code
Date: Sun, 20 Sep 2009 05:07:23 +0100
Message-ID: <3d374d00909192107t3e7d591dhf1a94ba43d0422e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:55973 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbZITEHV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Sep 2009 00:07:21 -0400
Received: by bwz6 with SMTP id 6so1380019bwz.37
        for <linux-omap@vger.kernel.org>; Sat, 19 Sep 2009 21:07:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello from the Linwizard project,

We have been working on supporting omap850 smartphones from HTC such
as Wizard, Herald etc. We have found that omap730 and omap850 are
almost exactly the same. As far as what is supported in linux-omap so
far, they are identical. Currently there are seperate code paths for
730 and 850, and this is causing us a lot of problems when one is
changed and the other isn't. I also noticed that OMAP F-Sample board
uses ARCH_OMAP730 even though it has a OMAP850 SoC.

In order to try to clean this up I have produced a patch series which
removes all cpu_is_omap730/850 and replaces them with unified
cpu_is_omap7xx() blocks, and similarly merges CONFIG checks. Here is a
random example:

-#ifdef CONFIG_ARCH_OMAP730
- if (cpu_is_omap730()) {
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+ if (cpu_is_omap7xx()) {
irq_banks =3D omap730_irq_banks;
irq_bank_count =3D ARRAY_SIZE(omap730_irq_banks);
}
#endif
-#ifdef CONFIG_ARCH_OMAP850
- if (cpu_is_omap850()) {
- irq_banks =3D omap850_irq_banks;
- irq_bank_count =3D ARRAY_SIZE(omap850_irq_banks);
- }
-#endif

Drilling down through the variables shows they are always equivalent
for 730 and 850, except where there is a bug.

The patch series converts all 730/850 specific code to omap7xx as
above. Then all variables and defines have been renamed to refer to
7xx. omap730.h and omap850.h are removed and replaced with omap7xx.h.
ARCH_OMAP730 and ARCH_OMAP850 are still distinct, as there are a few
differences - but only things that haven't been implemented yet.

This makes several bugs go away for us on omap850, including the
MPUIO_VBASE bug, and the lack of working IRQs - since these bugs arn't
in the 730 paths. It would hopefully prevent similar bugs from showing
up in the future too.

I did everything as small patches, so I won't spam all 35+ patches on
the list. The work is available in branch omap7xx here:

http://ali1234.homelinux.net/linwizard-kernel.git/

git diff-tree --stat linux-omap/master omap7xx

arch/arm/mach-omap1/board-fsample.c =A0 =A0 =A0 =A0 =A0 | =A0 18 +-
arch/arm/mach-omap1/board-perseus2.c =A0 =A0 =A0 =A0 =A0| =A0 18 +-
arch/arm/mach-omap1/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 2=
2 ++-
arch/arm/mach-omap1/clock.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 3=
0 ++++
arch/arm/mach-omap1/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 45 ++----
arch/arm/mach-omap1/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 32 +---
arch/arm/mach-omap1/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 3=
2 ++--
arch/arm/mach-omap1/mux.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 70 +++-----
arch/arm/mach-omap1/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
100 ++++++------
arch/arm/mach-omap1/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 53 +++---
arch/arm/mach-omap1/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 1=
3 +-
arch/arm/mach-omap1/sleep.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 2=
2 ++--
arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
6 +-
arch/arm/plat-omap/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 2=
2 ++--
arch/arm/plat-omap/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
227 +++++++------------------
arch/arm/plat-omap/include/mach/entry-macro.S | =A0 =A08 +-
arch/arm/plat-omap/include/mach/hardware.h =A0 =A0| =A0 =A02 +-
arch/arm/plat-omap/include/mach/irqs.h =A0 =A0 =A0 =A0| =A0229 ++++++++=
-----------------
arch/arm/plat-omap/include/mach/mcbsp.h =A0 =A0 =A0 | =A0 =A06 +-
arch/arm/plat-omap/include/mach/mux.h =A0 =A0 =A0 =A0 | =A0100 +++-----=
---
arch/arm/plat-omap/include/mach/omap730.h =A0 =A0 | =A0102 -----------
arch/arm/plat-omap/include/mach/omap7xx.h =A0 =A0 | =A0102 +++++++++++
arch/arm/plat-omap/include/mach/omap850.h =A0 =A0 | =A0102 -----------
arch/arm/plat-omap/include/mach/uncompress.h =A0| =A0 =A03 +-
arch/arm/plat-omap/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 14 +-
arch/arm/plat-omap/usb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 10 +-
drivers/rtc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +-
drivers/spi/omap_uwire.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A08 +-
28 files changed, 513 insertions(+), 885 deletions(-)

--
Alistair Buxton
a.j.buxton@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
