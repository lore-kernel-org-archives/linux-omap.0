From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 2/5] arm: omap: remove ocp2scp_usb_phy_ick clock node
Date: Wed, 30 May 2012 16:26:31 +0530
Message-ID: <1338375394-16268-3-git-send-email-kishon@ti.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1338375394-16268-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

"ocp2scp_usb_phy_ick" clock node was a fake clock node created
to control MODULEMODE of ocp2scp. Since the hwmod for ocp2scp is now added
(which can be used to control MODULEMODE) this clock node is removed.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2172f66..3e2cccf 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2132,16 +2132,6 @@ static struct clk ocp2scp_usb_phy_phy_48m = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ocp2scp_usb_phy_ick = {
-	.name		= "ocp2scp_usb_phy_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk ocp_wp_noc_ick = {
 	.name		= "ocp_wp_noc_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -3277,7 +3267,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"mmc4_fck",			&mmc4_fck,	CK_443X),
 	CLK(NULL,	"mmc5_fck",			&mmc5_fck,	CK_443X),
 	CLK(NULL,	"ocp2scp_usb_phy_phy_48m",	&ocp2scp_usb_phy_phy_48m,	CK_443X),
-	CLK(NULL,	"ocp2scp_usb_phy_ick",		&ocp2scp_usb_phy_ick,	CK_443X),
 	CLK(NULL,	"ocp_wp_noc_ick",		&ocp_wp_noc_ick,	CK_443X),
 	CLK("omap_rng",	"ick",				&rng_ick,	CK_443X),
 	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck,	CK_443X),
-- 
1.7.5.4
