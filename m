From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] OMAP2/3 clockdomains: autodeps should respect platform
	flags
Date: Tue, 12 Aug 2008 15:31:45 -0600
Message-ID: <20080812213144.24628.72502.stgit@localhost.localdomain>
References: <20080812212919.24628.82229.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49196 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbYHLVdv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 17:33:51 -0400
In-Reply-To: <20080812212919.24628.82229.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Fix the clockdomain autodep code to respect omap_chip platform flags.

Resolves "Unable to handle kernel paging request at virtual address
5f75706d" panic during power management initialization on OMAP2.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clockdomain.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index caa7992..49741e8 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -96,6 +96,9 @@ static void _clkdm_add_autodeps(struct clockdomain *clkdm)
 	struct clkdm_pwrdm_autodep *autodep;
 
 	for (autodep = autodeps; autodep->pwrdm.ptr; autodep++) {
+		if (!omap_chip_is(autodep->omap_chip))
+			continue;
+
 		pr_debug("clockdomain: adding %s sleepdep/wkdep for "
 			 "pwrdm %s\n", autodep->pwrdm.ptr->name,
 			 clkdm->pwrdm.ptr->name);
@@ -118,6 +121,9 @@ static void _clkdm_del_autodeps(struct clockdomain *clkdm)
 	struct clkdm_pwrdm_autodep *autodep;
 
 	for (autodep = autodeps; autodep->pwrdm.ptr; autodep++) {
+		if (!omap_chip_is(autodep->omap_chip))
+			continue;
+
 		pr_debug("clockdomain: removing %s sleepdep/wkdep for "
 			 "pwrdm %s\n", autodep->pwrdm.ptr->name,
 			 clkdm->pwrdm.ptr->name);


