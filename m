From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 271/671] bus: ti-sysc: Fix sysc_unprepare() when no clocks have been allocated
Date: Thu, 16 Jan 2020 11:58:29 -0500
Message-ID: <20200116170509.12787-8-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit aaa29bb01cc4bf5a87dbdb219efba3b09f259d8e ]

If we return early before ddata->clocks have been allocated we will get a
NULL pointer dereference in sysc_unprepare(). Let's fix this by returning
early when no clocks are allocated.

Fixes: 0eecc636e5a2 ("bus: ti-sysc: Add minimal TI sysc interconnect target driver")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 2813f9ed57c0..54c8c8644df2 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1400,6 +1400,9 @@ static void sysc_unprepare(struct sysc *ddata)
 {
 	int i;
 
+	if (!ddata->clocks)
+		return;
+
 	for (i = 0; i < SYSC_MAX_CLOCKS; i++) {
 		if (!IS_ERR_OR_NULL(ddata->clocks[i]))
 			clk_unprepare(ddata->clocks[i]);
-- 
2.20.1
