From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0107/1529] Fix typo
Date: Sat, 21 May 2016 13:50:25 +0200
Message-ID: <20160521115025.4915-1-andrea.gelmini@gelma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: andrea.gelmini@gelma.net
Cc: tony@atomide.com, linux-omap@vger.kernel.org, trivial@kernel.org, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-omap2/omap_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index f7ff3b9..a7be05d 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -268,7 +268,7 @@ static int _omap_device_idle_hwmods(struct omap_device *od)
  * function returns a value different than the value the caller got
  * the last time it called this function.
  *
- * If any hwmods exist for the omap_device assoiated with @pdev,
+ * If any hwmods exist for the omap_device associated with @pdev,
  * return the context loss counter for that hwmod, otherwise return
  * zero.
  */
-- 
2.8.2.534.g1f66975
