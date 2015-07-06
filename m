From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 3/5] arm: atags: Fix declaration of function save_atags
Date: Mon,  6 Jul 2015 22:26:11 +0200
Message-ID: <1436214373-12969-4-git-send-email-pali.rohar@gmail.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

In file atags_proc.c function save_atags() expect const argument, but i=
n
atags.h file is declarated as non const. Fix declaration in atags.h fil=
e to
match what is expected.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/kernel/atags.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index ec4164d..2dfc30f 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -1,7 +1,7 @@
 #ifdef CONFIG_ATAGS_PROC
-extern void save_atags(struct tag *tags);
+extern void save_atags(const struct tag *tags);
 #else
-static inline void save_atags(struct tag *tags) { }
+static inline void save_atags(const struct tag *tags) { }
 #endif
=20
 void convert_to_tag_list(struct tag *tags);
--=20
1.7.9.5
