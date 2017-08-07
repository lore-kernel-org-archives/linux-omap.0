From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2] phy: ti-pipe3: Use TRM recommended settings for SATA DPLL
Date: Mon, 7 Aug 2017 12:11:02 +0300
Message-ID: <c7bc0f49-f120-d195-5d40-3d0f9f8962d2@ti.com>
References: <1495440630-21332-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495440630-21332-1-git-send-email-rogerq@ti.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com
Cc: nsekhar@ti.com, linux-kernel@vger.kernel.org, rogerq@ti.com, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

The AM572x Technical Reference Manual, SPRUHZ6H,
Revised November 2016 [1], shows recommended settings for the
SATA DPLL in Table 26-8. DPLL CLKDCOLDO Recommended Settings.

Use those settings in the driver. The TRM does not show
a value for 20MHz SYS_CLK so we use something close to the
26MHz setting.

[1] - http://www.ti.com/lit/ug/spruhz6h/spruhz6h.pdf

Signed-off-by: Roger Quadros <rogerq@ti.com>
[nsekhar@ti.com: add exact TRM version to commit text]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
v2:
- Mention full TRM version in commit log

 drivers/phy/ti/phy-ti-pipe3.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 9c84d32..0e564f3 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -118,12 +118,12 @@ static struct pipe3_dpll_map dpll_map_usb[] = {
 };
 
 static struct pipe3_dpll_map dpll_map_sata[] = {
-	{12000000, {1000, 7, 4, 6, 0} },	/* 12 MHz */
-	{16800000, {714, 7, 4, 6, 0} },		/* 16.8 MHz */
+	{12000000, {625, 4, 4, 6, 0} },	/* 12 MHz */
+	{16800000, {625, 6, 4, 7, 0} },		/* 16.8 MHz */
 	{19200000, {625, 7, 4, 6, 0} },		/* 19.2 MHz */
-	{20000000, {600, 7, 4, 6, 0} },		/* 20 MHz */
-	{26000000, {461, 7, 4, 6, 0} },		/* 26 MHz */
-	{38400000, {312, 7, 4, 6, 0} },		/* 38.4 MHz */
+	{20000000, {750, 9, 4, 6, 0} },		/* 20 MHz */
+	{26000000, {750, 12, 4, 6, 0} },	/* 26 MHz */
+	{38400000, {625, 15, 4, 6, 0} },	/* 38.4 MHz */
 	{ },					/* Terminator */
 };
 
-- 
2.7.4
