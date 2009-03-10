From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/12] ARM: OMAP3: Remove unused CONFIG_I2C2_OMAP_BEAGLE
Date: Tue, 10 Mar 2009 14:02:16 -0700
Message-ID: <20090310210216.16425.72806.stgit@localhost>
References: <20090310205824.16425.97745.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64295 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbZCJVCR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 17:02:17 -0400
In-Reply-To: <20090310205824.16425.97745.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

From: Jarkko Nikula <jhnikula@gmail.com>

There is no CONFIG_I2C2_OMAP_BEAGLE in mainline and it is under
removal in linux-omap also so remove this dead code now.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index e39cd2c..e3c8628 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -175,9 +175,6 @@ static int __init omap3_beagle_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 2600, beagle_i2c_boardinfo,
 			ARRAY_SIZE(beagle_i2c_boardinfo));
-#ifdef CONFIG_I2C2_OMAP_BEAGLE
-	omap_register_i2c_bus(2, 400, NULL, 0);
-#endif
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
 	omap_register_i2c_bus(3, 100, NULL, 0);

