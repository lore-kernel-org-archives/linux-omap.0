From: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
Subject: [RFC PATCHv2 2/2] ux500: Export U8500 SoC info through sysfs
Date: Fri, 11 Mar 2011 13:35:11 +0100
Message-ID: <1299846911-15782-3-git-send-email-maxime.coquelin-nonst@stericsson.com>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Sarava
Cc: maxime_coquelin@yahoo.fr, ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Ambresh <a0393775@ti.com>, Jouni Hogander <jouni.hogander@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Daniel Walker <dwalker@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Paul Mundt <lethal@linux-sh.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Maxime Coquelin <maxime.coquelin-nonst@stericss>
List-Id: linux-omap@vger.kernel.org

ST-Ericsson's U8500 implementation.
Register sysfs SoC interface, and exports:
	- Machine name
	- Family name
	- SoC ID
	- Silicon process
	- Silicon revision number.

Signed-off-by: Maxime COQUELIN <maxime.coquelin-nonst@stericsson.com>

socinfo : ux500 part 2
---
 arch/arm/mach-ux500/Kconfig |    1 +
 arch/arm/mach-ux500/id.c    |   70 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 7f8620f..08f9859 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -23,6 +23,7 @@ config MACH_U8500
 	bool "U8500 Development platform"
 	depends on UX500_SOC_DB8500
 	select TPS6105X
+	select SYS_SOC
 	help
 	  Include support for the mop500 development platform.
 
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index d35122e..457b48e 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -8,6 +8,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/sys_soc.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
 
 #include <asm/cputype.h>
 #include <asm/tlbflush.h>
@@ -105,3 +108,70 @@ void __init ux500_map_io(void)
 
 	ux500_print_soc_info(asicid);
 }
+
+
+#ifdef CONFIG_SYS_SOC
+#define U8500_BB_UID_BASE (U8500_BACKUPRAM1_BASE + 0xFC0)
+#define U8500_BB_UID_LENGTH 5
+
+static ssize_t ux500_get_machine(char *buf, struct sysfs_soc_info *si)
+{
+	return sprintf(buf, "DB%4x\n", dbx500_partnumber());
+}
+
+static ssize_t ux500_get_soc_id(char *buf, struct sysfs_soc_info *si)
+{
+	void __iomem *uid_base;
+	int i;
+	ssize_t sz = 0;
+
+	if (dbx500_partnumber() == 0x8500) {
+		uid_base = __io_address(U8500_BB_UID_BASE);
+		for (i = 0; i < U8500_BB_UID_LENGTH; i++)
+			sz += sprintf(buf + sz, "%08x", readl(uid_base + i * sizeof(u32)));
+		sz += sprintf(buf + sz, "\n");
+	}
+	else {
+		/* Don't know where it is located for U5500 */
+		sz = sprintf(buf, "N/A\n");
+	}
+
+	return sz;
+}
+
+static ssize_t ux500_get_revision(char *buf, struct sysfs_soc_info *si)
+{
+	unsigned int rev = dbx500_revision();
+
+	if (rev == 0x01)
+		return sprintf(buf, "%s\n", "ED");
+	else if (rev >= 0xA0)
+		return sprintf(buf, "%d.%d\n" , (rev >> 4) - 0xA + 1, rev & 0xf);
+
+	return sprintf(buf, "%s", "Unknown\n");
+}
+
+static ssize_t ux500_get_process(char *buf, struct sysfs_soc_info *si)
+{
+	if (dbx500_id.process == 0x00)
+		return sprintf(buf, "Standard\n");
+
+	return sprintf(buf, "%02xnm\n", dbx500_id.process);
+}
+
+static struct sysfs_soc_info soc_info[] = {
+	SYSFS_SOC_ATTR_CALLBACK("machine", ux500_get_machine),
+	SYSFS_SOC_ATTR_VALUE("family", "Ux500"),
+	SYSFS_SOC_ATTR_CALLBACK("soc_id", ux500_get_soc_id),
+	SYSFS_SOC_ATTR_CALLBACK("revision", ux500_get_revision),
+	SYSFS_SOC_ATTR_CALLBACK("process", ux500_get_process),
+};
+
+static int __init ux500_sys_soc_init(void)
+{
+	return register_sysfs_soc(soc_info, ARRAY_SIZE(soc_info));
+}
+
+module_init(ux500_sys_soc_init);
+#endif
+
-- 
1.7.1
