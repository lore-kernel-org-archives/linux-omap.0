From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/5] OMAP3: Overo: Fix smsc911x platform device resource value
Date: Wed, 05 Aug 2009 17:17:17 +0300
Message-ID: <20090805141717.1964.68288.stgit@localhost>
References: <20090805141051.1964.74687.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56439 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934501AbZHEORZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:17:25 -0400
In-Reply-To: <20090805141051.1964.74687.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Sergio Aguirre <saaguirre@ti.com>, linux-omap@vger.kernel.org

From: Sergio Aguirre <saaguirre@ti.com>

Fixes a wrong setting of resource parameter list in
SMSC911x platform driver data structure for Overo case.

This fixes folowing warning when compiling for Overo board:

	warning: initialization from incompatible pointer type

Introduced since commit id:
	commit 172ef275444efa12d834fb9d1b1acdac92db47f7
	Author: Steve Sakoman <sakoman@gmail.com>
	Date:   Mon Feb 2 06:27:49 2009 +0000

	    ARM: Add SMSC911X support to Overo platform (V2)

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-overo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index dff5528..fec1bb1 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -146,7 +146,7 @@ static struct platform_device overo_smsc911x_device = {
 	.name		= "smsc911x",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(overo_smsc911x_resources),
-	.resource	= &overo_smsc911x_resources,
+	.resource	= overo_smsc911x_resources,
 	.dev		= {
 		.platform_data = &overo_smsc911x_config,
 	},

