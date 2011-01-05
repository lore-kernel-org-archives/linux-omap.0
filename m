From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: mach-omap2: mux: fix buffer overrun
Date: Wed,  5 Jan 2011 18:42:13 +0200
Message-ID: <1294245733-4126-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:23036 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277Ab1AEQkc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 11:40:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

memcpy() copies 8 bytes too much (omap_mux_entry vs. omap_mux). Correct
by replacing memcpy() with struct assignment, which is safer.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/mux.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 17bd639..df8d2f2 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -893,7 +893,7 @@ static struct omap_mux * __init omap_mux_list_add(
 		return NULL;
 
 	m = &entry->mux;
-	memcpy(m, src, sizeof(struct omap_mux_entry));
+	entry->mux = *src;
 
 #ifdef CONFIG_OMAP_MUX
 	if (omap_mux_copy_names(src, m)) {
-- 
1.5.6.5

