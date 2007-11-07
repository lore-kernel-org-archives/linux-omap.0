From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 3/3] ARM: OMAP: N800: Use I2C bus registration helper
Date: Wed,  7 Nov 2007 12:54:33 +0200
Message-ID: <1194432873-5209-4-git-send-email-jarkko.nikula@nokia.com>
References: <1194432873-5209-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1194432873-5209-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Use 400 kHz bus clock for both busses since board components are rated
for it.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-n800.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index 81c4a8d..a3e1c2b 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -464,12 +464,6 @@ static void __init nokia_n800_init(void)
 {
 	platform_add_devices(n800_devices, ARRAY_SIZE(n800_devices));
 
-	i2c_register_board_info(1, n800_i2c_board_info_1,
-				ARRAY_SIZE(n800_i2c_board_info_1));
-
-	i2c_register_board_info(2, n800_i2c_board_info_2,
-				ARRAY_SIZE(n800_i2c_board_info_2));
-
 	n800_flash_init();
 	n800_mmc_init();
 	n800_bt_init();
@@ -481,6 +475,10 @@ static void __init nokia_n800_init(void)
 	spi_register_board_info(n800_spi_board_info,
 				ARRAY_SIZE(n800_spi_board_info));
 	omap_serial_init();
+	omap_register_i2c_bus(1, 400, n800_i2c_board_info_1,
+			      ARRAY_SIZE(n800_i2c_board_info_1));
+	omap_register_i2c_bus(2, 400, n800_i2c_board_info_2,
+			      ARRAY_SIZE(n800_i2c_board_info_2));
 	mipid_dev_init();
 	blizzard_dev_init();
 	tsc2301_dev_init();
-- 
1.5.3.4
