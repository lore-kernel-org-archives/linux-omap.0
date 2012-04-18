From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 2/3] ARM: OMAP4: board-4430sdp: Register platform device for HDMI audio codec
Date: Tue, 17 Apr 2012 19:40:45 -0500
Message-ID: <1334709646-8468-3-git-send-email-ricardo.neri@ti.com>
References: <1334709646-8468-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54515 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab2DRAk6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Apr 2012 20:40:58 -0400
In-Reply-To: <1334709646-8468-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Add platform device registratation for HDMI audio codec. This is to
be able to transmit audio through the HDMI output featured in SDP4430
and Blaze boards.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index a39fc4b..3f26da2 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -383,6 +383,11 @@ static struct platform_device sdp4430_dmic_codec = {
 	.id	= -1,
 };
 
+static struct platform_device sdp4430_hdmi_audio_codec = {
+	.name	= "hdmi-audio-codec",
+	.id	= -1,
+};
+
 static struct omap_abe_twl6040_data sdp4430_abe_audio_data = {
 	.card_name = "SDP4430",
 	.has_hs		= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
@@ -417,6 +422,7 @@ static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_vbat,
 	&sdp4430_dmic_codec,
 	&sdp4430_abe_audio,
+	&sdp4430_hdmi_audio_codec,
 };
 
 static struct omap_musb_board_data musb_board_data = {
-- 
1.7.5.4

