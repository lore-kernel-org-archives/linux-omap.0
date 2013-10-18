From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 05/12] ASoC: davinci-mcasp: Change compatible property model to more accurate
Date: Fri, 18 Oct 2013 18:37:44 +0300
Message-ID: <5a00f98be6143547dedd0d3d73c3aa1fbbc2895c.1382110090.git.jsarha@ti.com>
References: <cover.1382110089.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48885 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756237Ab3JRPiJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Oct 2013 11:38:09 -0400
In-Reply-To: <cover.1382110089.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, joelf@ti.com, Jyri Sarha <jsarha@ti.com>

Change the model omap2-mcasp-audio in compatible property to
am33xx-mcasp-audio as omap2 does not have mcasp.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../bindings/sound/davinci-mcasp-audio.txt         |    2 +-
 sound/soc/davinci/davinci-mcasp.c                  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index c3ccde7..1945aec 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -4,7 +4,7 @@ Required properties:
 - compatible :
 	"ti,dm646x-mcasp-audio"	: for DM646x platforms
 	"ti,da830-mcasp-audio"	: for both DA830 & DA850 platforms
-	"ti,omap2-mcasp-audio"	: for OMAP2 platforms (TI81xx, AM33xx)
+	"ti,am33xx-mcasp-audio"	: for AM33xx platforms (AM33xx, TI81xx)
 
 - reg : Should contain reg specifiers for the entries in the reg-names property.
 - reg-names : Should contain:
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 2583802..08cceaf 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1033,7 +1033,7 @@ static const struct of_device_id mcasp_dt_ids[] = {
 		.data = &da830_mcasp_pdata,
 	},
 	{
-		.compatible = "ti,omap2-mcasp-audio",
+		.compatible = "ti,am33xx-mcasp-audio",
 		.data = &omap2_mcasp_pdata,
 	},
 	{ /* sentinel */ }
-- 
1.7.9.5

