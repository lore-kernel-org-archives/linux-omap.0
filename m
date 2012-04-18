From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 3/3] ARM: OMAP4: board-omap4panda: Register platform device for HDMI audio codec
Date: Tue, 17 Apr 2012 19:40:46 -0500
Message-ID: <1334709646-8468-4-git-send-email-ricardo.neri@ti.com>
References: <1334709646-8468-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54514 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab2DRAk6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Apr 2012 20:40:58 -0400
In-Reply-To: <1334709646-8468-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Add platform device registratation for HDMI audio codec. This is to
be able to transmit audio through the HDMI output featured in Pandaboard
and PandaboardES boards.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index d8c0e89..07dd0e4 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -116,6 +116,11 @@ static struct platform_device panda_abe_audio = {
 	},
 };
 
+static struct platform_device panda_hdmi_audio_codec = {
+	.name	= "hdmi-audio-codec",
+	.id	= -1,
+};
+
 static struct platform_device btwilink_device = {
 	.name	= "btwilink",
 	.id	= -1,
@@ -125,6 +130,7 @@ static struct platform_device *panda_devices[] __initdata = {
 	&leds_gpio,
 	&wl1271_device,
 	&panda_abe_audio,
+	&panda_hdmi_audio_codec,
 	&btwilink_device,
 };
 
-- 
1.7.5.4

