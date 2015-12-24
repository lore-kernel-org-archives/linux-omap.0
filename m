From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/3] ARM: ATAGS: Fix declaration of function save_atags
Date: Thu, 24 Dec 2015 16:00:57 +0200
Message-ID: <1450965658-2675-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1450965658-2675-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450965658-2675-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, tony@atomide.com, nicolas.pitre@linaro.org, arnd@arndb.de, pali.rohar@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

In file atags_proc.c function save_atags() expect const argument, but in
atags.h file is declarated as non const. Fix declaration in atags.h file to
match what is expected.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/include/asm/atags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/atags.h b/arch/arm/include/asm/atags.h
index ec4164d..2dfc30f 100644
--- a/arch/arm/include/asm/atags.h
+++ b/arch/arm/include/asm/atags.h
@@ -1,7 +1,7 @@
 #ifdef CONFIG_ATAGS_PROC
-extern void save_atags(struct tag *tags);
+extern void save_atags(const struct tag *tags);
 #else
-static inline void save_atags(struct tag *tags) { }
+static inline void save_atags(const struct tag *tags) { }
 #endif
 
 void convert_to_tag_list(struct tag *tags);
-- 
1.9.1
