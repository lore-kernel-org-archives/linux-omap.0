Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE684582CB;
	Fri, 21 Aug 2026 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305518; cv=none; b=bwa/OTw5IFBmD4hVPPcJZslk5r3nYM+rnzZkIYbfAR49KOIZYKc0fxaYXEChr1KJmdzpyrmOzvxiITX3VP/YZHBIEsMjElpV5tzxJaleKFUAkO2TlNRHMVXUZNUcKopJ++yuw3hWbNzhj+eQkaNFY7umyNUmnGImu6pIZuYG1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305518; c=relaxed/simple;
	bh=GOS3Sfd6WsIo0/Gd4p9eZj3WYjUl1BAGLoVcofgedSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g23eQf/0syGGrkpqXY5UoPxexqjqgGceZvjw+uK58KgK1RXVQoKpQtz3NBn5oKAXs2oiKvr1fl024SMb3YN399A6OPxc7unbBEW1QGfhmi5O5f4J1o0DjjN58DYSZv+Wa/e+2ou9zkekNfx2y90V2QTYHdaqrCJvnMo0W5zBJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=p9Xlbrx4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="p9Xlbrx4"
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 726751583;
	Fri, 21 Aug 2026 11:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1787305423;
	bh=GOS3Sfd6WsIo0/Gd4p9eZj3WYjUl1BAGLoVcofgedSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p9Xlbrx4yRZeEr+M5OiXU66CzzO56nw+H+DlrS759vl6uYgxeUurwgANT46H0j8XX
	 QJmph7g30madW4EG1Xd0G7Rle1Q855Qr6c7I9bCXncLCFQ2MeKXuRU8/bMg5Mfilko
	 kCs+pn9JgRH8USzzwJcRTSkrO+2/jJE+Joxyx5Kk=
Message-ID: <5b90d713-ffe4-44f2-846b-cb42751310ed@ideasonboard.com>
Date: Fri, 21 Aug 2026 12:45:01 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/omap: Report HDMI hotplug events to the ASoC HDMI
 codec
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Alex Deucher <alexander.deucher@amd.com>
References: <20260819171935.233946-1-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260819171935.233946-1-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 19/08/2026 20:19, Ivaylo Dimitrov wrote:
> The OMAP HDMI audio driver currently has no way of reporting HDMI cable
> hotplug events to ASoC. As a result, user space cannot detect HDMI audio
> availability through the standard jack mechanism and audio policy managers
> cannot automatically route audio to or from the HDMI output.
> 
> Add an optional HPD callback to `omap_hdmi_audio_pdata` and invoke it from
> the DRM HDMI bridge whenever the connector status changes. The HDMI audio
> driver registers an ASoC jack and reports `SND_JACK_AVOUT` state changes in
> response to these notifications.
> 
> Also fix the disconnect path by taking a runtime PM reference before
> updating the CEC physical address.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   drivers/gpu/drm/omapdrm/dss/hdmi.h        |  6 +++
>   drivers/gpu/drm/omapdrm/dss/hdmi4.c       | 29 ++++++++++---
>   drivers/gpu/drm/omapdrm/dss/hdmi5.c       | 37 +++++++++++++---
>   drivers/gpu/drm/omapdrm/dss/hdmi_common.c | 14 ++++++
>   include/sound/omap-hdmi-audio.h           |  1 +
>   sound/soc/ti/omap-hdmi.c                  | 53 +++++++++++++++++++++--
>   6 files changed, 125 insertions(+), 15 deletions(-)
Thanks, picking up to drm-misc-next.

  Tomi

