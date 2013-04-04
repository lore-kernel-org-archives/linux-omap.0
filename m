From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap usb platform init changes for v3.10 merge window
Date: Thu, 4 Apr 2013 12:39:54 -0700
Message-ID: <6622.16792484305$1365104430@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43148 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764681Ab3DDTkC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 15:40:02 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 1f0972f5b05a674d73e4eb314fa1b6c78e37aef1:

  usb: phy: nop: Add some parameters to platform data (2013-03-18 11:13:54 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/usb-signed

for you to fetch changes up to 2e5f78aeceb6f203b514ca03a48e3fd056025524:

  ARM: dts: omap3-beagle: Add USB Host support (2013-04-02 10:00:04 -0700)

----------------------------------------------------------------
EHCI platform data related changes for v3.10 merge window.
These are needed for the USB PHY support, and are based on
commit 1f0972f5 from Felipe Balbi's tree as agreed on the
mailing lists.

----------------------------------------------------------------
Roger Quadros (20):
      ARM: OMAP2+: omap-usb-host: Add usbhs_init_phys()
      ARM: OMAP2+: omap4panda: Adapt to ehci-omap changes
      ARM: OMAP3: Beagle: Adapt to ehci-omap changes
      ARM: OMAP3: 3430SDP: Adapt to ehci-omap changes
      ARM: OMAP3: 3630SDP: Adapt to ehci-omap changes
      ARM: OMAP: AM3517crane: Adapt to ehci-omap changes
      ARM: OMAP: AM3517evm: Adapt to ehci-omap changes
      ARM: OMAP3: cm-t35: Adapt to ehci-omap changes
      ARM: OMAP3: cm-t3517: Adapt to ehci-omap changes
      ARM: OMAP: devkit8000: Adapt to ehci-omap changes
      ARM: OMAP3: igep0020: Adapt to ehci-omap changes
      ARM: OMAP3: omap3evm: Adapt to ehci-omap changes
      ARM: OMAP3: omap3pandora: Adapt to ehci-omap changes
      ARM: OMAP3: omap3stalker: Adapt to ehci-omap changes
      ARM: OMAP3: omap3touchbook: Adapt to ehci-omap changes
      ARM: OMAP3: overo: Adapt to ehci-omap changes
      ARM: OMAP: zoom: Adapt to ehci-omap changes
      ARM: dts: OMAP4: Add HS USB Host IP nodes
      ARM: dts: OMAP3: Add HS USB Host IP nodes
      ARM: dts: omap3-beagle: Add USB Host support

 arch/arm/boot/dts/omap3-beagle.dts         |  71 +++++++++++++
 arch/arm/boot/dts/omap3.dtsi               |  31 ++++++
 arch/arm/boot/dts/omap4.dtsi               |  30 ++++++
 arch/arm/mach-omap2/board-3430sdp.c        |  21 ++--
 arch/arm/mach-omap2/board-3630sdp.c        |  21 ++--
 arch/arm/mach-omap2/board-am3517crane.c    |  24 ++---
 arch/arm/mach-omap2/board-am3517evm.c      |  17 +--
 arch/arm/mach-omap2/board-cm-t35.c         |  20 ++--
 arch/arm/mach-omap2/board-cm-t3517.c       |  20 ++--
 arch/arm/mach-omap2/board-devkit8000.c     |   8 --
 arch/arm/mach-omap2/board-igep0020.c       |  32 +++---
 arch/arm/mach-omap2/board-omap3beagle.c    |  32 ++++--
 arch/arm/mach-omap2/board-omap3evm.c       |  25 ++---
 arch/arm/mach-omap2/board-omap3pandora.c   |  21 ++--
 arch/arm/mach-omap2/board-omap3stalker.c   |  17 +--
 arch/arm/mach-omap2/board-omap3touchbook.c |  17 +--
 arch/arm/mach-omap2/board-omap4panda.c     |  55 ++++------
 arch/arm/mach-omap2/board-overo.c          |  16 +--
 arch/arm/mach-omap2/board-zoom.c           |  16 +--
 arch/arm/mach-omap2/usb-host.c             | 160 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/usb.h                  |   9 ++
 21 files changed, 503 insertions(+), 160 deletions(-)
