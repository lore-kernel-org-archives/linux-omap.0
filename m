From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] bus: ti-sysc: Fix missing reset delay handling
Date: Wed, 11 Dec 2019 10:59:01 -0800
Message-ID: <20191211185901.9879-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We have dts property for "ti,sysc-delay-us", and we're using it, but the
wait after OCP softreset only happens if devices are probed in legacy mode.

Let's add a delay after writing the OCP softreset when specified.

Fixes: e0db94fe87da ("bus: ti-sysc: Make OCP reset work for sysstatus and sysconfig reset bits")
Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1590,6 +1590,10 @@ static int sysc_reset(struct sysc *ddata)
 	sysc_val |= sysc_mask;
 	sysc_write(ddata, sysc_offset, sysc_val);
 
+	if (ddata->cfg.srst_udelay)
+		usleep_range(ddata->cfg.srst_udelay,
+			     ddata->cfg.srst_udelay * 2);
+
 	if (ddata->clk_enable_quirk)
 		ddata->clk_enable_quirk(ddata);
 
-- 
2.24.1
