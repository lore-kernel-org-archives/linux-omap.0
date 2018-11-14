From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] dt-bindings: sound: omap-mcpdm: Update
	documentation for pdmclk
Date: Wed, 14 Nov 2018 14:46:30 +0200
Message-ID: <20181114124631.4586-2-peter.ujfalusi@ti.com>
References: <20181114124631.4586-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181114124631.4586-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
Cc: tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

McPDM module receives it's functional clock from external source. This
clock is the pdmclk provided by the twl6040 audio IC. If the clock is not
available all register accesses to McPDM fails and the module is not
operational.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/omap-mcpdm.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
index 5f4e68ca228c..ff98a0cb5b3f 100644
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
@@ -7,6 +7,8 @@ Required properties:
        <L3 interconnect address, size>;
 - interrupts: Interrupt number for McPDM
 - ti,hwmods: Name of the hwmod associated to the McPDM
+- clocks:  phandle for the pdmclk provider, likely <&twl6040>
+- clock-names: Must be "pdmclk"
 
 Example:
 
@@ -18,3 +20,11 @@ mcpdm: mcpdm@40132000 {
 	interrupt-parent = <&gic>;
 	ti,hwmods = "mcpdm";
 };
+
+In board DTS file the pdmclk needs to be added:
+
+&mcpdm {
+	clocks = <&twl6040>;
+	clock-names = "pdmclk";
+	status = "okay";
+};
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
