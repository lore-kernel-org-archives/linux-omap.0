From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] omap legacy full speed usb cleanup for v3.6
Date: Mon, 21 May 2012 12:00:59 -0700
Message-ID: <20120521185323.927.88012.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14781 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab2EUTBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 15:01:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

This series removes the old legacy fulls speed support for
omap2 as it's pretty much only used for omap1 only.

For omap2, only n8x0 seems to have active development, and
that has the external high speed tusb chip instead.

This allows removes the last user of omap_read/write for omap2+,
removes cpu_is_omapxxx usage under drivers/usb except for omap1,
simplifies the plat/usb.h allowing further clean-up, simplifies
the DMA engine conversion by one driver, and so on.

The patches are against today's linux next branch.

Regards,

Tony


---

Tony Lindgren (4):
      ARM: OMAP3: There is no FS USB controller on omap3
      ARM: OMAP2: Remove legacy USB FS support
      ARM: OMAP: Make FS USB omap1 only
      USB: Remove omap2 support from omap_udc.c


 arch/arm/mach-omap1/board-ams-delta.c   |    2 
 arch/arm/mach-omap1/board-generic.c     |    4 
 arch/arm/mach-omap1/board-h2.c          |    2 
 arch/arm/mach-omap1/board-h3.c          |    2 
 arch/arm/mach-omap1/board-htcherald.c   |    2 
 arch/arm/mach-omap1/board-innovator.c   |    2 
 arch/arm/mach-omap1/board-nokia770.c    |    2 
 arch/arm/mach-omap1/board-osk.c         |    2 
 arch/arm/mach-omap1/board-palmte.c      |    2 
 arch/arm/mach-omap1/board-palmtt.c      |    2 
 arch/arm/mach-omap1/board-palmz71.c     |    2 
 arch/arm/mach-omap1/board-sx1.c         |    2 
 arch/arm/mach-omap1/board-voiceblue.c   |    3 
 arch/arm/mach-omap1/clock_data.c        |    3 
 arch/arm/mach-omap1/include/mach/usb.h  |  165 ++++++++++++++
 arch/arm/mach-omap1/usb.c               |  116 ++++++++++
 arch/arm/mach-omap2/Kconfig             |    3 
 arch/arm/mach-omap2/Makefile            |    3 
 arch/arm/mach-omap2/board-2430sdp.c     |   11 -
 arch/arm/mach-omap2/board-apollon.c     |   18 --
 arch/arm/mach-omap2/board-h4.c          |   13 -
 arch/arm/mach-omap2/usb-fs.c            |  359 -------------------------------
 arch/arm/plat-omap/Makefile             |    2 
 arch/arm/plat-omap/include/plat/board.h |   38 ---
 arch/arm/plat-omap/include/plat/usb.h   |  196 -----------------
 arch/arm/plat-omap/usb.c                |  145 -------------
 drivers/usb/gadget/Kconfig              |    2 
 drivers/usb/gadget/omap_udc.c           |  116 ++--------
 drivers/usb/host/Kconfig                |    2 
 drivers/usb/host/ohci-omap.c            |    7 -
 drivers/usb/otg/isp1301_omap.c          |    2 
 31 files changed, 333 insertions(+), 897 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/usb.h
 delete mode 100644 arch/arm/mach-omap2/usb-fs.c
 delete mode 100644 arch/arm/plat-omap/usb.c

-- 
Signature
