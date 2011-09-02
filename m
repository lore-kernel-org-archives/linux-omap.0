From: Kevin Hilman <khilman@ti.com>
Subject: testing-board branch: rebase to RMK's devel-stable?
Date: Fri, 02 Sep 2011 11:06:52 -0700
Message-ID: <87vcta7r9f.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:58435 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753632Ab1IBSGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 14:06:55 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so4838205pzk.1
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 11:06:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Nicolas Pitre <nicolas.pitre@linaro.org>

Hi Tony,

Your testing-board branch currently has a couple new boards that are
missing the boot_params to atag_offset conversion (patch below.)

There's a patch below to fix this, but maybe it's better to just rebase
your testing-board branch onto Russell's devel-stable branch (where he's
merged the seris from Nico) so any board stuff we add is sure to do it
correctly.

Kevin


>From 4c5699a5feb1a037e1ae3147ca7d7e9fe3eb62c1 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Fri, 2 Sep 2011 11:00:12 -0700
Subject: [PATCH] OMAP: convert new boards to atag_offset

These boards were added after the bulk converson from boot_params to
atag_offset (queued for v3.2.)  Fix them up.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/board-omap3encore.c |    2 +-
 arch/arm/mach-omap2/board-omap4pcm049.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3encore.c b/arch/arm/mach-omap2/board-omap3encore.c
index eb70fe1..07ed8ab 100644
--- a/arch/arm/mach-omap2/board-omap3encore.c
+++ b/arch/arm/mach-omap2/board-omap3encore.c
@@ -338,7 +338,7 @@ static void __init omap_encore_init(void)
 }
 
 MACHINE_START(ENCORE, "encore")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap_encore_init_early,
diff --git a/arch/arm/mach-omap2/board-omap4pcm049.c b/arch/arm/mach-omap2/board-omap4pcm049.c
index d889110..260f2cb 100644
--- a/arch/arm/mach-omap2/board-omap4pcm049.c
+++ b/arch/arm/mach-omap2/board-omap4pcm049.c
@@ -578,7 +578,7 @@ static void __init pcm049_map_io(void)
 
 MACHINE_START(PCM049, "phyCORE OMAP4")
 	/* Maintainer: Jan Weitzel - Phytec Messtechnik GmbH */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= pcm049_map_io,
 	.init_early	= pcm049_init_early,
-- 
1.7.6

