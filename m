From: Dmitriy Chumak <dmytro.chumak@globallogic.com>
Subject: ZOOM1 & SDP2430: MMC/SDIO: doesn't work at all
Date: Mon, 2 Mar 2009 19:09:40 +0200
Message-ID: <200903021909.40731.dmytro.chumak@globallogic.com>
Reply-To: dmytro.chumak@globallogic.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx-del1-1.globallogic.com ([202.174.92.25]:45836 "EHLO
	emailsecurity-del1-1.globallogic.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754679AbZCBRa4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 12:30:56 -0500
Received: from emailsecurity-del1-1.globallogic.com (127.0.0.1) by emailsecurity-del1-1.globallogic.com (MlfMTA v3.2r9) id hlgbj60171sh for <linux-omap@vger.kernel.org>; Mon, 2 Mar 2009 22:37:07 +0530 (envelope-from <Dmytro.Chumak@globallogic.com>)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I have a Zoom1 (3430 LDP) and SDP2430 devices.

I work on SDIO driver.

On both devices I have problems with SDIO using community kernels:

Zoom1:
--------------------------------------------------------------------------

    git://git.omapzoom.org/repo/omapkernel.git

    $ uname -a
    Linux OMAP3430LAB 2.6.27.10-omap1-00207-g26d16da #1 Mon Mar 2 15:50:14 EET 2009 armv7l unknown

To build a kernel I've used omap_ldp_defconfig

On kernel boot I get the following:

<7>mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
<7>mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
<7>mmc0: starting CMD0 arg 00000000 flags 000000c0
<7>mmci-omap mmci-omap.0: mmc0: CMD0, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 1
<7>mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
<7>mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
<7>mmc0: starting CMD8 arg 000001aa flags 000002f5
<7>mmci-omap mmci-omap.0: mmc0: CMD8, argument 0x000001aa
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI CTO
<7>mmc0: req done (CMD8): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD5 arg 00000000 flags 000002e1
<7>mmci-omap mmci-omap.0: mmc0: CMD5, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI CTO
<7>mmc0: req failed (CMD5): -110, retrying...
<7>mmci-omap mmci-omap.0: mmc0: CMD5, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI CTO
<7>mmc0: req failed (CMD5): -110, retrying...
<7>mmci-omap mmci-omap.0: mmc0: CMD5, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI CTO
<7>mmc0: req failed (CMD5): -110, retrying...
<7>mmci-omap mmci-omap.0: mmc0: CMD5, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI CTO
<7>mmc0: req done (CMD5): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD55 arg 00000000 flags 000000f5
<7>mmci-omap mmci-omap.0: mmc0: CMD55, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI CTO
<7>mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD55 arg 00000000 flags 000000f5
<7>mmci-omap mmci-omap.0: mmc0: CMD55, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI CTO
<7>mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD55 arg 00000000 flags 000000f5
<7>mmci-omap mmci-omap.0: mmc0: CMD55, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI CTO
<7>mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD55 arg 00000000 flags 000000f5
<7>mmci-omap mmci-omap.0: mmc0: CMD55, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI CTO
<7>mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD1 arg 00000000 flags 000000e1
<7>mmci-omap mmci-omap.0: mmc0: CMD1, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI CTO
<7>mmc0: req done (CMD1): -110: 00000000 00000000 00000000 00000000
<7>mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0


When I insert SDIO card:


<7>mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
<7>mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
<7>mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
<7>mmc0: starting CMD0 arg 00000000 flags 000000c0
mmc0: starting CMD0 arg 00000000 flags 000000c0
<7>mmci-omap mmci-omap.0: mmc0: CMD0, argument 0x00000000
mmci-omap mmci-omap.0: mmc0: CMD0, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 1
mmci-omap mmci-omap.0: IRQ Status is 1
<7>mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
<7>mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
<7>mmc0: starting CMD8 arg 000001aa flags 000002f5
mmc0: starting CMD8 arg 000001aa flags 000002f5
<7>mmci-omap mmci-omap.0: mmc0: CMD8, argument 0x000001aa
mmci-omap mmci-omap.0: mmc0: CMD8, argument 0x000001aa
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 :mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI ERRI CTO CTO

<7>mmc0: req done (CMD8): -110: 00000000 00000000 00000000 00000000
mmc0: req done (CMD8): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD5 arg 00000000 flags 000002e1
mmc0: starting CMD5 arg 00000000 flags 000002e1
<7>mmci-omap mmci-omap.0: mmc0: CMD5, argument 0x00000000
mmci-omap mmci-omap.0: mmc0: CMD5, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 :mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI ERRI CTO CTO

<7>mmc0: req failed (CMD5): -110, retrying...
mmc0: req failed (CMD5): -110, retrying...
<7>mmci-omap mmci-omap.0: mmc0: CMD5, argument 0x00000000
mmci-omap mmci-omap.0: mmc0: CMD5, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 :mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI ERRI CTO CTO

<7>mmc0: req failed (CMD5): -110, retrying...
mmc0: req failed (CMD5): -110, retrying...
<7>mmci-omap mmci-omap.0: mmc0: CMD5, argument 0x00000000
mmci-omap mmci-omap.0: mmc0: CMD5, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 :mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI ERRI CTO CTO

<7>mmc0: req failed (CMD5): -110, retrying...
mmc0: req failed (CMD5): -110, retrying...
<7>mmci-omap mmci-omap.0: mmc0: CMD5, argument 0x00000000
mmci-omap mmci-omap.0: mmc0: CMD5, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 :mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI ERRI CTO CTO

<7>mmc0: req done (CMD5): -110: 00000000 00000000 00000000 00000000
mmc0: req done (CMD5): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD55 arg 00000000 flags 000000f5
mmc0: starting CMD55 arg 00000000 flags 000000f5
<7>mmci-omap mmci-omap.0: mmc0: CMD55, argument 0x00000000
mmci-omap mmci-omap.0: mmc0: CMD55, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 :mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI ERRI CTO CTO

<7>mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD55 arg 00000000 flags 000000f5
mmc0: starting CMD55 arg 00000000 flags 000000f5
<7>mmci-omap mmci-omap.0: mmc0: CMD55, argument 0x00000000
mmci-omap mmci-omap.0: mmc0: CMD55, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 :mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI ERRI CTO CTO

<7>mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD55 arg 00000000 flags 000000f5
mmc0: starting CMD55 arg 00000000 flags 000000f5
<7>mmci-omap mmci-omap.0: mmc0: CMD55, argument 0x00000000
mmci-omap mmci-omap.0: mmc0: CMD55, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 :mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI ERRI CTO CTO

<7>mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD55 arg 00000000 flags 000000f5
mmc0: starting CMD55 arg 00000000 flags 000000f5
<7>mmci-omap mmci-omap.0: mmc0: CMD55, argument 0x00000000
mmci-omap mmci-omap.0: mmc0: CMD55, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 :mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI ERRI CTO CTO

<7>mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
<7>mmc0: starting CMD1 arg 00000000 flags 000000e1
mmc0: starting CMD1 arg 00000000 flags 000000e1
<7>mmci-omap mmci-omap.0: mmc0: CMD1, argument 0x00000000
mmci-omap mmci-omap.0: mmc0: CMD1, argument 0x00000000
<7>mmci-omap mmci-omap.0: IRQ Status is 18000
mmci-omap mmci-omap.0: IRQ Status is 18000
<7>mmci-omap mmci-omap.0: MMC IRQ 0x18000 :mmci-omap mmci-omap.0: MMC IRQ 0x18000 : ERRI ERRI CTO CTO

<7>mmc0: req done (CMD1): -110: 00000000 00000000 00000000 00000000
mmc0: req done (CMD1): -110: 00000000 00000000 00000000 00000000
<7>mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0



SDP2430:
--------------------------------------------------------------------------

    git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
 
    $ uname -a
    Linux omap 2.6.29-rc6-omap1-05477-gab3c802 #2 PREEMPT Mon Mar 2 14:47:42 EET 2009 armv6l GNU/Linux

To build a kernel I've used omap_2430sdp_defconfig

On kernel boot I get the following:

kobject: 'mmcblk' (c1da3f20): kobject_add_internal: parent: 'drivers', set: 'drivers'
kobject: 'mmcblk' (c1da3f20): kobject_uevent_env
kobject: 'mmcblk' (c1da3f20): fill_kobj_path: path = '/bus/mmc/drivers/mmcblk'
kobject: 'mmci-omap-hs' (c1da3ec0): kobject_add_internal: parent: 'drivers', set: 'drivers'
kobject: 'mmc0' (c1d35c4c): kobject_add_internal: parent: 'mmc_host', set: 'devices'
kobject: 'mmc0' (c1d35c4c): kobject_uevent_env
kobject: 'mmc0' (c1d35c4c): fill_kobj_path: path = '/class/mmc_host/mmc0'
kobject: 'mmci-omap-hs.0' (c1c3e24c): fill_kobj_path: path = '/devices/platform/mmci-omap-hs.0'
mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
kobject: 'mmci-omap-hs' (c1da3ec0): kobject_uevent_env
kobject: 'mmci-omap-hs' (c1da3ec0): fill_kobj_path: path = '/bus/platform/drivers/mmci-omap-hs'
mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 19 width 0 timing 0
mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 19 width 0 timing 0
mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 19 width 0 timing 0
mmc0: starting CMD0 arg 00000000 flags 000000c0
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD0, argument 0x00000000
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 1
mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 19 width 0 timing 0
mmc0: starting CMD8 arg 000001aa flags 000002f5
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD8, argument 0x000001aa
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 18000
mmci-omap-hs mmci-omap-hs.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req done (CMD8): -110: 00000000 00000000 00000000 00000000
mmc0: starting CMD5 arg 00000000 flags 000002e1
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD5, argument 0x00000000
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 18000
mmci-omap-hs mmci-omap-hs.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req failed (CMD5): -110, retrying...
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD5, argument 0x00000000
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 18000
mmci-omap-hs mmci-omap-hs.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req failed (CMD5): -110, retrying...
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD5, argument 0x00000000
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 18000
mmci-omap-hs mmci-omap-hs.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req failed (CMD5): -110, retrying...
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD5, argument 0x00000000
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 18000
mmci-omap-hs mmci-omap-hs.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req done (CMD5): -110: 00000000 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD55, argument 0x00000000
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 18000
mmci-omap-hs mmci-omap-hs.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD55, argument 0x00000000
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 18000
mmci-omap-hs mmci-omap-hs.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD55, argument 0x00000000
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 18000
mmci-omap-hs mmci-omap-hs.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD55, argument 0x00000000
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 18000
mmci-omap-hs mmci-omap-hs.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
mmc0: starting CMD1 arg 00000000 flags 000000e1
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD1, argument 0x00000000
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 18000
mmci-omap-hs mmci-omap-hs.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req done (CMD1): -110: 00000000 00000000 00000000 00000000
mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0

Also on SDP2430 I can observe the following:

    There is 2 LEDs (MMC1-1V8 and MMC1-3V0) near the MMC1 slot.  When I use
    an "official TI kernel" for SDP2430 (package version CSSD_Linux_18.12,
    kernel version Linux-2.6.14.7-arm1-omap2) SDIO works well and LED
    MMC1-3V0 is always on when kernel is booted. But with latest community
    kernel both LEDs are off and SDIO doesn't work and there are no logs
    on SDIO card insertion.

Did someone encounter a similar problem with SDIO? Or maybe someone can
advise me to build kernel from some special branch or to use special config
options?


Best regards,

Dmitriy
