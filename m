From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/18] omap: Overo: Add support for second ethernet port
Date: Wed, 05 May 2010 12:33:15 -0700
Message-ID: <20100505193315.21568.55530.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50050 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757981Ab0EETdP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:33:15 -0400
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

From: Steve Sakoman <steve@sakoman.com>

Some Overo add-on boards include a second ethernet port.  This patch
adds support for that second port.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-overo.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 8848c7c..79ac414 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -63,6 +63,8 @@
 
 #define OVERO_SMSC911X_CS      5
 #define OVERO_SMSC911X_GPIO    176
+#define OVERO_SMSC911X2_CS     4
+#define OVERO_SMSC911X2_GPIO   65
 
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
 	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
@@ -137,6 +139,16 @@ static struct resource overo_smsc911x_resources[] = {
 	},
 };
 
+static struct resource overo_smsc911x2_resources[] = {
+	{
+		.name	= "smsc911x2-memory",
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
+	},
+};
+
 static struct smsc911x_platform_config overo_smsc911x_config = {
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
@@ -146,7 +158,7 @@ static struct smsc911x_platform_config overo_smsc911x_config = {
 
 static struct platform_device overo_smsc911x_device = {
 	.name		= "smsc911x",
-	.id		= -1,
+	.id		= 0,
 	.num_resources	= ARRAY_SIZE(overo_smsc911x_resources),
 	.resource	= overo_smsc911x_resources,
 	.dev		= {

