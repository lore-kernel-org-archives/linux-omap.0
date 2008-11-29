From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/11] Omap gpio updates for review for 2.6.29 merge window
Date: Fri, 28 Nov 2008 17:09:42 -0800
Message-ID: <20081129010728.12337.8217.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57489 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbYK2BJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:09:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi all,

This series contains updates to omap gpio, mostly conversion
to generic gpio api.

Regards,

Tony


---

David Brownell (6):
      ARM: OMAP: minor gpio bugfixes
      ARM: OMAP: use gpio_to_irq
      ARM: OMAP: switch to gpio_direction_output
      ARM: OMAP: switch to gpio_direction_input
      ARM: OMAP: switch to standard gpio get/set calls
      ARM: OMAP: gpios implement new to_irq()

Jarkko Nikula (4):
      ARM: OMAP: Switch ohci-omap to gpio_request/free calls
      ARM: OMAP: Switch to gpio_request/free calls
      ARM: OMAP: make legacy gpio request/free calls superfluous
      ARM: OMAP: Extend gpio label column width in omap_gpio debugfs file

Jouni Hogander (1):
      ARM: OMAP: Enable GPIO debounce clock only when debounce is enabled v3


 arch/arm/mach-omap1/board-fsample.c    |    7 +-
 arch/arm/mach-omap1/board-h2.c         |   24 +++---
 arch/arm/mach-omap1/board-h3.c         |    9 +-
 arch/arm/mach-omap1/board-innovator.c  |    2 -
 arch/arm/mach-omap1/board-nokia770.c   |   12 ++-
 arch/arm/mach-omap1/board-osk.c        |   11 ++-
 arch/arm/mach-omap1/board-palmte.c     |   14 ++--
 arch/arm/mach-omap1/board-palmtt.c     |    2 -
 arch/arm/mach-omap1/board-palmz71.c    |   23 +++---
 arch/arm/mach-omap1/board-perseus2.c   |    7 +-
 arch/arm/mach-omap1/board-sx1.c        |   11 +--
 arch/arm/mach-omap1/board-voiceblue.c  |   49 ++++++------
 arch/arm/mach-omap1/fpga.c             |    6 +-
 arch/arm/mach-omap1/leds-h2p2-debug.c  |   10 +--
 arch/arm/mach-omap1/leds-osk.c         |    4 +
 arch/arm/mach-omap1/leds.c             |    8 +-
 arch/arm/mach-omap1/serial.c           |   10 +--
 arch/arm/mach-omap2/board-2430sdp.c    |    4 +
 arch/arm/mach-omap2/board-apollon.c    |   15 ++--
 arch/arm/mach-omap2/clock34xx.h        |   36 +++++----
 arch/arm/mach-omap2/usb-tusb6010.c     |    6 +-
 arch/arm/plat-omap/debug-devices.c     |    8 +-
 arch/arm/plat-omap/debug-leds.c        |   10 +--
 arch/arm/plat-omap/gpio.c              |  127 +++++++++++++-------------------
 arch/arm/plat-omap/include/mach/gpio.h |   31 ++++++--
 drivers/input/keyboard/omap-keypad.c   |    8 +-
 drivers/mtd/onenand/omap2.c            |   10 +--
 drivers/usb/host/ohci-omap.c           |    8 +-
 28 files changed, 225 insertions(+), 247 deletions(-)

-- 
Signature
