From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/8] omap2+ patches for v2.6.37 merge window
Date: Fri, 01 Oct 2010 16:33:57 -0700
Message-ID: <20101001233315.31894.49599.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50151 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0JAXeC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 19:34:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap2/3/4 related patches I've picked up.

Regards,

Tony

---

Benoit Cousson (1):
      omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS is not set

Grazvydas Ignotas (2):
      omap: pandora: add fixed regulator for wlan
      omap: pandora: enable twl4030 charger

Madhusudhan Chikkature (1):
      OMAP4 ES2: HSMMC soft reset change

Sanjeev Premi (1):
      omap2/3: Update revision identification

Tony Lindgren (1):
      omap: Fix omap_mux_init_signal not to trash muxname

kishore kadiyala (2):
      omap4 hsmmc: Register offset handling
      omap4 hsmmc: Update ocr mask for MMC2 for regulator to use


 arch/arm/mach-omap2/board-4430sdp.c      |    9 +++-
 arch/arm/mach-omap2/board-omap3pandora.c |   46 +++++++++++++++----
 arch/arm/mach-omap2/devices.c            |    8 +--
 arch/arm/mach-omap2/hsmmc.c              |    7 +++
 arch/arm/mach-omap2/id.c                 |   72 ++++++++++++++++++++----------
 arch/arm/mach-omap2/mux.c                |   13 +++--
 arch/arm/mach-omap2/mux.h                |    2 -
 arch/arm/plat-omap/include/plat/cpu.h    |   36 ++++++++-------
 arch/arm/plat-omap/include/plat/mmc.h    |    4 ++
 drivers/mmc/host/omap_hsmmc.c            |   25 ++++++++++
 10 files changed, 156 insertions(+), 66 deletions(-)

-- 
Signature
