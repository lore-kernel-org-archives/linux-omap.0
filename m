Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817409;
	b=quXWzeNdchDyqQ02BIy0NjQn8HE89/XHNHE7oQmnPMwbRqe3unU2CfzwAAXqAESXEhuk
	 GriTegCGBtH0meabkBHSG9CtaWuAzsiDznDMNWOCFLwlnfLILU/trx7G8atHAAn6a5ztR
	 TedosPWWUDLiEg9cw3QfZ1gP/f77GitHsr048iFXqPeu4nxIznnRPk9TmDM4aNUd9lnP3
	 t8ti9ScMro4D+e9+Oy9/4+1yuYqgVzhTLy4+talP//uvLF3waHWUjWuEnlyQMoPiR1Lk6
	 dHoijbOjQ6feQXZs3TiNRwuqmNPM0L3008fjpdQFKgbB5p5fnQ/BvYHYKJ5dY+pvU5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817409;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=AS3hYZ5Fhn7IieoMeybH0s20hVo5jwbEibdd7Dl4zys=;
	b=Ui/LlZYc/bSGAAuKH58mdobM7XpD5/22Sf6T1MFFckquXwTjlIJaOGFag2dK500gaDeB
	 zvm1vddkotXXau2zWjpdP43TkWUOsZVUNI8t0G1JPsxtDPQcI6N8ZIroShHXcC0miWW7Q
	 UWBN0pTSf66E63AwbCLITrMPigCdFrZ6fCj4LWfr9LuHhHIBTaBl0aNsn/DS46xpt4Z5P
	 2H3DbvOh7TF9Z3uxsSNCinT+ih7o1V4FClqpDCU/XnlAdUnRPn+w34XISJL47jVHDUmP2
	 aiC4dzJVjeHyuqcGbK0ibvY9AHkXNOswsTcyN8yA1u7ZnE6xFtwdwU0YsmDDpSgnY/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=FXk7Kugu;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9682606A32A;
	Mon, 16 Nov 2026 08:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9682606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=FXk7Kugu
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3558ABE;
	Mon, 16 Nov 2026 09:20:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794817259;
	bh=cjz8eLomQbaoeI4Wmw9YyE3zWz4vLpIrohseVtZx46Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FXk7KugudFmU7KelqDlRy+CLFVENa7Jxut7W7Geb3xjDbvBsqboY7QX0QA5bKZUpb
	 KhKgdsSzw5Grs8GCgSs2y8+upM+8tNkcIUbiUIm70QwHB7Fwo72egYErglsQnlOhg9
	 kzch9PziaJGW8EhyaAUDpcBYt2dymo9rwzZV3lkU=
Message-ID: <9f4e7421-0429-42bf-886e-78fdd6e0f55b@ideasonboard.com>
Date: Mon, 16 Nov 2026 10:23:23 +0200
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
 <e93d1911-a6d9-4256-a2cb-cd2d6112a4c0@ideasonboard.com>
 <20261112123522.09ef73fd@kemnade.info>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261112123522.09ef73fd@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/11/2026 13:35, Andreas Kemnade wrote:
> On Thu, 12 Nov 2026 12:25:20 +0200
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:
> 
>> Hi,
>>
>> On 11/11/2026 23:14, Andreas Kemnade wrote:
>>> Forward the error given by of_drm_get_bridge_by_endpoint() if it is
>>> EPROBE_DEFER to ensure output gets initialized later when available.
>>>
>>> On GTA04/OMAP3 no display was found, but it appeared after doing
>>> rmmod omapdrm ; modprobe omapdrm
>>>
>>> Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>> Changes in v2:
>>> - do not use the error goto
>>> - Link to v1: https://patch.msgid.link/20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info
>>> ---
>>>    drivers/gpu/drm/omapdrm/dss/output.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>
>> Thanks, I'll push to drm-misc-next.
>>
> Isn't it drm-misc-fixes? This issue is new in v7.4-rc1.

Indeed, you are correct. Pushed to drm-misc-fixes.

  Tomi

