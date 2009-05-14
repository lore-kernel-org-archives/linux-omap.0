From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] OMAP3 SDRC: Fix autorefresh counter for Qimonda SDRAM
	66.6MHz rate
Date: Thu, 14 May 2009 12:55:04 -0600
Message-ID: <20090514185445.2152.97428.stgit@localhost.localdomain>
References: <20090514185012.2152.36226.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52129 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbZENTE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 15:04:58 -0400
In-Reply-To: <20090514185012.2152.36226.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

The autorefresh counter value for the 66.6MHz rate for the Qimonda SDRAM
part is wrong; fix it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
index 74a92c8..304336b 100644
--- a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
+++ b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
@@ -1,8 +1,8 @@
 /*
  * SDRC register values for the Qimonda HYB18M512160AF-6
  *
- * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Paul Walmsley
  *
@@ -44,7 +44,7 @@ static struct omap_sdrc_params hyb18m512160af6_sdrc_params[] = {
 		.rate	     = 66666666,
 		.actim_ctrla = 0x290d2243,
 		.actim_ctrlb = 0x00012208,
-		.rfr_ctrl    = 0x0001d601,
+		.rfr_ctrl    = 0x0001d501,
 		.mr	     = 0x00000022,
 	},
 	[4] = {


