From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] staging: ti dspbridge: remove contributor leftovers
Date: Sun,  4 Jul 2010 16:31:47 +0300
Message-ID: <1278250307-16880-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39559 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757524Ab0GDNb5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 09:31:57 -0400
Received: by bwz1 with SMTP id 1so2294646bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 06:31:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Felipe Contreras <felipe.contreras@gmail.com>

The old history (before git) had these two character ids that never
stood any chance to identify anybody.

Nobody from that list was moved to the good list of contributors, so
let's get rid of it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .../staging/tidspbridge/Documentation/CONTRIBUTORS |   37 --------------------
 1 files changed, 0 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/tidspbridge/Documentation/CONTRIBUTORS b/drivers/staging/tidspbridge/Documentation/CONTRIBUTORS
index b40e7a6..86f5787 100644
--- a/drivers/staging/tidspbridge/Documentation/CONTRIBUTORS
+++ b/drivers/staging/tidspbridge/Documentation/CONTRIBUTORS
@@ -43,40 +43,3 @@ Please keep the following list in alphabetical order.
 	Armando Uribe de Leon
 	Nischal Varide
 	Wenbiao Wang
-
-
-
-The following list was taken from file Revision History, if you recognize your
-alias or did any contribution to the project please let us now, so we can
-proper credit your work.
-
-	ag
-	ap
-	cc
-	db
-	dh4
-	dr
-	hp
-	jg
-	kc
-	kln
-	kw
-	ge
-	gv
-	map
-	mf
-	mk
-	mr
-	nn
-	rajesh
-	rg
-	rr
-	rt
-	sb
-	sg
-	sh
-	sp
-	srid
-	swa
-	vp
-	ww
-- 
1.7.1

