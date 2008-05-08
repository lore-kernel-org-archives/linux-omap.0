From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/11] ARM: OMAP: Keymap fix for palmte and palmz71
Date: Thu,  8 May 2008 15:49:30 -0700
Message-ID: <1210286975-29506-7-git-send-email-tony@atomide.com>
References: omap-fixes-2008-05-08-154932
 <1210286975-29506-1-git-send-email-tony@atomide.com>
 <1210286975-29506-2-git-send-email-tony@atomide.com>
 <1210286975-29506-3-git-send-email-tony@atomide.com>
 <1210286975-29506-4-git-send-email-tony@atomide.com>
 <1210286975-29506-5-git-send-email-tony@atomide.com>
 <1210286975-29506-6-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61485 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761640AbYEHWtr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 18:49:47 -0400
In-Reply-To: <1210286975-29506-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>, Tony Lindgren <tony@atomide.com>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Keymap fix for palmte and palmz71

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-palmte.c  |    2 +-
 arch/arm/mach-omap1/board-palmz71.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index ca1a4bf..a0b16a7 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -63,7 +63,7 @@ static const int palmte_keymap[] = {
 	KEY(1, 1, KEY_DOWN),
 	KEY(1, 2, KEY_UP),
 	KEY(1, 3, KEY_RIGHT),
-	KEY(1, 4, KEY_CENTER),
+	KEY(1, 4, KEY_ENTER),
 	0,
 };
 
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 1565107..e020c27 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -65,7 +65,7 @@ static int palmz71_keymap[] = {
 	KEY(1, 1, KEY_DOWN),
 	KEY(1, 2, KEY_UP),
 	KEY(1, 3, KEY_RIGHT),
-	KEY(1, 4, KEY_CENTER),
+	KEY(1, 4, KEY_ENTER),
 	KEY(2, 0, KEY_CAMERA),
 	0,
 };
-- 
1.5.3.6

