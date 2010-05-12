From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH v3 2/2] ARM: McBSP: Add support for omap4 in McBSP driver
Date: Wed, 12 May 2010 12:18:40 -0500
Message-ID: <1273684720-16619-3-git-send-email-jorge.candelaria@ti.com>
References: <1273684720-16619-1-git-send-email-jorge.candelaria@ti.com>
 <1273684720-16619-2-git-send-email-jorge.candelaria@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54018 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754299Ab0ELRaV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 13:30:21 -0400
In-Reply-To: <1273684720-16619-2-git-send-email-jorge.candelaria@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, Margarita Olaya Cabrera <magi.olaya@ti.com>

McBSP module in OMAP4 needs to be able to set its tx/rx threshold
and enable the transmitter/receiver when starting an audio stream.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 arch/arm/plat-omap/mcbsp.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 6696eb6..6dbe669 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -489,7 +489,7 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
 {
 	struct omap_mcbsp *mcbsp;
 
-	if (!cpu_is_omap34xx())
+	if (!cpu_is_omap34xx() && !cpu_is_omap44xx())
 		return;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -511,7 +511,7 @@ void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 {
 	struct omap_mcbsp *mcbsp;
 
-	if (!cpu_is_omap34xx())
+	if (!cpu_is_omap34xx() && !cpu_is_omap44xx())
 		return;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -587,7 +587,7 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 	 * Enable wakup behavior, smart idle and all wakeups
 	 * REVISIT: some wakeups may be unnecessary
 	 */
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		u16 syscon;
 
 		syscon = MCBSP_READ(mcbsp, SYSCON);
@@ -610,7 +610,7 @@ static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
 	/*
 	 * Disable wakup behavior, smart idle and all wakeups
 	 */
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		u16 syscon;
 
 		syscon = MCBSP_READ(mcbsp, SYSCON);
@@ -859,7 +859,7 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 		MCBSP_WRITE(mcbsp, SPCR2, w | (1 << 7));
 	}
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		/* Release the transmitter and receiver */
 		w = MCBSP_READ_CACHE(mcbsp, XCCR);
 		w &= ~(tx ? XDISABLE : 0);
@@ -889,7 +889,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 
 	/* Reset transmitter */
 	tx &= 1;
-	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		w = MCBSP_READ_CACHE(mcbsp, XCCR);
 		w |= (tx ? XDISABLE : 0);
 		MCBSP_WRITE(mcbsp, XCCR, w);
@@ -899,7 +899,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 
 	/* Reset receiver */
 	rx &= 1;
-	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		w = MCBSP_READ_CACHE(mcbsp, RCCR);
 		w |= (rx ? RDISABLE : 0);
 		MCBSP_WRITE(mcbsp, RCCR, w);
-- 
1.6.3.3

