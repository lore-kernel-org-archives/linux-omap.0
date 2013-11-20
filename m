From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
Date: Wed, 20 Nov 2013 12:08:47 -0600
Message-ID: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39909 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154Ab3KTSKG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Afte these patches, we're very close to being able
to move arch/arm/mach-omap2/irq.c to drivers/irqchip/irq-intc.c

All which would be missing is for Tony to drop all OMAP2/3 board
files so we remove the few pending bits and pieces left in
for legacy boot.

Note that I have only boot tested these on AM335x Bone Black
(with a small fix for fixed regulator which should be in
the mailing list already), so I'd need help testing all
other impacted platforms, specially when it comes to PM.

Felipe Balbi (31):
  arm: omap: irq: make omap_irq_base global
  arm: omap: irq: define INTC_ILR0 register
  arm: omap: irq: start to remove irq_banks array
  arm: omap: irq: add a global omap_nr_irqs variable
  arm: omap: irq: remove rest of irq_banks usage
  arm: omap: irq: remove unused macro
  arm: omap: irq: switch over to intc_readl on omap_intc_handle_irq
  arm: omap: irq: remove unnecessary base_addr argument
  arm: omap: irq: rename omap3_intc_regs
  arm: omap: irq: always define omap3 support
  arm: omap: irq: reorganize code a little bit
  arm: omap: irq: add suspend/resume methods
  arm: omap: irq: remove last bits of our homebrew irqchip pm
  arm: omap: irq: make intc_of_init static
  arm: omap: irq: call set_handle_irq() from intc_of_init
  arm: omap: irq: use IRQCHIP_DECLARE macro
  arm: omap: irq: drop .handle_irq and .init_irq fields
  arm: omap: irq: add specific compatibles for omap3 and am33xx devices
  arm: omap: irq: use compatible flag to figure out number of IRQ lines
  arm: boot: dts: am33xx/omap3: fix intc compatible flag
  arm: omap: irq: drop ti,intc-size support
  arm: boot: dts: omap2/3/am33xx: drop ti,intc-size
  arm: omap: irq: move some more code around
  arm: omap: irq: call set_handle_irq() from .init_irq
  arm: omap: irq: drop omap3_intc_handle_irq()
  arm: omap: irq: drop omap2_intc_handle_irq()
  arm: omap: irq: drop omap_pending_irq()
  arm: omap: irq: remove unnecessary header
  arm: omap: irq: remove nr_irqs argument
  arm: omap: irq: introduce omap_nr_pending
  arm: omap: irq: get rid of ifdef hack

 arch/arm/boot/dts/am33xx.dtsi              |   3 +-
 arch/arm/boot/dts/omap2.dtsi               |   1 -
 arch/arm/boot/dts/omap3.dtsi               |   3 +-
 arch/arm/mach-omap2/board-2430sdp.c        |   1 -
 arch/arm/mach-omap2/board-3430sdp.c        |   1 -
 arch/arm/mach-omap2/board-am3517crane.c    |   1 -
 arch/arm/mach-omap2/board-am3517evm.c      |   1 -
 arch/arm/mach-omap2/board-cm-t35.c         |   2 -
 arch/arm/mach-omap2/board-cm-t3517.c       |   1 -
 arch/arm/mach-omap2/board-devkit8000.c     |   1 -
 arch/arm/mach-omap2/board-generic.c        |  12 -
 arch/arm/mach-omap2/board-h4.c             |   1 -
 arch/arm/mach-omap2/board-ldp.c            |   1 -
 arch/arm/mach-omap2/board-n8x0.c           |   3 -
 arch/arm/mach-omap2/board-omap3beagle.c    |   1 -
 arch/arm/mach-omap2/board-omap3logic.c     |   2 -
 arch/arm/mach-omap2/board-omap3pandora.c   |   1 -
 arch/arm/mach-omap2/board-omap3stalker.c   |   1 -
 arch/arm/mach-omap2/board-omap3touchbook.c |   1 -
 arch/arm/mach-omap2/board-overo.c          |   1 -
 arch/arm/mach-omap2/board-rx51.c           |   1 -
 arch/arm/mach-omap2/common.h               |  19 --
 arch/arm/mach-omap2/cpuidle34xx.c          |   2 +-
 arch/arm/mach-omap2/irq.c                  | 357 ++++++++++++-----------------
 arch/arm/mach-omap2/pm24xx.c               |  11 -
 arch/arm/mach-omap2/pm34xx.c               |  13 --
 26 files changed, 153 insertions(+), 289 deletions(-)

-- 
1.8.4.GIT

