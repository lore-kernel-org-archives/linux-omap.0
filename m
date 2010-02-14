From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] OMAP: Dereference of NULL autodep in _autodep_lookup()
Date: Sun, 14 Feb 2010 17:00:05 +0100
Message-ID: <4B781E05.9040502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:61717 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab0BNPwu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Feb 2010 10:52:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Don't dereference autodep when it's NULL. In _autodep_lookup() an
ERR_PTR(-ENOENT) is assigned to autodep->pwrdm.ptr if pwrdm_lookup() fails.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---

Alternatively we could do:

-		for (autodep = autodeps; autodep->pwrdm.ptr; autodep++)
+		for (autodep = autodeps; !IS_ERR(autodep->pwrdm.ptr); autodep++)

...but considering how _clkdm_add_autodeps() traverses trough the autodeps it
appears that we want to ignore failures. Correct?

Roel

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index dd285f0..8f359c1 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -64,9 +64,6 @@ static void _autodep_lookup(struct clkdm_pwrdm_autodep *autodep)
 {
 	struct powerdomain *pwrdm;
 
-	if (!autodep)
-		return;
-
 	if (!omap_chip_is(autodep->omap_chip))
 		return;
 
@@ -211,7 +208,7 @@ void clkdm_init(struct clockdomain **clkdms,
 
 	autodeps = init_autodeps;
 	if (autodeps)
-		for (autodep = autodeps; autodep->pwrdm.ptr; autodep++)
+		for (autodep = autodeps; autodep; autodep++)
 			_autodep_lookup(autodep);
 }
 
