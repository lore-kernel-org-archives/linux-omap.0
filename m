From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [RFC 14/23] USB: ehci-omap: raw read and write endian fix
Date: Sat, 16 Nov 2013 02:01:17 +0200
Message-ID: <1384560086-11994-15-git-send-email-taras.kondratiuk@linaro.org>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linaro-networking@linaro.org, Victor Kamensky <victor.kamensky@linaro.org>, Felipe Balbi <balbi@ti.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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
 drivers/usb/host/ehci-omap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 6fa82d6..803e706 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -73,12 +73,12 @@ struct omap_hcd {
 
 static inline void ehci_write(void __iomem *base, u32 reg, u32 val)
 {
-	__raw_writel(val, base + reg);
+	writel_relaxed(val, base + reg);
 }
 
 static inline u32 ehci_read(void __iomem *base, u32 reg)
 {
-	return __raw_readl(base + reg);
+	return readl_relaxed(base + reg);
 }
 
 /* configure so an HC device and id are always provided */
-- 
1.7.9.5
