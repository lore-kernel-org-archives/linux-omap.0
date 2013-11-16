From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [RFC 07/23] hwrng: omap - raw read and write endian fix
Date: Sat, 16 Nov 2013 02:01:10 +0200
Message-ID: <1384560086-11994-8-git-send-email-taras.kondratiuk@linaro.org>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linaro-networking@linaro.org, Victor Kamensky <victor.kamensky@linaro.org>, Deepak Saxena <dsaxena@plexity.net>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Victor Kamensky <victor.kamensky@linaro.org>

All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
Need to use endian neutral functions to read/write h/w registers.
I.e instead of __raw_read[lw] and __raw_write[lw] functions code
need to use read[lw]_relaxed and write[lw]_relaxed functions.
If the first simply reads/writes register, the second will byteswap
it if host operates in BE mode.

Changes are trivial sed like replacement of __raw_xxx functions
with xxx_relaxed variant.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 drivers/char/hw_random/omap-rng.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 9b89ff4..d68cf8a 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -131,13 +131,13 @@ struct omap_rng_dev {
 
 static inline u32 omap_rng_read(struct omap_rng_dev *priv, u16 reg)
 {
-	return __raw_readl(priv->base + priv->pdata->regs[reg]);
+	return readl_relaxed(priv->base + priv->pdata->regs[reg]);
 }
 
 static inline void omap_rng_write(struct omap_rng_dev *priv, u16 reg,
 				      u32 val)
 {
-	__raw_writel(val, priv->base + priv->pdata->regs[reg]);
+	writel_relaxed(val, priv->base + priv->pdata->regs[reg]);
 }
 
 static int omap_rng_data_present(struct hwrng *rng, int wait)
-- 
1.7.9.5
