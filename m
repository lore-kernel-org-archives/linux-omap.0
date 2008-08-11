From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] BeagleBoard: make Beagle use GPTIMER12 for system ticks
Date: Mon, 11 Aug 2008 17:34:50 -0600
Message-ID: <20080811233423.3046.42669.stgit@localhost.localdomain>
References: <20080811233109.3046.54050.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35738 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbYHKXia (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 19:38:30 -0400
In-Reply-To: <20080811233109.3046.54050.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Khasim Syed Mohammed <khasim@ti.com>, Koen Kooi <k.kooi@student.utwente.nl>, Steve Sakoman <sakoman@gmail.com>, Richard Woodruff <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, Philip Balister <philip@balister.org>, Dirk Behme <dirk.behme@googlemail.com>

There is suspicion that the 32kHz input clock to the OMAP may be noisy
on BeagleBoards.  On OMAP2/3 GPTIMER1, this can cause the timer
counter register to warp to unknown values or miss interrupt
conditions.  So, use GPTIMER12 instead, which apparently has its own
secure 32kHz oscillator and will hopefully not be prone to the
suspected sys_32k glitches.

This is only a workaround.  If sys_32k is noisy, other system peripherals
may be affected.

This workaround is a collective product of several people, most notably
Philip Balister <philip@balister.org>, Dirk Behme <dirk.behme@googlemail.com>,
Koen Kooi <k.kooi@student.utwente.nl>, Tony Lindgren <tony@atomide.com>,
Steve Sakoman <sakoman@gmail.com>, Khasim Syed Mohammed <khasim@ti.com>
Richard Woodruff <r-woodruff2@ti.com>.  I apologize if there is anyone whom
I've missed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Khasim Syed Mohammed <khasim@ti.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Steve Sakoman <sakoman@gmail.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Philip Balister <philip@balister.org>
Cc: Dirk Behme <dirk.behme@googlemail.com>
---

 arch/arm/configs/omap3_beagle_defconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index e1b16d0..7805995 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -182,8 +182,8 @@ CONFIG_OMAP_BOOT_REASON=y
 # CONFIG_OMAP_MCBSP is not set
 # CONFIG_OMAP_MMU_FWK is not set
 # CONFIG_OMAP_MBOX_FWK is not set
-CONFIG_OMAP_MPU_TIMER=y
-# CONFIG_OMAP_32K_TIMER is not set
+# CONFIG_OMAP_MPU_TIMER is not set
+CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_DM_TIMER=y
 # CONFIG_OMAP_LL_DEBUG_UART1 is not set
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
@@ -198,6 +198,7 @@ CONFIG_ARCH_OMAP3430=y
 # CONFIG_MACH_OMAP_3430SDP is not set
 # CONFIG_MACH_OMAP3EVM is not set
 CONFIG_MACH_OMAP3_BEAGLE=y
+CONFIG_OMAP_TICK_GPTIMER=12
 
 #
 # Boot options


