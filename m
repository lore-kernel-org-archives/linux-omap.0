From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC v2 17/18] ARM: OMAP2+: AM33XX: Select Mailbox when PM is enabled
Date: Mon, 31 Dec 2012 18:37:10 +0530
Message-ID: <1356959231-17335-18-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59697 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289Ab2LaNIi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Dec 2012 08:08:38 -0500
In-Reply-To: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

PM services on AM33XX depend on mailbox for communication
with WKUP-M3 core so ensure that the right config options
are selected. Thanks to Kevin Hilman <khilman@deeprootsystems.com>
for the suggestion on updating the Kconfig and not just
the omap2plus_defconfig which was done in the previous version
of the AM33XX suspend-resume support.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Tony Lingren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
v1->v2:
	Update the Kconfig instead of the defconfig

 arch/arm/mach-omap2/Kconfig |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 41b581f..c026fbd 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -114,9 +114,11 @@ config SOC_AM33XX
 	bool "AM33XX support"
 	default y
 	select ARM_CPU_SUSPEND if PM
+	select COMMON_CLK
 	select CPU_V7
+	select MAILBOX if PM
 	select MULTI_IRQ_HANDLER
-	select COMMON_CLK
+	select OMAP2PLUS_MBOX if PM
 
 config OMAP_PACKAGE_ZAF
        bool
-- 
1.7.0.4

