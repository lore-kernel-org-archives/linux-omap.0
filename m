From: "Hemanth V" <hemanthv@ti.com>
Subject: [PATCH 1/3] omap4: Add platform changes for Ambient Light sensor
Date: Thu, 2 Dec 2010 12:59:14 +0530 (IST)
Message-ID: <54105.10.24.255.17.1291274954.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51262 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756919Ab0LBH3P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 02:29:15 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB27TFHK003344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 2 Dec 2010 01:29:15 -0600
Received: from dbdmail.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id oB27TCop021756
	for <linux-omap@vger.kernel.org>; Thu, 2 Dec 2010 01:29:13 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From 10f5f9f918e197f4052ac66b4e4cfb4b72646878 Mon Sep 17 00:00:00 2001
From: Hemanth V <hemanthv@ti.com>
Date: Wed, 1 Dec 2010 16:28:51 +0530
Subject: [PATCH] omap4: Add platform changes for Ambient Light sensor

Register BH1780GLI Ambient light sensor, which is an I2C device
for 4430SDP board.

Signed-off-by: Hemanth V <hemanthv@ti.com>
---
BH1780GLI Driver is part of mainline kernel

 arch/arm/mach-omap2/board-4430sdp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 49b5a7b..d8ef903 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -465,6 +465,9 @@ static struct i2c_board_info __initdata sdp4430_i2c_3_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("tmp105", 0x48),
 	},
+	{
+		I2C_BOARD_INFO("bh1780", 0x29),
+	},
 };
 static struct i2c_board_info __initdata sdp4430_i2c_4_boardinfo[] = {
 	{
-- 
1.5.4.3



