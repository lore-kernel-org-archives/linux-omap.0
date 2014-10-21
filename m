From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 14/20] rtc: omap: add helper to read 32-bit registers
Date: Tue, 21 Oct 2014 19:38:00 +0200
Message-ID: <1413913086-12730-15-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1413913086-12730-1-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1413913086-12730-1-git-send-email-johan@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Felipe Balbi <balbi@ti.com>
Cc: devicetree@vger.kernel.org, rtc-linux@googlegroups.com, Lokesh Vutla <lokeshvutla@ti.com>, j-keerthy@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, t-kristo@ti.com, linux-arm-kernel@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

Add helper to read full register width.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index bcdf3c596214..c508e45ca3ce 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -123,6 +123,11 @@ static inline u8 rtc_read(struct omap_rtc *rtc, unsigned int reg)
 	return readb(rtc->base + reg);
 }
 
+static inline u32 rtc_readl(struct omap_rtc *rtc, unsigned int reg)
+{
+	return readl(rtc->base + reg);
+}
+
 static inline void rtc_write(struct omap_rtc *rtc, unsigned int reg, u8 val)
 {
 	writeb(val, rtc->base + reg);
-- 
2.0.4
