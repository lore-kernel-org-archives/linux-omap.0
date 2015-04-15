From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 19/35] ARM: OMAP3: PRM: remove code from __init section
Date: Wed, 15 Apr 2015 15:53:06 +0300
Message-ID: <1429102402-5276-20-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47054 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534AbbDOMxD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2015 08:53:03 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Needed by hwmod module boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm3xxx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 5713bbd..4f16257 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -270,7 +270,7 @@ int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
  * Toggles the reset signal to modem IP block. Required to allow
  * OMAP3430 without stacked modem to idle properly.
  */
-void __init omap3_prm_reset_modem(void)
+void omap3_prm_reset_modem(void)
 {
 	omap2_prm_write_mod_reg(
 		OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON_MASK |
@@ -286,7 +286,7 @@ void __init omap3_prm_reset_modem(void)
  *
  * Initializes PRM registers for PM use. Called from PM init.
  */
-void __init omap3_prm_init_pm(bool has_uart4, bool has_iva)
+void omap3_prm_init_pm(bool has_uart4, bool has_iva)
 {
 	u32 en_uart4_mask;
 	u32 grpsel_uart4_mask;
-- 
1.7.9.5

