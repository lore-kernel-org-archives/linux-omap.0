Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152683515CE
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159750; cv=none; b=k7Hr/Hg/pDUPQGAr93aqUdCH6ICREyfoyqqcOebIxS3TIOwGnbSR1lMmtWiJpOvMUSHVHPBWVzIBcKxT7nEuAZknXH7mxwvvqrJoFCM/zP5hmVk/Pzepjk1UyqLr7UOGU4TxQ93M/WSeEuY0qaGO/2ZUsrGZ8k3FTtmM1xtmn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159750; c=relaxed/simple;
	bh=tLVNRPo8EaMN0G7DyVKGQyoQnuoGAz8rD36ZFo8/aRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvjbDriMd09Gz7Ywh6zVwc1Qt3oArIbyLZRsx9LSiwgnoWILG35M5B/xV9FIIcCkfFQKThlRKbNYN4OjwmB4IObWt9RqEDc9FKcejBhVTMBemygFYPXTHxIFrrEH8izDhjsTU8XQ5I+WHB3qesKZ8+LEDHiVl+YVMprlPWlt1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTJgOYid; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTJgOYid"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so12233735e9.0
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787159747; x=1787764547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RIZaPbOB6HKBdZ78dGgTPxABNHg6yS/skomGOo3KKQA=;
        b=PTJgOYidxGx352TMs0xohaoNDims1nsZz6fvVVpCIeiBrPE7fkfgYl4OBso6MkrRfA
         ibv56nI+JlIdhMF4hk8DxgMQhBlwMiWRYY0yZNOqT2dWgjEQYoEZveLnDmqSAGBe9QLo
         uARvY6EaEAv2/JSdQ8uBURfx4rrT9c9hZyJPyVZ7oXYbRczwcQ8bu5YfErGWSBeAUnOo
         fL1EtoIX8b2dih+ClpUeImsgiMSgGR0LnMAOllkhstOoztpMO6K0LoU+nIr+xRyyDGL/
         a4/3KWWmRWdVkmQmAWenOsKafRZlYr1EoWUSnZ34wnY1HLRrnOikfN91Qbw+UhksBKhj
         TcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787159747; x=1787764547;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIZaPbOB6HKBdZ78dGgTPxABNHg6yS/skomGOo3KKQA=;
        b=njwylbvD5zYjhgYc3JUrj084BbYUVqvxRPU2FivRyitb8zdjctqe3dmGhTlY066ZbE
         AUUtik7WemncUO8ZIY0VtwkGD3o1BP09t19sTp9k3Db8WB4cTjsiWyHQMl1R+qxXvkYq
         SyvWA5TbaqvBifF92Q+eyHrfnwLnVSJoV/UifGjU7gaZDxllh7+YEANPUoWTeYrSeYx6
         nyIJb5Li7Y7e25DGvKWS22cR18dpMpOdSrBAtM1vqXr/pZsgRCKDXsyClNSOv0hkr/3Q
         AmWnYVVq/VKuyv+DGmMe9IUDTXBAMIjlQEqEFRI/hFThEdEYiATQlHEQg53v70Haoaoz
         Qysg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5LBqj0PuL3LNqSMaffZXHopwIws9dORY+qHxFWZWu/e0WYDxQklPED2WsMmcoTTJ8E59mndkkKrjN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7WO4QKk2rf9dRbszYcWZ+DSxXM7fU1XKIjYfkoWNEFbE99+28
	bim/R6w6fHjBbL9F/ISBmzqksHhds2jL6rEqHbUcXEt19gJq3sLt+cxQ
X-Gm-Gg: AR+sD13FLspIoQM7O7UnUrzv2qDcn7cNtC25nG6XWleq1f2W14+UQHbrG7sLKqCMbBC
	ecxcD9SzMx7BZQ/wZiMV2it8xmVDELPM44Vl9qZvtdyM6Fm8VI9Lvk0vc/VcVrTWB3sOVhFxfGg
	QsZfErF1S7hj56DbZGmFglhE1eQRJ9+lIAtARy6GrmlWVsdlmUQ/SBcVjlFiqTVihNzG4CD8lwg
	JZ+Tm/EBsU2tI/yTRWkaauFxTGsVavgkZ2IvfsxLbr5Zhk3o7fuHe5BDbQsu/6GHGSw+lah1iJ8
	h+1443ebHZzoRFwpsIxvuR/dMps6g4SKCxd6oPNt453H1+OuDJbgQNkJWKya/MryzgvOyUQnUAc
	X+sRMsxP0Ot37XhsqeHFq9r3iGpPDe2FtpzRs55Fgh0a6C5DfCZ+WF/+aszTeehoSKzIbemHWej
	+NmgDClEtCHmwNlzfNarW7xP45UbMllbkuSFJzySektHGbiMTEr+OiO5zs/bskm3SKNCteiPQw
X-Received: by 2002:a05:600c:468c:b0:495:6a50:3fb8 with SMTP id 5b1f17b1804b1-499aa180578mr102639775e9.1.1787159747195;
        Wed, 19 Aug 2026 10:15:47 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-482b1441b0fsm6634033f8f.4.2026.08.19.10.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 10:15:46 -0700 (PDT)
Message-ID: <d542433b-c1e5-4759-980d-0ac54dd1fa0c@gmail.com>
Date: Wed, 19 Aug 2026 20:15:44 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/omap: Report HDMI hotplug events to the ASoC HDMI
 codec
To: Mark Brown <broonie@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20260819152755.231754-1-ivo.g.dimitrov.75@gmail.com>
 <5681ef2c-b839-40c0-8e6b-65fff0f45af1@sirena.org.uk>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <5681ef2c-b839-40c0-8e6b-65fff0f45af1@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19.08.26 г. 19:02 ч., Mark Brown wrote:
> On Wed, Aug 19, 2026 at 06:27:55PM +0300, Ivaylo Dimitrov wrote:
>> The OMAP HDMI audio driver currently has no way of reporting HDMI cable
>> hotplug events to ASoC. As a result, user space cannot detect HDMI audio
>> availability through the standard jack mechanism and audio policy managers
>> cannot automatically route audio to or from the HDMI output.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Ugh, somehow managed to send the patch with wrong 
hdmi5_bridge_hpd_notify() signature, sashiko noticed that, will send v3.
