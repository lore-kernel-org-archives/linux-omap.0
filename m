From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5/5] usb: omap_control_usb: fix compile warning
Date: Wed, 6 Feb 2013 11:28:13 +0530
Message-ID: <1360130294-5976-6-git-send-email-kishon@ti.com>
References: <1360130294-5976-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1360130294-5976-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, tony@atomide.com, linux@arm.linux.org.uk, eballetbo@gmail.com, javier@dowhile0.org, b-cousson@ti.com, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc: kishon@ti.com
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>

When CONFIG_OMAP_CONTROL_USB isn't enabled,
there's a compile warning stating that a
particular function isn't a prototype.

Fix it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/usb/omap_control_usb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/omap_control_usb.h b/include/linux/usb/omap_control_usb.h
index f306db7..27b5b8c 100644
--- a/include/linux/usb/omap_control_usb.h
+++ b/include/linux/usb/omap_control_usb.h
@@ -70,7 +70,7 @@ extern void omap_control_usb3_phy_power(struct device *dev, bool on);
 extern void omap_control_usb_set_mode(struct device *dev,
 	enum omap_control_usb_mode mode);
 #else
-static inline struct device *omap_get_control_dev()
+static inline struct device *omap_get_control_dev(void)
 {
 	return ERR_PTR(-ENODEV);
 }
-- 
1.7.10.4
