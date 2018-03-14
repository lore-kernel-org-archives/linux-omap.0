From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/6] dt-bindings: omap5: ctrl: Support for control module
 wkup pad config
Date: Wed, 14 Mar 2018 15:53:11 +0200
Message-ID: <20180314135315.11215-3-peter.ujfalusi@ti.com>
References: <20180314135315.11215-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180314135315.11215-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

The pad configuration area under control module wkup has some miscellaneous
config registers, that are not pinmux related.
Add new compatible string for this section of control module.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/ctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
index ce8dabf8c0f9..f35b77920786 100644
--- a/Documentation/devicetree/bindings/arm/omap/ctrl.txt
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -25,6 +25,7 @@ Required properties:
 		"ti,omap4-scm-padconf-wkup"
 		"ti,omap5-scm-core"
 		"ti,omap5-scm-padconf-core"
+		"ti,omap5-scm-wkup-pad-conf"
 		"ti,dra7-scm-core"
 - reg:		Contains Control Module register address range
 		(base address and length)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
