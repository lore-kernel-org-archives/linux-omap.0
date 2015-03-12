From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 2/2] Documentation: omap-twl4030: Remove ti,codec property
Date: Thu, 12 Mar 2015 22:14:59 +0100
Message-ID: <1426194899-14037-3-git-send-email-marek@goldelico.com>
References: <1426194899-14037-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426194899-14037-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, peter.ujfalusi@ti.com
Cc: eballetbo@gmail.com, javier@dowhile0.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jarkko.nikula@bitmer.com, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

ti,codec property is not necessary anymore thus removing references
from documentation.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 Documentation/devicetree/bindings/sound/omap-twl4030.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/omap-twl4030.txt b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
index 1ab6bc8..656165f 100644
--- a/Documentation/devicetree/bindings/sound/omap-twl4030.txt
+++ b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
@@ -4,7 +4,6 @@ Required properties:
 - compatible: "ti,omap-twl4030"
 - ti,model: Name of the sound card (for example "omap3beagle")
 - ti,mcbsp: phandle for the McBSP node
-- ti,codec: phandle for the twl4030 audio node
 
 Optional properties:
 - ti,mcbsp-voice: phandle for the McBSP node connected to the voice port of twl
@@ -59,5 +58,4 @@ sound {
 	ti,model = "omap3beagle";
 
 	ti,mcbsp = <&mcbsp2>;
-	ti,codec = <&twl_audio>;
 };
-- 
1.9.1
