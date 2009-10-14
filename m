From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] omap: CONFIG_ISP1301_OMAP redefined in Beagle defconfig
Date: Tue, 13 Oct 2009 17:13:52 -0700
Message-ID: <20091014001352.6116.3939.stgit@localhost>
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
Cc: linux-omap@vger.kernel.org, Sanjeev Premi <premi@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Sanjeev Premi <premi@ti.com>

The symbol CONFIG_ISP1301_OMAP was defined twice in the
defconfig. This was causing the warning:
arch/arm/configs/omap3_beagle_defconfig:972:warning:
 override: reassigning to symbol ISP1301_OMAP

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_beagle_defconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index 357d402..b3c8cce 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -969,7 +969,6 @@ CONFIG_USB_ETH_RNDIS=y
 #
 CONFIG_USB_OTG_UTILS=y
 # CONFIG_USB_GPIO_VBUS is not set
-# CONFIG_ISP1301_OMAP is not set
 CONFIG_TWL4030_USB=y
 # CONFIG_NOP_USB_XCEIV is not set
 CONFIG_MMC=y
