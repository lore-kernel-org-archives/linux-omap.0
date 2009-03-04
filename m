From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: OMAP: board-omap3beagle: set i2c-3 to 100kHz
Date: Wed, 04 Mar 2009 10:30:29 -0800
Message-ID: <20090304183029.27331.54848.stgit@localhost>
References: <20090304182342.27331.35004.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51733 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbZCDSae (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 13:30:34 -0500
In-Reply-To: <20090304182342.27331.35004.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, Koen Kooi <koen@beagleboard.org>

From: Koen Kooi <koen@beagleboard.org>

Changing it do 100kHz is needed to make more devices works properly. Controlling the
TI DLP Pico projector[1] doesn't work properly at 400kHz, 100kHz and lower work fine.
EDID readout is unaffected by this change.

[1] http://focus.ti.com/dlpdmd/docs/dlpdiscovery.tsp?sectionId=60&tabId=2234

Signed-off-by: Koen Kooi <koen@beagleboard.org>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 38c88fb..e39cd2c 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -178,7 +178,9 @@ static int __init omap3_beagle_i2c_init(void)
 #ifdef CONFIG_I2C2_OMAP_BEAGLE
 	omap_register_i2c_bus(2, 400, NULL, 0);
 #endif
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	/* Bus 3 is attached to the DVI port where devices like the pico DLP
+	 * projector don't work reliably with 400kHz */
+	omap_register_i2c_bus(3, 100, NULL, 0);
 	return 0;
 }
 

