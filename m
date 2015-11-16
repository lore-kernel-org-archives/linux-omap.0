From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 25/27] ARM: make use of nand_set/get_controller_data() helpers
Date: Mon, 16 Nov 2015 14:37:58 +0100
Message-ID: <1447681080-31232-26-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Alexander Clouter <alex@digriz.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marek.vasut@gmail.com>, Steven Miao <realmz6@gmail.com>, adi-b
List-Id: linux-omap@vger.kernel.org

New helpers have been added to avoid directly accessing chip->field. Use
them where appropriate.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-ixp4xx/ixdp425-setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 333b0f9..508c2d7 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -77,7 +77,7 @@ static void
 ixdp425_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	int offset = (int)this->priv;
+	int offset = (int)nand_get_controller_data(this);
 
 	if (ctrl & NAND_CTRL_CHANGE) {
 		if (ctrl & NAND_NCE) {
@@ -88,7 +88,7 @@ ixdp425_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 
 		offset = (ctrl & NAND_CLE) ? IXDP425_NAND_CMD_BYTE : 0;
 		offset |= (ctrl & NAND_ALE) ? IXDP425_NAND_ADDR_BYTE : 0;
-		this->priv = (void *)offset;
+		nand_set_controller_data(this, (void *)offset);
 	}
 
 	if (cmd != NAND_CMD_NONE)
-- 
2.1.4
