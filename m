Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2783DD87B;
	Tue,  7 Jul 2026 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419811; cv=none; b=UWCKXsJCqvio1vR3i6EqUiHzvcsdBf/+auT2/XcNmEBHlzJqGgD79Rjj3vxd6/YlQ7gm+qkWvi4znC5HQGNVLjB4LTvdbgSLROuGWNibWUYPwpOkZwN4NULcithRQ1r9OHRm6cQYak9AwRwyOzrItvnpk8Y3YHJQB2Hq0MiWiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419811; c=relaxed/simple;
	bh=U2u7jAuQkfGOb0//ZhA6kmltPPJ/DEDYcMSN5BtW15g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll4zfllqrxqFkjPmm2nO6WTjshpobbC0Nf8mEjICVh9qeWha9p0SI9eVcal8SN3c6ANEPbvvQAiJnm7m9KNL4s1xRDJAAoP9L4c1tgFuYQCuEYgLN0UFN4za4Dy0ArbCFtKYuRU+nqLb2cY5c5U2MPhrdYWtmVR0cD4NS5I42b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=LUCaGTc/; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="LUCaGTc/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=obUmEjH5cNC4iY8a13DKMFpXMZHqKjdWLwToyyedgkg=; t=1783419809; x=1784629409; 
	b=LUCaGTc/g08jkRBFervL3U7wJxYNT3wUrvj+1bZDbHWBK6oK3ZsSiBkOZ321jVpnT3cEcrQoTV/
	hrrsIQRpztqjAewuvC3uJB8BIY+YWI5pH5q/4uOoCl54GGL0usFbTAp7gP0RfiHpOX7Y0Hll/eFtk
	6Fl0ImaKDiw8hHg3X0j1aUC5+iP5MUcIM678AukUFlIsGbs553hqeV0BGzojJjeWRBNbRHzD/T4gm
	vxMJXAB7sI5r25EuQ0hGFsfd9o4xzLzzxKqztgLeKCkGWsF0Ther+0UbNcrcnRNAa0vsOqbY46QAp
	Mg61PfrGzLDIHPoq4ALPBJQITAme7DgSLKJw==;
Date: Tue, 7 Jul 2026 12:22:03 +0200
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
Message-ID: <20260707122203.0bbc973e@kemnade.info>
In-Reply-To: <4cb964d9-524d-40ec-8cd2-d936fff8eb85@gmail.com>
References: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
 <4cb964d9-524d-40ec-8cd2-d936fff8eb85@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 08:42:57 +0300
Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:

> Hi,
> With this version of the patch I see:
> 
> [  102.760894] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  303.860321] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  307.071624] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  307.360626] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  307.671142] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  308.660339] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  308.961059] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  313.191314] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  313.700378] DSI: omapdss DSI error: Failed to set dsi_if_enable to 0
> [  313.980346] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  314.791564] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  315.090362] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  322.850952] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  323.111175] DSI: omapdss DSI error: Framedone not received for 250ms!
> 
> while scrolling the (hildon)desktop on droid4, so I would say the change 
> broke command mode.
> 
so let me summarize:
- sending initialisation commands to video mode panel: no problem visible in
  any case, theretical problems (not seen with the tested panels if sending too much data, fixed via v4.
- command mode display: no picture and error messages without any bta sync (patch version 1).
- working display with send_nop() replaced by simply sending bta_sync() and not
  waiting for PACKET_SENT irq for short packets (v2).
- partly working display (with v4), (always waiting for PACKET_SENT)

so there are some situations when waiting for a packet completition is harmful.
In your case these were only siutations when short packets were sent.
Do you have a more complete log of v4 boott?
In the log for v1 which is not accessible anymore, there were other 
more informative timeouts visible.

But maybe as a wild guess also based on Sasikhos AI reviews, maybe
this helps:

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 3f22929c36e2..eb3cd0d23cae 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -3267,7 +3267,7 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
 	 * updates stop working. This is probably related to DSI spec stating
 	 * that the DSI host should transition to LP at least once per frame.
 	 */
-	r = dsi_vc_send_bta_sync(dssdev, vc);
+	r = dsi_vc_send_bta_sync(dssdev, VC_CMD);
 	if (r < 0) {
 		DSSWARN("failed to send bta sync between frames: %d\n", r);
 		goto err;



Then the call is equal to the original one done via send_nnop.

Regards,
Andreas
