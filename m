From: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] i2c: omap: raw read and write endian fix
Date: Wed, 27 Nov 2013 15:48:08 +0200
Message-ID: <1385560088-22339-1-git-send-email-taras.kondratiuk@linaro.org>
References: <20131126124238.GC7427@katana>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131126124238.GC7427@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-networking-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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
Posting this as a saparate patch out of RFC series.
RFC: http://patchwork.ozlabs.org/patch/291726/
Only minor comment change is done since RFC patch.

Based on v3.13-rc1

 drivers/i2c/busses/i2c-omap.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d76228d..90dcc2e 100644
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
 
@@ -1162,9 +1162,9 @@ omap_i2c_probe(struct platform_device *pdev)
 	 * Read the Rev hi bit-[15:14] ie scheme this is 1 indicates ver2.
 	 * On omap1/3/2 Offset 4 is IE Reg the bit [15:14] is 0 at reset.
 	 * Also since the omap_i2c_read_reg uses reg_map_ip_* a
-	 * raw_readw is done.
+	 * readw_relaxed is done.
 	 */
-	rev = __raw_readw(dev->base + 0x04);
+	rev = readw_relaxed(dev->base + 0x04);
 
 	dev->scheme = OMAP_I2C_SCHEME(rev);
 	switch (dev->scheme) {
-- 
1.7.9.5
