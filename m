From: Colin Cross <ccross@android.com>
Subject: [PATCH] ARM: omap4: Enable keypad controller hwmod
Date: Wed,  4 May 2011 14:57:44 -0700
Message-ID: <1304546264-28922-1-git-send-email-ccross@android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:25950 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab1EDV6H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 17:58:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Colin Cross <ccross@android.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

The keypad controller hwmod was left commented out, but the
omap4-keypad driver requires it to function.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index abc548a..e1c69ff 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5109,7 +5109,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_iva_seq1_hwmod,
 
 	/* kbd class */
-/*	&omap44xx_kbd_hwmod, */
+	&omap44xx_kbd_hwmod,
 
 	/* mailbox class */
 	&omap44xx_mailbox_hwmod,
-- 
1.7.4.1

