From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Build fixes for omap
Date: Wed, 16 Dec 2009 11:09:38 -0800
Message-ID: <20091216190601.30032.91535.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49411 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935350AbZLPTJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 14:09:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are build fixes for omaps and a suspend fix for omap3.
There's one more build fix coming from the linux-usb list for
H2 transceiver.

Planning to send these today before starting to look into
the other pending fixes.

Regards,

Tony

---

Balaji T K (1):
      mfd: twl: fix twl4030 rename for remaining driver, board files

Mika Westerberg (1):
      OMAP3: serial - fix bug introduced in

Olof Johansson (1):
      omap3: Allow EHCI to be built on OMAP3

Thomas Weber (1):
      USB ehci: replace mach header with plat


 arch/arm/mach-omap2/Kconfig                  |    1 +
 arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
 arch/arm/mach-omap2/board-igep0020.c         |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 arch/arm/mach-omap2/serial.c                 |    7 ++++---
 drivers/usb/host/ehci-omap.c                 |    2 +-
 drivers/video/omap/lcd_ldp.c                 |    4 ++--
 drivers/video/omap/lcd_omap2evm.c            |   10 +++++-----
 drivers/video/omap/lcd_omap3beagle.c         |    2 +-
 drivers/video/omap/lcd_omap3evm.c            |   10 +++++-----
 drivers/video/omap/lcd_overo.c               |    2 +-
 sound/soc/omap/sdp3430.c                     |    6 +++---
 15 files changed, 29 insertions(+), 27 deletions(-)

-- 
Signature
