From: "Kim, Milo" <Milo.Kim@ti.com>
Subject: [PATCH] ethernet: add export.h in davinci_cpdma.c
Date: Mon, 2 Jul 2012 01:17:03 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998FCAAB@DQHE02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "arnd@arndb.de" <arnd@arndb.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>, "davem@davemloft.net" <davem@davemloft.net>
List-Id: linux-omap@vger.kernel.org

To remove warning messages about 'EXPORT_SYMBOL_GPL', include export header.

drivers/net/ethernet/ti/davinci_cpdma.c:280: warning: data definition has no type or storage class
drivers/net/ethernet/ti/davinci_cpdma.c:280: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
drivers/net/ethernet/ti/davinci_cpdma.c:280: warning: parameter names (without types) in function declaration
drivers/net/ethernet/ti/davinci_cpdma.c:326: warning: data definition has no type or storage class
drivers/net/ethernet/ti/davinci_cpdma.c:326: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
drivers/net/ethernet/ti/davinci_cpdma.c:326: warning: parameter names (without types) in function declaration
drivers/net/ethernet/ti/davinci_cpdma.c:357: warning: data definition has no type or storage class
drivers/net/ethernet/ti/davinci_cpdma.c:357: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
drivers/net/ethernet/ti/davinci_cpdma.c:357: warning: parameter names (without types) in function declaration
drivers/net/ethernet/ti/davinci_cpdma.c:428: warning: data definition has no type or storage class
drivers/net/ethernet/ti/davinci_cpdma.c:428: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
drivers/net/ethernet/ti/davinci_cpdma.c:428: warning: parameter names (without types) in function declaration
drivers/net/ethernet/ti/davinci_cpdma.c:452: warning: data definition has no type or storage class
drivers/net/ethernet/ti/davinci_cpdma.c:452: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
drivers/net/ethernet/ti/davinci_cpdma.c:452: warning: parameter names (without types) in function declaration
drivers/net/ethernet/ti/davinci_cpdma.c:537: warning: data definition has no type or storage class
drivers/net/ethernet/ti/davinci_cpdma.c:537: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
drivers/net/ethernet/ti/davinci_cpdma.c:537: warning: parameter names (without types) in function declaration
drivers/net/ethernet/ti/davinci_cpdma.c:555: warning: data definition has no type or storage class
drivers/net/ethernet/ti/davinci_cpdma.c:555: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
drivers/net/ethernet/ti/davinci_cpdma.c:555: warning: parameter names (without types) in function declaration
drivers/net/ethernet/ti/davinci_cpdma.c:704: warning: data definition has no type or storage class
drivers/net/ethernet/ti/davinci_cpdma.c:704: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
drivers/net/ethernet/ti/davinci_cpdma.c:704: warning: parameter names (without types) in function declaration
drivers/net/ethernet/ti/davinci_cpdma.c:788: warning: data definition has no type or storage class
drivers/net/ethernet/ti/davinci_cpdma.c:788: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
drivers/net/ethernet/ti/davinci_cpdma.c:788: warning: parameter names (without types) in function declaration
drivers/net/ethernet/ti/davinci_cpdma.c:816: warning: data definition has no type or storage class
drivers/net/ethernet/ti/davinci_cpdma.c:816: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
drivers/net/ethernet/ti/davinci_cpdma.c:816: warning: parameter names (without types) in function declaration
drivers/net/ethernet/ti/davinci_cpdma.c:877: warning: data definition has no type or storage class
drivers/net/ethernet/ti/davinci_cpdma.c:877: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
drivers/net/ethernet/ti/davinci_cpdma.c:877: warning: parameter names (without types) in function declaration

Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
---
 drivers/net/ethernet/ti/davinci_cpdma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index d614c37..3c1e423 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/export.h>
 
 #include "davinci_cpdma.h"
 
-- 
1.7.2.5

Best Regards,
Milo
