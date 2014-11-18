From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 05/10] arm: omap: omap2plus_defconfig: enable ECAP and EHRPWM
Date: Tue, 18 Nov 2014 12:07:03 -0600
Message-ID: <1416334028-7766-5-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53413 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627AbaKRSHU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 13:07:20 -0500
In-Reply-To: <1416334028-7766-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Many of AM335x and AM437x hook backlight to
one of these two devices. By enabling their
drivers we make sure pwm-backlight can do
its thing.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 3837a3e..9be67b7 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -401,6 +401,8 @@ CONFIG_DMA_OMAP=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_PALMAS=y
 CONFIG_PWM=y
+CONFIG_PWM_TIECAP=y
+CONFIG_PWM_TIEHRPWM=y
 CONFIG_PWM_TWL=y
 CONFIG_PWM_TWL_LED=y
 CONFIG_OMAP_USB2=y
-- 
2.1.0.GIT

