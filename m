From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: omap: add read permission to mux debugfs files
Date: Tue, 11 Dec 2012 19:04:56 +0200
Message-ID: <1355245496-19180-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52296 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754115Ab2LKRMH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Dec 2012 12:12:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

All those files provide a ->read() method on their
file_operations structure.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 2612634..6701f31 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -742,8 +742,8 @@ static void __init omap_mux_dbg_create_entry(
 	list_for_each_entry(e, &partition->muxmodes, node) {
 		struct omap_mux *m = &e->mux;
 
-		(void)debugfs_create_file(m->muxnames[0], S_IWUSR, mux_dbg_dir,
-					  m, &omap_mux_dbg_signal_fops);
+		(void)debugfs_create_file(m->muxnames[0], S_IWUSR | S_IRUSR,
+				mux_dbg_dir, m, &omap_mux_dbg_signal_fops);
 	}
 }
 
-- 
1.8.1.rc1.5.g7e0651a

