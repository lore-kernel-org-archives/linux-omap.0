From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] omap: RX-51: Drop I2C-1 speed to 2200
Date: Tue, 13 Oct 2009 17:14:30 -0700
Message-ID: <20091014001430.6116.52257.stgit@localhost>
References: <20091014001233.6116.84749.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091014001233.6116.84749.stgit@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Aaro Koskinen <Aaro.Koskinen@nokia.com>

The I2C-1 bus frequency on RX-51 should be 2.2 MHz. The speed is limited
by TWL5030/GAIA; a higher speed could lead to errors on the interface. The
maximum speed depends on the system clock for GAIA: 2.2 MHz (if 19.2 MHz),
2.4 MHz (26 MHz) or 2.9 MHz (38.4 MHz).

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index c1af532..2b0eb1b 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -444,7 +444,7 @@ static int __init rx51_i2c_init(void)
 		rx51_twldata.vaux3 = &rx51_vaux3_cam;
 		rx51_twldata.vmmc2 = &rx51_vmmc2;
 	}
-	omap_register_i2c_bus(1, 2600, rx51_peripherals_i2c_board_info_1,
+	omap_register_i2c_bus(1, 2200, rx51_peripherals_i2c_board_info_1,
 			ARRAY_SIZE(rx51_peripherals_i2c_board_info_1));
 	omap_register_i2c_bus(2, 100, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
