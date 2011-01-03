From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] OMAP3+: sr_device: include pm header
Date: Mon,  3 Jan 2011 13:35:41 -0600
Message-ID: <1294083341-32147-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33933 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940Ab1ACTgN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jan 2011 14:36:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony <tony@atomide.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

omap_enable_smartreflex_on_init is meant to be used by boards
which would like to have SR enabled by default on the platform, while
omap_devinit_smartreflex is used by pm code, the protos are defined
in pm.h. This header should be included to ensure that sr_device
function definitions match the prototypes.

including pm.h fixes the sparse warnings (with CONFIG_OMAP_SMARTREFLEX=y):
arch/arm/mach-omap2/sr_device.c:138:13: warning: symbol 'omap_enable_smartreflex_on_init' was not declared. Should it be static?
arch/arm/mach-omap2/sr_device.c:143:12: warning: symbol 'omap_devinit_smartreflex' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Based on:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
branch: omap-for-linus

 arch/arm/mach-omap2/sr_device.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 786d685..b1e0af1 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -27,6 +27,7 @@
 #include <plat/voltage.h>
 
 #include "control.h"
+#include "pm.h"
 
 static bool sr_enable_on_init;
 
-- 
1.6.3.3

