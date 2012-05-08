From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] ARM: OMAP1: fix compilation issue in board-sx1.c
Date: Tue,  8 May 2012 16:59:35 +0300
Message-ID: <1336485575-18352-1-git-send-email-dedekind1@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19255 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503Ab2EHN6t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 09:58:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: OMAP Mailing List <linux-omap@vger.kernel.org>

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

SX1 board requirese i2c, so select it in Kconfig, otherwise I have the
following build error:

arch/arm/mach-omap1/board-sx1.c: In function 'sx1_i2c_write_byte':
arch/arm/mach-omap1/board-sx1.c:58:2: error: implicit declaration of function 'i2c_get_adapter' [-Werror=implicit-function-declaration]
arch/arm/mach-omap1/board-sx1.c:58:7: warning: assignment makes pointer from integer without a cast [enabled by default]
arch/arm/mach-omap1/board-sx1.c:67:2: error: implicit declaration of function 'i2c_transfer' [-Werror=implicit-function-declaration]
arch/arm/mach-omap1/board-sx1.c:68:2: error: implicit declaration of function 'i2c_put_adapter' [-Werror=implicit-function-declaration]
arch/arm/mach-omap1/board-sx1.c: In function 'sx1_i2c_read_byte':
arch/arm/mach-omap1/board-sx1.c:82:7: warning: assignment makes pointer from integer without a cast [enabled by default]
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mach-omap1/board-sx1.o] Error 1
make: *** [arch/arm/mach-omap1] Error 2
make: *** Waiting for unfinished jobs....

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/arm/mach-omap1/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index dfab466..cba3f71 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -132,6 +132,7 @@ config MACH_OMAP_PALMTT
 
 config MACH_SX1
 	bool "Siemens SX1"
+	select I2C
 	depends on ARCH_OMAP1 && ARCH_OMAP15XX
 	help
 	  Support for the Siemens SX1 phone. To boot the kernel,
-- 
1.7.9.1

