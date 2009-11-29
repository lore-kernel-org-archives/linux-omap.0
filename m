From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] omap3: mux: add shorthands for OUTPUT_PULL{UP,DOWN}
Date: Sun, 29 Nov 2009 10:07:10 +0200
Message-ID: <1b6ff0b31e4c22532659749282e0dcf4dccdf5e4.1259481545.git.mike@compulab.co.il>
References: <cover.1259481545.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:58292 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbZK2ILV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 29 Nov 2009 03:11:21 -0500
In-Reply-To: <cover.1259481545.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/mux.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index e09c5d2..02a1b53 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -37,6 +37,8 @@
 
 /* Active pin states */
 #define OMAP_PIN_OUTPUT			0
+#define OMAP_PIN_OUTPUT_PULLUP		(OMAP_PULL_ENA | OMAP_PULL_UP)
+#define OMAP_PIN_OUTPUT_PULLDOWN	OMAP_PULL_ENA
 #define OMAP_PIN_INPUT			OMAP_INPUT_EN
 #define OMAP_PIN_INPUT_PULLUP		(OMAP_PULL_ENA | OMAP_INPUT_EN \
 						| OMAP_PULL_UP)
-- 
1.6.4.4

