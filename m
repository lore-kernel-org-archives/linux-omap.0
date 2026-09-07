Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE840BCD1
	for <linux-omap@vger.kernel.org>; Mon,  7 Sep 2026 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814905; cv=none; b=cU6/AmbpCrHFn3+Gq0it9DHqOWaYP21sUkK1YgjU9s1sESHWoGXnBZjBrMAR0+m5z4j7wGRh99ItCt5AhfOS28HXFwZFBBNziympITf7oLuvraQPFDz8JlMFcm9FPdXPXayev2246QoPgJueKkrcCKi2qmxGqFo6KGhBs/jYzKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814905; c=relaxed/simple;
	bh=NBcfPz5Kg5pxUSo6iph13FYLp+Mgm5G1VrbxsH1itNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3LndL0Wxr0yvF48gofk7IgYlH+y/D7attpai8zQW2iWaiLAth/Wqh/WBHgzlAV67V6e9ahT4ywNHpa7YygVL8bzO6w69oxaNVYrGIJ3N9jI85cFWaq9PiC1+q9feZE3sHzKt+XrYjZz5iljudkW1DwRnvma1XArd7KBAPNPQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghebp8M5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghebp8M5"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-485888b3c3dso4047360f8f.2
        for <linux-omap@vger.kernel.org>; Mon, 07 Sep 2026 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788814902; x=1789419702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0jKO+9sWDvAmMVaHnfnr4Hp4hjfEF0vm85uCtXj8WFQ=;
        b=ghebp8M5VPbmNcaHHW7NTilf6ArvvK1Rw9d00eTsqMrk47ryKX5Lv5Ibv7wm50vSnk
         PDernjrqC6K1ONjX7RuwGLKREynlU8grfvc5fKglYxmEXkEhtNol8pfQp/HxGmpvDPlq
         b/4Vu1pJVyRZNTWVp9nhw+9jSf5Z35V7AG/m2v7ZQyx56/cw7pg3x8jjQkwIIrExYdeO
         Phq/rYgdDwCAtYX+XpQQ4ehGl8U9RMjzF2mAkd4AM7CUaWEz0Un1U6HpiCqJTmimewO5
         fLoE543d8kal8UHNI9FTJbNLdTU1Sf13fj2g1C0Y4aWqAKcc4p6mwQFbpARXlnAbClJo
         pycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814902; x=1789419702;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0jKO+9sWDvAmMVaHnfnr4Hp4hjfEF0vm85uCtXj8WFQ=;
        b=lzDw5Lwy8r2PNHd4Nzl/+Bx1CCv8TCMjne+Yffc3sUUeAvtXjfBPRCtYZ/hiCHruUu
         OQWdzZAndJFtBBWxmKGOvckbHbUe3V7GxYb3u4PeIG1LCDypHXy1fp//nKDYS5EHETFh
         vj375E0eNzfJv1q6EMWxZnLRd3kqyFlBjP7iXye4Suk5Sww4BQhicKnIjdU3QUrbuuYy
         oux5UcL9fl61ZK4bZkrVptIVn+UYYfA5ByuREIDVYBPH7fGLZZJ2cFpQP8MhHVuBia6k
         VkrXw+lcd3iB7NHe+rpRVs7hOKEXAlkvHwTTFgwowo6wn8uthTmLMPeXQqyziR1gMjvX
         Rk8g==
X-Forwarded-Encrypted: i=1; AKwUvBwpbidwyVB/8pFwS9ju41j7G35D5dxwLXE78hJDj92kv5wmTGqjHrV2gddl0liulgd6JWK3dPm+cl+j@vger.kernel.org
X-Gm-Message-State: AFuF++l2eELf9QZZe4Sm/OMutazRpqvzJ+UY5d2KNAHrR5zmaC2OPeWq
	vwVwOHGi8cV1UQ7C0xN110hbYuaugXGtVr7qD+ioBERkM8OBVM2ujcX9
X-Gm-Gg: AYBFou0Gktli8x7RkR9ws4U8yFRwc4estdxOfuoS+rVTUOSRnUWumGVFP1qaJA13ijy
	9c4HzlcDPMsPg9LJmGZDnexAvDyDrjzL/7bdpqm+WmTmTsJloLeY9GiLmw7EalW62vYcPihbXMs
	K01IeFi13RQzPZverUPNIgzUbb9l5gxXFWpripU7VkoAdjTJWOXlzHsjnbGk9FfEYE31Zt/QKWR
	rHaE1tPPkohEtgD1hJFhjj8ujNyc9FK7T7HkLbMBYCZNnrdWaUXB84gRIGcfNKaWQZCDcDVwh9t
	FJO6PvjtZIk1FmODY9z1xOsbPPiu2CxmHN1ahe+r6+WRLzrtMUogRde3asdiEvPrHyrp7EOYOi4
	oMDemgM/qwePyHtljji9EAZcFKCysRzURJ7sQdh4VEm6uLkSEQDHfIPYfWigRsF2dTuYsY+QQ4u
	O/kbEdLWOGB1CA4rfDVI+jdcPMnzAtT6v4mjibftwZ3S9WTTsDycQLtb0/9c4xIAQsvnCOaQBJ
X-Received: by 2002:a05:600c:1da8:b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49cf825a530mr297613755e9.12.1788814901592;
        Mon, 07 Sep 2026 14:01:41 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49cf5135353sm299682235e9.2.2026.09.07.14.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 14:01:41 -0700 (PDT)
Message-ID: <6fb14341-655f-4cd0-8704-50c8d2e5850d@gmail.com>
Date: Tue, 8 Sep 2026 00:01:39 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: ti: omap-hdmi: Fix build error from a merge commit
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260903-omap-hdmi-fix-v1-1-b0447a1d35d5@ideasonboard.com>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260903-omap-hdmi-fix-v1-1-b0447a1d35d5@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3.09.26 г. 12:38 ч., Tomi Valkeinen wrote:
> 'ad->card' was removed in commit 9af2c1d4f847 ("ASoC: ti: omap-hdmi:
> remove unused *card"), but commit 699e5975e2a5 ("drm/omap: Report HDMI
> hotplug events to the ASoC HDMI codec") moved that code line. These
> commits were applied to different trees, and the merge was not quite
> right: assignment to 'ad->card' from the latter commit was left in the
> file, causing:
> 
> sound/soc/ti/omap-hdmi.c:408:11: error: ‘struct hdmi_audio_data’ has no member named ‘card’
> 
> Fix the issue by removing the line.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/apbbvQSfUbzYRFaw@sirena.org.uk/
> Fixes: 1ae7fe832c2d ("Merge drm/drm-next into drm-misc-next")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

> ---
>   sound/soc/ti/omap-hdmi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
> index c32ec7c0b0cf..2cabd4cc5b0b 100644
> --- a/sound/soc/ti/omap-hdmi.c
> +++ b/sound/soc/ti/omap-hdmi.c
> @@ -405,7 +405,6 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
>   	card->dev = dev;
>   
>   	atomic_set(&ad->jack_state, -1);
> -	ad->card = card;
>   
>   	snd_soc_card_set_drvdata(card, ad);
>   	ret = devm_snd_soc_register_card(dev, card);
> 
> ---
> base-commit: 97c594f71fa71dc30a0583a76d8b6ef5c5ea10b1
> change-id: 20260903-omap-hdmi-fix-7f085e21b708
> 
> Best regards,
> --
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
