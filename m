From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] Powerdomains: add OMAP2/3 powerdomain code, and common OMAP type bitfield
Date: Thu, 10 Apr 2008 08:46:24 -0600
Message-ID: <20080410144624.246788469@pwsan.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47221 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400AbYDJRPO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2008 13:15:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com, sakari.poussa@nokia.com, igor.stoppa@nokia.com, r-woodruff2@ti.com, tony@atomide.com

Hello,

this patch series adds a hardware control and monitoring interface for=20
OMAP2/3 powerdomains.  The interface is fully documented in the code. =20

The series also adds a common OMAP chip type detection bitfield for use=
=20
with powerdomain and clockdomain structures; it is planned to expand it=
s
use to the clock framework in the future.

Powerdomain code tested on 3430SDP ES2.1; also boot-tested on N800.

Many people at Nokia and TI provided commentary and review during the
development of the powerdomain patches.  Particular help came from (in
alphabetical order): Jouni H=C3=B6gander, Tony Lindgren, Sakari Poussa,
Igor Stoppa, and Richard Woodruff.


Comments welcome,

- Paul


size:
  text    data     bss     dec     hex filename
3265548  151032  100736 3517316  35ab84 vmlinux.3430sdp.orig
3270062  151896  100832 3522790  35c0e6 vmlinux.3430sdp


diffstat:
 arch/arm/mach-omap2/Makefile            |    2
 arch/arm/mach-omap2/id.c                |  166 ++++--
 arch/arm/mach-omap2/io.c                |    7
 arch/arm/mach-omap2/pm.c                |    2
 arch/arm/mach-omap2/powerdomain.c       |  884 +++++++++++++++++++++++=
+++++++++
 arch/arm/mach-omap2/powerdomains.h      |  180 ++++++
 arch/arm/mach-omap2/powerdomains24xx.h  |  176 ++++++
 arch/arm/mach-omap2/powerdomains34xx.h  |  296 ++++++++++
 arch/arm/mach-omap2/prcm-common.h       |    3
 arch/arm/mach-omap2/prm-regbits-24xx.h  |   12
 arch/arm/mach-omap2/prm-regbits-34xx.h  |   11
 arch/arm/mach-omap2/prm.h               |    3
 arch/arm/plat-omap/Kconfig              |   12
 include/asm-arm/arch-omap/cpu.h         |   27
 include/asm-arm/arch-omap/powerdomain.h |  137 ++++
 15 files changed, 1853 insertions(+), 65 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
