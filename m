From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/9] ARM: OMAP2+: board-generic: add support for DRA71x family
Date: Fri, 14 Oct 2016 18:30:29 +0530
Message-ID: <20161014130033.14172-6-lokeshvutla@ti.com>
References: <20161014130033.14172-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161014130033.14172-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

DRA71x processor family is a derivative of DRA722 ES2.0 targeted for
infotainment systems.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 6 ++++++
 arch/arm/mach-omap2/board-generic.c                 | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index f53e2ee..454b1be 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -86,6 +86,9 @@ SoCs:
 - DRA722
   compatible = "ti,dra722", "ti,dra72", "ti,dra7"
 
+- DRA718
+  compatible = "ti,dra718", "ti,dra722", "ti,dra72", "ti,dra7"
+
 - AM5728
   compatible = "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
 
@@ -181,6 +184,9 @@ Boards:
 - DRA722 EVM: Software Development Board for DRA722
   compatible = "ti,dra72-evm", "ti,dra722", "ti,dra72", "ti,dra7"
 
+- DRA718 EVM: Software Development Board for DRA718
+  compatible = "ti,dra718-evm", "ti,dra718", "ti,dra722", "ti,dra72", "ti,dra7"
+
 - DM3730 Logic PD Torpedo + Wireless: Commercial System on Module with WiFi and Bluetooth
   compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap3630", "ti,omap3"
 
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index bab814d..981b23a 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -341,6 +341,7 @@ static const char *const dra72x_boards_compat[] __initconst = {
 	"ti,am5718",
 	"ti,am5716",
 	"ti,dra722",
+	"ti,dra718",
 	NULL,
 };
 
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
