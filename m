From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] ARM: omap2plus_defconfig: Fix SATA and NAND for v4.0-rc
Date: Mon, 23 Feb 2015 17:18:35 +0200
Message-ID: <1424704717-29728-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53131 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbbBWPT1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2015 10:19:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: balbi@ti.com, grinberg@compulab.co.il, grygorii.strashko@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

Hi,

These changes fix SATA boot and NAND for OMAP based boards.

I must also point out that basic SATA operation is also
broken when TI_PIPE3 driver is built as a module.
I will be investigating that on lower priority.

--
cheers,
-roger

Roger Quadros (2):
  ARM: omap2plus_defconfig: Enable OMAP NAND BCH driver
  ARM: omap2plus_defconfig: Fix SATA boot

 arch/arm/configs/omap2plus_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.1.0

