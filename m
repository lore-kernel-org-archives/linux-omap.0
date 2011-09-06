From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] OMAP2: Devkit8000: Remove double omap_mux_init_gpio
Date: Tue,  6 Sep 2011 17:11:49 +0200
Message-ID: <1315321909-5593-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Thomas Weber <weber@corscience.de>, Russell King <linux@arm.linux.org.uk>, open list <linux-kernel@vger.kernel.org>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Remove the init of card detect pin because
omap_mux_init_gpio() is called during hsmmc initialization
for the write protect and card detect pin.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index f15f2a2..029c08a 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -226,7 +226,6 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 {
 	int ret;
 
-	omap_mux_init_gpio(29, OMAP_PIN_INPUT);
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
-- 
1.7.6.1
