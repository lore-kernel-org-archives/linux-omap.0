From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv2 00/12] ARM: OMAP: core/hwmod: first set of fixes for 3.5-rc
Date: Sun, 10 Jun 2012 18:45:51 -0600
Message-ID: <20120611004502.20034.8840.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42515 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab2FKAwJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 20:52:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

Hi,

Here is an initial set of fixes for power management and OMAP core
infrastructure for 3.5-rc.  Most of these patches address boot
warnings and power management problems on OMAP4, although a few of
them address more general issues.

Thanks to (in alphabetical order) Beno=C3=AEt Cousson, Tero Kristo, Kev=
in
Hilman, Vaibhav Hiremath, and Tony Lindgren for help with this series.

Compile-test information is below.  The patches been boot-tested on
OMAP3530 ES3.0 BeagleBoard and OMAP4430 ES2.0 PandaBoard.  Suspend and
idle are broken on both of these platforms right now.  Unfortunately
my board farm is down at the moment, so I'm unable to do further
testing on other boards.  Boot logs, such as they are, are available
from:

http://www.pwsan.com/omap/bootlogs/20120610/omap_fixes_a_3.5rc__1869336=
b045e205b874e178443213815a8561cd1/

These patches are available via git from git://git.pwsan.com/linux-2.6
in the branch 'omap_fixes_a_3.5rc'.

This second version contains several changes:

- Rebased on v3.5-rc2.

- A new patch has been added to change the 32k sync timer
  SIDLEMODE flags ("ARM: OMAP4: hwmod data: fix 32k sync timer
  idle modes").

- A bug has been fixed ("ARM: OMAP2+: hwmod code/data: fix 32K
  sync timer").

- setup_preprogram code for the AESS and FSUSB IP blocks has been
  moved to include/linux/platform_data at Tony's request
  ("ARM: OMAP4+: AESS: enable internal auto-gating during initial
   setup" and "ARM: OMAP2+: usb_host_fs: add custom
   setup_preprogram for usb_host_fs (fsusb)")


- Paul

---

object size (delta in bytes from v3.5-rc2 (cfaf025112d3856637ff34a767ef=
785ef5cf2ca9)):
 text 	 data 	  bss 	total 	kernel
    0 	    0 	    0 	    0 	5912osk_testconfig/vmlinux
  +64 	  +96 	    0 	 +160 	n800_multi_omap2xxx/vmlinux
  +96 	  +96 	    0 	 +192 	n800_testconfig/vmlinux
    0 	    0 	    0 	    0 	omap1510_defconfig/vmlinux
    0 	    0 	    0 	    0 	omap1_defconfig/vmlinux
 +304 	 +320 	    0 	 +624 	omap2_4_testconfig/vmlinux
 +304 	 +448 	    0 	 +752 	omap2plus_defconfig/vmlinux
 +240 	 +384 	    0 	 +624 	omap2plus_no_pm/vmlinux
+4404 	 +312 	    0 	+4716 	omap3_4_testconfig/vmlinux
 +100 	  +56 	    0 	 +156 	omap3_testconfig/vmlinux
 +308 	 +280 	    0 	 +588 	omap4_testconfig/vmlinux

Djamil Elaidi (1):
      ARM: OMAP4+: hwmod: fix issue causing IPs not going back to Smart=
-Standby

Paul Walmsley (10):
      ARM: OMAP2+: hwmod code/data: fix 32K sync timer
      ARM: OMAP4: hwmod data: fix 32k sync timer idle modes
      ARM: OMAP2+: hwmod: add setup_preprogram hook
      ARM: OMAP2+: hwmod: add flag to prevent hwmod code from touching =
IP block during init
      ARM: OMAP4+: AESS: enable internal auto-gating during initial set=
up
      ARM: OMAP4: hwmod data: add SL2IF hardreset line
      ARM: OMAP2+: usb_host_fs: add custom setup_preprogram for usb_hos=
t_fs (fsusb)
      ARM: OMAP2+: CM: increase the module disable timeout
      ARM: OMAP4: clock data: add clockdomains for clocks used as main =
clocks
      ARM: OMAP4: hwmod data: do not enable or reset the McPDM during k=
ernel init

Todd Poynor (1):
      ARM: OMAP: PM: Lock clocks list while generating summary


 arch/arm/mach-omap2/clock44xx_data.c         |    5 +
 arch/arm/mach-omap2/cm.h                     |   11 +++
 arch/arm/mach-omap2/cminst44xx.c             |    4 -
 arch/arm/mach-omap2/omap_hwmod.c             |   43 +++++++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    2=20
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   30 +++++++
 arch/arm/plat-omap/clock.c                   |    2=20
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   24 ++++++
 include/linux/platform_data/aess.h           |   76 ++++++++++++++++++=
+
 include/linux/platform_data/fsusb.h          |  105 ++++++++++++++++++=
++++++++
 10 files changed, 288 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/platform_data/aess.h
 create mode 100644 include/linux/platform_data/fsusb.h


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
