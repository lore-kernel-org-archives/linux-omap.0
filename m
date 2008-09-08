From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/12] OMAP2/3 clockdomain: remove wkup_clkdm
Date: Mon, 08 Sep 2008 10:57:45 -0600
Message-ID: <20080908165744.2540.29653.stgit@localhost.localdomain>
References: <20080908164444.2540.98619.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49068 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652AbYIIIVA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 04:21:00 -0400
In-Reply-To: <20080908164444.2540.98619.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Remove wkup_clkdm, as it has been completely replaced by prm_clkdm and
cm_clkdm.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomains.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index ec5a720..2156668 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -21,13 +21,6 @@
  * sys_clkout/sys_clkout2.
  */
 
-/* This is an implicit clockdomain - it is never defined as such in TRM */
-static struct clockdomain wkup_clkdm = {
-	.name		= "wkup_clkdm",
-	.pwrdm		= { .name = "wkup_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
-};
-
 static struct clockdomain prm_clkdm = {
 	.name		= "prm_clkdm",
 	.pwrdm		= { .name = "wkup_pwrdm" },
@@ -282,7 +275,6 @@ static struct clkdm_pwrdm_autodep clkdm_pwrdm_autodeps[] = {
 
 static struct clockdomain *clockdomains_omap[] = {
 
-	&wkup_clkdm,
 	&cm_clkdm,
 	&prm_clkdm,
 


