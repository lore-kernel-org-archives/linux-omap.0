From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/13] bus: ti-sysc: Handle swsup idle mode quirks
Date: Mon, 27 May 2019 23:24:08 -0700
Message-ID: <20190528062414.27192-8-tony@atomide.com>
References: <20190528062414.27192-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528062414.27192-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Some modules have idlemodes wired, but not completely functional. We have
quirks for SWSUP_SIDLE and SWSUP_SIDLE_ACT to manage interconnect target
modules without hardware support, but we've been only using them so far
in legacy mode. Let's add support for SWSUP quirks in non-legacy mode too.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -872,10 +872,15 @@ static int sysc_enable_module(struct device *dev)
 	if (!idlemodes || regbits->sidle_shift < 0)
 		goto set_midle;
 
-	best_mode = fls(ddata->cfg.sidlemodes) - 1;
-	if (best_mode > SYSC_IDLE_MASK) {
-		dev_err(dev, "%s: invalid sidlemode\n", __func__);
-		return -EINVAL;
+	if (ddata->cfg.quirks & (SYSC_QUIRK_SWSUP_SIDLE |
+				 SYSC_QUIRK_SWSUP_SIDLE_ACT)) {
+		best_mode = SYSC_IDLE_NO;
+	} else {
+		best_mode = fls(ddata->cfg.sidlemodes) - 1;
+		if (best_mode > SYSC_IDLE_MASK) {
+			dev_err(dev, "%s: invalid sidlemode\n", __func__);
+			return -EINVAL;
+		}
 	}
 
 	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
@@ -959,10 +964,14 @@ static int sysc_disable_module(struct device *dev)
 	if (!idlemodes || regbits->sidle_shift < 0)
 		return 0;
 
-	ret = sysc_best_idle_mode(idlemodes, &best_mode);
-	if (ret) {
-		dev_err(dev, "%s: invalid sidlemode\n", __func__);
-		return ret;
+	if (ddata->cfg.quirks & SYSC_QUIRK_SWSUP_SIDLE) {
+		best_mode = SYSC_IDLE_FORCE;
+	} else {
+		ret = sysc_best_idle_mode(idlemodes, &best_mode);
+		if (ret) {
+			dev_err(dev, "%s: invalid sidlemode\n", __func__);
+			return ret;
+		}
 	}
 
 	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
-- 
2.21.0
