From: Koen Kooi <koen@openembedded.org>
Subject: [PATCH] ARM: OMAP: armv7a Makefile: change -march flag to "armv7-a" so gcc 4.3.x works
Date: Fri, 13 Jun 2008 16:45:51 +0200
Message-ID: <1213368351-10664-1-git-send-email-koen@openembedded.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:48371 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047AbYFMOrF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jun 2008 10:47:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Koen Kooi <koen@openembedded.org>

armv7a Makefile: change -march flag to "armv7-a" so gcc 4.3.x works, "armv7a" is a CSL-ism. CSL compilers accept both variants.

Tested with: gcc 4.2.4, 4.3.0, 4.3.1 and csl 2007q3, 2008q1

Signed-off-by: Koen Kooi <koen@openembedded.org>
---
 arch/arm/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 40a0b44..a3befbd 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -47,7 +47,7 @@ comma = ,
 # Note that GCC does not numerically define an architecture version
 # macro, but instead defines a whole series of macros which makes
 # testing for a specific architecture or later rather impossible.
-arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7a,-march=armv5t -Wa$(comma)-march=armv7a)
+arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7-a,-march=armv5t -Wa$(comma)-march=armv7-a)
 arch-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6,-march=armv5t -Wa$(comma)-march=armv6)
 # Only override the compiler option if ARMv6. The ARMv6K extensions are
 # always available in ARMv7
-- 
1.5.4.3

