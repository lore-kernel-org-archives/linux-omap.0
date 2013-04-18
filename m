From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: OMAP2+: Fix is_gpmc_muxed warning for H4
Date: Thu, 18 Apr 2013 10:54:35 -0700
Message-ID: <20130418175435.7436.60372.stgit@muffinssi.local>
References: <20130418175303.7436.75241.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56704 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab3DRRyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 13:54:36 -0400
In-Reply-To: <20130418175303.7436.75241.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

=46ix the following error by moving the function to be within
the smc91x related ifdef as that's the only user:

arch/arm/mach-omap2/board-h4.c:238: warning: =E2=80=98is_gpmc_muxed=E2=80=
=99 defined but not used

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-h4.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board=
-h4.c
index 69c0acf..f745cae 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -229,6 +229,8 @@ static u32 get_sysboot_value(void)
 		 OMAP2_SYSBOOT_1_MASK | OMAP2_SYSBOOT_0_MASK));
 }
=20
+#if IS_ENABLED(CONFIG_SMC91X)
+
 /* H4-2420's always used muxed mode, H4-2422's always use non-muxed
  *
  * Note: OMAP-GIT doesn't correctly do is_cpu_omap2422 and is_cpu_omap=
2423
@@ -246,8 +248,6 @@ static u32 is_gpmc_muxed(void)
 		return 0;
 }
=20
-#if IS_ENABLED(CONFIG_SMC91X)
-
 static struct omap_smc91x_platform_data board_smc91x_data =3D {
 	.cs		=3D 1,
 	.gpio_irq	=3D 92,

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
