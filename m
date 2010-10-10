From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] staging: tidspbridge: remove memory consistency from TODO list
Date: Sun, 10 Oct 2010 20:40:40 +0300
Message-ID: <1286732440-28644-4-git-send-email-felipe.contreras@gmail.com>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63650 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab0JJRlC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Oct 2010 13:41:02 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so1272773bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 10 Oct 2010 10:41:01 -0700 (PDT)
In-Reply-To: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Arnd Bergmann <arnd@arndb.de>

The mempool area is not handled by the kernel any more.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/TODO |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/tidspbridge/TODO b/drivers/staging/tidspbridge/TODO
index 187363f..54f4a29 100644
--- a/drivers/staging/tidspbridge/TODO
+++ b/drivers/staging/tidspbridge/TODO
@@ -13,7 +13,6 @@
 * Audit and clean up header files folder
 * Use kernel coding style
 * checkpatch.pl fixes
-* allocate ext_mem_pool from consistent memory instead of using ioremap
 
 Please send any patches to Greg Kroah-Hartman <greg@kroah.com>
 and Omar Ramirez Luna <omar.ramirez@ti.com>.
-- 
1.7.3.1.2.g7fe2b

