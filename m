From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] OMAP hwmod/PRCM/clock: patches for 2.6.39-rc
Date: Wed, 20 Apr 2011 13:28:37 -0600
Message-ID: <20110420192601.16986.56558.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49001 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab1DTTpn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Apr 2011 15:45:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

This series contains OMAP hwmod/PRCM/clock fixes for the 2.6.39-rc merge
period.  Of particular note is the DSS clock alias patch, without which
OMAP4 will crash on boot.

Boot-tested on N800, OMAP35xx Beagle, OMAP37xx Beagle, and OMAP4430
ES2 Panda.


- Paul

---

for_tony_a_2.6.39rc
   text	   data	    bss	    dec	    hex	filename
5793259	 542448	5594272	11929979	 b6097b	vmlinux.omap2plus_defconfig.orig
5793339	 542448	5594272	11930059	 b609cb	vmlinux.omap2plus_defconfig

Avinash.H.M (1):
      OMAP2/3: hwmod: fix gpio-reset timeouts seen during bootup.

Benoit Cousson (1):
      OMAP2+: hwmod data: Fix wrong dma_system end address

Eduardo Valentin (2):
      OMAP2+: PM: Fix the saving of CM_AUTOIDLE_PLL register on scratchpad area
      OMAP3: PM: Do not rely on ROM code to restore CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL

Tomi Valkeinen (1):
      OMAP4: clock data: Change DSS clock aliases


 arch/arm/mach-omap2/clock44xx_data.c       |    9 ++-------
 arch/arm/mach-omap2/cm2xxx_3xxx.c          |   17 +++++++++++++++++
 arch/arm/mach-omap2/control.c              |    8 +++++++-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 +++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 +++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 7 files changed, 45 insertions(+), 12 deletions(-)

