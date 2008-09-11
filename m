From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 16/29] OMAP3: PM: Remove static keyword from _omap_sram_idle declaration
Date: Thu, 11 Sep 2008 15:34:00 +0300
Message-ID: <1221136453-16697-16-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-12-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-13-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-14-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-15-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43087 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882AbYIKMeq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:46 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BCYWWH022906
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 07:34:45 -0500
In-Reply-To: <1221136453-16697-15-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jouni Hogander <jouni.hogander@nokia.com>, Git administrator <gitowner@stego.research.nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

_omap_sram_idle is shared between cpuidle34xx.c and pm34xx.c so static
keyword needs to be removed.

Signed-off-by: Git administrator <gitowner@stego.research.nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 42fa546..73f32a0 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -60,7 +60,7 @@ u32 restore_pointer_address;
 
 static LIST_HEAD(pwrst_list);
 
-static void (*_omap_sram_idle)(u32 *addr, int save_state);
+void (*_omap_sram_idle)(u32 *addr, int save_state);
 
 static void (*saved_idle)(void);
 
-- 
1.6.0

