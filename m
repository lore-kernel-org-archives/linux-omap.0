From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@freescale.com>
Subject: [PATCH linux-next] ARM: OMAP2+: fix omap4-restart compilation
Date: Thu, 27 Jun 2013 14:26:00 +0200
Message-ID: <1372335961-31401-1-git-send-email-vincent.stehle@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:17014
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751566Ab3F0M0X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jun 2013 08:26:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@freescale.com>, Robin Holt <holt@sgi.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, trivial@kernel.org

=46ix following compilation error due to missing include file:

  arch/arm/mach-omap2/omap4-restart.c:21:28: warning: =E2=80=98enum reb=
oot_mode=E2=80=99 declared inside parameter list [enabled by default]
  arch/arm/mach-omap2/omap4-restart.c:21:28: warning: its scope is only=
 this definition or declaration, which is probably not what you want [e=
nabled by default]
  arch/arm/mach-omap2/omap4-restart.c:21:40: error: parameter 1 (=E2=80=
=98mode=E2=80=99) has incomplete type
  arch/arm/mach-omap2/omap4-restart.c:21:6: warning: function declarati=
on isn=E2=80=99t a prototype [-Wstrict-prototypes]
  make[1]: *** [arch/arm/mach-omap2/omap4-restart.o] Error 1

Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@freescale.com>
Cc: Robin Holt <holt@sgi.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>
Cc: trivial@kernel.org
---


Hi,

This fixes the build of linux-next for arch ARM, config multi_v7_defcon=
fig, tag
next-20130627.

Best regards,

V.


 arch/arm/mach-omap2/omap4-restart.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap4-restart.c b/arch/arm/mach-omap2/=
omap4-restart.c
index 652adde..41dfd7d 100644
--- a/arch/arm/mach-omap2/omap4-restart.c
+++ b/arch/arm/mach-omap2/omap4-restart.c
@@ -8,6 +8,7 @@
  */
=20
 #include <linux/types.h>
+#include <linux/reboot.h>
 #include "prminst44xx.h"
=20
 /**
--=20
1.7.10.4



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
