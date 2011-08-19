From: tom.leiming@gmail.com
Subject: [PATCH] mfd: omap-usb-host: fix build failure
Date: Fri, 19 Aug 2011 16:57:54 +0800
Message-ID: <1313744274-5031-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sameo@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, Ming Lei <ming.lei@canonical.com>
List-Id: linux-omap@vger.kernel.org

From: Ming Lei <tom.leiming@gmail.com>

The patch fixes the build failure:

drivers/mfd/omap-usb-host.c:1034:1: warning: data definition has no type
or storage class
drivers/mfd/omap-usb-host.c:1034:1: warning: type defaults to 'int' in
declaration of 'EXPORT_SYMBOL_GPL'
drivers/mfd/omap-usb-host.c:1034:1: warning: parameter names (without
types) in function declaration
drivers/mfd/omap-usb-host.c:1040:1: warning: data definition has no type
or storage class
drivers/mfd/omap-usb-host.c:1040:1: warning: type defaults to 'int' in
declaration of 'EXPORT_SYMBOL_GPL'
drivers/mfd/omap-usb-host.c:1040:1: warning: parameter names (without
types) in function declaration
drivers/mfd/omap-usb-host.c:1045:13: error: 'THIS_MODULE' undeclared
here (not in a function)
drivers/mfd/omap-usb-host.c:1050:15: error: expected declaration
specifiers or '...' before string constant
drivers/mfd/omap-usb-host.c:1050:1: warning: data definition has no type
or storage class
drivers/mfd/omap-usb-host.c:1050:1: warning: type defaults to 'int' in
declaration of 'MODULE_AUTHOR'
drivers/mfd/omap-usb-host.c:1050:15: warning: function declaration isn't
a prototype
drivers/mfd/omap-usb-host.c:1051:14: error: expected declaration
specifiers or '...' before string constant
drivers/mfd/omap-usb-host.c:1051:1: warning: data definition has no type
or storage class
drivers/mfd/omap-usb-host.c:1051:1: warning: type defaults to 'int' in
declaration of 'MODULE_ALIAS'
drivers/mfd/omap-usb-host.c:1051:14: warning: function declaration isn't
a prototype
drivers/mfd/omap-usb-host.c:1052:16: error: expected declaration
specifiers or '...' before string constant
drivers/mfd/omap-usb-host.c:1052:1: warning: data definition has no type
or storage class
drivers/mfd/omap-usb-host.c:1052:1: warning: type defaults to 'int' in
declaration of 'MODULE_LICENSE'
drivers/mfd/omap-usb-host.c:1052:16: warning: function declaration isn't
a prototype
drivers/mfd/omap-usb-host.c:1053:20: error: expected declaration
specifiers or '...' before string constant
drivers/mfd/omap-usb-host.c:1053:1: warning: data definition has no type
or storage class
drivers/mfd/omap-usb-host.c:1053:1: warning: type defaults to 'int' in
declaration of 'MODULE_DESCRIPTION'
drivers/mfd/omap-usb-host.c:1053:20: warning: function declaration isn't
a prototype
make[2]: *** [drivers/mfd/omap-usb-host.o] Error 1
  CC      fs/proc/namespaces.o
make[1]: *** [drivers/mfd] Error 2
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/mfd/omap-usb-host.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 29601e7..03debe8 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -17,6 +17,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-- 
1.7.4.1
