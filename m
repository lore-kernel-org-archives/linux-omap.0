From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: full-retention fix for 2430
Date: Tue, 24 Jul 2007 15:36:51 -0700
Message-ID: <20070724223650.978943750@mvista.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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

This fixes a bug where the 2430 crashes upon entering full-retention 
due to a register difference between 2420 and 2430.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/mach-omap2/pm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: dev/arch/arm/mach-omap2/pm.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/pm.c
+++ dev/arch/arm/mach-omap2/pm.c
@@ -346,7 +346,7 @@ static struct subsys_attribute sleep_whi
 
 static struct clk *osc_ck, *emul_ck;
 
-#define CONTROL_DEVCONF		__REG32(0x48000274)
+#define CONTROL_DEVCONF		__REG32(OMAP2_CTRL_BASE + 0x274)
 
 static int omap2_fclks_active(void)
 {
--
