From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/3] ARM: DTS: dra7xx: am57xx: fix cd-gpios definition as per hardware design and dt binding docs
Date: Mon, 12 Oct 2015 14:37:12 +0530
Message-ID: <1444640832-7396-4-git-send-email-mugunthanvnm@ti.com>
References: <1444640832-7396-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444640832-7396-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

As per mmc device tree binding documentation card detect gpio has
to be active low signal. When a hardware is designed with active
high card detect, gpio polarity has to be changed with
cd-inverted dt property.

In DRA74x, DRA72x and AM57xx EVMs the card detect gpio is
designed as active low gpio. So correcting the dt card detect
gpio definition.

Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 2 +-
 arch/arm/boot/dts/dra7-evm.dts          | 2 +-
 arch/arm/boot/dts/dra72-evm.dts         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 568adf5..e554596 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -585,7 +585,7 @@
 
 	vmmc-supply = <&ldo1_reg>;
 	bus-width = <4>;
-	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
+	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>; /* gpio 219 */
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index a6c82e5..4379277 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -479,7 +479,7 @@
 	 * SDCD signal is not being used here - using the fact that GPIO mode
 	 * is always hardwired.
 	 */
-	cd-gpios = <&gpio6 27 0>;
+	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 6f6bd98..d4aca5a1 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -514,7 +514,7 @@
 	 * SDCD signal is not being used here - using the fact that GPIO mode
 	 * is a viable alternative
 	 */
-	cd-gpios = <&gpio6 27 0>;
+	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>;
 	max-frequency = <192000000>;
 };
 
-- 
2.6.1.133.gf5b6079

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
