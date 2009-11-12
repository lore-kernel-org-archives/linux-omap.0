From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/10] omap am35xx, 3630,
	7xx cpu changes for merge window after 2.6.32
Date: Wed, 11 Nov 2009 19:01:50 -0800
Message-ID: <20091112025802.5159.97598.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52951 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760030AbZKLDBs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 22:01:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

This series mostly adds support for new omaps and better
support for 7xx.

Regards,

Tony

---

Alexander Shishkin (1):
      omap: Eliminate OMAP_MAX_NR_PORTS

Cory Maccarrone (2):
      omap1: mmc: Add platform init for omap7xx
      omap1: omap_udc: Add clocking and disable vbus sense for omap7xx

Nishanth Menon (1):
      omap3: Introduce OMAP3630

Ranjith Lohithakshan (1):
      omap3: AM35xx: Initialize omap_chip bits

Sanjeev Premi (3):
      omap3: Runtime detection of Si features
      omap3: Runtime detection of OMAP35x devices
      omap3: AM35xx: Runtime detection of the device

vikram pandita (2):
      omap: introduce OMAP_LL_DEBUG_NONE DEBUG_LL config
      omap3: 3630: update is_chip variable


 arch/arm/mach-omap1/Kconfig                  |    1 
 arch/arm/mach-omap1/clock.c                  |    6 +
 arch/arm/mach-omap1/clock.h                  |   22 ++++
 arch/arm/mach-omap1/devices.c                |   15 ++
 arch/arm/mach-omap1/mux.c                    |    5 +
 arch/arm/mach-omap1/serial.c                 |    2 
 arch/arm/mach-omap2/id.c                     |  163 ++++++++++++++++++++++++--
 arch/arm/mach-omap2/serial.c                 |    6 -
 arch/arm/plat-omap/Kconfig                   |    5 +
 arch/arm/plat-omap/include/plat/control.h    |   34 +++++
 arch/arm/plat-omap/include/plat/cpu.h        |   91 ++++++++++++++-
 arch/arm/plat-omap/include/plat/mux.h        |    5 +
 arch/arm/plat-omap/include/plat/serial.h     |    4 -
 arch/arm/plat-omap/include/plat/uncompress.h |    6 +
 arch/arm/plat-omap/usb.c                     |   20 ++-
 drivers/usb/gadget/omap_udc.c                |   19 +++
 16 files changed, 364 insertions(+), 40 deletions(-)

-- 
Signature
