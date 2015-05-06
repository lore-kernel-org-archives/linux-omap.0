From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/2] ARM: OMAP2+: AM4372: Add emif hwmod and dt node
Date: Wed, 6 May 2015 12:25:31 -0500
Message-ID: <1430933133-33412-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58829 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbbEFR0I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 May 2015 13:26:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>

This series adds an hwmod for the emif on am4372. Also, we add a dt node
in order to provide the reg address for the hwmod in order to have
SYSCONFIG access.

Without the hwmod, once PM code is added for am437x, the emif_clkdm sees
no users and may be idled even though we obviously still need it.

Regards,
Dave

Dave Gerlach (2):
  ARM: OMAP: AM43xx hwmod: Add data for am43xx emif hwmod
  ARM: dts: am4372: Add emif node

 .../bindings/memory-controllers/ti/emif.txt        |  1 +
 arch/arm/boot/dts/am4372.dtsi                      |  6 ++++++
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  1 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 13 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 13 -------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 22 ++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h                     |  1 +
 7 files changed, 44 insertions(+), 13 deletions(-)

-- 
2.3.6

