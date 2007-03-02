From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: Unable to build any OMAP kernels ?
Date: Fri, 2 Mar 2007 17:50:38 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47622CB5@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

I was not able to set default config or compile the kernel (for all
OMAPs). Please see the log below. This is due to the
drivers/video/Kconfig change, if I revert the same it works fine. Am I
doing some thing wrong?  (hope not :)

I will send a patch to correct this one.

LOG:
----
make omap_h3_1710_defconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  SHIPPED scripts/kconfig/zconf.hash.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
file drivers/video/omap/Kconfig already scanned?
make[1]: *** [omap_h3_1710_defconfig] Error 1
make: *** [omap_h3_1710_defconfig] Error 2

PATCH:
------

file:b8f0a11e8f3174c83b02d69229d2d516c251ce4d ->
file:0a99c248bf9639411c40961fbfd86eae90276653
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1635,6 +1635,10 @@ config FB_PS3_DEFAULT_SIZE_M
The default value can be overridden on the kernel command line
using the "ps3fb" option (e.g. "ps3fb=3D9M");
+if ARCH_OMAP
+ source "drivers/video/omap/Kconfig"
+endif
+

Regards,
Khasim
