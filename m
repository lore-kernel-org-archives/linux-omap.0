From: green@linuxhacker.ru
Subject: [PATCH 3/3] Update Nook Color machine 3284 to common Encore name.
Date: Tue, 14 Jun 2011 11:45:07 -0400
Message-ID: <1308066307-415-4-git-send-email-green@linuxhacker.ru>
References: <1308066307-415-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from c-71-228-165-73.hsd1.tn.comcast.net ([71.228.165.73]:38571 "EHLO
	fatbox1.localnet" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753123Ab1FNPqe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 11:46:34 -0400
In-Reply-To: <1308066307-415-1-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Oleg Drokin <green@linuxhacker.ru>

From: Oleg Drokin <green@linuxhacker.ru>

Machine database already updated:
http://www.arm.linux.org.uk/developer/machines/list.php?id=3284

Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 arch/arm/tools/mach-types |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 3b3776d..fff68d0 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -910,7 +910,7 @@ omapl138_case_a3	MACH_OMAPL138_CASE_A3	OMAPL138_CASE_A3	3280
 uemd			MACH_UEMD		UEMD			3281
 ccwmx51mut		MACH_CCWMX51MUT		CCWMX51MUT		3282
 rockhopper		MACH_ROCKHOPPER		ROCKHOPPER		3283
-nookcolor		MACH_NOOKCOLOR		NOOKCOLOR		3284
+encore			MACH_ENCORE		ENCORE			3284
 hkdkc100		MACH_HKDKC100		HKDKC100		3285
 ts42xx			MACH_TS42XX		TS42XX			3286
 aebl			MACH_AEBL		AEBL			3287
-- 
1.7.4.4

