From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 06/14] ARM: OMAP2+: AM43x: static mapping
Date: Mon, 27 May 2013 20:06:13 +0530
Message-ID: <c58538b01232c0bc0ad342dd89204acdf6778aa7.1369658705.git.afzal@ti.com>
References: <cover.1369658705.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1369658705.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <benoit.cousson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>
List-Id: linux-omap@vger.kernel.org

AM43x L4 WKUP/PER mappings are similar to AM335x, reuse.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 06a8946..3a81221 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -202,7 +202,7 @@ static struct map_desc omapti81xx_io_desc[] __initdata = {
 };
 #endif
 
-#ifdef CONFIG_SOC_AM33XX
+#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
 static struct map_desc omapam33xx_io_desc[] __initdata = {
 	{
 		.virtual	= L4_34XX_VIRT,
@@ -318,7 +318,7 @@ void __init ti81xx_map_io(void)
 }
 #endif
 
-#ifdef CONFIG_SOC_AM33XX
+#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
 void __init am33xx_map_io(void)
 {
 	iotable_init(omapam33xx_io_desc, ARRAY_SIZE(omapam33xx_io_desc));
-- 
1.7.12
