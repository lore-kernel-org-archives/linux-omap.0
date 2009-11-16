From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] OMAP clock and PM architecture fixes for 2.6.32-rc6
Date: Mon, 16 Nov 2009 06:36:49 -0700
Message-ID: <20091116133237.14128.39687.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49333 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbZKPNh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 08:37:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi,

this series contains fixes for some clock and PM architecture components
for the 2.6.32-rc series.

- Paul

---

Paul Walmsley (1):
      OMAP clock/hwmod: fix off-by-one errors

Rajendra Nayak (1):
      OMAP3 clock: Fix the DPLL freqsel computations

Tero Kristo (1):
      OMAP3: Clock: Fixed dpll3_m2x2 rate calculation


 arch/arm/mach-omap2/clock34xx.c  |    2 +-
 arch/arm/mach-omap2/clock34xx.h  |    4 ++--
 arch/arm/mach-omap2/cm.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c |   12 +++++-------
 arch/arm/mach-omap2/prcm.c       |    4 ++--
 5 files changed, 11 insertions(+), 13 deletions(-)

