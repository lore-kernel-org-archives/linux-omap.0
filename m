From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/5] omap3|4: mux: make local structures static
Date: Tue,  4 Jan 2011 14:07:10 -0600
Message-ID: <1294171634-13943-2-git-send-email-nm@ti.com>
References: <1294171634-13943-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54395 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886Ab1ADUHX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 15:07:23 -0500
In-Reply-To: <1294171634-13943-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony <tony@atomide.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

Mux data is passed by pointers to mux.c from the SoC specific
mux file, these variables dont really need to be global scope.

This fixes the following sparse warnings:
arch/arm/mach-omap2/mux44xx.c:547:29: warning: symbol 'omap4_core_cbl_ball' was not declared. Should it be static?
arch/arm/mach-omap2/mux44xx.c:1265:29: warning: symbol 'omap4_core_cbs_ball' was not declared. Should it be static?
arch/arm/mach-omap2/mux44xx.c:1549:29: warning: symbol 'omap4_wkup_cbl_cbs_ball' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/mux34xx.c |    4 ++--
 arch/arm/mach-omap2/mux44xx.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index 440c98e..17f80e4 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -703,7 +703,7 @@ static struct omap_mux __initdata omap3_muxmodes[] = {
  * Signals different on CBC package compared to the superset
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_OMAP_PACKAGE_CBC)
-struct omap_mux __initdata omap3_cbc_subset[] = {
+static struct omap_mux __initdata omap3_cbc_subset[] = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
@@ -721,7 +721,7 @@ struct omap_mux __initdata omap3_cbc_subset[] = {
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)	\
 		&& defined(CONFIG_OMAP_PACKAGE_CBC)
-struct omap_ball __initdata omap3_cbc_ball[] = {
+static struct omap_ball __initdata omap3_cbc_ball[] = {
 	_OMAP3_BALLENTRY(CAM_D0, "ae16", NULL),
 	_OMAP3_BALLENTRY(CAM_D1, "ae15", NULL),
 	_OMAP3_BALLENTRY(CAM_D10, "d25", NULL),
diff --git a/arch/arm/mach-omap2/mux44xx.c b/arch/arm/mach-omap2/mux44xx.c
index 980f11d..c322e7b 100644
--- a/arch/arm/mach-omap2/mux44xx.c
+++ b/arch/arm/mach-omap2/mux44xx.c
@@ -544,7 +544,7 @@ static struct omap_mux __initdata omap4_core_muxmodes[] = {
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)		\
 		&& defined(CONFIG_OMAP_PACKAGE_CBL)
-struct omap_ball __initdata omap4_core_cbl_ball[] = {
+static struct omap_ball __initdata omap4_core_cbl_ball[] = {
 	_OMAP4_BALLENTRY(GPMC_AD0, "c12", NULL),
 	_OMAP4_BALLENTRY(GPMC_AD1, "d12", NULL),
 	_OMAP4_BALLENTRY(GPMC_AD2, "c13", NULL),
@@ -1262,7 +1262,7 @@ static struct omap_mux __initdata omap4_es2_core_muxmodes[] = {
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)		\
 		&& defined(CONFIG_OMAP_PACKAGE_CBS)
-struct omap_ball __initdata omap4_core_cbs_ball[] = {
+static struct omap_ball __initdata omap4_core_cbs_ball[] = {
 	_OMAP4_BALLENTRY(GPMC_AD0, "c12", NULL),
 	_OMAP4_BALLENTRY(GPMC_AD1, "d12", NULL),
 	_OMAP4_BALLENTRY(GPMC_AD2, "c13", NULL),
@@ -1546,7 +1546,7 @@ static struct omap_mux __initdata omap4_wkup_muxmodes[] = {
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)		\
 		&& defined(CONFIG_OMAP_PACKAGE_CBL)
-struct omap_ball __initdata omap4_wkup_cbl_cbs_ball[] = {
+static struct omap_ball __initdata omap4_wkup_cbl_cbs_ball[] = {
 	_OMAP4_BALLENTRY(SIM_IO, "h4", NULL),
 	_OMAP4_BALLENTRY(SIM_CLK, "j2", NULL),
 	_OMAP4_BALLENTRY(SIM_RESET, "g2", NULL),
-- 
1.6.3.3

