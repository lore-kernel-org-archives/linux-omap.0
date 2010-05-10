From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 3/4] mach-omap1: export omap1 info under /proc/socinfo
Date: Mon, 10 May 2010 13:37:36 +0300
Message-ID: <1273487857-32281-4-git-send-email-eduardo.valentin@nokia.com>
References: <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Ambresh <a0393775@ti.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, santosh.shilimkar@ti.com, Andrew Morton <akpm@linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Report OMAP name and rev under /proc/socinfo node.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap1/id.c |   45 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index a0e3560..917892b 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/seq_file.h>
 #include <plat/cpu.h>
 
 #define OMAP_DIE_ID_0		0xfffe1800
@@ -118,9 +119,12 @@ static u8 __init omap_get_die_rev(void)
 	return die_rev;
 }
 
+#define SOCINFO_SZ		128
+static char socinfo[SOCINFO_SZ];
+
 void __init omap_check_revision(void)
 {
-	int i;
+	int i, sz;
 	u16 jtag_id;
 	u8 die_rev;
 	u32 omap_id;
@@ -194,11 +198,40 @@ void __init omap_check_revision(void)
 		printk(KERN_INFO "Unknown OMAP cpu type: 0x%02x\n", cpu_type);
 	}
 
-	printk(KERN_INFO "OMAP%04x", omap_revision >> 16);
+	sz = snprintf(socinfo, SOCINFO_SZ, "OMAP%04x", omap_revision >> 16);
 	if ((omap_revision >> 8) & 0xff)
-		printk(KERN_INFO "%x", (omap_revision >> 8) & 0xff);
-	printk(KERN_INFO " revision %i handled as %02xxx id: %08x%08x\n",
-	       die_rev, omap_revision & 0xff, system_serial_low,
-	       system_serial_high);
+		snprintf(socinfo + sz, SOCINFO_SZ - sz, "%x",
+						(omap_revision >> 8) & 0xff);
+	pr_info("%s revision %i handled as %02xxx id: %08x%08x\n",
+		socinfo, die_rev, omap_revision & 0xff, system_serial_low,
+		system_serial_high);
+}
+
+static int c_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "SoC\t: %s\n", socinfo);
+
+	return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	return *pos < 1 ? (void *)1 : NULL;
 }
 
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return NULL;
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+const struct seq_operations socinfo_op = {
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= c_show
+};
-- 
1.7.0.4.361.g8b5fe.dirty
