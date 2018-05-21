From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next 2/5] net: ethernet: ti: cpts: Fix timestamp print
Date: Mon, 21 May 2018 11:45:52 -0700
Message-ID: <20180521184555.21555-3-f.fainelli@gmail.com>
References: <20180521184555.21555-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180521184555.21555-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Keerthy <j-keerthy@ti.com>, Bhumika Goyal <bhumirks@gmail.com>, =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>, Richard Cochran <richardcochran@gmail.com>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, "open list:TI ETHERNET SWITCH DRIVER CPSW" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 64-bit hosts we will get the following warning:

drivers/net/ethernet/ti/cpts.c: In function 'cpts_overflow_check':
drivers/net/ethernet/ti/cpts.c:297:11: warning: format '%lld' expects
argument of type 'long long int', but argument 3 has type
'__kernel_time_t {aka long int}' [-Wformat=]
  pr_debug("cpts overflow check at %lld.%09lu\n", ts.tv_sec,
ts.tv_nsec);

Fix this by using an appropriate casting that works on all bit sizes.

Fixes: a5c79c26e168 ("ptp: cpts: convert to the 64 bit get/set time methods.")
Fixes: 87c0e764d43a ("cpts: introduce time stamping code and a PTP hardware clock.")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/ti/cpts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 7842f094f2ef..6f63c8729afc 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -294,7 +294,8 @@ static long cpts_overflow_check(struct ptp_clock_info *ptp)
 		delay = CPTS_SKB_TX_WORK_TIMEOUT;
 	spin_unlock_irqrestore(&cpts->lock, flags);
 
-	pr_debug("cpts overflow check at %lld.%09lu\n", ts.tv_sec, ts.tv_nsec);
+	pr_debug("cpts overflow check at %lld.%09ld\n",
+		 (long long)ts.tv_sec, ts.tv_nsec);
 	return (long)delay;
 }
 
-- 
2.14.1
