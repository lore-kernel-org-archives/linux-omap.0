From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rfc/rft/patch 2/9] arm: omap: remove unused variables
Date: Tue,  1 Dec 2009 15:03:48 +0200
Message-ID: <1259672635-12306-3-git-send-email-felipe.balbi@nokia.com>
References: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20669 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbZLANFA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 08:05:00 -0500
In-Reply-To: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kalle Valo <kalle.valo@iki.fi>, Jean Pihet <jpihet@mvista.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

those are never used, remove it until we need to
actually use them to avoid the compile warning.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430.h b/arch/arm/mach-omap2/omap_hwmod_2430.h
index 59a208b..49139ad 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430.h
+++ b/arch/arm/mach-omap2/omap_hwmod_2430.h
@@ -62,8 +62,6 @@ static struct omap_hwmod omap2430_l3_hwmod = {
 };
 
 static struct omap_hwmod omap2430_l4_wkup_hwmod;
-static struct omap_hwmod omap2430_mmc1_hwmod;
-static struct omap_hwmod omap2430_mmc2_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
-- 
1.6.6.rc0

