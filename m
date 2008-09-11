From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 18/29] OMAP3: PM: Do not build pm_idle loop if cpuidle is used
Date: Thu, 11 Sep 2008 15:34:02 +0300
Message-ID: <1221136453-16697-18-git-send-email-khilman@deeprootsystems.com>
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
 <1221136453-16697-16-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-17-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43102 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930AbYIKMey (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:54 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BCYJUj022824
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 07:34:52 -0500
In-Reply-To: <1221136453-16697-17-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jouni Hogander <jouni.hogander@nokia.com>, Git administrator <gitowner@stego.research.nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

Signed-off-by: Git administrator <gitowner@stego.research.nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ae324b4..d696dde 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -465,6 +465,7 @@ err:
 	return ret;
 }
 
+#ifndef CONFIG_CPU_IDLE
 static void omap3_pm_idle(void)
 {
 	local_irq_disable();
@@ -484,6 +485,7 @@ out:
 	local_fiq_enable();
 	local_irq_enable();
 }
+#endif /* CONFIG_CPU_IDLE */
 
 static int omap3_pm_prepare(void)
 {
-- 
1.6.0

