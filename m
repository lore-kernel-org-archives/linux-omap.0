From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/6] omap4: Add platform changes for Ambient Light sensor
Date: Fri, 17 Dec 2010 19:05:39 -0800
Message-ID: <20101218030539.10251.20653.stgit@baageli.muru.com>
References: <20101218030406.10251.73118.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35195 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab0LRDFl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 22:05:41 -0500
In-Reply-To: <20101218030406.10251.73118.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Hemanth V <hemanthv@ti.com>, linux-omap@vger.kernel.org

From: Hemanth V <hemanthv@ti.com>

Register BH1780GLI Ambient light sensor, which is an I2C device
for 4430SDP board.

Signed-off-by: Hemanth V <hemanthv@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 8842ec5..66f8943 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -464,6 +464,9 @@ static struct i2c_board_info __initdata sdp4430_i2c_3_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("tmp105", 0x48),
 	},
+	{
+		I2C_BOARD_INFO("bh1780", 0x29),
+	},
 };
 static struct i2c_board_info __initdata sdp4430_i2c_4_boardinfo[] = {
 	{

