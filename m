From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP: hwmod: add softreset delay field and OMAP4 data
Date: Tue, 28 Feb 2012 03:26:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202280325200.11716@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47806 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab2B1K0T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 05:26:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>, b-cousson@ti.com


From: Fernando Guzman Lugo <fernando.lugo@ti.com>

Due to HW limitation, some IPs should not be accessed just after a
softreset. Since the current hwmod sequence is accessing the sysconfig
register just after the reset, it might lead to OCP bus error in
that case.

Add a new field in the sysconfig structure to specify a delay in usecs
needed after doing a softreset.

In the case of the ISS and FDIF modules, the L3 OCP port will be
disconnected upon a SW reset. That issue was confirmed with HW simulation
and an errata should be available soon. The HW recommendation to avoid
that is to wait for 100 OCP clk cycles, before accessing the IP.

Considering the worse case (OPP50), the L3 bus will run at 100 MHz,
so a 1 usec delay is needed. Add an x2 margin to be safe.

Acked-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    3 +++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   18 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +++-
 3 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index ac0b03f..89d048a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1418,6 +1418,9 @@ static int _ocp_softreset(struct omap_hwmod *oh)
 		goto dis_opt_clks;
 	_write_sysconfig(v, oh);
 
+	if (oh->class->sysc->srst_udelay)
+		udelay(oh->class->sysc->srst_udelay);
+
 	if (oh->class->sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
 		omap_test_timeout((omap_hwmod_read(oh,
 						    oh->class->sysc->syss_offs)
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index b5b9b87..2acfc7f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1774,6 +1774,15 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 static struct omap_hwmod_class_sysconfig omap44xx_fdif_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
+	/*
+	 * FDIF needs 100 OCP clk cycles delay after a softreset before
+	 * accessing sysconfig again.
+	 * The lowest frequency at the moment for L3 bus is 100 MHz, so
+	 * 1usec delay is needed. Add an x2 margin to be safe (2 usecs).
+	 *
+	 * TODO: Indicate errata when available.
+	 */
+	.srst_udelay	= 2,
 	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_RESET_STATUS |
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
@@ -2597,6 +2606,15 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 static struct omap_hwmod_class_sysconfig omap44xx_iss_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
+	/*
+	 * ISS needs 100 OCP clk cycles delay after a softreset before
+	 * accessing sysconfig again.
+	 * The lowest frequency at the moment for L3 bus is 100 MHz, so
+	 * 1usec delay is needed. Add an x2 margin to be safe (2 usecs).
+	 *
+	 * TODO: Indicate errata when available.
+	 */
+	.srst_udelay	= 2,
 	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_RESET_STATUS |
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 3303c63..e9969a3 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -306,6 +306,7 @@ struct omap_hwmod_sysc_fields {
  * @rev_offs: IP block revision register offset (from module base addr)
  * @sysc_offs: OCP_SYSCONFIG register offset (from module base addr)
  * @syss_offs: OCP_SYSSTATUS register offset (from module base addr)
+ * @srst_udelay: Delay needed after doing a softreset in usecs
  * @idlemodes: One or more of {SIDLE,MSTANDBY}_{OFF,FORCE,SMART}
  * @sysc_flags: SYS{C,S}_HAS* flags indicating SYSCONFIG bits supported
  * @clockact: the default value of the module CLOCKACTIVITY bits
@@ -331,9 +332,10 @@ struct omap_hwmod_class_sysconfig {
 	u16 sysc_offs;
 	u16 syss_offs;
 	u16 sysc_flags;
+	struct omap_hwmod_sysc_fields *sysc_fields;
+	u8 srst_udelay;
 	u8 idlemodes;
 	u8 clockact;
-	struct omap_hwmod_sysc_fields *sysc_fields;
 };
 
 /**
-- 
1.7.9.1

