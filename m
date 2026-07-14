Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75697356A0D;
	Tue, 14 Jul 2026 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046684; cv=none; b=i8eZv7XNDEX+vyy/NOc/LUGGl/PjzXDyKpmZuVrWC34IRzA6MlgSdxOP+dCBCVYKf5O5xeb22BNBU/CoG0wGcGpYWR6AzV0FGefNeDDKZ4BUywhDH5GVpGbUdxAh/Ir7FfK18i0jnoonCEmKCNBqsmpLphcclY6r3HkkFMO+4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046684; c=relaxed/simple;
	bh=2n0X9spLPWBQQwUy4KQUYXZv4lUuIOLjI5LbZgdT8ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEQM4KxrtlZATkcu+Le5aWEjzPlm3mtKAaaXh2RGeKeQ/7t6Tj9wSyfwfLkXrp8bsDOong4TNVHIjI6CG6IiHcCx7Fvp1Hy3iiLpLGjTthjCfhiHJ8yEYotSDNTPPWaDILPaYRRiBmwPDTg3AKHuHhvfMRxlAEM+U+i7tIO8nJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=mJn6bOF2; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="mJn6bOF2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=zLaxl7OxlxMFCnSPhkyE01FY6akqGQYk1tPfRA+r0DA=; t=1784046682; x=1785256282; 
	b=mJn6bOF2H9cZ6Hl/k3bPneqNfhD8oKZ+sLAXTacR2zY5Db9Nu+qAfBq4qiDPBgZE7XdAb/7CPw/
	dhM1eEifvdrIGblI8AJLDVZ3BcVWiebVM/mR3LgiRXsB5uLpDpspqcG5EOHTsFbTahH9EpLYppqIo
	YUBEmmBev/X+YCgz0GHONRLSMzyhA7AJ8Ky+uds170OdRcwBMoA+Hq/HH3CMkU8EwYFKg4dUI/TcA
	D8fFO7M5mYk0UqsQt0cH6X1JMLCIhQ1foh9BphyCacYahswjtSltGFCwPp9gQsQgc1d0SMMV1r9QZ
	OCkyj0BqzGOkw/fajIA0aZExF0SkOhmsVLeg==;
Date: Tue, 14 Jul 2026 17:53:37 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>, "H.
 Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4] drm/omap: dsi: avoid sending bta sync all the time
 in writes
Message-ID: <20260714175337.4ad430fc@akphone>
In-Reply-To: <24368e1c-171f-4f6b-80f8-58accab1d3be@gmail.com>
References: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
	<4cb964d9-524d-40ec-8cd2-d936fff8eb85@gmail.com>
	<20260707122203.0bbc973e@kemnade.info>
	<24368e1c-171f-4f6b-80f8-58accab1d3be@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; aarch64-alpine-linux-musl)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jul 2026 22:07:53 +0300
Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:

> > 
> > diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c
> > b/drivers/gpu/drm/omapdrm/dss/dsi.c index
> > 3f22929c36e2..eb3cd0d23cae 100644 ---
> > a/drivers/gpu/drm/omapdrm/dss/dsi.c +++
> > b/drivers/gpu/drm/omapdrm/dss/dsi.c @@ -3267,7 +3267,7 @@ static
> > int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
> >   	 * updates stop working. This is probably related to DSI
> > spec stating
> >   	 * that the DSI host should transition to LP at least
> > once per frame. */
> > -	r = dsi_vc_send_bta_sync(dssdev, vc);
> > +	r = dsi_vc_send_bta_sync(dssdev, VC_CMD);
> >   	if (r < 0) {
> >   		DSSWARN("failed to send bta sync between frames:
> > %d\n", r); goto err;
> > 
> > 
> > 
> > Then the call is equal to the original one done via send_nnop.
> >   
> 
> With that change it seems to work properly, will keep that version of 
> the driver for the time being.

will send a v5 with this change included

Regards,
Andreas
