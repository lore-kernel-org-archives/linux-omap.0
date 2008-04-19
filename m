From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/4] clockdomains: add OMAP2/3 clockdomain code,
	link 34xx clocks with clockdomains
Date: Fri, 18 Apr 2008 19:42:44 -0600
Message-ID: <20080419014100.8203.31672.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59953 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbYDSBsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 21:48:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, karthik-dp@ti.com, rnayak@ti.com, igor.stoppa@nokia.com, sakari.poussa@nokia.com, jouni.hogander@nokia.com, r-woodruff2@ti.com, paul@pwsan.com


Hi everyone,

This is the second version of the clockdomain patches.  It:=20

=2E adds the IVA1 clockdomain in the DSP powerdomain, for OMAP2420 only

=2E replaces omap_type_t typedef with struct omap_chip_id

=2E removes all EXPORT_SYMBOLs - these can be added back in if clockdom=
ain
  code needs to be used from loadable PM modules - the expectation is t=
hat=20
  it will only be used from PM code

=2E creates _clkdm_lookup() to avoid potential race in clkdm_register()

=2E fixes several clockdomain platform flag bugs

=2E gets rid of tabs in comments

=2E is refreshed against current git head (e015fc7)

This version is tested against 3430SDP ES2.1, and compile-tested with
N800 and 2430SDP configs.  Size, diffstat have been updated below.

Thanks to Tony & Jouni for review and comments.  More comments welcome,


- Paul

-------------------------

Hello,

this patch series adds a hardware control interface for OMAP2/3
clockdomains.  Also added is clockdomain usecounting of underlying
clocks, so hardware-supervised and software-supervised clockdomain
transitions can occur correctly.  The interface is fully documented in
the code.

24xx clocks are not yet linked with clockdomains. This will be done in
a later patchset.

This series must be applied after the powerdomain series, posted earlie=
r.

Clockdomain code tested on 3430SDP ES2.1; also boot-tested on N800.

Many people at Nokia and TI provided commentary and review during the
development of the clockdomain patches.  Particular help came from (in
alphabetical order): Karthik Dasu, Tony Lindgren, Rajendra Nayak,
Sakari Poussa, Igor Stoppa, and Richard Woodruff.  Jouni H=C3=B6gander
merits special mention; he took the original code and made it do what
it was supposed to do on the hardware, testing and fixing many bugs.


-----------

size:
  text    data     bss     dec     hex filename
3269405  152552  100736 3522693  35c085 vmlinux.3430sdp.orig
3272093  154920  100736 3527749  35d445 vmlinux.3430sdp

Paul Walmsley (4):
      Subject: Integrate OMAP3 clocks with clockdomain code
      Subject: encode OMAP2/3 clockdomains
      Subject: connect clockdomain code to powerdomain code
      Subject: add base OMAP2/3 clockdomain code


 arch/arm/mach-omap2/Makefile            |    3=20
 arch/arm/mach-omap2/clock.c             |   45 ++
 arch/arm/mach-omap2/clock.h             |    1=20
 arch/arm/mach-omap2/clock34xx.c         |    4=20
 arch/arm/mach-omap2/clock34xx.h         |  196 +++++++++-
 arch/arm/mach-omap2/clockdomain.c       |  606 +++++++++++++++++++++++=
++++++++
 arch/arm/mach-omap2/clockdomains.h      |  298 +++++++++++++++
 arch/arm/mach-omap2/cm-regbits-24xx.h   |   24 +
 arch/arm/mach-omap2/cm-regbits-34xx.h   |   42 ++
 arch/arm/mach-omap2/io.c                |    4=20
 arch/arm/mach-omap2/pm.c                |   12 -
 arch/arm/mach-omap2/powerdomain.c       |  132 +++++++
 arch/arm/plat-omap/Kconfig              |   12 +
 drivers/dsp/dspgateway/dsp_core.c       |    2=20
 include/asm-arm/arch-omap/clock.h       |    4=20
 include/asm-arm/arch-omap/clockdomain.h |  105 +++++
 include/asm-arm/arch-omap/powerdomain.h |   16 +
 17 files changed, 1457 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain.c
 create mode 100644 arch/arm/mach-omap2/clockdomains.h
 create mode 100644 include/asm-arm/arch-omap/clockdomain.h

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
