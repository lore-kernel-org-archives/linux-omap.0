Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469447;
	b=lr0YQpcWHqV6Qccs2PA8p13jP5L3q3UR+UAD+pSdg0K7vU99jBVeIDUJS/qVrAeLAS2L
	 GMtTCGiR+FYuSceFygRk0HC0pCK8QB/z4ycvBV1HKbzGG4NT8B6llrG1Le7spt+sBNa9l
	 Whs8KeNkfMZoh9qk/XkY4OvWqn3ajYvUmXr68lP4vLiqZNRXlEACc9lmW0gqM+ux6UUor
	 BYOipQnuNkTE3WHXvHOZ2+unIBhANeUJvsMWnLUs9McA9bU1ELTvYaJF++F3xvR68DGMF
	 vPWwG0CfEQmxLG7mj0Tyd5qS2MlPAlXAlbn8FVQYZxNal9c039rRzKYHdgzrw0SJK0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469447;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:Subject:
	 Cc:To:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=kmQ9tCdfHJvODaaQiJY8VbOIwr70LOZMLlckjTphBqE=;
	b=5H3o0vXoNIWIwV9eiGlmPw/tDoZlf+2y4J9OxT4z/Yb25WRFSe//aNR6ieif1BSfpRpA
	 d+d0ZHZrbF7gX7qS4lqHcSXUO+VgwzigFRm5IPPFCRCF02y5MDmg+GYcUpr2gttMdzGvr
	 8CDMNJCP/JnHPdb1jitSmH/uktsLyiytD9hxQyhtgFHFXTfEdMnOayMTc9xsk2LKOxaxM
	 Z2i203hQxQ1YDJUpWQ+DHr/4MShPsNDmRH6wMq53pZuII2aLqh0n5mgxrY1oKhcEGJxIc
	 flytKBrwKuGyd7ZSgnbdYQI5Q7JIdqofbJSkhR4RXgpK4BFFjOgxqKDDwcW11g7WZjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qxWBGn5U;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B7606A31C;
	Thu, 12 Nov 2026 07:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B4B7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qxWBGn5U
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6B8F91A162A;
	Thu, 12 Nov 2026 07:43:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 394845FF85;
	Thu, 12 Nov 2026 07:43:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A761B11BC05A9;
	Thu, 12 Nov 2026 08:43:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794469436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kmQ9tCdfHJvODaaQiJY8VbOIwr70LOZMLlckjTphBqE=;
	b=qxWBGn5U7P1yTzXNaHcOOzcQZq/cFIGm7krSI+3Bi66X7rsB7bQq1hsuuju80p+MgL5JBm
	/r2GnHwH2uOCNh0G+cZq9ucouQ1Lq7gWIOSKnf5Zgs//geAQg8sGL+Yn/J0XsoBSP+wy9X
	rlaMgtg14HY7xLBBcCnBeZdrQr6ZwVbrI6/uOYtntDPksJbf2UuLNQevRxR3RjWGjli7Za
	4XeyRzOn804jwucyIf54TvFMmkm/PPSyZbJwcedjRnjoLT+DOt8j3soYsdVmTFaSDg+XlL
	OXvNJ2412KL1/8vQVlpQofV8u9fcLC4mnXzCXmzv8L56R0aByuvpqzHNfswM1g==
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 08:43:50 +0100
Message-Id: <DMT2BO0OMZAC.3IJ7D9NC2GQ0W@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2] drm/omap: dss: fix handling deferrals
Cc: <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>,
 <hns@goldelico.com>, <linux-kernel@vger.kernel.org>
To: "Andreas Kemnade" <andreas@kemnade.info>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
In-Reply-To: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Nov 11, 2026 at 10:14 PM CET, Andreas Kemnade wrote:
> Forward the error given by of_drm_get_bridge_by_endpoint() if it is
> EPROBE_DEFER to ensure output gets initialized later when available.
>
> On GTA04/OMAP3 no display was found, but it appeared after doing
> rmmod omapdrm ; modprobe omapdrm
>
> Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
