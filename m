From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/7] More omap2+ randconfig fixes
Date: Thu, 23 Feb 2012 16:54:00 -0800
Message-ID: <20120224005324.16794.73852.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63262 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2BXAyE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 19:54:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some more omap2+ randconfig related fixes for review.

Regards,

Tony

---

Tony Lindgren (7):
      ARM: OMAP2+: Fix Kconfig dependencies for USB_ARCH_HAS_EHCI
      ARM: OMAP2+: Fix OMAP_HDQ_BASE build error
      ARM: OMAP2+: Fix board_mux section type conflict when OMAP_MUX is not set
      ARM: OMAP2+: Fix zoom LCD backlight if TWL_CORE is not selected
      ARM: OMAP2+: Fix devexit for smartreflex when CONFIG_HOTPLUG is not set
      ARM: OMAP: Fix devexit for dma when CONFIG_HOTPLUG is not set
      ARM: OMAP2+: Fix multiple randconfig errors with SOC_OMAP and SOC_OMAP_NOOP


 arch/arm/Makefile                        |    4 +-
 arch/arm/mach-omap2/Kconfig              |   55 ++++++++++++++++++++----------
 arch/arm/mach-omap2/board-zoom-display.c |    6 +++
 arch/arm/mach-omap2/devices.c            |    7 ++--
 arch/arm/mach-omap2/mux.h                |    2 +
 arch/arm/mach-omap2/smartreflex.c        |    2 +
 arch/arm/plat-omap/dma.c                 |    2 +
 7 files changed, 50 insertions(+), 28 deletions(-)

-- 
Signature
