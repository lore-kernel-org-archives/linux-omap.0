From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/10] omap non-critical fixes for v3.5 merge window
Date: Thu, 10 May 2012 11:39:17 -0700
Message-ID: <3392.59662800959$1336675172@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:33948 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757463Ab2EJSjW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 14:39:22 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-non-critical-for-v3.5

for you to fetch changes up to b2f44dc29bfab77b10f3a709f14677f51ce3a4cd:

  ARM: OMAP: igep0020: Specify the VPLL2 regulator unconditionally (2012-05-09 11:21:45 -0700)

----------------------------------------------------------------
Omap fixes that were considered too intrusive or not critical for the -rc cycle

----------------------------------------------------------------
Artem Bityutskiy (1):
      ARM: OMAP1: fix compilation issue in board-sx1.c

Balaji T K (1):
      ARM: OMAP4: hsmmc: check for null pointer

Chris Lalancette (1):
      ARM: OMAP4: Adding ID for OMAP4460 ES1.1

Felipe Contreras (1):
      ARM: OMAP: fix trivial warnings for dspbridge

Grazvydas Ignotas (1):
      ARM: OMAP2+: remove incorrect irq_chip ack field

Kevin Hilman (1):
      ARM: OMAP2+: INTC: fix Kconfig option for TI81XX

Laurent Pinchart (1):
      ARM: OMAP: igep0020: Specify the VPLL2 regulator unconditionally

Tomi Valkeinen (1):
      ARM: OMAP4: panda: add statics to remove warnings

Tony Lindgren (1):
      ARM: OMAP2+: Incorrect Register Offsets in OMAP Mailbox

 arch/arm/mach-omap1/Kconfig            |    1 +
 arch/arm/mach-omap2/board-4430sdp.c    |   44 ------------------------
 arch/arm/mach-omap2/board-igep0020.c   |   10 +++---
 arch/arm/mach-omap2/board-omap4panda.c |   57 +++----------------------------
 arch/arm/mach-omap2/common.h           |    3 ++
 arch/arm/mach-omap2/dsp.c              |    5 +--
 arch/arm/mach-omap2/id.c               |    5 ++-
 arch/arm/mach-omap2/irq.c              |    3 +-
 arch/arm/mach-omap2/mailbox.c          |    6 ++--
 arch/arm/mach-omap2/omap4-common.c     |   58 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/devices.c           |    4 +--
 arch/arm/plat-omap/include/plat/cpu.h  |    1 +
 12 files changed, 85 insertions(+), 112 deletions(-)
