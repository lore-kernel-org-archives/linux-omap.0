From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2] MAINTAINERS: add OMAP defconfigs under OMAP SUPPORT
Date: Mon, 19 Jan 2015 16:13:53 -0600
Message-ID: <1421705633-29056-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59159 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbbASWPQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jan 2015 17:15:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Felipe Balbi <balbi@ti.com>

omap2plus_defconfig and omap1_defconfig are also
part of the OMAP Support maintained, because of
that it's best to list them under OMAP SUPPORT on
MAINTAINERS so people know to Cc linux-omap when
patching them.

Reported-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Add omap1_defconfig too

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97de006f38f0..7423e9759187 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6783,6 +6783,8 @@ Q:	http://patchwork.kernel.org/project/linux-omap/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
 S:	Maintained
 F:	arch/arm/*omap*/
+F:	arch/arm/configs/omap1_defconfig
+F:	arch/arm/configs/omap2plus_defconfig
 F:	drivers/i2c/busses/i2c-omap.c
 F:	drivers/irqchip/irq-omap-intc.c
 F:	drivers/mfd/*omap*.c
-- 
2.2.0

