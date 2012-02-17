From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] OMAP4: panda: Correct cpu version check for 4430
Date: Fri, 17 Feb 2012 11:27:41 +0200
Message-ID: <1329470861-29795-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:51189 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752253Ab2BQJ1x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 04:27:53 -0500
Received: by mail-lpp01m010-f49.google.com with SMTP id g1so4331040lah.8
        for <linux-omap@vger.kernel.org>; Fri, 17 Feb 2012 01:27:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The cpu_is_omap4430() macro always return with 0. Use the correct
cpu_is_omap443x() to check for Panda revision.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi,

Since the depending patches are going via Liam's tree it would be best if we
can queue this via audio as well.
Without this patch the audio on Panda 4430 is not working correctly.

Regards,
Peter

 arch/arm/mach-omap2/board-omap4panda.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index eada955..74db647 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -520,7 +520,7 @@ void omap4_panda_display_init(void)
 
 static void omap4_panda_init_rev(void)
 {
-	if (cpu_is_omap4430()) {
+	if (cpu_is_omap443x()) {
 		/* PandaBoard 4430 */
 		/* ASoC audio configuration */
 		panda_abe_audio_data.card_name = "PandaBoard";
-- 
1.7.8.4

