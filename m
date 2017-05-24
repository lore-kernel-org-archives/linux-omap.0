From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 13/13] crypto: omap-sham: force word alignment on the xmit-buf also
Date: Wed, 24 May 2017 10:35:34 +0300
Message-ID: <1495611334-15039-14-git-send-email-t-kristo@ti.com>
References: <1495611334-15039-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <1495611334-15039-1-git-send-email-t-kristo@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
To: herbert@gondor.apana.org.au, lokeshvutla@ti.com, davem@davemloft.net, linux-crypto@vger.kernel.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This was previously missed from the code, causing SDMA to hang in
some cases where the buffer ended up being not aligned.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-sham.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index d8305dd..1e7c9ef 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -225,7 +225,7 @@ struct omap_sham_dev {
 	struct dma_chan		*dma_lch;
 	struct tasklet_struct	done_task;
 	u8			polling_mode;
-	u8			xmit_buf[BUFLEN];
+	u8			xmit_buf[BUFLEN] OMAP_ALIGNED;
 
 	unsigned long		flags;
 	struct crypto_queue	queue;
-- 
1.9.1
