From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 064/493] hwspinlock: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:20:13 -0500
Message-ID: <1353349642-3677-64-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
List-Id: linux-omap@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Ohad Ben-Cohen <ohad@wizery.com> 
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> 
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: linux-omap@vger.kernel.org 
Cc: linux-arm-kernel@lists.infradead.org 
---
 drivers/hwspinlock/omap_hwspinlock.c | 2 +-
 drivers/hwspinlock/u8500_hsem.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 887d34e..28640b8 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -163,7 +163,7 @@ static int __devexit omap_hwspinlock_remove(struct platform_device *pdev)
 
 static struct platform_driver omap_hwspinlock_driver = {
 	.probe		= omap_hwspinlock_probe,
-	.remove		= __devexit_p(omap_hwspinlock_remove),
+	.remove		= omap_hwspinlock_remove,
 	.driver		= {
 		.name	= "omap_hwspinlock",
 		.owner	= THIS_MODULE,
diff --git a/drivers/hwspinlock/u8500_hsem.c b/drivers/hwspinlock/u8500_hsem.c
index 86980fe..4039810 100644
--- a/drivers/hwspinlock/u8500_hsem.c
+++ b/drivers/hwspinlock/u8500_hsem.c
@@ -172,7 +172,7 @@ static int __devexit u8500_hsem_remove(struct platform_device *pdev)
 
 static struct platform_driver u8500_hsem_driver = {
 	.probe		= u8500_hsem_probe,
-	.remove		= __devexit_p(u8500_hsem_remove),
+	.remove		= u8500_hsem_remove,
 	.driver		= {
 		.name	= "u8500_hsem",
 		.owner	= THIS_MODULE,
-- 
1.8.0
