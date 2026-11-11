Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399749;
	b=SGA++aRpHvjASMwEToaSjM1ujuA0r2oPWD7aFvdXrbArRcP95cYfIVA5sLe+qRX31jrN
	 NGTENNygltPxVCimvtbH3YEdKCSJn+SCi5cYqU2FDIJOFDnt+dETDy7qVPMWlMMqIhJP8
	 yfWTRJnl07HE8jlh8UEnZ+bLqLcRb/dG8ESKkHyU4m4PKMJZ7HO2pTMHlsX1lBvVGHR5p
	 Wh3fIaqvAVkg+7n5xamWb9S6egoNh7neq6JInkbUwgzJQqh00P7Gtdy//+N8Wl3W05oC+
	 t5IXno1AxXz0KeMeG0+9cP1oga+lVypncBwcvhtTs/PE5cSX4iTkiDQ+lsVuRh33+ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399749;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mZ+YfTL18HsVdL8YZNUUTUPVwVk+UCUNOsnK/2xOcPE=;
	b=tK+4VOXIH+mpbM0MqZgG0dmwJouzVsS4gN/Qn3ZhA2/HGoCnkBvTN7cQsBTxznLJameS
	 e9fzdz+0hkOQfwuGGuAUFT1lId58rlVY5y8EEEOIpzdN48KUZsnJO7JIlzLmU3vCxZ4iI
	 F4l3ultOgqa52qfOAV8VmEGgUUO0J4YvFWqx2ybXQwu+QVXtoe5tGej0R9TjpDaRhcFtC
	 GFJEx/s4ga2dNwDHT67naPGXL52H4tw5d3X59YFaNYF0sVSSF2lQT7Fji6PZgzXw7V+mQ
	 2STUOA7g50LOnsmZxAAP9/f4mcPCW4pePaUJnvfdH5OrRRmarFDrAukXJiQ/xjgce5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b="98yA7/rY";
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E66606A31C;
	Wed, 11 Nov 2026 12:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08E66606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=98yA7/rY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=mZ+YfTL18HsVdL8YZNUUTUPVwVk+UCUNOsnK/2xOcPE=; t=1794399748; x=1795609348; 
	b=98yA7/rY5tVXkL/dXyV/8rM0XOg+E+BkAypKgfd2Y2VnA6JJNMhArVshgkZaYQr5bri1WzPeoWN
	75IhOEFVG2BYxViR5eAYxZPu6pPIgHv2u2D/emGoqL8gJT+Fu9oX7gCcb5K7pqcky4XsiyJ1B9WB5
	nJv0Psws/eO2viTnfyvTXn1QjKb+Iv7naVwfoUFnRAHw/lxxjIzlAPhkKQyv3KZr8GtUtPuJcNGIh
	LNQevjzDl/asn3t4YXoq4HoYmAr0dm+Fv0vk6DpmSwQ8s9RTnu0fFFSe1tFF7bDpT8Y8pKc7XHmVT
	XQJm3JwXFnX/DTLittiHawMk6Xl6Zo78EmUg==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 11 Nov 2026 13:22:11 +0100
Subject: [PATCH] drm/omap: dss: fix handling deferrals
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAPJd9GoC/yWMQQrCQBAEvxLm7EA2mhX8iniIu73rCEaZiSKE/
 N2J6Vs1VM1kUIHRqZlJ8RGT5+gQdg2l2zBWsGRn6touBh/XaWgPnPXBiqqwVeAiXy5HlD6kGJH
 35PpL4fc/fb5sbO/rHWlae7QsPw+508t8AAAA
X-Change-ID: 20261111-gta04-drm-regression-fix-f7ef51c66ed3
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, 
 hns@goldelico.com, linux-kernel@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=31k+GywuKgPH1aDOshD9a7rFWejPIZkjp23zr87NNVg=;
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBq9F30t+ptQJ6jh9qwz4SprN0rYuR4nyZ+wkvG9
 gr8MkjFxXOJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCavRd9AAKCRCEYUX6QCjc
 8QnKD/9RKTKkv0Rq2ZMvV5gBRp96kAyV2MVJVCMndbsN887x6didR2tVVzbsNalj5tO9+76jqcb
 IiXMci1nh/1kiW4brbIEigNLHEMgOOrvdL9yPyS+HuFhxpniZF/0bMJZqv0q0MBDh4GEiBfwwVc
 pBCygKmQQQ0X1d8LApBx202hdIRIHayWgHeJF8eLWcJxSLTj6mVknGZueT/0tcGMiNG5+YCEDy8
 VuQWHDE8uTIcbOFTy1vwRsVQitlG3OB5oEQHSZ5MsGl/qgVrbjTwuivic4QAUIYIoe3snm45ANf
 8fNJkzlCYKe03SQyTsfQDq3xwoouVIaVvUZXtQ8x24QqFBBbW/ZOCaahnP2FriVFLvRdIKC122Q
 HAz/wRlDeduGOskFJ30Aiu9xs9KZRcmUXHiAjs9E8XZHbEYYAhfYQjvBkSZhrqPOltcz7wfjD6K
 QmM9+qC/+tB/Ep0ErbIHAZ+VIfrST7Bx6Wxnq4go+lXus3ssqNl06p9bSnYES3j1ulkr1q1/Q0i
 qD1ojcR7q88zQQK0raxZF3wZWuwhVpok9fJ2644hpOOj7k4LLZKqOl2tkemx0f0QFhG0hLoUKo/
 hnRRekIFO7GgZXkSQHFy07kGovv/JUeLRRvvsIteMzZxzkOSaW5naA9jC5ZwfAGR25Fr70QrGN6
 YkKMbmZd3FqAJsA==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Forward the error given by of_drm_get_bridge_by_endpoint() if it is
EPROBE_DEFER to ensure output gets initialized later when available.

On GTA04/OMAP3 no display was found, but it appeared after doing
rmmod omapdrm ; modprobe omapdrm

Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/omapdrm/dss/output.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
index 36d37deac8026..220ed7e003080 100644
--- a/drivers/gpu/drm/omapdrm/dss/output.c
+++ b/drivers/gpu/drm/omapdrm/dss/output.c
@@ -24,6 +24,11 @@ int omapdss_device_init_output(struct omap_dss_device *out,
 
 	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
 	if (IS_ERR(bridge)) {
+		if (PTR_ERR(bridge) == -EPROBE_DEFER) {
+			ret = PTR_ERR(bridge);
+			goto error;
+		}
+
 		dev_dbg(out->dev, "failed to find video sink\n");
 		return 0;
 	}

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261111-gta04-drm-regression-fix-f7ef51c66ed3

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

