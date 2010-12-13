From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 5/5] OMAP4: clock data: Keep L3INSTR clock domain modulemode under HW control
Date: Mon, 13 Dec 2010 22:49:29 +0100
Message-ID: <1292276969-29733-6-git-send-email-b-cousson@ti.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36045 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757463Ab0LMVuw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 16:50:52 -0500
In-Reply-To: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

L3INSTR clock domain is read only register and its reset value is
HW_AUTO. The modules withing this clock domain needs to be kept under
hardware control.

MODULEMODE:
- 0x0: Module is disable by software. Any INTRCONN access to module
  results in an error, except if resulting from a module wakeup
  (asynchronous wakeup).
- 0x1: Module is managed automatically by hardware according to
  clock domain transition. A clock domain sleep transition put
  module into idle. A wakeup domain transition put it back
  into function. If CLKTRCTRL=3, any INTRCONN access to module
  is always granted. Module clocks may be gated according to
  the clock domain state.

This patch keeps CM_L3INSTR_L3_3_CLKCTRL, CM_L3INSTR_L3_INSTR_CLKCTRL
and CM_L3INSTR_INTRCONN_WP1_CLKCTRL module mode under hardware control
by using ENABLE_ON_INIT flag.

Without this the OMAP4 device OFF mode SAR restore phase aborts during
interconnect register restore phase. This can be also handled by doing
explicit a clock enable and disable in the low power code since there
is no direct module associated with it. But that seems not necessary
since the clock domain is under HW control.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 76e900b..a72f6ab 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1755,6 +1755,7 @@ static struct clk l3_instr_ick = {
 	.enable_reg	= OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "l3_instr_clkdm",
+	.flags		= ENABLE_ON_INIT,
 	.parent		= &l3_div_ck,
 	.recalc		= &followparent_recalc,
 };
@@ -1765,6 +1766,7 @@ static struct clk l3_main_3_ick = {
 	.enable_reg	= OMAP4430_CM_L3INSTR_L3_3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "l3_instr_clkdm",
+	.flags		= ENABLE_ON_INIT,
 	.parent		= &l3_div_ck,
 	.recalc		= &followparent_recalc,
 };
@@ -2069,6 +2071,7 @@ static struct clk ocp_wp_noc_ick = {
 	.enable_reg	= OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "l3_instr_clkdm",
+	.flags		= ENABLE_ON_INIT,
 	.parent		= &l3_div_ck,
 	.recalc		= &followparent_recalc,
 };
-- 
1.7.0.4

