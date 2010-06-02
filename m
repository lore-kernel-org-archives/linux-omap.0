From: Thomas Weber <weber@corscience.de>
Subject: [PATCHv2 07/11] OMAP2: Devkit8000: Remove en-/disable for tv panel
Date: Wed,  2 Jun 2010 13:37:47 +0200
Message-ID: <1275478671-24563-8-git-send-email-weber@corscience.de>
References: <1275478671-24563-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1275478671-24563-1-git-send-email-weber@corscience.de>
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
Cc: Tony Lindgren <tony@atomide.com>, Thomas Weber <weber@corscience.de>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

devkit8000_panel_enable_tv and devkit8000_panel_disable_tv are already
done in DSS2 code. So they are no longer needed in board code.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 59877b1..095dc7a 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -158,16 +158,6 @@ static void devkit8000_panel_disable_dvi(struct omap_dss_device *dssdev)
 		gpio_set_value(dssdev->reset_gpio, 0);
 }
 
-static int devkit8000_panel_enable_tv(struct omap_dss_device *dssdev)
-{
-
-	return 0;
-}
-
-static void devkit8000_panel_disable_tv(struct omap_dss_device *dssdev)
-{
-}
-
 static struct regulator_consumer_supply devkit8000_vmmc1_supply = {
 	.supply			= "vmmc",
 };
@@ -201,8 +191,6 @@ static struct omap_dss_device devkit8000_tv_device = {
 	.driver_name            = "venc",
 	.type                   = OMAP_DISPLAY_TYPE_VENC,
 	.phy.venc.type          = OMAP_DSS_VENC_TYPE_SVIDEO,
-	.platform_enable        = devkit8000_panel_enable_tv,
-	.platform_disable       = devkit8000_panel_disable_tv,
 };
 
 
-- 
1.7.1
