From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/10] ARM: OMAP: Fix OSK ASoC by registering I2C board info
	for tlvaic23
Date: Mon, 12 Jan 2009 16:47:29 +0200
Message-ID: <20090112144729.24205.37961.stgit@localhost>
References: <20090112143405.24205.52151.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50447 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbZALOrd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 09:47:33 -0500
In-Reply-To: <20090112143405.24205.52151.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Arun KS <arunks@mistralsolutions.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

From: Arun KS <arunks@mistralsolutions.com>

Adding I2C board info is required for tlvaic23 i2c chip driver.

Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Arun KS <arunks@mistralsolutions.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-osk.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index ff9e67b..d17952f 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -259,8 +259,10 @@ static struct i2c_board_info __initdata osk_i2c_board_info[] = {
 		.platform_data	= &tps_board,
 
 	},
+	{
+		I2C_BOARD_INFO("tlv320aic23", 0x1B),
+	},
 	/* TODO when driver support is ready:
-	 *  - aic23 audio chip at 0x1a
 	 *  - optionally on Mistral, ov9640 camera sensor at 0x30
 	 */
 };

