From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 5/5] [RFC] Adds I2C board info for tlvaic23b in osk board file
Date: Mon, 29 Sep 2008 15:25:51 +0530
Message-ID: <dfeb90390809290255y509053e2v6a75ee16d0596500@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:40280 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbYI2Jzv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 05:55:51 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2167836rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 29 Sep 2008 02:55:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com

Adding I2C board info required for tlvaic23b i2c chip driver

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap1/board-osk.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 3e766e4..8ddae82 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -258,8 +258,10 @@ static struct i2c_board_info __initdata
osk_i2c_board_info[] = {
 		.platform_data	= &tps_board,

 	},
+	{
+		I2C_BOARD_INFO("tlvaic23b", 0x1B),
+	},
 	/* TODO when driver support is ready:
-	 *  - aic23 audio chip at 0x1a
 	 *  - on Mistral, 24c04 eeprom at 0x50
 	 *  - optionally on Mistral, ov9640 camera sensor at 0x30
 	 */
-- 
1.5.3.4
