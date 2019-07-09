From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH linux-next] net: ethernet: ti: davinci_cpdma:
 cpdma_chan_split_pool() can be static
Date: Wed, 10 Jul 2019 03:32:25 +0800
Message-ID: <20190709193225.GA89649@lkp-kbuild04>
References: <201907100329.bQl3UgMB%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201907100329.bQl3UgMB%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: kbuild-all@01.org, Grygorii Strashko <grygorii.strashko@ti.com>, Andrew Lunn <andrew@lunn.ch>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Fixes: 962fb618909e ("net: ethernet: ti: davinci_cpdma: allow desc split while down")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 davinci_cpdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index 0ca2a1a..1f6065b 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -722,7 +722,7 @@ static void cpdma_chan_set_descs(struct cpdma_ctlr *ctlr,
  * cpdma_chan_split_pool - Splits ctrl pool between all channels.
  * Has to be called under ctlr lock
  */
-int cpdma_chan_split_pool(struct cpdma_ctlr *ctlr)
+static int cpdma_chan_split_pool(struct cpdma_ctlr *ctlr)
 {
 	int tx_per_ch_desc = 0, rx_per_ch_desc = 0;
 	int free_rx_num = 0, free_tx_num = 0;
