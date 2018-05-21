From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next 5/5] ti: ethernet: davinci: Fix cast to int warnings
Date: Mon, 21 May 2018 11:45:55 -0700
Message-ID: <20180521184555.21555-6-f.fainelli@gmail.com>
References: <20180521184555.21555-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180521184555.21555-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Keerthy <j-keerthy@ti.com>, Bhumika Goyal <bhumirks@gmail.com>, =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>, Richard Cochran <richardcochran@gmail.com>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, "open list:TI ETHERNET SWITCH DRIVER CPSW" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Now that we can compile test this driver on 64-bit hosts, we get some
warnings about how a pointer/address is written/read to/from a register
(sw_token). Fix this by doing the appropriate conversions, we cannot
possibly have the driver work on 64-bit hosts the way the tokens are
managed though, since the registers being written to a 32-bit only.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/ti/davinci_cpdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index 9ec49213de5e..cdbddf16dd29 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -1080,7 +1080,7 @@ int cpdma_chan_submit(struct cpdma_chan *chan, void *token, void *data,
 	writel_relaxed(buffer, &desc->hw_buffer);
 	writel_relaxed(len, &desc->hw_len);
 	writel_relaxed(mode | len, &desc->hw_mode);
-	writel_relaxed(token, &desc->sw_token);
+	writel_relaxed((uintptr_t)token, &desc->sw_token);
 	writel_relaxed(buffer, &desc->sw_buffer);
 	writel_relaxed(len, &desc->sw_len);
 	desc_read(desc, sw_len);
@@ -1121,15 +1121,15 @@ static void __cpdma_chan_free(struct cpdma_chan *chan,
 	struct cpdma_desc_pool		*pool = ctlr->pool;
 	dma_addr_t			buff_dma;
 	int				origlen;
-	void				*token;
+	uintptr_t			token;
 
-	token      = (void *)desc_read(desc, sw_token);
+	token      = desc_read(desc, sw_token);
 	buff_dma   = desc_read(desc, sw_buffer);
 	origlen    = desc_read(desc, sw_len);
 
 	dma_unmap_single(ctlr->dev, buff_dma, origlen, chan->dir);
 	cpdma_desc_free(pool, desc, 1);
-	(*chan->handler)(token, outlen, status);
+	(*chan->handler)((void *)token, outlen, status);
 }
 
 static int __cpdma_chan_process(struct cpdma_chan *chan)
-- 
2.14.1
