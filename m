From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] ARM: dts: dra7-evm: Fixes for 3.17
Date: Wed, 3 Sep 2014 14:17:30 +0300
Message-ID: <1409743052-632-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52736 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160AbaICLSM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Sep 2014 07:18:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: nm@ti.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Hi Tony,

These patches fix  I2C3 bus pinmux and frequency as well as
NAND partition name on dra7-evm.

cheers,
-roger

---
Roger Quadros (2):
  ARM: dts: dra7-evm: Fix i2c3 pinmux and frequency
  ARM: dts: dra7-evm: Fix 8th NAND partition's name

 arch/arm/boot/dts/dra7-evm.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.3.2

