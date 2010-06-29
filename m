From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] omap: Disable VGA console for omaps
Date: Tue, 29 Jun 2010 14:47:20 +0300
Message-ID: <20100629114720.16008.84291.stgit@baageli.muru.com>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64081 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab0F2LrL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 07:47:11 -0400
In-Reply-To: <20100629113229.16008.2931.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

Otherwise we have to disable it manually to avoid compile errors.

Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/video/console/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 8e8f18d..467a966 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -6,7 +6,7 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EMBEDDED || !X86
-	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE && !SUPERH && !BLACKFIN && !AVR32 && !MN10300
+	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE && !SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !ARCH_OMAP
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a

