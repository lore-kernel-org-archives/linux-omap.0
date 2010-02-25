From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] AM35x: Enable OMAP_MUX in defconfig
Date: Thu, 25 Feb 2010 15:03:13 -0800
Message-ID: <20100225230313.26233.8965.stgit@baageli.muru.com>
References: <20100225230116.26233.65157.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58272 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934451Ab0BYXCK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 18:02:10 -0500
In-Reply-To: <20100225230116.26233.65157.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Enabling OMAP_MUX in defconfig as it is required for EHCI to work.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/am3517_evm_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/am3517_evm_defconfig b/arch/arm/configs/am3517_evm_defconfig
index abe9966..edae1c2 100644
--- a/arch/arm/configs/am3517_evm_defconfig
+++ b/arch/arm/configs/am3517_evm_defconfig
@@ -201,7 +201,7 @@ CONFIG_ARCH_OMAP3=y
 # CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
 # CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
 CONFIG_OMAP_RESET_CLOCKS=y
-# CONFIG_OMAP_MUX is not set
+CONFIG_OMAP_MUX=y
 # CONFIG_OMAP_MCBSP is not set
 # CONFIG_OMAP_MBOX_FWK is not set
 # CONFIG_OMAP_MPU_TIMER is not set

