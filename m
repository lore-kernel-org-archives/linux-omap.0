From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/2] ARM: OMAP4: Fix gpmc_fck clock
Date: Mon, 17 Feb 2014 12:27:43 +0100
Message-ID: <1392636465-31459-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:40513 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516AbaBQL2U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Feb 2014 06:28:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Hello,

Trying to get my SMSC9221 working on OMAP4 with DT,
I faced a misconfigured gpmc_fck (dummy clock set to 0)
resulting in serveral division-by-zero, misconfigured
timings and driver lost in the La La Land.

To solve this, patch 1 removes gpmc_fck from the dummy
clocks, and patch 2 adds the gpmc_fck DT node and
reference it from the gpmc node.

Tested on DuoVero/Parlor (OMAP4430) with SMSC9221.

Regards,
Florian

---
Tero: I hopped to have figured out correctly the clock
type and topology based on the TRM, but this is not the
easiest part of the OMAP family :)


Florian Vaussard (2):
  CLK: TI: OMAP4: Remove gpmc_fck from dummy clocks
  ARM: DTS: OMAP4: Add gpmc_fck clock node

 arch/arm/boot/dts/omap4.dtsi           | 2 ++
 arch/arm/boot/dts/omap44xx-clocks.dtsi | 6 ++++++
 drivers/clk/ti/clk-44xx.c              | 1 -
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
1.8.1.2

