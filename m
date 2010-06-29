From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Platform init changes for old FS USB code for 2.6.36
	merge window
Date: Tue, 29 Jun 2010 14:54:06 +0300
Message-ID: <20100629115056.17702.56622.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54404 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab0F2Lx4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 07:53:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some FS USB platform init changes to allow further improvment
of the code for muxing, register access and hwmod.

This set mostly moves the code around to split it between mach-omap1
and mach-omap2.

Regards,

Tony

---

Tony Lindgren (4):
      omap: Separate out omap2 FS USB platform init functions
      omap: Move omap2 FS USB platform init code into mach-omap2/usb-fs.c
      omap: Enable interface clock for omap2 FS USB
      omap: Move omap1 USB platform init code into mach-omap1/usb.c


 arch/arm/mach-omap1/Makefile            |    3 
 arch/arm/mach-omap1/board-ams-delta.c   |    2 
 arch/arm/mach-omap1/board-generic.c     |    4 
 arch/arm/mach-omap1/board-h2.c          |    2 
 arch/arm/mach-omap1/board-h3.c          |    2 
 arch/arm/mach-omap1/board-htcherald.c   |    2 
 arch/arm/mach-omap1/board-innovator.c   |    4 
 arch/arm/mach-omap1/board-nokia770.c    |    2 
 arch/arm/mach-omap1/board-osk.c         |    2 
 arch/arm/mach-omap1/board-palmte.c      |    2 
 arch/arm/mach-omap1/board-palmtt.c      |    2 
 arch/arm/mach-omap1/board-palmz71.c     |    2 
 arch/arm/mach-omap1/board-sx1.c         |    2 
 arch/arm/mach-omap1/board-voiceblue.c   |    2 
 arch/arm/mach-omap1/usb.c               |  530 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/Makefile            |    2 
 arch/arm/mach-omap2/board-2430sdp.c     |    2 
 arch/arm/mach-omap2/board-apollon.c     |    2 
 arch/arm/mach-omap2/board-h4.c          |    2 
 arch/arm/mach-omap2/usb-fs.c            |  356 +++++++++++++++++
 arch/arm/plat-omap/include/plat/board.h |    8 
 arch/arm/plat-omap/include/plat/usb.h   |   49 ++
 arch/arm/plat-omap/usb.c                |  644 +------------------------------
 23 files changed, 981 insertions(+), 647 deletions(-)
 create mode 100644 arch/arm/mach-omap1/usb.c
 create mode 100644 arch/arm/mach-omap2/usb-fs.c

-- 
Signature
