From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 5/5] bus: ti-sysc: Simplify cleanup upon failures in sysc_probe()
Date: Tue, 25 Jun 2019 18:33:15 -0500
Message-ID: <20190625233315.22301-6-s-anna@ti.com>
References: <20190625233315.22301-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625233315.22301-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

The clocks are not yet parsed and prepared until after a successful
sysc_get_clocks(), so there is no need to unprepare the clocks upon
any failure of any of the prior functions in sysc_probe(). The current
code path would have been a no-op because of the clock validity checks
within sysc_unprepare(), but let's just simplify the cleanup path by
returning the error directly.

While at this, also fix the cleanup path for a sysc_init_resets()
failure which is executed after the clocks are prepared.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/bus/ti-sysc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index ccdd1f0871f9..a7e704e0840d 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2384,27 +2384,27 @@ static int sysc_probe(struct platform_device *pdev)
 
 	error = sysc_init_dts_quirks(ddata);
 	if (error)
-		goto unprepare;
+		return error;
 
 	error = sysc_map_and_check_registers(ddata);
 	if (error)
-		goto unprepare;
+		return error;
 
 	error = sysc_init_sysc_mask(ddata);
 	if (error)
-		goto unprepare;
+		return error;
 
 	error = sysc_init_idlemodes(ddata);
 	if (error)
-		goto unprepare;
+		return error;
 
 	error = sysc_init_syss_mask(ddata);
 	if (error)
-		goto unprepare;
+		return error;
 
 	error = sysc_init_pdata(ddata);
 	if (error)
-		goto unprepare;
+		return error;
 
 	sysc_init_early_quirks(ddata);
 
@@ -2414,7 +2414,7 @@ static int sysc_probe(struct platform_device *pdev)
 
 	error = sysc_init_resets(ddata);
 	if (error)
-		return error;
+		goto unprepare;
 
 	error = sysc_init_module(ddata);
 	if (error)
-- 
2.21.0
