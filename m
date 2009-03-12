From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 52/86] [ARM] OMAP2/3 clockdomains: autodeps should respect platform flags
Date: Thu, 12 Mar 2009 11:28:02 -0700
Message-ID: <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757079AbZCLSc1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:32:27 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:32:25 -0700 (PDT)
In-Reply-To: <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Fix the clockdomain autodep code to respect omap_chip platform flags.

Resolves "Unable to handle kernel paging request at virtual address
5f75706d" panic during power management initialization on OMAP2.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clockdomain.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index c9c367c..ae0c53a 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -100,6 +100,9 @@ static void _clkdm_add_autodeps(struct clockdomain *clkdm)
 		if (IS_ERR(autodep->pwrdm.ptr))
 			continue;
 
+		if (!omap_chip_is(autodep->omap_chip))
+			continue;
+
 		pr_debug("clockdomain: adding %s sleepdep/wkdep for "
 			 "pwrdm %s\n", autodep->pwrdm.ptr->name,
 			 clkdm->pwrdm.ptr->name);
@@ -125,6 +128,9 @@ static void _clkdm_del_autodeps(struct clockdomain *clkdm)
 		if (IS_ERR(autodep->pwrdm.ptr))
 			continue;
 
+		if (!omap_chip_is(autodep->omap_chip))
+			continue;
+
 		pr_debug("clockdomain: removing %s sleepdep/wkdep for "
 			 "pwrdm %s\n", autodep->pwrdm.ptr->name,
 			 clkdm->pwrdm.ptr->name);
-- 
1.6.1.2

