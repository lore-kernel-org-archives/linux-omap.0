From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] add support for omap wake-up interrupts via
 pinctrl-single
Date: Wed, 02 Oct 2013 22:16:54 -0700
Message-ID: <20131003051049.8444.16913.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28805 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593Ab3JCFQ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Oct 2013 01:16:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here's a respin of the pinctrl-single related patches to
use chained irq as suggested by Linus W earlier. This series
does not try to provide any generic automated solution yet,
but works by doing a request_irq() for the wake-up pin, so
it should be flexible enough for both manual control and
automated solution.

This series removes the last nasty blocker for making omap3
to be device tree only without causing nasty PM regressions.

Assuming Linus W acks the drivers/pinctrl parts, I can
provide those three patches in a separate immutable branch
against v3.12-rc3 for Linus W to pull so I can merge them in
too.

This series is based on my earlier series "[PATCH 0/4] Clean
up legacy platform data handling for omaps for v3.13" as
it has a dependency for the pdata quirks for passing the
auxdata to the driver.

Regards,

Tony

---

Tony Lindgren (6):
      ARM: dts: Fix pinctrl mask for omap3
      ARM: OMAP2+: Add support for auxdata
      pinctrl: single: Prepare for supporting SoC specific features
      pinctrl: single: Add support for wake-up interrupts
      pinctrl: single: Add support for auxdata
      ARM: OMAP: Move DT wake-up event handling over to use pinctrl-single-omap


 .../devicetree/bindings/pinctrl/pinctrl-single.txt |   11 +
 arch/arm/boot/dts/omap3.dtsi                       |    8 
 arch/arm/boot/dts/omap4.dtsi                       |    4 
 arch/arm/mach-omap2/board-generic.c                |    5 
 arch/arm/mach-omap2/common.h                       |    3 
 arch/arm/mach-omap2/mux.c                          |    8 
 arch/arm/mach-omap2/mux.h                          |    4 
 arch/arm/mach-omap2/pdata-quirks.c                 |   29 +-
 arch/arm/mach-omap2/prm3xxx.h                      |    8 
 arch/arm/mach-omap2/prm44xx_54xx.h                 |    8 
 arch/arm/mach-omap2/prm_common.c                   |   11 +
 drivers/pinctrl/pinctrl-single.c                   |  386 ++++++++++++++++++++
 include/dt-bindings/pinctrl/omap.h                 |    4 
 include/linux/platform_data/pinctrl-single.h       |   12 +
 14 files changed, 474 insertions(+), 27 deletions(-)
 create mode 100644 include/linux/platform_data/pinctrl-single.h

-- 
Signature
