From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 10/14] TEMP: mux: added trace for io wkup event
Date: Fri, 9 Dec 2011 16:27:33 +0200
Message-ID: <1323440857-385-11-git-send-email-t-kristo@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46869 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138Ab1LIO2V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:28:21 -0500
In-Reply-To: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com

Temporary patch for testing purposes, not meant for integration.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/mux.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 0d1962e..0233cb8 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -376,6 +376,8 @@ bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
 					pad->mux->reg_offset);
 			if (val & OMAP_WAKEUP_EVENT) {
 				ret = true;
+				pr_info("wkup detected: %04x\n",
+					pad->mux->reg_offset);
 				break;
 			}
 		}
-- 
1.7.4.1

