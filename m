From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] ARM: OMAP: Amstrad Delta defconfig fixes
Date: Wed, 4 Nov 2009 13:15:25 +0100
Message-ID: <200911041315.26589.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:56836 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453AbZKDMSr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 07:18:47 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

The patch provides the following fixes:

- keep kernel small enough to boot with standard tools,
- ensure compatibility with both new and legacy distros,
- turn on support for recently added or fixed hardware features.

Created and tested against linux-2.6.32-rc5.

Signed-off-by: Janusz Krzysztofik <jkrzysz@tis.icnet.pl>

---
Tuesday 03 November 2009 18:24:00 Tony Lindgren napisa=C5=82(a):
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091024 19:41]:
> >
> > Starting from the current version, created over 2 years ago for 2.6=
=2E22, I
> > turned on a few device drivers that was added recently, turned on t=
humb
> > instructions support, turned on EABI, kept old ABI compatibility an=
d
> > NWFPE, and got a resulting kernel that is ~170kB too large to be
> > successfully booted using tools available at http://the.earth.li/pu=
b/e3/.
> >
> > -# CONFIG_EMBEDDED is not set
> > -CONFIG_KALLSYMS=3Dy
> > +CONFIG_EMBEDDED=3Dy
> > +# CONFIG_KALLSYMS is not set
> >
> > That would give me a kernel that is small enough, but since only a =
few of
> > arm defconfigs have CONFIG_KALLSYMS not set, I am not sure if it is
> > generally acceptable.
>
> Just do the diff -u, then edit the patch to leave out all
> the other hunks except the one above.

Tony,
The one above is only for keeping the kernel small enough, with other c=
hanges
mentioned it's not so compact. Nevertheless, I hope the result can stil=
l go
as a fix.

Thanks,
Janusz

--- linux-2.6.32-rc5/arch/arm/configs/ams_delta_defconfig.orig	2009-11-=
03 21:11:55.000000000 +0100
+++ linux-2.6.32-rc5/arch/arm/configs/ams_delta_defconfig	2009-11-04 13=
:10:01.000000000 +0100
@@ -55,10 +55,10 @@
 CONFIG_INITRAMFS_SOURCE=3D""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
 CONFIG_SYSCTL=3Dy
-# CONFIG_EMBEDDED is not set
+CONFIG_EMBEDDED=3Dy
 CONFIG_UID16=3Dy
 CONFIG_SYSCTL_SYSCALL=3Dy
-CONFIG_KALLSYMS=3Dy
+# CONFIG_KALLSYMS is not set
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_HOTPLUG=3Dy
@@ -224,7 +224,7 @@
 #
 # Processor Features
 #
-# CONFIG_ARM_THUMB is not set
+CONFIG_ARM_THUMB=3Dy
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
 CONFIG_CPU_DCACHE_WRITETHROUGH=3Dy
@@ -248,7 +248,7 @@
 # CONFIG_HIGH_RES_TIMERS is not set
 CONFIG_PREEMPT=3Dy
 CONFIG_HZ=3D100
-# CONFIG_AEABI is not set
+CONFIG_AEABI=3Dy
 # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
 CONFIG_SELECT_MEMORY_MODEL=3Dy
 CONFIG_FLATMEM_MANUAL=3Dy
@@ -299,7 +299,9 @@
 #
 # Power management options
 #
-# CONFIG_PM is not set
+CONFIG_PM=3Dy
+# CONFIG_SUSPEND is not set
+CONFIG_PM_RUNTIME=3Dy
=20
 #
 # Networking
@@ -670,7 +672,7 @@
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
 # CONFIG_INPUT_JOYDEV is not set
 # CONFIG_INPUT_TSDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+CONFIG_INPUT_EVDEV=3Dy
 # CONFIG_INPUT_EVBUG is not set
=20
 #
@@ -784,6 +786,7 @@
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
+CONFIG_GPIO_SYSFS=3Dy
=20
 #
 # Dallas's 1-wire bus
@@ -820,6 +823,7 @@
 CONFIG_LEDS_TRIGGERS=3Dy
 CONFIG_LEDS_TRIGGER_TIMER=3Dy
 CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy
=20
 #
 # Multimedia devices
@@ -896,7 +900,13 @@
 #
 # Sound
 #
-# CONFIG_SOUND is not set
+CONFIG_SOUND=3Dy
+CONFIG_SND=3Dy
+CONFIG_SND_MIXER_OSS=3Dy
+CONFIG_SND_PCM_OSS=3Dy
+CONFIG_SND_SOC=3Dy
+CONFIG_SND_OMAP_SOC=3Dy
+CONFIG_SND_OMAP_SOC_AMS_DELTA=3Dy
=20
 #
 # HID Devices
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
