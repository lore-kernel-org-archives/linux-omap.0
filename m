From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/2] ARM: OMAP5: Couple of patches for KVM
Date: Sat, 23 Nov 2013 19:07:44 -0500
Message-ID: <1385251666-27532-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60556 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755840Ab3KXAIQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 Nov 2013 19:08:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Tony Lindgren <tony@atomide.com>

Couple of patches for OMAP5 machines towards KVM support.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>

Santosh Shilimkar (2):
  ARM: dts: OMAP5: Add maintenance interrupt for virtualisation
  ARM: OMAP5: Add HYP mode entry support for secondary CPUs

 arch/arm/boot/dts/omap5.dtsi       |    1 +
 arch/arm/mach-omap2/omap-headsmp.S |    7 +++++++
 2 files changed, 8 insertions(+)

-- 
1.7.9.5

