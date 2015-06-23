From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 04/17] phy: omap-usb2: use omap_usb_power_off to power off the
 PHY during probe
Date: Tue, 23 Jun 2015 17:28:49 +0530
Message-ID: <1435060743-5511-5-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435060743-5511-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com, tony@atomide.com, balbi@ti.com, rogerq@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, kishon@ti.com
Cc: mark.rutland@arm.com, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, gregkh@linuxfoundation.org, nsekhar@ti.com, robh+dt@kernel.org, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

No functional change. Previously omap_control_phy_power() was used to power
off the PHY during probe. But once phy-omap-usb2 driver is adapted to
use syscon, omap_control_phy_power() cannot be used. Hence used
omap_usb_power_off to power off the PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-omap-usb2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index c1a4686..b5c266a 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -241,7 +241,6 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 
 	phy->control_dev = &control_pdev->dev;
-	omap_control_phy_power(phy->control_dev, 0);
 
 	otg->set_host		= omap_usb_set_host;
 	otg->set_peripheral	= omap_usb_set_peripheral;
@@ -261,6 +260,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 
 	phy_set_drvdata(generic_phy, phy);
+	omap_usb_power_off(generic_phy);
 
 	phy_provider = devm_of_phy_provider_register(phy->dev,
 			of_phy_simple_xlate);
-- 
1.7.9.5
