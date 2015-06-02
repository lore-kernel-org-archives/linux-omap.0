From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] ARM: DRA7: hwmod: fix gpmc hwmod for core-retention
Date: Tue, 2 Jun 2015 13:02:51 +0300
Message-ID: <1433239373-14653-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55752 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348AbbFBKDM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 06:03:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: nm@ti.com, j-keerthy@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Hi,

Disabling GPMC node in device tree prevents core retention on dra7-evm.
Fix that by getting rid of HWMOD_INIT_NO_IDLE & NO_RESET.

Fixup gpmc hwmod as it doesn't support SIDLE_SMART_WKUP.

cheers,
-roger

Roger Quadros (2):
  ARM: DRA7: hwmod: fix gpmc hwmod
  ARM: DRA7: hwmod: Fix GPMC from preventing core suspend

 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
2.1.4

