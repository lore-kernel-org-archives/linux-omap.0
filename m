From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/12] bus: ti-sysc: Support 16-bit writes too
Date: Mon, 27 May 2019 05:13:37 -0700
Message-ID: <20190527121348.45251-2-tony@atomide.com>
References: <20190527121348.45251-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527121348.45251-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We need to also support 16-bit writes for i2c in addition to the reads
when we start configuring the sysconfig register for reset and idle modes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -100,6 +100,13 @@ static void sysc_parse_dts_quirks(struct sysc *ddata, struct device_node *np,
 
 static void sysc_write(struct sysc *ddata, int offset, u32 value)
 {
+	if (ddata->cfg.quirks & SYSC_QUIRK_16BIT) {
+		writew_relaxed(value & 0xffff, ddata->module_va + offset);
+		writew_relaxed(value >> 16, ddata->module_va + offset + 4);
+
+		return;
+	}
+
 	writel_relaxed(value, ddata->module_va + offset);
 }
 
-- 
2.21.0
