From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next 3/5] net: ethernet: ti: cpsw: Fix cpsw_add_ch_strings() printk format
Date: Mon, 21 May 2018 11:45:53 -0700
Message-ID: <20180521184555.21555-4-f.fainelli@gmail.com>
References: <20180521184555.21555-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180521184555.21555-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Keerthy <j-keerthy@ti.com>, Bhumika Goyal <bhumirks@gmail.com>, =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>, Richard Cochran <richardcochran@gmail.com>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, "open list:TI ETHERNET SWITCH DRIVER CPSW" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

When building on a 64-bit host we will get the following warning:

drivers/net/ethernet/ti/cpsw.c: In function 'cpsw_add_ch_strings':
drivers/net/ethernet/ti/cpsw.c:1284:19: warning: format '%d' expects
argument of type 'int', but argument 5 has type 'long unsigned int'
[-Wformat=]
     "%s DMA chan %d: %s", rx_dir ? "Rx" : "Tx",
                  ~^
                  %ld

Fix this by using an %ld format and casting to long.

Fixes: e05107e6b747 ("net: ethernet: ti: cpsw: add multi queue support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/ti/cpsw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index a7285dddfd29..643cd2d9dfb6 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1281,8 +1281,8 @@ static void cpsw_add_ch_strings(u8 **p, int ch_num, int rx_dir)
 	for (i = 0; i < ch_stats_len; i++) {
 		line = i % CPSW_STATS_CH_LEN;
 		snprintf(*p, ETH_GSTRING_LEN,
-			 "%s DMA chan %d: %s", rx_dir ? "Rx" : "Tx",
-			 i / CPSW_STATS_CH_LEN,
+			 "%s DMA chan %ld: %s", rx_dir ? "Rx" : "Tx",
+			 (long)(i / CPSW_STATS_CH_LEN),
 			 cpsw_gstrings_ch_stats[line].stat_string);
 		*p += ETH_GSTRING_LEN;
 	}
-- 
2.14.1
