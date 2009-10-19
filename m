From: Tony Lindgren <tony@atomide.com>
Subject: Plat header changes merged, script to convert existing patches
Date: Mon, 19 Oct 2009 16:15:45 -0700
Message-ID: <20091019231545.GW12576@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J4XPiPrVK1ev6Sgr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53177 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732AbZJSXPo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 19:15:44 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1N01S7-0002Za-93
	for linux-omap@vger.kernel.org; Mon, 19 Oct 2009 23:15:48 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I've pushed the series posted last week to create #include <plat/xxx.h>
directory for us. [1]

As the series touches tons of header includes, here's a script you can
use to convert your existing patches.

Since generic arm code expects to find certain headers under
#include <mach/xxx.h>, we should follow the same naming in all our
files. And that's why the script below might become handy :)

Regards,

Tony

[1] http://marc.info/?l=linux-omap&m=125555743114559&w=2

--J4XPiPrVK1ev6Sgr
Content-Type: application/x-sh
Content-Disposition: inline; filename="omap-header-fixup.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0A#=0A# Convert omap headers to use plat except for the head=
ers=0A# arm compile expects to find under mach=0A#=0A# Usage: omap-header-f=
ixup.sh filename1 filename2 filename3 ..=0A#=0A# Or to refresh a patch:=0A#=
 $ git show | diffstat -l | xargs omap-header-fixup.sh=0A=0Aplat_dir=3D"arc=
h/arm/plat-omap/include/plat"=0A=0Amach_files=3D"clkdev.h gpio.h hardware.h=
 io.h irqs.h memory.h \=0Asmp.h system.h timex.h uncompress.h vmalloc.h"=0A=
=0A# Generated with:$ echo $(cd arch/arm/plat-omap/include/plat/ && ls *.h)=
=0Aplat_files=3D"blizzard.h board-ams-delta.h board.h board-sx1.h board-voi=
ceblue.h \=0Aclkdev.h clockdomain.h clock.h common.h control.h cpu.h dma.h =
dmtimer.h \=0Adsp_common.h fpga.h gpio.h gpio-switch.h gpmc.h gpmc-smc91x.h=
 hardware.h \=0Ahwa742.h io.h iommu2.h iommu.h iovmm.h irda.h irqs.h keypad=
=2Eh lcd_mipid.h \=0Aled.h mailbox.h mcbsp.h mcspi.h memory.h menelaus.h mm=
c.h mux.h nand.h \=0Aomap1510.h omap16xx.h omap24xx.h omap34xx.h omap44xx.h=
 omap730.h omap7xx.h \=0Aomap850.h omap-alsa.h omap_device.h omapfb.h omap_=
hwmod.h omap-pm.h onenand.h \=0Aparam.h powerdomain.h prcm.h sdrc.h serial.=
h smp.h sram.h system.h tc.h \=0Atimer-gp.h timex.h uncompress.h usb.h vmal=
loc.h"=0A=0Afor file in $*; do=0A	for plat_hdr in $plat_files; do=0A		is_ma=
ch=3D0=0A		for mach_hdr in $mach_files; do=0A			if [ "$plat_hdr" =3D "$mach=
_hdr" ]; then=0A				is_mach=3D1=0A			fi=0A		done=0A		if [ "$is_mach" -eq 0 =
]; then=0A			old=3D"#include <mach\/$plat_hdr"=0A			new=3D"#include <plat\/=
$plat_hdr"=0A			if [ -f $file ]; then=0A				sed -i "s/$old/$new/" $file=0A	=
		fi=0A		fi=0A	done=0Adone
--J4XPiPrVK1ev6Sgr--
