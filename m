From: Thomas Weber <thomas@tomweber.eu>
Subject: [PATCH] ARM: OMAP3: Devkit8000: Add DDC i2c_bus_num
Date: Thu, 15 Nov 2012 19:12:03 +0100
Message-ID: <1353003123-7335-1-git-send-email-thomas@tomweber.eu>
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
To: Tony Lindgren <tony@atomide.com>
Cc: "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, open list <linux-kernel@vger.kernel.org>, "moderated list:ARM SUB-ARCHITECT..." <linux-arm-kernel@lists.infradead.org>, Thomas Weber <thomas@tomweber.eu>
List-Id: linux-omap@vger.kernel.org

Add i2c bus number for DVI output.
The driver uses this to detect if a panel is connected and to read EDID.

Signed-off-by: Thomas Weber <thomas@tomweber.eu>
---
 arch/arm/mach-omap2/board-devkit8000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 1fd161e..6f04f0f 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -139,6 +139,7 @@ static struct omap_dss_device devkit8000_lcd_device = {
 
 static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= -1,
+	.i2c_bus_num		= 1,
 };
 
 static struct omap_dss_device devkit8000_dvi_device = {
-- 
1.8.0
