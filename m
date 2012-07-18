From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH] regulator: tps65217: fix build error if REGULATOR is not enabled
Date: Wed, 18 Jul 2012 12:11:03 +0530
Message-ID: <1342593663-23938-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: rdunlap@xenotime.net
Cc: sfr@canb.auug.org.au, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

Fixes below build error if CONFIG_REGULATOR is not enabled.

drivers/built-in.o: In function `tps65217_probe':
tps65217.c:(.devinit.text+0x13e37): undefined reference to `of_regulator_match'

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/mfd/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e129c82..01c929a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -159,6 +159,7 @@ config TPS6507X
 config MFD_TPS65217
 	tristate "TPS65217 Power Management / White LED chips"
 	depends on I2C
+	depends on REGULATOR
 	select MFD_CORE
 	select REGMAP_I2C
 	help
-- 
1.7.9.5
