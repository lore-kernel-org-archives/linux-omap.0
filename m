From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Omap1 updates for 2.6.29 merge window
Date: Mon, 15 Dec 2008 14:08:15 -0800
Message-ID: <20081215220814.GK10664@atomide.com>
References: <20081205022951.2992.97190.stgit@localhost> <20081207111136.GA1646@flint.arm.linux.org.uk> <20081215214653.GA21704@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56880 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907AbYLOWIY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 17:08:24 -0500
Content-Disposition: inline
In-Reply-To: <20081215214653.GA21704@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [081215 13:47]:
> On Sun, Dec 07, 2008 at 11:11:36AM +0000, Russell King - ARM Linux wrote:
> > On Thu, Dec 04, 2008 at 06:31:04PM -0800, Tony Lindgren wrote:
> > > Here are few omap1 specific updates for review.
> > 
> > Ok.
> 
> Are these, and the other OMAP2,3 series going to be submitted sometime?

Here's the pull request for you for all of the above. Let me know if you
want a separate pull request for each series.

This does not include the MMC init patches or Hiroshi's patches.

Regards,

Tony

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pull.txt"

The following changes since commit 8b1fae4e4200388b64dd88065639413cb3f1051c:
  Linus Torvalds (1):
        Linux 2.6.28-rc8

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap3-upstream

Arun KS (1):
      ARM: OMAP3: Pin multiplexing updates for 24xx and 34xx

David Brownell (9):
      ARM: OMAP: gpios implement new to_irq()
      ARM: OMAP: switch to standard gpio get/set calls
      ARM: OMAP: switch to gpio_direction_input
      ARM: OMAP: switch to gpio_direction_output
      ARM: OMAP: use gpio_to_irq
      ARM: OMAP: minor gpio bugfixes
      ARM: OMAP1: osk5912: Mistral eeprom support
      ARM: OMAP1: osk5912: LED trigger update for CF
      ARM: OMAP2: bard-h4: list those eeproms

Grazvydas Ignotas (1):
      ARM: OMAP3: Add basic support for Pandora handheld console

Jarkko Nikula (5):
      ARM: OMAP: Extend gpio label column width in omap_gpio debugfs file
      ARM: OMAP: make legacy gpio request/free calls superfluous
      ARM: OMAP: Switch to gpio_request/free calls
      ARM: OMAP: Switch ohci-omap to gpio_request/free calls
      ARM: OMAP3: Add OMAP34xx pin multiplexing into I2C bus registration helper

Jouni Hogander (1):
      ARM: OMAP: Enable GPIO debounce clock only when debounce is enabled v3

Lauri Leukkunen (1):
      ARM: OMAP2: Use omap_rev() instead of system_rev

Paul Walmsley (2):
      ARM: OMAP2: drop redundant pending write check for gptimer
      ARM: OMAP2: skip unnecessary TLDR write during non-autoreload for gptimer

Santosh Shilimkar (1):
      ARM: OMAP3: DMA: Fix for sDMA Errata 1.113

Stanley.Miao (1):
      ARM: OMAP3: LDP: Add Ethernet device support to make ldp boot succeess

Tony Lindgren (3):
      ARM: OMAP2: Prepare cpu detection for further improvements
      ARM: OMAP2: Fix cpu detection
      ARM: OMAP3: Warn about spurious interrupts

 arch/arm/configs/omap3_pandora_defconfig        | 1409 +++++++++++++++++++++++
 arch/arm/configs/omap_ldp_defconfig             |  148 +++-
 arch/arm/mach-omap1/board-fsample.c             |    7 +-
 arch/arm/mach-omap1/board-h2.c                  |   24 +-
 arch/arm/mach-omap1/board-h3.c                  |    9 +-
 arch/arm/mach-omap1/board-innovator.c           |    2 +-
 arch/arm/mach-omap1/board-nokia770.c            |   12 +-
 arch/arm/mach-omap1/board-osk.c                 |   43 +-
 arch/arm/mach-omap1/board-palmte.c              |   14 +-
 arch/arm/mach-omap1/board-palmtt.c              |    2 +-
 arch/arm/mach-omap1/board-palmz71.c             |   23 +-
 arch/arm/mach-omap1/board-perseus2.c            |    7 +-
 arch/arm/mach-omap1/board-sx1.c                 |   11 +-
 arch/arm/mach-omap1/board-voiceblue.c           |   49 +-
 arch/arm/mach-omap1/fpga.c                      |    6 +-
 arch/arm/mach-omap1/id.c                        |   53 +-
 arch/arm/mach-omap1/leds-h2p2-debug.c           |   10 +-
 arch/arm/mach-omap1/leds-osk.c                  |    4 +-
 arch/arm/mach-omap1/leds.c                      |    8 +-
 arch/arm/mach-omap1/pm.c                        |    6 +-
 arch/arm/mach-omap1/serial.c                    |   10 +-
 arch/arm/mach-omap2/Kconfig                     |    4 +
 arch/arm/mach-omap2/Makefile                    |    1 +
 arch/arm/mach-omap2/board-2430sdp.c             |    4 +-
 arch/arm/mach-omap2/board-apollon.c             |   15 +-
 arch/arm/mach-omap2/board-h4.c                  |   14 +
 arch/arm/mach-omap2/board-ldp.c                 |   57 +
 arch/arm/mach-omap2/board-omap3pandora.c        |  180 +++
 arch/arm/mach-omap2/clock34xx.c                 |    2 +-
 arch/arm/mach-omap2/clock34xx.h                 |   36 +-
 arch/arm/mach-omap2/id.c                        |  305 +++---
 arch/arm/mach-omap2/irq.c                       |   39 +
 arch/arm/mach-omap2/mux.c                       |   44 +-
 arch/arm/mach-omap2/usb-tusb6010.c              |    6 +-
 arch/arm/plat-omap/debug-devices.c              |    8 +-
 arch/arm/plat-omap/debug-leds.c                 |   10 +-
 arch/arm/plat-omap/dma.c                        |   15 +-
 arch/arm/plat-omap/dmtimer.c                    |   11 +-
 arch/arm/plat-omap/gpio.c                       |  127 +--
 arch/arm/plat-omap/i2c.c                        |   55 +-
 arch/arm/plat-omap/include/mach/board-apollon.h |    4 +-
 arch/arm/plat-omap/include/mach/board-ldp.h     |    5 +-
 arch/arm/plat-omap/include/mach/cpu.h           |   82 +-
 arch/arm/plat-omap/include/mach/gpio.h          |   31 +-
 arch/arm/plat-omap/include/mach/mux.h           |   41 +
 arch/arm/plat-omap/sram.c                       |    3 +-
 drivers/input/keyboard/omap-keypad.c            |    8 +-
 drivers/mtd/onenand/omap2.c                     |   10 +-
 drivers/usb/host/ohci-omap.c                    |    8 +-
 49 files changed, 2448 insertions(+), 534 deletions(-)
 create mode 100644 arch/arm/configs/omap3_pandora_defconfig
 create mode 100644 arch/arm/mach-omap2/board-omap3pandora.c

--f2QGlHpHGjS2mn6Y--
