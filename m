From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] bus: ti-sysc: Fix getting optional clocks in clock_roles
Date: Thu, 15 Nov 2018 14:02:36 -0800
Message-ID: <20181115220237.32129-2-tony@atomide.com>
References: <20181115220237.32129-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115220237.32129-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can have holes in clock_roles with interface clock missing for
example. Currently getting an optional clock will fail if there are
only a functional clock and an optional clock.

Fixes: 09dfe5810762 ("bus: ti-sysc: Add handling for clkctrl opt clocks")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -214,8 +214,13 @@ static int sysc_get_clocks(struct sysc *ddata)
 	if (!ddata->clocks)
 		return -ENOMEM;
 
-	for (i = 0; i < ddata->nr_clocks; i++) {
-		error = sysc_get_one_clock(ddata, ddata->clock_roles[i]);
+	for (i = 0; i < SYSC_MAX_CLOCKS; i++) {
+		const char *name = ddata->clock_roles[i];
+
+		if (!name)
+			continue;
+
+		error = sysc_get_one_clock(ddata, name);
 		if (error && error != -ENOENT)
 			return error;
 	}
-- 
2.19.1
