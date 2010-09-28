From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] mfd: fix TWL4030 COR bit polarity for BCI SIH block
Date: Tue, 28 Sep 2010 16:22:19 +0300
Message-ID: <1285680139-19092-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49550 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab0I1NWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 09:22:43 -0400
Received: by ewy23 with SMTP id 23so1745735ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 06:22:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-omap@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Grazvydas Ignotas <notasas@gmail.com>

The chip TRM documentation contradicts itself about this bit, page 174
of swcu050e says bit should be 0 for clear-on-read behavior, while
page 487 says it should be 1. Testing shows it should be 1, so set
the .set_cor flag accordingly. This is needed for upcoming BCI
charging driver to function.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/mfd/twl4030-irq.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 097f24d..5b5a559 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -144,6 +144,7 @@ static const struct sih sih_modules_twl4030[6] = {
 		.name		= "bci",
 		.module		= TWL4030_MODULE_INTERRUPTS,
 		.control_offset	= TWL4030_INTERRUPTS_BCISIHCTRL,
+		.set_cor	= true,
 		.bits		= 12,
 		.bytes_ixr	= 2,
 		.edr_offset	= TWL4030_INTERRUPTS_BCIEDR1,
@@ -408,7 +409,7 @@ static int twl4030_init_sih_modules(unsigned line)
 		 * set Clear-On-Read (COR) bit.
 		 *
 		 * NOTE that sometimes COR polarity is documented as being
-		 * inverted:  for MADC and BCI, COR=1 means "clear on write".
+		 * inverted:  for MADC, COR=1 means "clear on write".
 		 * And for PWR_INT it's not documented...
 		 */
 		if (sih->set_cor) {
-- 
1.6.3.3

