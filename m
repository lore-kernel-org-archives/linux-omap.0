Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479128;
	b=Ba6wWAAl6ennvIrzpyHlmTT9NobvWkHFCidvszdxBgye47hzFUJHvZQrxPFLbbKzViRi
	 +bOWHX556KIrz0YFdX/UxMbb54V9u7iy1MzmPkT1tSQSyYxxHUFz5ApFkY/2gB3uhd50o
	 oiEMD3nhS46JTmCRConr1QHv22z0cz3bSGXsvOWUkGnnw9z5vh3OaHDSD5AEZVA7kHb9M
	 l6yHC7LfHbDW95cFb+BbZAXJLGUuBgBWIf9j4kiCkh2ZLznsm5Pehxf0/VYYq23xKSKTy
	 6pF7/mhTUfTPnb1WiARe9vNtn6IUn3h+7cUBZP4UB6jd+ORoptMKyJ9VZSGAQhSxYuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479128;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=r1boeH31u6OekFt6hR72UfAwBYoY6BZyWGRx8JJ1BpI=;
	b=Z6Cn2jO2R+GSEGLFnT2F+UnV8hgO6o2Zn5k1i22qfJRrFQofLIL/ot516ySjvyzsOR8k
	 vLbuA35WdBgqpS6iMXVyTP9mdvISGvTmCxGOE9Q0HG+4v/kby8ly8cPdD0nQy+D/6tP+m
	 RXdaQ5vob/Nh8HEpIIKjnyBlDmXpOtORtPwmOCprDhlPSG/YgHF2hoalwhiyDwanfME7V
	 lSfzd6VC+r7oMFun4ZsYdlFbZ6G2BVP7IG10qNQbnEYKZ4HINRDAMz3k1HmMLadtr/81k
	 dMzMxJEtn3n2nHg2qJgTucah9PrQiZyehpeheZzAVzJrYgvXFp5/dCQQCNeQb4b2bIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=nSe0RQaY;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F594606A32A;
	Thu, 12 Nov 2026 10:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F594606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=nSe0RQaY
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A05A6802;
	Thu, 12 Nov 2026 11:23:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794478981;
	bh=m3PNmU33zF/fXWsagM6zSSS6S9ylBnP9yC97sAMjp38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nSe0RQaYko4amJJHwPtkHqMlysca2D7eh/uECdmwT5xquIyKIFb/cXKXslR3LRy+c
	 LKLOY0eXC9ktGawwh4Qwu7SEuBsmrvW2zO/SVmFqyovGRVLIIDoK0g9CZFd8rpjag2
	 49jESfeI5+hIjh7eo8E7Qb3GGJ+DZscPGsO7RI6A=
Message-ID: <e93d1911-a6d9-4256-a2cb-cd2d6112a4c0@ideasonboard.com>
Date: Thu, 12 Nov 2026 12:25:20 +0200
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/omap: dss: fix handling deferrals
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
 hns@goldelico.com, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/11/2026 23:14, Andreas Kemnade wrote:
> Forward the error given by of_drm_get_bridge_by_endpoint() if it is
> EPROBE_DEFER to ensure output gets initialized later when available.
> 
> On GTA04/OMAP3 no display was found, but it appeared after doing
> rmmod omapdrm ; modprobe omapdrm
> 
> Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
> - do not use the error goto
> - Link to v1: https://patch.msgid.link/20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info
> ---
>   drivers/gpu/drm/omapdrm/dss/output.c | 3 +++
>   1 file changed, 3 insertions(+)

Thanks, I'll push to drm-misc-next.

  Tomi

> diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
> index 36d37deac8026..b5cef5093a883 100644
> --- a/drivers/gpu/drm/omapdrm/dss/output.c
> +++ b/drivers/gpu/drm/omapdrm/dss/output.c
> @@ -24,6 +24,9 @@ int omapdss_device_init_output(struct omap_dss_device *out,
>   
>   	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
>   	if (IS_ERR(bridge)) {
> +		if (PTR_ERR(bridge) == -EPROBE_DEFER)
> +			return PTR_ERR(bridge);
> +
>   		dev_dbg(out->dev, "failed to find video sink\n");
>   		return 0;
>   	}
> 
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261111-gta04-drm-regression-fix-f7ef51c66ed3
> 
> Best regards,
> --
> Andreas Kemnade <andreas@kemnade.info>
> 

