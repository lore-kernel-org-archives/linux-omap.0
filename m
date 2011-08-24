From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] omap cleanup for makefile and init_early
Date: Wed, 24 Aug 2011 04:54:28 -0700
Message-ID: <20110824115048.2985.24230.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45877 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752725Ab1HXLya (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 07:54:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are few patches for review to cleanup mach-omap2 for
Makefile and init_early.

The init_early changes will continue the earlier cleanup
efforts of initializing things later on during the boot
and cutting down dependencies.

Regards,

Tony

---

Tony Lindgren (3):
      omap2+: Use Kconfig symbol in Makefile instead of obj-y
      ARM: OMAP: Move omap2_init_common_devices out of init_early
      ARM: OMAP: Introduce SoC specific early_init


 arch/arm/mach-omap2/Makefile               |   76 ++++++++++++----------------
 arch/arm/mach-omap2/board-2430sdp.c        |    9 +--
 arch/arm/mach-omap2/board-3430sdp.c        |    9 +--
 arch/arm/mach-omap2/board-3630sdp.c        |   11 +---
 arch/arm/mach-omap2/board-4430sdp.c        |    9 +--
 arch/arm/mach-omap2/board-am3517crane.c    |    9 +--
 arch/arm/mach-omap2/board-am3517evm.c      |    8 +--
 arch/arm/mach-omap2/board-apollon.c        |    9 +--
 arch/arm/mach-omap2/board-cm-t35.c         |   13 +----
 arch/arm/mach-omap2/board-cm-t3517.c       |    9 +--
 arch/arm/mach-omap2/board-devkit8000.c     |   12 +---
 arch/arm/mach-omap2/board-generic.c        |    2 -
 arch/arm/mach-omap2/board-h4.c             |    9 +--
 arch/arm/mach-omap2/board-igep0020.c       |   13 +----
 arch/arm/mach-omap2/board-ldp.c            |    9 +--
 arch/arm/mach-omap2/board-n8x0.c           |   13 +----
 arch/arm/mach-omap2/board-omap3beagle.c    |    4 +
 arch/arm/mach-omap2/board-omap3evm.c       |    9 +--
 arch/arm/mach-omap2/board-omap3logic.c     |   11 +---
 arch/arm/mach-omap2/board-omap3pandora.c   |   11 +---
 arch/arm/mach-omap2/board-omap3stalker.c   |    9 +--
 arch/arm/mach-omap2/board-omap3touchbook.c |   11 +---
 arch/arm/mach-omap2/board-omap4panda.c     |    9 +--
 arch/arm/mach-omap2/board-overo.c          |   11 +---
 arch/arm/mach-omap2/board-rm680.c          |   17 +++---
 arch/arm/mach-omap2/board-rx51.c           |   17 +++---
 arch/arm/mach-omap2/board-ti8168evm.c      |    9 +--
 arch/arm/mach-omap2/board-zoom.c           |   23 ++++----
 arch/arm/mach-omap2/io.c                   |   40 +++++++++++++++
 arch/arm/plat-omap/include/plat/common.h   |    9 +++
 30 files changed, 164 insertions(+), 246 deletions(-)

-- 
Signature
