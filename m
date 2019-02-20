From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 5/6] dt-bindings: net: ti: deprecate cpsw-phy-sel bindings
Date: Wed, 20 Feb 2019 17:25:18 +0200
Message-ID: <1550676319-6440-6-git-send-email-grygorii.strashko@ti.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

The cpsw-phy-sel driver was replaced with new PHY driver phy-gmii-sel, so
deprecate cpsw-phy-sel bindings.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 Documentation/devicetree/bindings/net/cpsw-phy-sel.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cpsw-phy-sel.txt b/Documentation/devicetree/bindings/net/cpsw-phy-sel.txt
index 764c0c79b43d..5d76f991c027 100644
--- a/Documentation/devicetree/bindings/net/cpsw-phy-sel.txt
+++ b/Documentation/devicetree/bindings/net/cpsw-phy-sel.txt
@@ -1,4 +1,4 @@
-TI CPSW Phy mode Selection Device Tree Bindings
+TI CPSW Phy mode Selection Device Tree Bindings (DEPRECATED)
 -----------------------------------------------
 
 Required properties:
-- 
2.17.1
