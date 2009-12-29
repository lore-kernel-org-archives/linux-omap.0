From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-v2.6.33-rc2+ 07/12] arm: omap: remove unused variables
Date: Wed, 30 Dec 2009 00:51:27 +0200
Message-ID: <1262127092-14878-8-git-send-email-felipe.balbi@nokia.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58955 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbZL2W4h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 17:56:37 -0500
In-Reply-To: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <felipe.balbi@nokia.com>

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
1.6.6.35.g1d85d

