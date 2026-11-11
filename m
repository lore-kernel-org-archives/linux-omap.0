Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431689;
	b=tEn80JYl63ADs2YNltwlhMrZ1XTwhbZQWRIe6LFHHtM1mubielCWWk6CURI/t4dTVEkx
	 bHBunR2V17xoIR9atVJr01iyJm7hVjouE8ZvDJzrTQLMs5029fBQcbt/ss3E2LzVB/Pn5
	 cxycHzyMMl9FWFU4EnzEz6o6yKtUzPC/eLlkx7sXwNa4aSEVdQoyyUwa8ZW45RflcVit6
	 HAAK+9jUZI3Mj/RXqRXdPWrMA27iDqX2uGPC/b6OxOpH4lASOi4lU6geAz6HboMCdOLBL
	 3tJBArZ7YzoqME+rAD4TdbZlssudB0hTGB8dmXP4QmVJfXzcUvYS5VP7W7RIHerHbJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431689;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YZA0mL/g+XaMvzLe7dWFyFSxxKt5KDjWkQKQzVStFdo=;
	b=oqjVn4+0bhi+hzce5xdHEpmySHLe7GRGjbFNYPgdFC0IJJBiq5AUJgCuGhZWp+W6Im4L
	 zBbuldaem8+NlKb71yz+slgLhBhdWnJRAaYLdkqUpt1stKhrgyDmUEMLn2kAZNb4t/3CL
	 a8VDWCfT6y+MyotRPIT3yHi8VOD8bux53SQN3ugExyD0+6cmQuPnL2t24q+uPaLW5M7vk
	 4yGNLg70YPmBESFOWNFwuRkX4gCDJLA+KOqCnTeLFzwx8rwH0G8FWQ2hAY350ovnmHQ0E
	 c694Psbi1zNh2+A/pm3okiTUkBaq6RgMP8uKqWnYNws9eubHC/BiNuj+lYYWPTtATQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=a+HGgVlg;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94A606A31C;
	Wed, 11 Nov 2026 21:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA94A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=a+HGgVlg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=YZA0mL/g+XaMvzLe7dWFyFSxxKt5KDjWkQKQzVStFdo=; t=1794431688; x=1795641288; 
	b=a+HGgVlgzoRDc3jQLlPI6rHDIAMdRF24ca9hPGAzb7LtSUM+CF33QBndFyiR9BOxpRwtoG0jOCE
	mepHqKKbDy9DJF1yDNnFtThteMsMv6wCgd8iErkcli0qMOQtALA8t28Co4Kz/ZhPILCmNpG56k13D
	FDc8DOCrcH2bjA1TTCU98XMYknMNbn2o00rHlkN4+Wt/FJhCnqrBVUW2TV5MG4daQvgqZoOIay03R
	iSJXfdUPuKPUlifWoo8RtViNMO/OdNhKaXoBeE20NN4pyX1uda3+Dh15Y0Ml0BoP3i0XjVDHWmL1T
	ywT/IjoWgdgpjBNBrpGUe2VM87CVT7NgQtBw==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 11 Nov 2026 22:14:02 +0100
Subject: [PATCH v2] drm/omap: dss: fix handling deferrals
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
Message-Id: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAJna9GoC/42NTQ6CMBCFr0Jm7RhaoSSuvIdhUegURmMxUyQaw
 t1t8QLOrL6X97NCJGGKcC5WEFo48hQS6EMB/WjDQMguMehSG5UOh9mWFTp5oNAgFHMAPb/RN+R
 r1RtD7gQp/hRK8l59bX8cX92N+jn3ZcfIcZ7ks28vKvv+mFkUpnekG1d3tjL2cqdHsI6OHPwE7
 bZtXzMUpenVAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=K1/4nD/blrdt+2IR2NBi2vL6dVXYJQk3uUPTTqOJMN4=;
 b=kA0DAAoBhGFF+kAo3PEByyZiAGr02pygYASQbIaOAroFim6KIiMDqNJTEu+EB3RlC6JZu8djR
 4kCMwQAAQoAHRYhBNjrEJkvRMQTVcd8WIRhRfpAKNzxBQJq9NqcAAoJEIRhRfpAKNzxrPEP/1LO
 z9iYICL7nom1ymbXEbuEKu20tqWn7eVXIBr4I+ceFI5mjKUatVEmYmFHWS+J+E0DtU6ls+Ybf1p
 nyVK2W7UACJ2DotrtKLGdphTcyRuyXpzqLdQtviI/fMOTq/VGJr3dsiy45r3JTcx6ezxOEAkW9b
 5mwQGwtpa4SQYrgBs93DuEb5tOEjLM7Kg9pvqGE39jeUC3K+8wan2YkLR9v4sMiFxKkvM8GGPoY
 hQrZUBmS+luTG6mNMrQfbY6cyOf/s1IFFCZso6441UIj/XF9MSxPS2TR3QFAyLXCSNOYISy4i5T
 MScssy2ZyxFspdtiSQZn/JS0tBHv6JhaxScHbCz8GAwOji0Qxjo0Nqk4UodBn1wt8mcfGyplzLr
 pfIiqqPpeCl8DToFqeuEUEdjxeSHtiT/FEJyUAoCbnv9e8LitSQ5CyPfUynKxH9KOhpEy9eXg8L
 rblKMqyj/Drb3EbUE6XRXr1XJIlRzD1Jq5by+bp3i9hvkGtuCxLPjJ/2fHpmh1iHufrTML4HOPJ
 1qcccX5fa3QIhh/FHs8XCpI1veksy/BDxVoBDdAb1066gNR00NKsL3YQa5R0IwKXtB/hhBxV3i3
 mjh6brmjri+P5E/AkkLagifMcyTSl0eMJjzcDIx80ByTamb3Rgu/Uhs9TyEPGf42uwOrev3+m7q
 CZGGG
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Forward the error given by of_drm_get_bridge_by_endpoint() if it is
EPROBE_DEFER to ensure output gets initialized later when available.

On GTA04/OMAP3 no display was found, but it appeared after doing
rmmod omapdrm ; modprobe omapdrm

Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
- do not use the error goto
- Link to v1: https://patch.msgid.link/20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info
---
 drivers/gpu/drm/omapdrm/dss/output.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
index 36d37deac8026..b5cef5093a883 100644
--- a/drivers/gpu/drm/omapdrm/dss/output.c
+++ b/drivers/gpu/drm/omapdrm/dss/output.c
@@ -24,6 +24,9 @@ int omapdss_device_init_output(struct omap_dss_device *out,
 
 	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
 	if (IS_ERR(bridge)) {
+		if (PTR_ERR(bridge) == -EPROBE_DEFER)
+			return PTR_ERR(bridge);
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

