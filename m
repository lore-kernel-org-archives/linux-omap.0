From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv3 7/7] ARM: OMAP2+: mux: fix sparse warning
Date: Mon, 18 Jun 2012 00:16:17 -0600
Message-ID: <20120618061614.30632.26422.stgit@dusk>
References: <20120618061037.30632.28539.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55797 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab2FRGSa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 02:18:30 -0400
In-Reply-To: <20120618061037.30632.28539.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Shawn Guo <shawn.guo@linaro.org>

Commit bbd707acee279a61177a604822db92e8164d00db ("ARM: omap2: use
machine specific hook for late init") resulted in the addition of this
sparse warning:

arch/arm/mach-omap2/mux.c:791:12: warning: symbol 'omap_mux_late_init' was not declared. Should it be static?

Fix by including the header file containing the prototype.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 80e55c5..d3ef99c 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -41,6 +41,7 @@
 #include "control.h"
 #include "mux.h"
 #include "prm.h"
+#include "common.h"
 
 #define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
 #define OMAP_MUX_BASE_SZ		0x5ca


