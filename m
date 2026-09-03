Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E5372691;
	Thu,  3 Sep 2026 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428353; cv=none; b=BlPwC7kWkSjaoUmFfBUy5fRA2XOiUzfcoU4pgpMk/X20av0zl1XZYJLoRlydva1jSh1aGHppLYd88vXtTDCqoGwImEEc3ycoYk7XhxvNKRxdgSCXmt0RpAYxwDRaOHejWcU9Dvo6lwq3EfFhIqAsuFwDsS65jUuR13kuk8rfui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428353; c=relaxed/simple;
	bh=/XrhpQhgML/patl5tvbJhQokPqoO8e00UtkhqEtUdV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kQZTXK+ZQfiBFPEcLlupmyNk+J06QfX4gSf0TLW4v4jCiQTE4MJGXmesp+wUoxHc9hO9Gfn0tiu1cQdYOQIrSCW8AfROjRyBYj4hAjLHugaIjOI1yR7fZYa2pffwMemSok5owJCQCITp790q46WID3zK9Sw7VpT8y8BfOQTLWEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Zylaj5uB; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Zylaj5uB"
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4DDEE1CF5;
	Thu,  3 Sep 2026 11:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1788428251;
	bh=/XrhpQhgML/patl5tvbJhQokPqoO8e00UtkhqEtUdV8=;
	h=From:Date:Subject:To:Cc:From;
	b=Zylaj5uBmDePLy13C8G3W4nWg8Yf8O9V7PQfINx4dcm0+A0MTyujbIJOLxDKXMn8n
	 O0pCWn5V7P10WCxkYbXAQNKTXn8LMkLiPTHok24iA+yxWdogPEpHlKB/aKagc97d1x
	 mDU8LNrEWsvqC5xA1wkMOPCPuD/p6fiYkFPC4Uo0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 03 Sep 2026 12:38:40 +0300
Subject: [PATCH] ASoC: ti: omap-hdmi: Fix build error from a merge commit
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-omap-hdmi-fix-v1-1-b0447a1d35d5@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAB9AmWoC/yXM3QpAQBCG4VvRHJsaK7+3IgfsDkb5aRcpuXeLw
 +er773AsRV2UAYXWD7EyTJ7RGEAemjmnlGMNyhSKRUU4zI1Kw5mEuzkxKyjPGEVtRnl4D+rZT9
 /var+7fZ2ZL29EbjvB83f6r9xAAAA
X-Change-ID: 20260903-omap-hdmi-fix-7f085e21b708
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=/XrhpQhgML/patl5tvbJhQokPqoO8e00UtkhqEtUdV8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqmUAxLId3anRmnRy1ht1FIJ8xxfMn0whluUd7v
 veFq4f04wKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaplAMQAKCRD6PaqMvJYe
 9UvbD/9K5VxOI1QWJZ9kSRAwaGRKwHIwjvZscILiy9KJ/3Ab1TM6Hz3vCQoc0VU5g3XqZaDUk2O
 km7TptwQIRyz0NQLHslwEmHVFiNbfW++i2cWqZupvK/deMNy+VNox2gdda7PWTahgCB9hQL10+w
 JIabGzwzkEuLctrQd97S3T9nCHD893FTDp3ZBnoKzETwxvtKirD0sTLSMTyhcoa5eOXQSKFXnCq
 LaU7CAhxryaroZQHEIbX9Af0j+cGSG2VT+U5Ksce64YFIB2OAS5dBAraiMjk5iircoE2Nw8RHBs
 9VjYyTTji3rNow13D1lXEENogOuzVFqbb5pEbzO0ZUytUCV1APcnjReJ/80lpabhg7n2B0w6FDu
 rMut6n4F2R3LQI0VVw82rebxd8h7LHFMtfLwZd4CSMDev6281ufnPfh0R//gVnr8npJVi1BVHLa
 W0kZaKiuN6bsmnAKX8+cmYBXE1BVJ9wJFDuj2ad5kpHgllc8w9dqUv7MXd+eN0ZrJ85pzmk/C4g
 /4DsLRtsmynvYbkNp+aU8tgibyG1tHZGH40/lh0rj7gHZzsMb+XtXZ4PjIudH3tXXMXzznW+lUh
 DP3V/dOyk2NZeIMZlY8Nc9UgIExZA9F/y16AF6w8qFrett4f1div4+vMfWAP1t2F+f0YC6Yi/g+
 t/I3hqPhTua/zmA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

'ad->card' was removed in commit 9af2c1d4f847 ("ASoC: ti: omap-hdmi:
remove unused *card"), but commit 699e5975e2a5 ("drm/omap: Report HDMI
hotplug events to the ASoC HDMI codec") moved that code line. These
commits were applied to different trees, and the merge was not quite
right: assignment to 'ad->card' from the latter commit was left in the
file, causing:

sound/soc/ti/omap-hdmi.c:408:11: error: ‘struct hdmi_audio_data’ has no member named ‘card’

Fix the issue by removing the line.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/apbbvQSfUbzYRFaw@sirena.org.uk/
Fixes: 1ae7fe832c2d ("Merge drm/drm-next into drm-misc-next")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 sound/soc/ti/omap-hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
index c32ec7c0b0cf..2cabd4cc5b0b 100644
--- a/sound/soc/ti/omap-hdmi.c
+++ b/sound/soc/ti/omap-hdmi.c
@@ -405,7 +405,6 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	card->dev = dev;
 
 	atomic_set(&ad->jack_state, -1);
-	ad->card = card;
 
 	snd_soc_card_set_drvdata(card, ad);
 	ret = devm_snd_soc_register_card(dev, card);

---
base-commit: 97c594f71fa71dc30a0583a76d8b6ef5c5ea10b1
change-id: 20260903-omap-hdmi-fix-7f085e21b708

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

