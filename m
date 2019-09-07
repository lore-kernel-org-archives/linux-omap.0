From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 4/4] DTS: bindings: omap: update bindings documentation
Date: Sat,  7 Sep 2019 19:46:53 +0200
Message-ID: <35e4f219af5f8bff48e89ece7541f4e4ae6f27a0.1567878413.git.hns@goldelico.com>
References: <cover.1567878413.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1567878413.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Teresa Remmet <t.remmet@phytec.de>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* clarify that we now need either "ti,omap3430" or "ti,omap3630" or "ti,am3517" for omap3 chips
* clarify that "ti,omap3" has no default
* clarify that AM33x is not an "ti,omap3"
* clarify that the list of boards is incomplete
* remove some "ti,am33xx", "ti,omap3"
* add some missing "ti,omap4"

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/arm/omap/omap.txt     | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index b301f753ed2c..e77635c5422c 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -43,7 +43,7 @@ SoC Families:
 
 - OMAP2 generic - defaults to OMAP2420
   compatible = "ti,omap2"
-- OMAP3 generic - defaults to OMAP3430
+- OMAP3 generic
   compatible = "ti,omap3"
 - OMAP4 generic - defaults to OMAP4430
   compatible = "ti,omap4"
@@ -51,6 +51,8 @@ SoC Families:
   compatible = "ti,omap5"
 - DRA7 generic - defaults to DRA742
   compatible = "ti,dra7"
+- AM33x generic
+  compatible = "ti,am33xx"
 - AM43x generic - defaults to AM4372
   compatible = "ti,am43"
 
@@ -63,12 +65,14 @@ SoCs:
 
 - OMAP3430
   compatible = "ti,omap3430", "ti,omap3"
+  legacy: "ti,omap34xx" - please do not use any more
 - AM3517
   compatible = "ti,am3517", "ti,omap3"
 - OMAP3630
-  compatible = "ti,omap36xx", "ti,omap3"
-- AM33xx
-  compatible = "ti,am33xx", "ti,omap3"
+  compatible = "ti,omap3630", "ti,omap3"
+  legacy: "ti,omap36xx" - please do not use any more
+- AM335x
+  compatible = "ti,am33xx"
 
 - OMAP4430
   compatible = "ti,omap4430", "ti,omap4"
@@ -110,19 +114,19 @@ SoCs:
 - AM4372
   compatible = "ti,am4372", "ti,am43"
 
-Boards:
+Boards (incomplete list of examples):
 
 - OMAP3 BeagleBoard : Low cost community board
-  compatible = "ti,omap3-beagle", "ti,omap3"
+  compatible = "ti,omap3-beagle", "ti,omap3430", "ti,omap3"
 
 - OMAP3 Tobi with Overo : Commercial expansion board with daughter board
-  compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3"
+  compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3430", "ti,omap3"
 
 - OMAP4 SDP : Software Development Board
-  compatible = "ti,omap4-sdp", "ti,omap4430"
+  compatible = "ti,omap4-sdp", "ti,omap4430", "ti,omap4"
 
 - OMAP4 PandaBoard : Low cost community board
-  compatible = "ti,omap4-panda", "ti,omap4430"
+  compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4"
 
 - OMAP4 DuoVero with Parlor : Commercial expansion board with daughter board
   compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
@@ -134,16 +138,16 @@ Boards:
   compatible = "variscite,var-dvk-om44", "variscite,var-som-om44", "ti,omap4460", "ti,omap4";
 
 - OMAP3 EVM : Software Development Board for OMAP35x, AM/DM37x
-  compatible = "ti,omap3-evm", "ti,omap3"
+  compatible = "ti,omap3-evm", "ti,omap3630", "ti,omap3"
 
 - AM335X EVM : Software Development Board for AM335x
-  compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3"
+  compatible = "ti,am335x-evm", "ti,am33xx"
 
 - AM335X Bone : Low cost community board
-  compatible = "ti,am335x-bone", "ti,am33xx", "ti,omap3"
+  compatible = "ti,am335x-bone", "ti,am33xx"
 
 - AM3359 ICEv2 : Low cost Industrial Communication Engine EVM.
-  compatible = "ti,am3359-icev2", "ti,am33xx", "ti,omap3"
+  compatible = "ti,am3359-icev2", "ti,am33xx"
 
 - AM335X OrionLXm : Substation Automation Platform
   compatible = "novatech,am335x-lxm", "ti,am33xx"
-- 
2.19.1
