Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802A3D5C2A;
	Fri, 31 Jul 2026 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499742; cv=none; b=ghr9uY2XeJgHBjzNI7vnif0aURpRnCnkMxxJCS5JRl0LYRAI5cy9VOkMoNd8l1iJYo3R/bhzgsCb1Z94bMLR66OIGGLHZ2xCxz0UFiSjft3PQWHq1OkB7dPWchicK6O0mdpyT1qbVG19xU+P3v2ggSlDsddJNfRVqOtFZhIoBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499742; c=relaxed/simple;
	bh=AuRUSBB3pt/bOHRKDJ15G3+SvfEoKU/WMN9UGRRsFxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/V0RsWKpOcSN+O5bbeSgHJCyFW0JIsv0wlLyli+WwBqg4F4P25kNJhR1rU2ZRHbdQXQ4RpqcbGwRKCiIvdlFRk18rPUU49bmpsslz4t7uss2dBA65a+pHR70YAXmFbUrDZvbt6rGoOe0JKIx36f96yhJGhm6aRfQ2mrhBSSmro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=U5tVT4O4; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="U5tVT4O4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=In-Reply-To:References:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=NX7y02AytQR/eBKRBBahNpRVTejIjfYTyHXAd68tZJc=; t=1785499741; x=1786709341; 
	b=U5tVT4O4CShQd+QW4EBXWvJUwXDko6x3kzaxqz4brjBNK6ZVBwig5T5WLD9rnnCsyZr3tJugPzs
	EEtLgmi1/D2I3KOuUaDTmeovHiN0Z7a8N3tmCpy2g/2CZfhGDsdjMLy3C6gAx0728aAM+m6lapvAc
	zFCBa/hrXRgwKOTSwqXQh7972EN7KvTzTPxg15b/pJ0R16PdsM3Djxx+dwyuVb0cO5Y9YPuy+8koK
	213M0TwCfzUiV5QccTRcwb//+SsOwyAzU3V2t6mVYboQKZDJNOknx/O+jsJP9orMevXKh0P7zjsO0
	H3L3aV8hhdgpDIKeKVw9RAOetVVv1FrSgsQA==;
Date: Fri, 31 Jul 2026 13:42:56 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>,
	hns@goldelico.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tony Lindgren <tony@atomide.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH v5] drm/omap: dsi: avoid sending bta sync all the time in
 writes
Message-ID: <amyKQNbemhTMKTk8@akepd>
References: <20260725165909.508612-1-andreas@kemnade.info>
 <39434782-9909-4bb4-b3da-a507acfc5e3d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39434782-9909-4bb4-b3da-a507acfc5e3d@ideasonboard.com>

On Wed, Jul 29, 2026 at 02:15:33PM +0300, Tomi Valkeinen wrote:
> > -	/*
> > -	 * TODO: we do not always have to do the BTA sync, for example
> > -	 * we can improve performance by setting the update window
> > -	 * information without sending BTA sync between the commands.
> > -	 * In that case we can return early.
> > -	 */
> > +	/* TODO: find out if more needs to be done for MIPI_DSI_MSG_REQ_ACK */
> > -	r = dsi_vc_send_bta_sync(dssdev, vc);
> > -	if (r) {
> > -		DSSERR("bta sync failed\n");
> > -		return r;
> > +	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
> > +		r = dsi_vc_send_bta_sync(dssdev, vc);
> > +		if (r) {
> > +			DSSERR("bta sync failed\n");
> > +			return r;
> > +		}
> >   	}
> 
> The dsi_vc_send_bta_sync() function does dsi_get_errors(), which we now
> don't always do here. I think that might cause any errors to be left there,
> which would trigger error handling on next read or write-with-bta.
> 
> _omap_dsi_host_transfer forward declaration can now be remove.

I will produce a v6, when I have the possibility to test again,
probably on Monday.
> 
> I don't have HW to test this, but other than the above, it looks reasonable.
> Although I have to say, based on my past experience, it's also very easy to
> break a use case =).
> 
Probably these usecases should use MIPI_DSI_MSG_REQ_ACK.

Regards,
Andreas
