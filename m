From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 5/5] arm: omap: n8x0: enable retu
Date: Wed, 29 Aug 2012 00:34:27 +0300
Message-ID: <1346189667-32330-6-git-send-email-aaro.koskinen@iki.fi>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:37225 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab2H1Ve3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Aug 2012 17:34:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri1.pp.htv.fi (Postfix) with ESMTP id B77F921B2C0
	for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 00:34:28 +0300 (EEST)
Received: from smtp6.welho.com ([213.243.153.40])
	by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
	with ESMTP id sG7U1zJqMXfT for <linux-omap@vger.kernel.org>;
	Wed, 29 Aug 2012 00:34:28 +0300 (EEST)
Received: from blackmetal.bb.dnainternet.fi (212-149-209-232.bb.dnainternet.fi [212.149.209.232])
	by smtp6.welho.com (Postfix) with ESMTP id 5888C5BC006
	for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 00:34:28 +0300 (EEST)
In-Reply-To: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add Retu configuration.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap2/board-n8x0.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 8ea0dea..6ac8cd9 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -58,8 +58,16 @@ static struct platform_device n8x0_cbus_device = {
 	},
 };
 
+static struct i2c_board_info n8x0_i2c_board_info_3[] __initdata = {
+	{
+		I2C_BOARD_INFO("retu-mfd", 0x01),
+	},
+};
+
 static void __init n8x0_cbus_init(void)
 {
+	i2c_register_board_info(3, n8x0_i2c_board_info_3,
+				ARRAY_SIZE(n8x0_i2c_board_info_3));
 	platform_device_register(&n8x0_cbus_device);
 }
 #else /* CONFIG_I2C_CBUS */
-- 
1.7.2.5

