From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 14/17] DSPBRIDGE: KFILE_Seek & KFILE_Tell, u32 replaced with loff_t
Date: Tue, 15 Dec 2009 00:19:55 -0600
Message-ID: <1260857998-19349-15-git-send-email-omar.ramirez@ti.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43254 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbZLOGMw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 01:12:52 -0500
In-Reply-To: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

KFILE_Seek & KFILE_Tell, u32 replaced with loff_t

Discovered-by: Ameya Palande <ameya.palande@nokia.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/cod.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index a85f2a7..1ebbe8d 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -199,7 +199,7 @@ static s32 COD_fRead(void __user *pBuffer, s32 cSize, s32 cCount,
 
 static s32 COD_fSeek(struct file *hFile, s32 lOffset, s32 cOrigin)
 {
-	u32 dwCurPos;
+	loff_t dwCurPos;
 
 	/* check for valid file handle */
 	if (!hFile)
@@ -217,7 +217,7 @@ static s32 COD_fSeek(struct file *hFile, s32 lOffset, s32 cOrigin)
 
 static s32 COD_fTell(struct file *hFile)
 {
-	u32 dwCurPos;
+	loff_t dwCurPos;
 
 	if (!hFile)
 		return DSP_EHANDLE;
-- 
1.6.2.4

