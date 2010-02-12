From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/19] omap3: Clean-up for omap_mux_init
Date: Thu, 11 Feb 2010 16:51:33 -0800
Message-ID: <20100212005133.24958.45495.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53714 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757749Ab0BLAuw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 19:50:52 -0500
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Get rid of the ifdeffery in omap_mux_init by creating
omap_mux_init_package and omap_mux_init_signals functions.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |   46 +++++++++++++++++++++++++++++++++------------
 1 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 5ee2372..986077f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -985,6 +985,38 @@ static void __init omap_mux_init_list(struct omap_mux *superset)
 	}
 }
 
+#ifdef CONFIG_OMAP_MUX
+
+static void omap_mux_init_package(struct omap_mux *superset,
+				  struct omap_mux *package_subset,
+				  struct omap_ball *package_balls)
+{
+	if (package_subset)
+		omap_mux_package_fixup(package_subset, superset);
+	if (package_balls)
+		omap_mux_package_init_balls(package_balls, superset);
+}
+
+static void omap_mux_init_signals(struct omap_board_mux *board_mux)
+{
+	omap_mux_set_cmdline_signals();
+	omap_mux_write_array(board_mux);
+}
+
+#else
+
+static void omap_mux_init_package(struct omap_mux *superset,
+				  struct omap_mux *package_subset,
+				  struct omap_ball *package_balls)
+{
+}
+
+static void omap_mux_init_signals(struct omap_board_mux *board_mux)
+{
+}
+
+#endif
+
 int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 				struct omap_mux *superset,
 				struct omap_mux *package_subset,
@@ -1001,19 +1033,9 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 		return -ENODEV;
 	}
 
-#ifdef CONFIG_OMAP_MUX
-	if (package_subset)
-		omap_mux_package_fixup(package_subset, superset);
-	if (package_balls)
-		omap_mux_package_init_balls(package_balls, superset);
-#endif
-
+	omap_mux_init_package(superset, package_subset, package_balls);
 	omap_mux_init_list(superset);
-
-#ifdef CONFIG_OMAP_MUX
-	omap_mux_set_cmdline_signals();
-	omap_mux_write_array(board_mux);
-#endif
+	omap_mux_init_signals(board_mux);
 
 	return 0;
 }

