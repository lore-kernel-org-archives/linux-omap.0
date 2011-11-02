From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ARM: OMAP: dmtimer: Include linux/module.h
Date: Wed, 02 Nov 2011 09:49:46 +0800
Message-ID: <1320198586.9065.2.camel@phoenix>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Include linux/module.h to fix below build error:

  CC      arch/arm/plat-omap/dmtimer.o
arch/arm/plat-omap/dmtimer.c:184: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:184: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:184: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:215: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:215: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:215: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:228: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:228: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:228: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:234: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:234: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:234: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:240: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:240: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:240: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:248: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:248: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:248: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:294: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:294: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:294: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:302: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:302: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:302: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:316: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:316: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:316: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:344: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:344: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:344: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:361: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:361: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:361: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:380: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:380: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:380: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:406: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:406: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:406: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:443: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:443: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:443: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:468: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:468: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:468: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:494: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:494: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:494: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:517: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:517: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:517: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:534: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:534: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:534: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:549: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:549: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:549: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:561: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:561: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:561: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:572: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:572: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:572: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:587: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:587: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:587: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:604: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:604: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:604: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:746: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-omap/dmtimer.c:746: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:746: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
arch/arm/plat-omap/dmtimer.c:746: warning: function declaration isn't a prototype
arch/arm/plat-omap/dmtimer.c:747: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-omap/dmtimer.c:747: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:747: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
arch/arm/plat-omap/dmtimer.c:747: warning: function declaration isn't a prototype
arch/arm/plat-omap/dmtimer.c:748: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-omap/dmtimer.c:748: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:748: warning: type defaults to 'int' in declaration of 'MODULE_ALIAS'
arch/arm/plat-omap/dmtimer.c:748: warning: function declaration isn't a prototype
arch/arm/plat-omap/dmtimer.c:749: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-omap/dmtimer.c:749: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:749: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
arch/arm/plat-omap/dmtimer.c:749: warning: function declaration isn't a prototype
make[1]: *** [arch/arm/plat-omap/dmtimer.o] Error 1
make: *** [arch/arm/plat-omap] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I got the build error by make omap2plus_defconfig on linux-next 20111101.

 arch/arm/plat-omap/dmtimer.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 2def4e1..af3b92b 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -35,6 +35,7 @@
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/module.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-- 
1.7.5.4
