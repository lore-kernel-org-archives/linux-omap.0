From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ARM: OMAP2+: l3-noc: Include linux/module.h
Date: Wed, 02 Nov 2011 09:40:11 +0800
Message-ID: <1320198011.9065.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Include linux/module.h to fix below build error:

  CC      arch/arm/mach-omap2/omap_l3_noc.o
arch/arm/mach-omap2/omap_l3_noc.c:240: error: expected ',' or ';' before 'MODULE_DEVICE_TABLE'
arch/arm/mach-omap2/omap_l3_noc.c:250: error: 'THIS_MODULE' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-omap2/omap_l3_noc.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I got the build error by make omap2plus_defconfig on linux-next 20111101.

 arch/arm/mach-omap2/omap_l3_noc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index c8b1bef..6a66aa5 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -20,6 +20,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
  * USA
  */
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
-- 
1.7.5.4
