From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/14] bus: ti-sysc: Make functions static
Date: Mon, 25 Mar 2019 14:58:38 -0700
Message-ID: <20190325215849.13182-4-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can make sysc_write() and sysc_child_pm_domain static as noted by
sparse.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -94,7 +94,7 @@ struct sysc {
 static void sysc_parse_dts_quirks(struct sysc *ddata, struct device_node *np,
 				  bool is_child);
 
-void sysc_write(struct sysc *ddata, int offset, u32 value)
+static void sysc_write(struct sysc *ddata, int offset, u32 value)
 {
 	writel_relaxed(value, ddata->module_va + offset);
 }
@@ -1209,7 +1209,7 @@ static int sysc_child_resume_noirq(struct device *dev)
 }
 #endif
 
-struct dev_pm_domain sysc_child_pm_domain = {
+static struct dev_pm_domain sysc_child_pm_domain = {
 	.ops = {
 		SET_RUNTIME_PM_OPS(sysc_child_runtime_suspend,
 				   sysc_child_runtime_resume,
-- 
2.21.0
