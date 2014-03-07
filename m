From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4] phy: omap-control: update dra7 and am437 usb2
 Documentation bindings
Date: Fri, 7 Mar 2014 13:55:30 +0530
Message-ID: <1394121786-28193-1-git-send-email-balbi__18975.8018627346$1394180775$gmane$org@ti.com>
References: <53189742.3060705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53189742.3060705@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>

From: Roger Quadros <rogerq@ti.com>

The dra7-usb2 and am437-usb2 bindings have not yet been used.
Change them to be more elegant.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
Changes from v3:
* changed the compatible name to 'ti,control-phy-usb2-dra7' and
  'ti,control-phy-usb2-am437'

 Documentation/devicetree/bindings/phy/ti-phy.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 41dc132..8694aae 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -9,9 +9,9 @@ Required properties:
                         e.g. USB2_PHY on OMAP5.
  "ti,control-phy-pipe3" - if it has DPLL and individual Rx & Tx power control
                         e.g. USB3 PHY and SATA PHY on OMAP5.
- "ti,control-phy-dra7usb2" - if it has power down register like USB2 PHY on
+ "ti,control-phy-usb2-dra7" - if it has power down register like USB2 PHY on
                         DRA7 platform.
- "ti,control-phy-am437usb2" - if it has power down register like USB2 PHY on
+ "ti,control-phy-usb2-am437" - if it has power down register like USB2 PHY on
                         AM437 platform.
  - reg : Address and length of the register set for the device. It contains
    the address of "otghs_control" for control-phy-otghs or "power" register
-- 
1.9.0
