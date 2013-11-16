From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [RFC 23/23] ARM: OMAP4: enable big endian support
Date: Sat, 16 Nov 2013 02:01:26 +0200
Message-ID: <1384560086-11994-24-git-send-email-taras.kondratiuk@linaro.org>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:58438 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847Ab3KPACB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Nov 2013 19:02:01 -0500
Received: by mail-ee0-f45.google.com with SMTP id d49so1384450eek.32
        for <linux-omap@vger.kernel.org>; Fri, 15 Nov 2013 16:02:00 -0800 (PST)
In-Reply-To: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linaro-networking@linaro.org, Victor Kamensky <victor.kamensky@linaro.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

From: Victor Kamensky <victor.kamensky@linaro.org>

Previous patches fixed big endian issues in OMAP4 code,
so mark it as one that supports big endian

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b5fb5f7..b5b19a3 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -48,6 +48,7 @@ config ARCH_OMAP4
 	select COMMON_CLK
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
+	select ARCH_SUPPORTS_BIG_ENDIAN
 
 config SOC_OMAP5
 	bool "TI OMAP5"
-- 
1.7.9.5

