From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] Powerdomains: add OMAP2/3 powerdomain code and common
	OMAP type bitfield
Date: Fri, 18 Apr 2008 19:23:46 -0600
Message-ID: <20080419012246.6809.79667.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60026 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbYDSBe4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 21:34:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, igor.stoppa@nokia.com, sakari.poussa@nokia.com, jouni.hogander@nokia.com, r-woodruff2@ti.com, paul@pwsan.com


Hi everyone,

This is the second version of the powerdomain patches.  It:

=2E replaces omap_type_t typedef with struct omap_chip_id

=2E fixes 34xx bug in OMAP type detection code

=2E removes all EXPORT_SYMBOLs - these can be added back in if powerdom=
ain
  code needs to be used from loadable PM modules - the expectation is t=
hat
  it will only be used from PM code

=2E gets rid of all of the forward declarations in the powerdomain
  dependency definitions - now uses powerdomain names

=2E creates _pwrdm_lookup() to avoid potential race in pwrdm_register()

=2E gets rid of tabs in comments

=2E cleans up some dead structure members in struct powerdomain

=2E adds IVA2 sleepdep for DSS, PER, USBHOST

=2E is refreshed against current git head (e015fc7)

This version is tested against 3430SDP ES2.1, and compile-tested with
the N800 and 2430SDP configs.  Size, diffstat have been updated below.

Thanks to Tony & Jouni for review and comments.  More comments welcome,


- Paul

-------------------------

Hello,

this patch series adds a hardware control and monitoring interface for
OMAP2/3 powerdomains.  The interface is fully documented in the code.

The series also adds a common OMAP chip type detection bitfield for use
with powerdomain and clockdomain structures; it is planned to expand it=
s
use to the clock framework in the future.

Powerdomain code tested on 3430SDP ES2.1; also boot-tested on N800.

Many people at Nokia and TI provided commentary and review during the
development of the powerdomain patches.  Particular help came from (in
alphabetical order): Jouni H=C3=B6gander, Tony Lindgren, Sakari Poussa,
Igor Stoppa, and Richard Woodruff.

---

   text    data     bss     dec     hex filename
3265996  151704  100736 3518436  35afe4 vmlinux.3430sdp.orig
3269405  152552  100736 3522693  35c085 vmlinux.3430sdp


Paul Walmsley (5):
      Subject: add OMAP3 powerdomains
      Subject: add OMAP2 powerdomains
      Subject: add OMAP2/3 common powerdomains
      Subject: add base OMAP2/3 powerdomain code
      Subject: add OMAP chip type global bitfield; clean up mach-omap2/=
id.c


 arch/arm/mach-omap2/Makefile            |    2
 arch/arm/mach-omap2/id.c                |  167 ++++--
 arch/arm/mach-omap2/io.c                |    5
 arch/arm/mach-omap2/pm.c                |    2
 arch/arm/mach-omap2/powerdomain.c       |  885 +++++++++++++++++++++++=
++++++++
 arch/arm/mach-omap2/powerdomains.h      |  187 +++++++
 arch/arm/mach-omap2/powerdomains24xx.h  |  200 +++++++
 arch/arm/mach-omap2/powerdomains34xx.h  |  327 +++++++++++
 arch/arm/mach-omap2/prcm-common.h       |    3
 arch/arm/mach-omap2/prm-regbits-24xx.h  |   12
 arch/arm/mach-omap2/prm-regbits-34xx.h  |   11
 arch/arm/mach-omap2/prm.h               |    3
 arch/arm/plat-omap/Kconfig              |   12
 include/asm-arm/arch-omap/cpu.h         |   33 +
 include/asm-arm/arch-omap/powerdomain.h |  137 +++++
 15 files changed, 1924 insertions(+), 62 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain.c
 create mode 100644 arch/arm/mach-omap2/powerdomains.h
 create mode 100644 arch/arm/mach-omap2/powerdomains24xx.h
 create mode 100644 arch/arm/mach-omap2/powerdomains34xx.h
 create mode 100644 include/asm-arm/arch-omap/powerdomain.h

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
