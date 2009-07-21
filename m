From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 14/14] OMAP3: Overo: add missing pen-down GPIO definition
Date: Tue, 21 Jul 2009 15:08:40 -0700
Message-ID: <1248214120-18886-15-git-send-email-khilman@deeprootsystems.com>
References: <1248214120-18886-1-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-2-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-3-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-4-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-5-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-6-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-7-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-8-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-9-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-10-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-11-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-12-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-13-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-14-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:7329 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756373AbZGUWJQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 18:09:16 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1009646wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 15:09:16 -0700 (PDT)
In-Reply-To: <1248214120-18886-14-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-overo.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index dff5528..e26af83 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -51,6 +51,7 @@
 
 #define OVERO_GPIO_BT_XGATE	15
 #define OVERO_GPIO_W2W_NRESET	16
+#define OVERO_GPIO_PENDOWN	114
 #define OVERO_GPIO_BT_NRESET	164
 #define OVERO_GPIO_USBH_CPEN	168
 #define OVERO_GPIO_USBH_NRESET	183
-- 
1.6.3.3

