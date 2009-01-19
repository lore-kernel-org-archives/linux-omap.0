From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH] DSPBRIDGE Memory leak when dynbase is loaded
Date: Mon, 19 Jan 2009 11:00:18 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F220B869@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38278 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbZASRA3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 12:00:29 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

From: Omar Ramirez <x0084701@mmlinux.(none)>
Date: Wed, 14 Jan 2009 15:47:54 -0600
Subject: [PATCH] DSPBRIDGE Memory leak when dynbase is loaded

This patch fixes a memory leak that happens whenever
a dynamic base image is loaded and then the driver is
uninstalled.

Signed-off-by: Omar Ramirez Luna <x0084701@ti.com>
---
 drivers/dsp/bridge/dynload/cload.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/dynload/cload.c b/drivers/dsp/bridge/dynload/cload.c
index 271ab81..a6d7ae6 100644
--- a/drivers/dsp/bridge/dynload/cload.c
+++ b/drivers/dsp/bridge/dynload/cload.c
@@ -1806,6 +1806,8 @@ loop_end:
 		if (syms->Find_Matching_Symbol
 			(syms, LOADER_DLLVIEW_ROOT) == NULL)
 			syms->Deallocate(syms, root);
+		if (root != NULL)
+			syms->Deallocate(syms, root);
 	}
 #endif
 func_end:
-- 
1.5.4.3
