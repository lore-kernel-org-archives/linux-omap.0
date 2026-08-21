Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093E466B0E;
	Fri, 21 Aug 2026 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305548; cv=none; b=I/1GFD+Y49w9d6XK51pKGI4XTNzxuqyMyhqYOjc3z47eQHziPQthkBZ+nQjbDLoNU6pacZAPc0hHda8GNKIHoRBRWS23XbsQBEjo1qXgwh3VLVf15zUMsCvzMIF8+3/lNSj2WNPCbo6xKwCRTyWkN44bmN1ZFT55cYQh8dAOBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305548; c=relaxed/simple;
	bh=FmuNeO/2gbwPF6v+5N6ElQDNIvtDrpPAysHLpirSETo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDpnFcZ8N2SeGXDESwX6BuTP8ONsH7rCkfjk+w5voDsgA0t5+wY8Dnjy3Vxh+9+4seXCY/pkcg7L9a+W1T7mKwNoKr4OX5Weke2XgUtkmpPnF4dnk1sA1xDWk0Zrip0aGBW+Il3mBxSCXbvx411EOP0w5cMa/A5FegfV27T7mBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=YaZBLv9i; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YaZBLv9i"
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7CB571583;
	Fri, 21 Aug 2026 11:44:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1787305457;
	bh=FmuNeO/2gbwPF6v+5N6ElQDNIvtDrpPAysHLpirSETo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YaZBLv9i2dae2/vtK/G/v2hZGB8JWKHXHHHGnagU9uj1+Zzoo4uvcXplPjDxZhUqJ
	 prTxvhTQzjibdmt5ORabvwEwZWf0/gMlPBoiXbbgw3bfG6L/ncNqCqUxoA03lgo8UX
	 PitKIbxW+77BF9x2rEJx791E4YC4bjOjUWddFLyo=
Message-ID: <eb39ee2b-1e6b-47b0-b901-6333f6df075b@ideasonboard.com>
Date: Fri, 21 Aug 2026 12:45:35 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/omap: dsi: avoid sending bta sync all the time in
 writes
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>,
 "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
References: <20260804-vm-upstr-v6-1-1bf3748b2fa3@kemnade.info>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260804-vm-upstr-v6-1-1bf3748b2fa3@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 04/08/2026 11:37, Andreas Kemnade wrote:
> Some chips need configuration commands to be sent first, before they can
> send data. TC358762 for example needs PPI_LPTXTIMECNT configured
> and PPI_STARTPPI set to 1 to be able to transmit anything. To be able to
> configure such chips, do not send bta sync during writes if no acks are
> requested. Instead just wait for the packet to be sent to avoid FIFO
> overflows. There might be more to do about acks, but there seem to be
> virtually no users of that flag.
> 
> This came to light when fiddling with the Epson Moverio BT-200 display
> which consists of 2 TC358762 bridges with SPI funneled through
> to the unknown display chip. With that patch the bridge can be accessed,
> Reading back registers works, when the above-mentioned registers are set.
> 
> In Command-Mode update, there was a nop sent, apparently the most
> relevant part was the bta sync to actually force low power mode.
> 
> Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.
> 
> Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Thanks, picking up to drm-misc-next.

  Tomi

