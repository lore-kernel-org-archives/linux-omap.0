From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 1/2] staging: ti-soc-thermal: update DT reference for OMAP5430
Date: Wed, 24 Apr 2013 14:16:07 -0400
Message-ID: <1366827368-14316-2-git-send-email-eduardo.valentin@ti.com>
References: <1366827368-14316-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1366827368-14316-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Add missing irq line for TALERT on DT entry for OMAP5430.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti_soc_thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/ti-soc-thermal/ti_soc_thermal.txt b/drivers/staging/ti-soc-thermal/ti_soc_thermal.txt
index a4a33d1..1629652 100644
--- a/drivers/staging/ti-soc-thermal/ti_soc_thermal.txt
+++ b/drivers/staging/ti-soc-thermal/ti_soc_thermal.txt
@@ -57,4 +57,5 @@ bandgap {
 		0x4a002380 0x2c
 		0x4a0023C0 0x3c>;
 	compatible = "ti,omap5430-bandgap";
+	interrupts = <0 126 4>; /* talert */
 };
-- 
1.8.2.1.342.gfa7285d

