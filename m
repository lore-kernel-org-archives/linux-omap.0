From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 14/14] mfd: twl6040: Constify struct regmap_config and
 reg_default array
Date: Mon, 05 Jan 2015 10:01:33 +0100
Message-ID: <1420448493-9355-14-git-send-email-k.kozlowski@samsung.com>
References: <1420448493-9355-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1420448493-9355-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const. Make array of
struct reg_default const as well.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
---
 drivers/mfd/twl6040.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 9687645162ae..f71ee3dbc2a2 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -44,7 +44,7 @@
 #define VIBRACTRL_MEMBER(reg) ((reg == TWL6040_REG_VIBCTLL) ? 0 : 1)
 #define TWL6040_NUM_SUPPLIES	(2)
 
-static struct reg_default twl6040_defaults[] = {
+static const struct reg_default twl6040_defaults[] = {
 	{ 0x01, 0x4B }, /* REG_ASICID	(ro) */
 	{ 0x02, 0x00 }, /* REG_ASICREV	(ro) */
 	{ 0x03, 0x00 }, /* REG_INTID	*/
@@ -580,7 +580,7 @@ static bool twl6040_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct regmap_config twl6040_regmap_config = {
+static const struct regmap_config twl6040_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-- 
1.9.1
