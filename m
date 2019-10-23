From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ARM: OMAP2+: Remove duplicated include from pmic-cpcap.c
Date: Wed, 23 Oct 2019 06:29:00 +0000
Message-ID: <20191023062900.43576-1-yuehaibing@huawei.com>
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
To: Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
Cc: kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/arm/mach-omap2/pmic-cpcap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pmic-cpcap.c b/arch/arm/mach-omap2/pmic-cpcap.c
index 2c2a178d988d..38b0307dc79d 100644
--- a/arch/arm/mach-omap2/pmic-cpcap.c
+++ b/arch/arm/mach-omap2/pmic-cpcap.c
@@ -15,8 +15,6 @@
 #include "voltage.h"
 
 #include <linux/init.h>
-#include <linux/kernel.h>
-#include "pm.h"
 #include "vc.h"
 
 /**
