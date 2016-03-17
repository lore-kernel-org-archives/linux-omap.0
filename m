From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 14/15] dt-bindings: arm-gic: Drop 'clock-names' from binding document
Date: Thu, 17 Mar 2016 14:19:18 +0000
Message-ID: <1458224359-32665-15-git-send-email-jonathanh@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Commit afbbd2338176 ("irqchip/gic: Document optional Clock and Power
Domain properties") documented optional clock and power-dmoain properties
for the ARM GIC. Currently, there are no users of these and for the
Tegra210 Audio GIC (based upon the GIC-400) there are two clocks, a
functional clock and interface clock, that need to be enabled.

To allow flexibility, drop the 'clock-names' from the GIC binding and
just provide a list of clocks which the driver can parse. It is assumed
that any clocks that are listed, need to be enabled in order to access
the GIC.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

---

Please note that I am not sure if this will be popular, but I am trying
to come up with a generic way to handle multiple clocks that may be
required for accessing a GIC.

 .../devicetree/bindings/interrupt-controller/arm,gic.txt      | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
index 793c20ff8fcc..c471d1a7a8ea 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
@@ -61,15 +61,8 @@ Optional
   regions, used when the GIC doesn't have banked registers. The offset is
   cpu-offset * cpu-nr.
 
-- clocks        : List of phandle and clock-specific pairs, one for each entry
-  in clock-names.
-- clock-names   : List of names for the GIC clock input(s). Valid clock names
-  depend on the GIC variant:
-	"ic_clk" (for "arm,arm11mp-gic")
-	"PERIPHCLKEN" (for "arm,cortex-a15-gic")
-	"PERIPHCLK", "PERIPHCLKEN" (for "arm,cortex-a9-gic")
-	"clk" (for "arm,gic-400")
-	"gclk" (for "arm,pl390")
+- clocks        : List of phandle and clock-specific pairs required for
+		  accessing the GIC.
 
 - power-domains : A phandle and PM domain specifier as defined by bindings of
 		  the power controller specified by phandle, used when the GIC
-- 
2.1.4
