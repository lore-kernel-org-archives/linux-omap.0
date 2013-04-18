From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: OMAP2+: Fix unused variable warning for am3517
 crane
Date: Thu, 18 Apr 2013 10:54:33 -0700
Message-ID: <20130418175433.7436.18512.stgit@muffinssi.local>
References: <20130418175303.7436.75241.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56641 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab3DRRye (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 13:54:34 -0400
In-Reply-To: <20130418175303.7436.75241.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

=46ix the following by removing the unused variable:

arch/arm/mach-omap2/board-am3517crane.c: In function =E2=80=98am3517_cr=
ane_init=E2=80=99:
arch/arm/mach-omap2/board-am3517crane.c:113: warning: unused variable =E2=
=80=98ret=E2=80=99

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-om=
ap2/board-am3517crane.c
index fc53911..0d499a1 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -110,8 +110,6 @@ static void __init am3517_crane_i2c_init(void)
=20
 static void __init am3517_crane_init(void)
 {
-	int ret;
-
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
