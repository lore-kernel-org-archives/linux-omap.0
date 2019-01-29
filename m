From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] ARM: dts: omap3-gta04a5: Replace LXR reference with a local one
Date: Tue, 29 Jan 2019 15:45:18 +0100
Message-ID: <20190129144518.9744-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

There's no need to use an external link when the file is already here.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

Alternatively, I could change the link to https://elixir.bootlin.com
(the successor of lxr.free-electrons.com), but this solution seemed
simpler.
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index bd232b1b24cb..223b47ac596e 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -82,7 +82,7 @@
 
 /*
  * for WL183x module see
- * http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
+ * Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
  */
 
 &wifi_pwrseq {
-- 
2.20.1
