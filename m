From: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [RFC 05/23] i2c: omap: raw read and write endian fix
Date: Sat, 16 Nov 2013 02:01:08 +0200
Message-ID: <1384560086-11994-6-git-send-email-taras.kondratiuk@linaro.org>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384560086-11994-1-git-send-email-taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linaro-networking-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
Need to use endian neutral functions to read/write h/w registers.
I.e instead of __raw_read[lw] and __raw_write[lw] functions code
need to use read[lw]_relaxed and write[lw]_relaxed functions.
If the first simply reads/writes register, the second will byteswap
it if host operates in BE mode.

Changes are trivial sed like replacement of __raw_xxx functions
with xxx_relaxed variant.

Signed-off-by: Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9967a6f..d69826e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -266,13 +266,13 @@ static const u8 reg_map_ip_v2[] = {
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
 				      int reg, u16 val)
 {
-	__raw_writew(val, i2c_dev->base +
+	writew_relaxed(val, i2c_dev->base +
 			(i2c_dev->regs[reg] << i2c_dev->reg_shift));
 }
 
 static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 {
-	return __raw_readw(i2c_dev->base +
+	return readw_relaxed(i2c_dev->base +
 				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
 }
 
@@ -1142,7 +1142,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	 * Also since the omap_i2c_read_reg uses reg_map_ip_* a
 	 * raw_readw is done.
 	 */
-	rev = __raw_readw(dev->base + 0x04);
+	rev = readw_relaxed(dev->base + 0x04);
 
 	dev->scheme = OMAP_I2C_SCHEME(rev);
 	switch (dev->scheme) {
-- 
1.7.9.5
