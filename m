From: Kevin Hilman <khilman@ti.com>
Subject: arm-soc/next/boards: mis-merge breaks build on OMAP4/Panda
Date: Mon, 26 Mar 2012 17:05:17 -0700
Message-ID: <877gy6rjr6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:55002 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751431Ab2C0AFV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Mar 2012 20:05:21 -0400
Received: by mail-gx0-f175.google.com with SMTP id y3so4263557ggc.6
        for <linux-omap@vger.kernel.org>; Mon, 26 Mar 2012 17:05:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

Hi Arnd,

Looks like a conflict resolution in next/boards is causing a build
failure for OMAP4/Panda in arm-soc/for-next.

This merge:

  Merge tag 'asoc-3.4' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into next/boards

broke the build on OMAP4/Panda due to a missing ';' at the end of the
newly added panda_abe_audio platform_device.

Since you already sent the pull request to Linus, here's a patch on top
of next/boards to fix it.

Kevin

>From 3180f1d289b80dbe63f38931edd1245f10b619a0 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Mon, 26 Mar 2012 16:57:40 -0700
Subject: [PATCH] ARM: OMAP4: Panda: fix mis-merge build error

Merging some board changes from the ASoC tree with some board fixes
from the OMAP tree resulted in a minor mis-merge causing build failure
on OMAP4/Panda.  Fix it.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 7459844..7866749 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -114,7 +114,7 @@ static struct platform_device panda_abe_audio = {
 	.dev = {
 		.platform_data = &panda_abe_audio_data,
 	},
-}
+};
 
 static struct platform_device btwilink_device = {
 	.name	= "btwilink",
-- 
1.7.9.2





