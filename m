From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH] ASoC: Replace snd_soc_machine by snd_soc_card structure in
 SDP3430 machine driver
Date: Mon, 9 Feb 2009 17:57:00 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705D6175398@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50918 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbZBIX5K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 18:57:10 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel-request@alsa-project.org" <alsa-devel-request@alsa-project.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>

This patch replaces "snd_soc_machine" structure by "snd_soc_card" in
SP3430 driver. This change is needed in SDP3430 driver to reflect
changes introduced by "ASoC: Rename snd_soc_card to snd_soc_machine" patch
(875065491fba8eb13219f16c36e79a6fb4e15c68).

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/omap/sdp3430.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index ad97836..e226fa7 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -91,7 +91,7 @@ static struct snd_soc_dai_link sdp3430_dai = {
 };
 
 /* Audio machine driver */
-static struct snd_soc_machine snd_soc_machine_sdp3430 = {
+static struct snd_soc_card snd_soc_sdp3430 = {
 	.name = "SDP3430",
 	.platform = &omap_soc_platform,
 	.dai_link = &sdp3430_dai,
@@ -100,7 +100,7 @@ static struct snd_soc_machine snd_soc_machine_sdp3430 = {
 
 /* Audio subsystem */
 static struct snd_soc_device sdp3430_snd_devdata = {
-	.machine = &snd_soc_machine_sdp3430,
+	.card = &snd_soc_sdp3430,
 	.codec_dev = &soc_codec_dev_twl4030,
 };
 
-- 
1.5.4.3
