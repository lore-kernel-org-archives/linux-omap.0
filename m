From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/3] ARM: ATAGS: move atags.h to include/asm so it can be included by files outside kernel/
Date: Thu, 24 Dec 2015 16:00:56 +0200
Message-ID: <1450965658-2675-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1450965658-2675-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450965658-2675-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, tony@atomide.com, nicolas.pitre@linaro.org, arnd@arndb.de, pali.rohar@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

This is needed by a follow-up patch that saves atags on RX51 device

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/include/asm/atags.h  | 20 ++++++++++++++++++++
 arch/arm/kernel/atags.h       | 20 --------------------
 arch/arm/kernel/atags_parse.c |  3 +--
 arch/arm/kernel/setup.c       |  3 +--
 4 files changed, 22 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/include/asm/atags.h
 delete mode 100644 arch/arm/kernel/atags.h

diff --git a/arch/arm/include/asm/atags.h b/arch/arm/include/asm/atags.h
new file mode 100644
index 0000000..ec4164d
--- /dev/null
+++ b/arch/arm/include/asm/atags.h
@@ -0,0 +1,20 @@
+#ifdef CONFIG_ATAGS_PROC
+extern void save_atags(struct tag *tags);
+#else
+static inline void save_atags(struct tag *tags) { }
+#endif
+
+void convert_to_tag_list(struct tag *tags);
+
+#ifdef CONFIG_ATAGS
+const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
+	unsigned int machine_nr);
+#else
+static inline const struct machine_desc *
+setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
+{
+	early_print("no ATAGS support: can't continue\n");
+	while (true);
+	unreachable();
+}
+#endif
diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
deleted file mode 100644
index ec4164d..0000000
--- a/arch/arm/kernel/atags.h
+++ /dev/null
@@ -1,20 +0,0 @@
-#ifdef CONFIG_ATAGS_PROC
-extern void save_atags(struct tag *tags);
-#else
-static inline void save_atags(struct tag *tags) { }
-#endif
-
-void convert_to_tag_list(struct tag *tags);
-
-#ifdef CONFIG_ATAGS
-const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
-	unsigned int machine_nr);
-#else
-static inline const struct machine_desc *
-setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
-{
-	early_print("no ATAGS support: can't continue\n");
-	while (true);
-	unreachable();
-}
-#endif
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 68c6ae0..faac2d1 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -28,8 +28,7 @@
 #include <asm/system_info.h>
 #include <asm/page.h>
 #include <asm/mach/arch.h>
-
-#include "atags.h"
+#include <asm/atags.h>
 
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 20edd34..aa0193a 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -60,8 +60,7 @@
 #include <asm/unwind.h>
 #include <asm/memblock.h>
 #include <asm/virt.h>
-
-#include "atags.h"
+#include <asm/atags.h>
 
 
 #if defined(CONFIG_FPE_NWFPE) || defined(CONFIG_FPE_FASTFPE)
-- 
1.9.1
