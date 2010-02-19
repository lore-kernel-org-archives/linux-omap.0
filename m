From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/11] omap updates for 2.6.34, part 4
Date: Fri, 19 Feb 2010 15:29:59 -0800
Message-ID: <20100219232648.10559.380.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51741 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671Ab0BSX3H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 18:29:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are few USB platform init patches that have been already
posted to linux-usb and linux-omap and have been sitting in for-next.

Posting them one more time to make sure people on linux-arm-kernel
have seen these too.

Regards,

Tony

---

Felipe Balbi (7):
      arm: omap: musb: ioremap only what's ours
      omap: musb: remove unused data
      arm: omap: musb: we can use clk framework
      omap: musb: remove unused soft_con field
      omap: musb: remove unused dma data
      omap: musb: remove unnecessary return
      omap: musb: get rid of dyn_fifo

Maulik Mankad (4):
      USB: Add empty functions in otg.h
      omap: musb: Remove #ifdef from board-omap3evm.c
      omap: musb: Pass board specific data from board file
      omap: musb: Add USB support to 4430 SDP board file


 arch/arm/mach-omap2/board-2430sdp.c          |    8 ++-
 arch/arm/mach-omap2/board-3430sdp.c          |    8 ++-
 arch/arm/mach-omap2/board-4430sdp.c          |   10 +++
 arch/arm/mach-omap2/board-cm-t35.c           |    8 ++-
 arch/arm/mach-omap2/board-devkit8000.c       |    8 ++-
 arch/arm/mach-omap2/board-igep0020.c         |    8 ++-
 arch/arm/mach-omap2/board-ldp.c              |    8 ++-
 arch/arm/mach-omap2/board-omap3beagle.c      |    8 ++-
 arch/arm/mach-omap2/board-omap3evm.c         |   12 +++-
 arch/arm/mach-omap2/board-omap3pandora.c     |    8 ++-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    8 ++-
 arch/arm/mach-omap2/board-overo.c            |    8 ++-
 arch/arm/mach-omap2/board-rx51.c             |    8 ++-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    8 ++-
 arch/arm/mach-omap2/usb-musb.c               |   83 ++++----------------------
 arch/arm/plat-omap/include/plat/omap44xx.h   |    1 
 arch/arm/plat-omap/include/plat/usb.h        |   11 +++
 include/linux/usb/musb.h                     |    3 +
 include/linux/usb/otg.h                      |   10 +++
 19 files changed, 141 insertions(+), 85 deletions(-)

-- 
Signature
