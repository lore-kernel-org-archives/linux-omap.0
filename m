From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/13] Omap header clean-up for next merge window
Date: Thu, 26 Feb 2009 15:52:18 -0800
Message-ID: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49260 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbZBZXwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 18:52:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi all,

This series gets rid of the board-*.h includes from hardware.h
as suggested earlier by Russell King.

Regards,

Tony

---

Tony Lindgren (13):
      ARM: OMAP: Remove remaining board-*.h includes from hardware.h
      ARM: OMAP: No need to include board-nokia.h from hardware.h
      ARM: OMAP: No need to include board-overo.h from hardware.h
      ARM: OMAP: No need to include board-ldp.h from hardware.h
      ARM: OMAP: No need to include board-h4.h from hardware.h
      ARM: OMAP: No need to include board-apollon.h from hardware.h
      ARM: OMAP: No need to include board-omap2430sdp.h from hardware.h
      ARM: OMAP: No need to include board-palm*.h from hardware.h
      ARM: OMAP: No need to include board-osk.h from hardware.h
      ARM: OMAP: No need to include board-innovator.h from hardware.h
      ARM: OMAP: No need to include board-h3.h from hardware.h
      ARM: OMAP: No need to include board-h2.h from hardware.h
      ARM: OMAP: No need to include board-perseus2.h or board-fsample.h from hardware.h


 arch/arm/mach-omap1/board-fsample.c                |   34 +++++++++
 arch/arm/mach-omap1/board-h2-mmc.c                 |    2 +
 arch/arm/mach-omap1/board-h2.c                     |    5 +
 arch/arm/mach-omap1/board-h2.h                     |    5 -
 arch/arm/mach-omap1/board-h3-mmc.c                 |    2 +
 arch/arm/mach-omap1/board-h3.c                     |    5 +
 arch/arm/mach-omap1/board-h3.h                     |    5 -
 arch/arm/mach-omap1/board-innovator.c              |    3 +
 arch/arm/mach-omap1/board-osk.c                    |   14 ++++
 arch/arm/mach-omap1/board-palmte.c                 |   15 ++++
 arch/arm/mach-omap1/board-palmtt.c                 |    7 ++
 arch/arm/mach-omap1/board-palmz71.c                |   10 +++
 arch/arm/mach-omap1/board-sx1-mmc.c                |    1 
 arch/arm/mach-omap1/board-sx1.c                    |    1 
 arch/arm/mach-omap2/board-2430sdp.c                |   13 ++--
 arch/arm/mach-omap2/board-apollon.c                |    1 
 arch/arm/mach-omap2/board-h4.c                     |    4 +
 arch/arm/mach-omap2/board-ldp.c                    |   10 ++-
 arch/arm/mach-omap2/board-overo.c                  |    7 ++
 arch/arm/plat-omap/include/mach/board-2430sdp.h    |   41 -----------
 arch/arm/plat-omap/include/mach/board-apollon.h    |   46 ------------
 arch/arm/plat-omap/include/mach/board-fsample.h    |   51 --------------
 arch/arm/plat-omap/include/mach/board-h4.h         |   38 ----------
 arch/arm/plat-omap/include/mach/board-innovator.h  |   52 --------------
 arch/arm/plat-omap/include/mach/board-ldp.h        |   39 -----------
 arch/arm/plat-omap/include/mach/board-nokia.h      |   54 ---------------
 .../arm/plat-omap/include/mach/board-omap3beagle.h |   33 ---------
 arch/arm/plat-omap/include/mach/board-osk.h        |   47 -------------
 arch/arm/plat-omap/include/mach/board-overo.h      |   26 -------
 arch/arm/plat-omap/include/mach/board-palmte.h     |   32 ---------
 arch/arm/plat-omap/include/mach/board-palmtt.h     |   23 ------
 arch/arm/plat-omap/include/mach/board-palmz71.h    |   26 -------
 arch/arm/plat-omap/include/mach/board-perseus2.h   |   39 -----------
 arch/arm/plat-omap/include/mach/board-voiceblue.h  |    1 
 arch/arm/plat-omap/include/mach/board.h            |    3 -
 arch/arm/plat-omap/include/mach/hardware.h         |   74 --------------------
 arch/arm/plat-omap/include/mach/system.h           |    2 +
 37 files changed, 126 insertions(+), 645 deletions(-)
 rename arch/arm/{plat-omap/include/mach/board-h2.h => mach-omap1/board-h2.h} (90%)
 rename arch/arm/{plat-omap/include/mach/board-h3.h => mach-omap1/board-h3.h} (90%)
 delete mode 100644 arch/arm/plat-omap/include/mach/board-2430sdp.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-apollon.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-fsample.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-h4.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-innovator.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-ldp.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-nokia.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-omap3beagle.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-osk.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-overo.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-palmte.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-palmtt.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-palmz71.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-perseus2.h

-- 
Signature
