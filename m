From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/2] ARM: ATAGS: move save_atags() to include/asm arch/arm/include/asm/setup.h
Date: Thu, 24 Dec 2015 18:37:55 +0200
Message-ID: <1450975076-7411-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
 <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, tony@atomide.com, nicolas.pitre@linaro.org, arnd@arndb.de, pali.rohar@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

So it can be used by code outside arch/arm/kernel/. Fix save_atags()
declaration to match its definition while at it.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/include/asm/setup.h | 6 ++++++
 arch/arm/kernel/atags.h      | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index e0adb9f..3613d7e 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -25,4 +25,10 @@ extern int arm_add_memory(u64 start, u64 size);
 extern void early_print(const char *str, ...);
 extern void dump_machine_table(void);
 
+#ifdef CONFIG_ATAGS_PROC
+extern void save_atags(const struct tag *tags);
+#else
+static inline void save_atags(const struct tag *tags) { }
+#endif
+
 #endif
diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index ec4164d..edfa226 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -1,9 +1,3 @@
-#ifdef CONFIG_ATAGS_PROC
-extern void save_atags(struct tag *tags);
-#else
-static inline void save_atags(struct tag *tags) { }
-#endif
-
 void convert_to_tag_list(struct tag *tags);
 
 #ifdef CONFIG_ATAGS
-- 
1.9.1
