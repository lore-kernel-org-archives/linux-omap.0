From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 0/4] ARM: OMAP2+: Adapt to ehci-omap changes for 3.10
Date: Mon, 18 Mar 2013 14:51:14 +0200
Message-ID: <1363611078-13002-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

I've revised the patches based on your comments. For now I've just
adapted Panda and Beagleboard.
If this looks OK then I can adapt the other boards as well.

cheers,
-roger

Roger Quadros (4):
  usb: phy: nop: Add some parameters to platform data
  ARM: OMAP2+: omap-usb-host: Add usbhs_init_phys()
  ARM: OMAP2+: omap4panda: Adapt to ehci-omap changes
  ARM: OMAP3: Beagle: Adapt to ehci-omap changes

 arch/arm/mach-omap2/board-omap3beagle.c |   32 ++++--
 arch/arm/mach-omap2/board-omap4panda.c  |   55 ++++------
 arch/arm/mach-omap2/usb-host.c          |  177 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/usb.h               |    9 ++
 include/linux/usb/nop-usb-xceiv.h       |    5 +
 5 files changed, 232 insertions(+), 46 deletions(-)

-- 
1.7.4.1
