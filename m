From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/12] bus: ti-sysc: Enable interconnect target module autoidle bit on enable
Date: Mon, 27 May 2019 05:13:40 -0700
Message-ID: <20190527121348.45251-5-tony@atomide.com>
References: <20190527121348.45251-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527121348.45251-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

For interconnect target modules with autoidle bit wired, we need to manage
it for enable and disable.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -879,7 +879,7 @@ static int sysc_enable_module(struct device *dev)
 	/* Set MIDLE mode */
 	idlemodes = ddata->cfg.midlemodes;
 	if (!idlemodes || regbits->midle_shift < 0)
-		return 0;
+		goto set_autoidle;
 
 	best_mode = fls(ddata->cfg.midlemodes) - 1;
 	if (best_mode > SYSC_IDLE_MASK) {
@@ -891,6 +891,14 @@ static int sysc_enable_module(struct device *dev)
 	reg |= best_mode << regbits->midle_shift;
 	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
 
+set_autoidle:
+	/* Autoidle bit must enabled separately if available */
+	if (regbits->autoidle_shift >= 0 &&
+	    ddata->cfg.sysc_val & BIT(regbits->autoidle_shift)) {
+		reg |= 1 << regbits->autoidle_shift;
+		sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
+	}
+
 	return 0;
 }
 
@@ -952,6 +960,9 @@ static int sysc_disable_module(struct device *dev)
 
 	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
 	reg |= best_mode << regbits->sidle_shift;
+	if (regbits->autoidle_shift >= 0 &&
+	    ddata->cfg.sysc_val & BIT(regbits->autoidle_shift))
+		reg |= 1 << regbits->autoidle_shift;
 	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
 
 	return 0;
-- 
2.21.0
