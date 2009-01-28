From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH B 10/10] OMAP3: PM: Emu_pwrdm is switched off by hardware even
	when sdti is in use
Date: Tue, 27 Jan 2009 19:44:38 -0700
Message-ID: <20090128024435.27240.44368.stgit@localhost.localdomain>
References: <20090128024301.27240.39391.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60307 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbZA1UYO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:24:14 -0500
In-Reply-To: <20090128024301.27240.39391.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

Using sdti doesn't keep emu_pwrdm on if hardware supervised pwrdm
transitions are used. This causes sdti stop to work when power
management is initialized and hardware supervised pwrdm control is
enabled. This patch disables hardware supervised pwrdm control for
emu_pwrdm. Now emu_pwrdm is switched off on boot by software when it
is not used.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clockdomains.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index bafa650..3d4eaca 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -251,10 +251,14 @@ static struct clockdomain per_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/*
+ * Disable hw supervised mode for emu_clkdm, because emu_pwrdm is
+ * switched of even if sdti is in use
+ */
 static struct clockdomain emu_clkdm = {
 	.name		= "emu_clkdm",
 	.pwrdm		= { .name = "emu_pwrdm" },
-	.flags		= CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_SWSUP,
+	.flags		= /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_EMU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };


