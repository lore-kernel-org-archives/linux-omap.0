From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/12] bus: ti-sysc: Allow QUIRK_LEGACY_IDLE even if legacy_mode is not set
Date: Mon, 27 May 2019 05:13:39 -0700
Message-ID: <20190527121348.45251-4-tony@atomide.com>
References: <20190527121348.45251-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527121348.45251-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We need to specify QUIRK_LEGACY_IDLE for device drivers that still have
pm_runtime_irq_safe() set like 8250.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1779,9 +1779,6 @@ static struct dev_pm_domain sysc_child_pm_domain = {
  */
 static void sysc_legacy_idle_quirk(struct sysc *ddata, struct device *child)
 {
-	if (!ddata->legacy_mode)
-		return;
-
 	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
 		dev_pm_domain_set(child, &sysc_child_pm_domain);
 }
-- 
2.21.0
