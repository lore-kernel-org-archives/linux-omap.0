Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483336;
	b=pFFrmPujYoAvt2wEYUGUy1Ts1Jyq6ngeBDUDn0BQh5Lh9o1sZ0zeio+5FwovfIz/yXQA
	 +LmK2H3HieHY5ztR5RAbft/oy+UnA7UvufddC/Wh41g8fSysKMVboPhk/3WU6yLdZeI3/
	 YVBW3II5bA77IDIN5JoS3YX+XmW7WeJKlLWnewh4VQhSgfdMf2wiiYHf1l1xHWTKoBh3a
	 5EurEm/BDiG4RqL3akEyenutvuOASUbrRfu5trXp9cLR1eCssWhqgngjIqm/xzyjTfiT/
	 g04Nsy23pSREWcUqDNAsk47gFkCYmHgfGsB0Vvf6HP1QjVwnLSlKrHqASPYOChkJHnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483336;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EPcJkEv6Mv9K5uRm29JHqDQ1ukD6n2G1FK8ZkT2iuVE=;
	b=Nsalad3bQ4jo/GIvjHPjP/h1KWlCkn2ugzbR/YrBc8jdmWaLQB/u6rXlO64hZDdzuB46
	 FOlO/Pa/xp/+QdaeqCaSCBPCguhaWtT2jvWmuJzXAwA/vuwdaPg7kE1oSRPJ/vT/JoR+S
	 NPDbHEkGQVGuxGzubZkHqFu6NKSS8/RyZ61ZKeqZWjn7j0kwvt4YhIQKV5HwuFLTiCjb0
	 eB+Ocy0yvVfY8vYWoqXcRzrVmHlv04K72P2GTl3nOmLpT/RHSA200N+XjIds9Q2aSuX0h
	 5srrsZ9iZed0JCWQ2GtEndCx6v7wuO/8XUAaX1JVLtnmKQi9Q/0px/G/LYcuE/TClSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=0fe1SDEf;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC7606A31C;
	Thu, 12 Nov 2026 11:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1FC7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=0fe1SDEf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=EPcJkEv6Mv9K5uRm29JHqDQ1ukD6n2G1FK8ZkT2iuVE=; t=1794483335; x=1795692935; 
	b=0fe1SDEfB9b2igjfKc7fzsFKJNemg5u0zOwnfPtbIWkuobtQVwNUHWpUaraw/maTeD+93V+qMSb
	7akUkWxvGjdggGbn3ZI9TdypIxIr1eERjeBftGtq7LRXHGHr20lFPjbTzPoz1uEZUIhcnnFITrchE
	O53PvWmnPvqHmwOYoyXUCC08i+B5cZqiNt+uPXRNOm1cLyGrr13dybIdoU9BmHQtqkAWSPzhPILTA
	d6sWnTD9OkMear1GHkLcKWW0OHGqKQfSYQXejti7F9mNhgQ158uk510Am3Gm8susOOv8fUobmlcmO
	eXVW00vp6F2zlm3XCF1EyNvsbcb8ICKbzZYQ==;
Date: Thu, 12 Nov 2026 12:35:22 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
 hns@goldelico.com, linux-kernel@vger.kernel.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2] drm/omap: dss: fix handling deferrals
Message-ID: <20261112123522.09ef73fd@kemnade.info>
In-Reply-To: <e93d1911-a6d9-4256-a2cb-cd2d6112a4c0@ideasonboard.com>
References: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
	<e93d1911-a6d9-4256-a2cb-cd2d6112a4c0@ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 12:25:20 +0200
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> Hi,
> 
> On 11/11/2026 23:14, Andreas Kemnade wrote:
> > Forward the error given by of_drm_get_bridge_by_endpoint() if it is
> > EPROBE_DEFER to ensure output gets initialized later when available.
> > 
> > On GTA04/OMAP3 no display was found, but it appeared after doing
> > rmmod omapdrm ; modprobe omapdrm
> > 
> > Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v2:
> > - do not use the error goto
> > - Link to v1: https://patch.msgid.link/20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info
> > ---
> >   drivers/gpu/drm/omapdrm/dss/output.c | 3 +++
> >   1 file changed, 3 insertions(+)  
> 
> Thanks, I'll push to drm-misc-next.
> 
Isn't it drm-misc-fixes? This issue is new in v7.4-rc1.

Regards,
Andreas

>   Tomi
> 
> > diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
> > index 36d37deac8026..b5cef5093a883 100644
> > --- a/drivers/gpu/drm/omapdrm/dss/output.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/output.c
> > @@ -24,6 +24,9 @@ int omapdss_device_init_output(struct omap_dss_device *out,
> >   
> >   	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
> >   	if (IS_ERR(bridge)) {
> > +		if (PTR_ERR(bridge) == -EPROBE_DEFER)
> > +			return PTR_ERR(bridge);
> > +
> >   		dev_dbg(out->dev, "failed to find video sink\n");
> >   		return 0;
> >   	}
> > 
> > ---
> > base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> > change-id: 20261111-gta04-drm-regression-fix-f7ef51c66ed3
> > 
> > Best regards,
> > --
> > Andreas Kemnade <andreas@kemnade.info>
> >   
> 
> 
> 

