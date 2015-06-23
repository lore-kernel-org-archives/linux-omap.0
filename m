From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 3/5] drivers/rtc/rtc-ds1307.c: Sort the headers
Date: Tue, 23 Jun 2015 11:15:12 -0500
Message-ID: <1435076114-12416-4-git-send-email-nm@ti.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435076114-12416-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>
Cc: Nishanth Menon <nm@ti.com>, grygorii.strashko@ti.com, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

It is always a good practice to keep the #includes sorted

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/rtc/rtc-ds1307.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 0a98d8a52791..b03880fc32b5 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -11,14 +11,14 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/module.h>
+#include <linux/bcd.h>
+#include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/module.h>
+#include <linux/rtc/ds1307.h>
+#include <linux/rtc.h>
 #include <linux/slab.h>
-#include <linux/i2c.h>
 #include <linux/string.h>
-#include <linux/rtc.h>
-#include <linux/bcd.h>
-#include <linux/rtc/ds1307.h>
 
 /*
  * We can't determine type by probing, but if we expect pre-Linux code
-- 
1.7.9.5
