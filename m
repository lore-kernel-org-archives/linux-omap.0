From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/5] ARM: OMAP: arm part of usb patches
Date: Wed, 6 Feb 2013 11:28:08 +0530
Message-ID: <1360130294-5976-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, tony@atomide.com, linux@arm.linux.org.uk, eballetbo@gmail.com, javier@dowhile0.org, b-cousson@ti.com, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc: kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Greg,

Here is the patch series that includes the arch/arm part to get MUSB
working in OMAP platforms. As discussed in the other mail thread with
Tony, this patch series should go into usb-next.

This patch series also contains a patch by Felipe to fix compilation
warning in usb-next when CONFIG_OMAP_CONTROL_USB is not set.

Boot tested panda board.

Felipe Balbi (1):
  usb: omap_control_usb: fix compile warning

Kishon Vijay Abraham I (4):
  ARM: OMAP4: remove control module address space from PHY and OTG
  ARM: OMAP: devices: create device for usb part of control module
  ARM: OMAP2: MUSB: Specify omap4 has mailbox
  ARM: OMAP: USB: Add phy binding information

 arch/arm/mach-omap2/board-2430sdp.c          |    2 ++
 arch/arm/mach-omap2/board-3430sdp.c          |    2 ++
 arch/arm/mach-omap2/board-4430sdp.c          |    2 ++
 arch/arm/mach-omap2/board-cm-t35.c           |    2 ++
 arch/arm/mach-omap2/board-devkit8000.c       |    2 ++
 arch/arm/mach-omap2/board-igep0020.c         |    2 ++
 arch/arm/mach-omap2/board-ldp.c              |    2 ++
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 ++
 arch/arm/mach-omap2/board-omap3evm.c         |    2 ++
 arch/arm/mach-omap2/board-omap3logic.c       |    2 ++
 arch/arm/mach-omap2/board-omap3pandora.c     |    2 ++
 arch/arm/mach-omap2/board-omap3stalker.c     |    2 ++
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 ++
 arch/arm/mach-omap2/board-omap4panda.c       |    2 ++
 arch/arm/mach-omap2/board-overo.c            |    2 ++
 arch/arm/mach-omap2/board-rm680.c            |    2 ++
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 ++
 arch/arm/mach-omap2/devices.c                |   45 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   13 --------
 arch/arm/mach-omap2/usb-musb.c               |    3 ++
 include/linux/usb/musb.h                     |    2 ++
 include/linux/usb/omap_control_usb.h         |    2 +-
 22 files changed, 85 insertions(+), 14 deletions(-)

-- 
1.7.10.4
