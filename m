Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409024;
	b=5I0tldC9zRAYWnOon/L5dK9TggAkC98nU6JPiaXItFT2gzklYM6Piv+jPwGI0yfEsKyh
	 lWIIC/INv4Ttj5xNq7KLPQDCJwwzTvjq60+2rHMLZHht4DaWPpuwvI0j0AaVUB0HAAtTu
	 ueGwkYGfGb7LrGHBQwNOnJQz0okCpe1IfOrVKMD5ZoQpalAs8yOGrDISDbd/QX4mGeRLM
	 8Bdkvv1Kj1TMbm/g3JfPFdmuNxq5DjWYdvoppKvjPAeEdqnIsf+SUP3+X+T2gkUpxikTa
	 xh8jWDi/vITd3lqPV4ioPJjXDUD8x/zVcYC3A7JKEYlk6ngJBXmjQHwcULRRO6gpkgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409024;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=7uvkDwwRX8gpLtDIFfvio+pE0Qt6+6ClgmrGEjNhhaQ=;
	b=KZzX9dZ7nxbjcx7aLnP48MO8bjDmF02y7OQ1M3q3BtO5+j9iTzmTK2q0Lxr1eBL5jSOG
	 //kd1rFVi7Omr31D1LCMINSKddnmwRSQ4eHG/OP7RviG9scjFu0ecRzLT/E4uFjDfYKVp
	 1A8Ha0e8Jy/N8bAxeX38SUhZ7etRa+04LJnnofy+Sk0WUEjpx+3ROl9Ie7JE+XNtOsaCf
	 bkJ8sisZEAXdQA5JDwHL2g3Ul7+tiHDK9nh+RdJQO0xChWvUHvt6vUabAz1ekWBCwB93G
	 imbNfRWxzQ84I06vLaLwow8ZHV0zwv0oSW21YVbqpCoxYvv5l/ntkGPsy69m7AxAY8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=TmI2vofj;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E12606A331;
	Wed, 11 Nov 2026 14:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0E12606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=TmI2vofj
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 86CCF6AF;
	Wed, 11 Nov 2026 15:54:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794408878;
	bh=EinXmH3Lj3xhxGn+GXfi8CWJurPypEP8fTNioLOcrwQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TmI2vofj+dNTr9Dqf/lkQXjj50cDDJBeesqq2sZ4Bv7y2K4NoLzc8tJm2RkxTcwZc
	 X7Vul+/nQf1gRsyjBWhjFYW8H+JaS0Fn+Mnxym4oRZjbVnorWpk67ar0hDAPiCQmhH
	 CD69Mv4ex2CtrW5g6iPRiokxbnZQa5mPibyd+O6A=
Message-ID: <33f63eaf-42a0-4b3f-a21c-3752436d07b4@ideasonboard.com>
Date: Wed, 11 Nov 2026 16:56:57 +0200
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
Subject: Re: [PATCH] drm/omap: dss: fix handling deferrals
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
 hns@goldelico.com, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/11/2026 14:22, Andreas Kemnade wrote:
> Forward the error given by of_drm_get_bridge_by_endpoint() if it is
> EPROBE_DEFER to ensure output gets initialized later when available.
> 
> On GTA04/OMAP3 no display was found, but it appeared after doing
> rmmod omapdrm ; modprobe omapdrm
> 
> Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/gpu/drm/omapdrm/dss/output.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
> index 36d37deac8026..220ed7e003080 100644
> --- a/drivers/gpu/drm/omapdrm/dss/output.c
> +++ b/drivers/gpu/drm/omapdrm/dss/output.c
> @@ -24,6 +24,11 @@ int omapdss_device_init_output(struct omap_dss_device *out,
>   
>   	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
>   	if (IS_ERR(bridge)) {
> +		if (PTR_ERR(bridge) == -EPROBE_DEFER) {
> +			ret = PTR_ERR(bridge);
> +			goto error;
> +		}
> +
Shouldn't we just return PTR_ERR(bridge) here? The error label will call 
omapdss_device_cleanup_output(), which cleans up things set up later in 
this function.

  Tomi

