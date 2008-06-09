From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [Resend][PATCH] Fix for the i2c initialization error on 2430sdp
Date: Mon, 9 Jun 2008 11:55:06 +0530
Message-ID: <c656a4d20806082325u41572f75i980a9abc7a012d9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:45382 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbYFIGZI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 02:25:08 -0400
Received: by ti-out-0910.google.com with SMTP id b6so525648tic.23
        for <linux-omap@vger.kernel.org>; Sun, 08 Jun 2008 23:25:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Chandra shekhar <x0044955@ti.com>, Felipe Balbi <me@felipebalbi.com>, Eduardo Valentin <edubezval@gmail.com>

Hi all,

Resending the patch after incorporating comments from
Chandra , Eduardo Valentin and Felipe.

########################################################


>From ee2a6fd572c6d0464166fc8123982a38b36e7776 Mon Sep 17 00:00:00 2001
From: arun <arunedarath@mistralsolutions.com>
Date: Fri, 6 Jun 2008 18:18:50 +0530
Subject: [PATCH] Fix for the i2c initialization error on 2430sdp


Signed-off-by: arun <arunedarath@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c
b/arch/arm/mach-omap2/board-2430sdp.c
index e078a2a..780913e 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -379,8 +379,12 @@ static struct omap_board_config_kernel
sdp2430_config[] __initdata = {

 static int __init omap2430_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 400, NULL, 0);
+	/*
+	 * Registering bus 2 first to avoid twl4030 misbehaving as 2430SDP
+	 * has twl4030 on bus 2
+	 */
 	omap_register_i2c_bus(2, 2600, NULL, 0);
+	omap_register_i2c_bus(1, 400, NULL, 0);
 	return 0;
 }

-- 
1.5.3.4

#################################################
Regards,
Arun C
