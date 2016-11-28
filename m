From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH  v2 06/13] net: ethernet: ti: cpts: disable cpts when unregistered
Date: Mon, 28 Nov 2016 17:03:30 -0600
Message-ID: <20161128230337.6731-7-grygorii.strashko@ti.com>
References: <20161128230337.6731-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20161128230337.6731-1-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>, Richard Cochran <richardcochran@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Wingman Kwok <w-kwok2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

The cpts now is left enabled after unregistration.
Hence, disable it in cpts_unregister().

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index cb851a7..9ad0998 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -404,6 +404,10 @@ void cpts_unregister(struct cpts *cpts)
 		ptp_clock_unregister(cpts->clock);
 		cancel_delayed_work_sync(&cpts->overflow_work);
 	}
+
+	cpts_write32(cpts, 0, int_enable);
+	cpts_write32(cpts, 0, control);
+
 	if (cpts->refclk)
 		cpts_clk_release(cpts);
 }
-- 
2.10.1
