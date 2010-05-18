From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/13] omap4: Adds Dummy Interface clock's for MMC controllers
Date: Mon, 17 May 2010 19:42:59 -0700
Message-ID: <20100518024259.21705.56602.stgit@baageli.muru.com>
References: <20100518023707.21705.26205.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58629 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab0ERCnB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 22:43:01 -0400
In-Reply-To: <20100518023707.21705.26205.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>

From: kishore kadiyala <kishore.kadiyala@ti.com>

This patch adds dummy Interface clocks for MMC controllers

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index a5c0c9c..0280422 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2675,6 +2675,11 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap2_mcspi.2",	"ick",			&dummy_ck,	CK_443X),
 	CLK("omap2_mcspi.3",	"ick",			&dummy_ck,	CK_443X),
 	CLK("omap2_mcspi.4",	"ick",			&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.0",	"ick",		&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.1",	"ick",		&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.2",	"ick",		&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.3",	"ick",		&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.4",	"ick",		&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),

