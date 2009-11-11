From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/8] Omap fixes for v2.6.32-rc6
Date: Tue, 10 Nov 2009 19:00:17 -0800
Message-ID: <20091111025907.31793.84134.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64269 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbZKKDAQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 22:00:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are still few more fixes for review for the current -rc series.

Regards,

Tony

---

Grazvydas Ignotas (2):
      omap: update Pandora defconfig
      omap3: pandora: Fix keypad keymap

Janusz Krzysztofik (1):
      omap1: Amstrad Delta defconfig fixes

Jarkko Nikula (1):
      omap3: beagle: Fix USB host port power control

Mike Turquette (1):
      omap3: Decrease cpufreq transition latency

Sergio Aguirre (1):
      omap3: 3430sdp: Enable Linux Regulator framework

Tao Hu (1):
      omap: Fix race condition in omap dma driver

Tobias Klauser (1):
      omap: Use resource_size


 arch/arm/configs/ams_delta_defconfig     |   24 +++++++--
 arch/arm/configs/omap3_pandora_defconfig |   49 +++++++++++++++++--
 arch/arm/configs/omap_3430sdp_defconfig  |    9 +++
 arch/arm/mach-omap2/board-omap3beagle.c  |    2 -
 arch/arm/mach-omap2/board-omap3pandora.c |   78 +++++++++++++++---------------
 arch/arm/mach-omap2/gpmc.c               |    2 -
 arch/arm/mach-omap2/mailbox.c            |    2 -
 arch/arm/plat-omap/cpu-omap.c            |    2 -
 arch/arm/plat-omap/dma.c                 |    6 ++
 9 files changed, 118 insertions(+), 56 deletions(-)

-- 
Signature
