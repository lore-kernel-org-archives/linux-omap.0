From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] omap: Fix cmdline muxing
Date: Wed, 20 Jan 2010 13:23:34 -0800
Message-ID: <20100120212334.25335.50876.stgit@baageli.muru.com>
References: <20100120212248.25335.55761.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63603 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab0ATVXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 16:23:24 -0500
In-Reply-To: <20100120212248.25335.55761.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Philip Balister <philip@balister.org>, linux-omap@vger.kernel.org

Looks like cmdline muxing got broken at some point when we
decided to limit muxing to __init code. Currently omap_mux_entry
list is not yet initialized when we try to initialize cmdline
muxing.

Fix this by calling omap_mux_init_list() before calling
omap_mux_set_cmdline_signals().

Reported-by: Philip Balister <philip@balister.org>
Tested-by: Philip Balister <philip@balister.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 459ef23..40ea9fd 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -998,12 +998,15 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 		omap_mux_package_fixup(package_subset, superset);
 	if (package_balls)
 		omap_mux_package_init_balls(package_balls, superset);
-	omap_mux_set_cmdline_signals();
-	omap_mux_set_board_signals(board_mux);
 #endif
 
 	omap_mux_init_list(superset);
 
+#ifdef CONFIG_OMAP_MUX
+	omap_mux_set_cmdline_signals();
+	omap_mux_set_board_signals(board_mux);
+#endif
+
 	return 0;
 }
 

