From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/7] omap4: Temporary fix silicon version detection
Date: Thu,  9 Sep 2010 16:53:10 +0530
Message-ID: <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51387 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055Ab0IILXY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Sep 2010 07:23:24 -0400
In-Reply-To: <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Few initial omap4 es2 samples IDCODE is same as es1. This patch
uses ARM cpuid register to detect the ES version for such samples

This patch can be reverted once all the samples gets replaced
with new lot.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/id.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a423c7f..487e8d6 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -308,6 +308,16 @@ static void __init omap4_check_revision(void)
 	hawkeye = (idcode >> 12) & 0xffff;
 	rev = (idcode >> 28) & 0xff;
 
+	/*
+	 * FIXME: This patch should be reverted later.
+	 * Few initial ES2.0 samples IDCODE is same as ES1.0
+	 * Use ARM register to detect the correct ES version
+	 */
+	if (!rev) {
+		idcode = read_cpuid(CPUID_ID);
+		rev = (idcode & 0xf) - 1;
+	}
+
 	switch (hawkeye) {
 	case 0xb852:
 		switch (rev) {
-- 
1.6.0.4

