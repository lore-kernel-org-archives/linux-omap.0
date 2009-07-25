From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/8] OMAP3 SDRC: Fix freeze when scaling CORE dpll to < 83Mhz
Date: Fri, 24 Jul 2009 20:11:27 -0600
Message-ID: <20090725021127.29059.44697.stgit@localhost.localdomain>
References: <20090725021102.29059.94214.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50652 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272AbZGYCNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 22:13:04 -0400
In-Reply-To: <20090725021102.29059.94214.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Limei Wang <E12499@motorola.com>, Richard Woodruff <r-woodruff2@ti.com>, Girish Ghongdemath <girishsg@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch fixes a bug in the CORE dpll scaling sequence which was
errouneously clearing some bits in the SDRC DLLA CTRL register and
hence causing a freeze.  The issue was observed only on platforms
which scale CORE dpll to < 83Mhz and hence program the DLL in fixed
delay mode.

Issue reported by Limei Wang <E12499@motorola.com>, with debugging
assistance from Richard Woodruff <r-woodruff2@ti.com> and Girish
Ghongdemath <girishsg@ti.com>.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Limei Wang <E12499@motorola.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Girish Ghongdemath <girishsg@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
[paul@pwsan.com: updated patch description to include collaboration credits]
---
 arch/arm/mach-omap2/sram34xx.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 9c2d046..e6b1125 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -143,7 +143,7 @@ return_to_sdram:
 unlock_dll:
 	ldr	r11, omap3_sdrc_dlla_ctrl
 	ldr	r12, [r11]
-	and	r12, r12, #FIXEDDELAY_MASK
+	bic	r12, r12, #FIXEDDELAY_MASK
 	orr	r12, r12, #FIXEDDELAY_DEFAULT
 	orr	r12, r12, #DLLIDLE_MASK
 	str	r12, [r11]		@ (no OCP barrier needed)


