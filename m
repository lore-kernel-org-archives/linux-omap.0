From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 22/28] omap: Devkit8000: Fix typo in supplies
Date: Fri, 23 Apr 2010 16:11:56 -0700
Message-ID: <20100423231156.31953.21428.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57155 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127Ab0DWXLz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:55 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org

From: Thomas Weber <weber@corscience.de>

Replace wrong vdss_dsi with vdds_dsi.

Signed-off-by: Thomas Weber <weber@corscience.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index db4c093..b82e438 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -303,7 +303,7 @@ static struct regulator_consumer_supply devkit8000_vpll2_supplies[] = {
 	.dev		= &devkit8000_lcd_device.dev,
 	},
 	{
-	.supply		= "vdss_dsi",
+	.supply		= "vdds_dsi",
 	.dev		= &devkit8000_dss_device.dev,
 	}
 };

