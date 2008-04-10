From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/4] Clockdomains: add OMAP2/3 clockdomain code, link 34xx clocks with clockdomains
Date: Thu, 10 Apr 2008 10:25:32 -0600
Message-ID: <20080410162532.097381890@pwsan.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34120 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100AbYDJRRr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2008 13:17:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com, sakari.poussa@nokia.com, igor.stoppa@nokia.com, karthik-dp@ti.com, rnayak@ti.com, r-woodruff2@ti.com, tony@atomide.com

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


Comments welcome,

- Paul

size:
  text    data     bss     dec     hex filename
3270030  151896  100832 3522758  35c0c6 vmlinux.3430sdp.orig
3272798  154168  100832 3527798  35d476 vmlinux.3430sdp

diffstat:
 arch/arm/mach-omap2/Makefile            |    3
 arch/arm/mach-omap2/clock.c             |   45 ++
 arch/arm/mach-omap2/clock.h             |    1
 arch/arm/mach-omap2/clock34xx.c         |    4
 arch/arm/mach-omap2/clock34xx.h         |  198 +++++++++-
 arch/arm/mach-omap2/clockdomain.c       |  583 +++++++++++++++++++++++=
+++++++++
 arch/arm/mach-omap2/clockdomains.h      |  283 +++++++++++++++
 arch/arm/mach-omap2/cm-regbits-24xx.h   |   24 -
 arch/arm/mach-omap2/cm-regbits-34xx.h   |   42 +-
 arch/arm/mach-omap2/io.c                |    4
 arch/arm/mach-omap2/pm.c                |   12
 arch/arm/mach-omap2/powerdomain.c       |  128 +++++++
 arch/arm/plat-omap/Kconfig              |   12
 drivers/dsp/dspgateway/dsp_core.c       |    2
 include/asm-arm/arch-omap/clock.h       |    4
 include/asm-arm/arch-omap/clockdomain.h |  105 +++++
 include/asm-arm/arch-omap/powerdomain.h |   17
 17 files changed, 1416 insertions(+), 51 deletions(-)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
