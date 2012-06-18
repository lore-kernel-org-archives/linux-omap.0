From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv3 0/7] ARM: OMAP: core/hwmod: first set of fixes for 3.5-rc
Date: Mon, 18 Jun 2012 00:15:54 -0600
Message-ID: <20120618061037.30632.28539.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55768 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab2FRGS1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 02:18:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

Here is an initial set of fixes for power management and OMAP core
infrastructure for 3.5-rc.  Most of these patches address boot
warnings and power management problems on OMAP4, although a few of
them address more general issues.

Thanks to (in alphabetical order) Beno=C3=AEt Cousson, Tero Kristo, Kev=
in
Hilman, Vaibhav Hiremath, and Tony Lindgren for help with this series.

Compile- and boot-test information is below.  Note that on OMAP3,
return from suspend when off-mode is enabled is via GPIO buttons due to=
:

http://www.spinics.net/lists/arm-kernel/msg173688.html

Boot logs are available from:

http://www.pwsan.com/omap/bootlogs/20120617/omap_fixes_a_3.5rc__52a5ae4=
06dadef781bfcf3a641dae2064e9697ff/

These patches are available via git from git://git.pwsan.com/linux-2.6
in the branch 'omap_fixes_a_3.5rc'.

This third version adds a fix for a new sparse warning, and drops
everything that is still being commented on or reviewed or which needs
acks.  Hopefully those will make it into a future 3.5-rc series.


- Paul

---

object size (delta in bytes from v3.5-rc3 (485802a6c524e62b5924849dd727=
ddbb1497cc71)):
 text 	 data 	  bss 	total 	kernel
    0 	    0 	    0 	    0 	5912osk_testconfig/vmlinux
  +32 	    0 	    0 	  +32 	n800_multi_omap2xxx/vmlinux
  +64 	    0 	    0 	  +64 	n800_testconfig/vmlinux
    0 	    0 	    0 	    0 	omap1510_defconfig/vmlinux
    0 	    0 	    0 	    0 	omap1_defconfig/vmlinux
  +64 	    0 	    0 	  +64 	omap2_4_testconfig/vmlinux
+4160 	    0 	    0 	+4160 	omap2plus_defconfig/vmlinux
    0 	    0 	    0 	    0 	omap2plus_no_pm/vmlinux
    0 	    0 	    0 	    0 	omap3_4_testconfig/vmlinux
    0 	    0 	    0 	    0 	omap3_testconfig/vmlinux
  +64 	    0 	    0 	  +64 	omap4_testconfig/vmlinux


Djamil Elaidi (1):
      ARM: OMAP4+: hwmod: fix issue causing IPs not going back to Smart=
-Standby

Paul Walmsley (5):
      ARM: OMAP2+: hwmod code/data: fix 32K sync timer
      ARM: OMAP4: hwmod data: fix 32k sync timer idle modes
      ARM: OMAP4: clock data: add clockdomains for clocks used as main =
clocks
      ARM: OMAP2+: CM: increase the module disable timeout
      ARM: OMAP2+: mux: fix sparse warning

Todd Poynor (1):
      ARM: OMAP: PM: Lock clocks list while generating summary


 arch/arm/mach-omap2/clock44xx_data.c         |    5 +++++
 arch/arm/mach-omap2/cm.h                     |   11 ++++++++++
 arch/arm/mach-omap2/cminst44xx.c             |    4 ++--
 arch/arm/mach-omap2/mux.c                    |    1 +
 arch/arm/mach-omap2/omap_hwmod.c             |   28 ++++++++++++++++++=
--------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    6 +++---
 arch/arm/plat-omap/clock.c                   |    2 ++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    9 ++++++++
 9 files changed, 53 insertions(+), 15 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
