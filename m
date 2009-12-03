From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/10] OMAP: omap_hwmod/omap_device patches for 2.6.33
Date: Thu, 03 Dec 2009 06:49:40 -0700
Message-ID: <20091203134852.17146.81997.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49038 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137AbZLCNyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:54:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

This series contains some updates and bugfixes for the omap_hwmod/omap_device
code, intended for the 2.6.33 merge window.


- Paul

---

Kevin Hilman (6):
      OMAP: omap_device: add to_omap_device() macro
      OMAP: omap_device: use UINT_MAX for default wakeup latency limit
      OMAP: omap_device: use read_persistent_clock() instead of getnstimeofday()
      OMAP: hwmod: warn on missing clockdomain
      OMAP: omap_device: fix nsec/usec conversion in latency calculations
      OMAP: omap_device: track latency in nanoseconds

Paul Walmsley (4):
      OMAP3 hwmod: reprogram OCP_SYSCONFIG register after setting SOFTRESET
      OMAP3 hwmod: Add automatic OCP_SYSCONFIG AUTOIDLE handling
      OMAP hwmod: add names to module MPU IRQ lines
      OMAP3 hwmod: drop most of the OCP_SYSCONFIG.CLOCKACTIVITY code


 arch/arm/mach-omap2/omap_hwmod.c              |  151 ++++++++++---------------
 arch/arm/plat-omap/include/plat/omap_device.h |    8 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |   26 ++++
 arch/arm/plat-omap/omap_device.c              |   18 +--
 4 files changed, 96 insertions(+), 107 deletions(-)

