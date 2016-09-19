From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 8/8] crypto: omap-sham: shrink the internal buffer size
Date: Mon, 19 Sep 2016 18:22:19 +0300
Message-ID: <1474298539-23897-9-git-send-email-t-kristo@ti.com>
References: <1474298539-23897-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <1474298539-23897-1-git-send-email-t-kristo@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
To: herbert@gondor.apana.org.au, lokeshvutla@ti.com, davem@davemloft.net, linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The current internal buffer size is way too large for crypto core, so
shrink it to be smaller. This makes the buffer to fit into the space
reserved for the export/import buffers also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-sham.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 8eefd79..d0b16e5 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -135,7 +135,7 @@
 #define OMAP_ALIGN_MASK		(sizeof(u32)-1)
 #define OMAP_ALIGNED		__attribute__((aligned(sizeof(u32))))
 
-#define BUFLEN			PAGE_SIZE
+#define BUFLEN			SHA512_BLOCK_SIZE
 #define OMAP_SHA_DMA_THRESHOLD	256
 
 struct omap_sham_dev;
-- 
1.9.1
