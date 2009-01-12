From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/10] Omap fixes for 2.6.29-rc1
Date: Mon, 12 Jan 2009 16:37:07 +0200
Message-ID: <20090112143405.24205.52151.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55552 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbZALOhL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 09:37:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi,

Here are some omap fixes for review. Some of these patches
were posted earlier.

Regards,

Tony

---

Anand Gadiyar (1):
      ARM: OMAP: Fix DMA CCR programming for request line > 63

Arun KS (1):
      ARM: OMAP: Fix OSK ASoC by registering I2C board info for tlvaic23

Huang Weiyi (1):
      ARM: OMAP: remove duplicated #include's

Jarkko Nikula (1):
      ARM: OMAP: Fix gpio by switching to generic gpio calls, v2

Tony Lindgren (6):
      ARM: OMAP: Remove unused platform devices for old ALSA code
      ARM: OMAP: Fix ASoC by enabling writes to XCCR and RCCR McBSP registers
      ARM: OMAP: Fix gpio.c compile on 15xx with CONFIG_DEBUGFS
      ARM: OMAP: Fix compile for beagle
      ARM: OMAP: Fix compile for palmte
      ARM: OMAP: Fix compile for various McBSP


 arch/arm/mach-omap1/board-h2.c          |   38 ----------
 arch/arm/mach-omap1/board-h3.c          |   38 ----------
 arch/arm/mach-omap1/board-innovator.c   |   39 ----------
 arch/arm/mach-omap1/board-nokia770.c    |    7 ++
 arch/arm/mach-omap1/board-osk.c         |   43 +----------
 arch/arm/mach-omap1/board-palmte.c      |   29 --------
 arch/arm/mach-omap1/board-palmtt.c      |   41 -----------
 arch/arm/mach-omap1/board-palmz71.c     |   37 ----------
 arch/arm/mach-omap1/board-sx1.c         |   38 +---------
 arch/arm/mach-omap1/board-voiceblue.c   |    1 
 arch/arm/mach-omap1/mcbsp.c             |    1 
 arch/arm/mach-omap2/board-apollon.c     |   64 ++---------------
 arch/arm/mach-omap2/board-ldp.c         |    2 -
 arch/arm/mach-omap2/board-omap3beagle.c |    9 +-
 arch/arm/mach-omap2/mcbsp.c             |    1 
 arch/arm/plat-omap/dma.c                |    5 -
 arch/arm/plat-omap/gpio.c               |    3 +
 arch/arm/plat-omap/include/mach/aic23.h |  116 -------------------------------
 arch/arm/plat-omap/include/mach/gpio.h  |   10 ---
 arch/arm/plat-omap/include/mach/mcbsp.h |    7 ++
 arch/arm/plat-omap/mcbsp.c              |    4 +
 drivers/mtd/onenand/omap2.c             |    6 +-
 22 files changed, 45 insertions(+), 494 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/aic23.h

-- 
Signature
