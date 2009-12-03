From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/9] OMAP2/3 PRCM: don't export prm_*(), cm_*() functions
Date: Thu, 03 Dec 2009 06:45:32 -0700
Message-ID: <20091203134530.16229.16918.stgit@localhost.localdomain>
References: <20091203134321.16229.87539.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48951 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088AbZLCNwW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:52:22 -0500
In-Reply-To: <20091203134321.16229.87539.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Device drivers and loadable modules should not be calling these
prm_* and cm_* functions, so stop exporting them.  Only core code
and device driver integration code (in arch/arm/*omap*) should
call these functions.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 029d376..9208b6e 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -170,14 +170,12 @@ u32 prm_read_mod_reg(s16 module, u16 idx)
 {
 	return __omap_prcm_read(prm_base, module, idx);
 }
-EXPORT_SYMBOL(prm_read_mod_reg);
 
 /* Write into a register in a PRM module */
 void prm_write_mod_reg(u32 val, s16 module, u16 idx)
 {
 	__omap_prcm_write(val, prm_base, module, idx);
 }
-EXPORT_SYMBOL(prm_write_mod_reg);
 
 /* Read-modify-write a register in a PRM module. Caller must lock */
 u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
@@ -191,21 +189,18 @@ u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
 
 	return v;
 }
-EXPORT_SYMBOL(prm_rmw_mod_reg_bits);
 
 /* Read a register in a CM module */
 u32 cm_read_mod_reg(s16 module, u16 idx)
 {
 	return __omap_prcm_read(cm_base, module, idx);
 }
-EXPORT_SYMBOL(cm_read_mod_reg);
 
 /* Write into a register in a CM module */
 void cm_write_mod_reg(u32 val, s16 module, u16 idx)
 {
 	__omap_prcm_write(val, cm_base, module, idx);
 }
-EXPORT_SYMBOL(cm_write_mod_reg);
 
 /* Read-modify-write a register in a CM module. Caller must lock */
 u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
@@ -219,7 +214,6 @@ u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
 
 	return v;
 }
-EXPORT_SYMBOL(cm_rmw_mod_reg_bits);
 
 /**
  * omap2_cm_wait_idlest - wait for IDLEST bit to indicate module readiness


