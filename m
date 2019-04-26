From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 16/20] net: ethernet: ti: davinci_cpdma: use dma_addr_t for desc_mem_phys and desc_hw_addr
Date: Fri, 26 Apr 2019 20:12:38 +0300
Message-ID: <1556298762-8632-17-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Use dma_addr_t for desc_mem_phys and desc_hw_addr to avoid types
conversions.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/davinci_cpdma.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.h b/drivers/net/ethernet/ti/davinci_cpdma.h
index 7d38210f3267..10376062dafa 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.h
+++ b/drivers/net/ethernet/ti/davinci_cpdma.h
@@ -27,8 +27,8 @@ struct cpdma_params {
 	int			num_chan;
 	bool			has_soft_reset;
 	int			min_packet_size;
-	u32			desc_mem_phys;
-	u32			desc_hw_addr;
+	dma_addr_t		desc_mem_phys;
+	dma_addr_t		desc_hw_addr;
 	int			desc_mem_size;
 	int			desc_align;
 	u32			bus_freq_mhz;
-- 
2.17.1
