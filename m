From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/4] GIC crossbar support for v3.14 merge window
Date: Wed, 8 Jan 2014 17:22:16 -0800
Message-ID: <20140109012215.GL31323@atomide.com>
References: <20140109011940.GI31323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11145 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaAIBWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jan 2014 20:22:21 -0500
Content-Disposition: inline
In-Reply-To: <20140109011940.GI31323@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 413541dd66d51f791a0b169d9b9014e4f56be13c:

  Linux 3.13-rc5 (2013-12-22 13:08:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/crossbar-signed

for you to fetch changes up to 70d4545544853e2d95909b919d4565ff32c3e3c5:

  ARM: DRA: Enable Crossbar IP support for DRA7XX (2014-01-08 09:21:42 -0800)

----------------------------------------------------------------
Add support for GIC crossbar that routes interrupts on newer omaps.

----------------------------------------------------------------
Sricharan R (4):
      irqchip: irq-gic: Add support for routable irqs
      irqchip: crossbar: Add support for Crossbar IP
      ARM: OMAP4+: Correct Wakeup-gen code to use physical irq number
      ARM: DRA: Enable Crossbar IP support for DRA7XX

 Documentation/devicetree/bindings/arm/gic.txt      |   6 +
 .../devicetree/bindings/arm/omap/crossbar.txt      |  27 +++
 arch/arm/mach-omap2/Kconfig                        |   1 +
 arch/arm/mach-omap2/omap-wakeupgen.c               |   4 +-
 arch/arm/mach-omap2/omap4-common.c                 |   4 +
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-crossbar.c                     | 208 +++++++++++++++++++++
 drivers/irqchip/irq-gic.c                          |  82 +++++++-
 include/linux/irqchip/arm-gic.h                    |   7 +-
 include/linux/irqchip/irq-crossbar.h               |  11 ++
 11 files changed, 346 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/crossbar.txt
 create mode 100644 drivers/irqchip/irq-crossbar.c
 create mode 100644 include/linux/irqchip/irq-crossbar.h
