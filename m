Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F404D3090CD
	for <linux-omap@vger.kernel.org>; Sun, 12 Jul 2026 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783883279; cv=none; b=vFvMQOvG5so+hjN2Dl2YhkqVby7WzdOBWjwc+JFXC7XgZMPp7Xt/0qbhyycihh35L+PFgwB8WypDLzAM5aYqXwaFXpGrjaj+fwtlDGhNiD+RB5j7Ef5zbIBsmmTafwL493Vr+CVGuHi3EXxdHOySOEYGITSHufJ+XFKuoF7HTIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783883279; c=relaxed/simple;
	bh=Zq5rj8MXuH9eq+y9VKSH0dwCH55KqEZTdD7vc4Szt+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViRCimtsXKg4szqTqGjV+v5betoaBbBqe8O+9IB0Y2di3hA9udQ35+NhBS9bI16FjtCvWqCK9jYf1fvu+upJgUlce0OiHJBi2eAEjzVM08mqJx7wVZQ30vxiOok978TIo8IOyY0GlvbvRU9v1b8weqN0tvLpKQf9agSXZ41FLDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKABp/HF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKABp/HF"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f36a122fdso543334f8f.2
        for <linux-omap@vger.kernel.org>; Sun, 12 Jul 2026 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783883276; x=1784488076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xZg60sAAA06cSnVFm1g3I8u9K5C+cZsTy9v614jrUA=;
        b=SKABp/HF3BtuQPaou5DG8ZCZ0FdaI+GKp0HHZ/WkT6Ac42pquyYQ5Ek69FjjNe4AHV
         NtFCBCbjbXn6gNv86deIl3qBRVu3r+wNN0J8o3RQQAArNeOHFXJu3ySx2CdYcszwnElu
         rOPrtbrbthKssi+9y6A7BmJoM1HBGz6f4a+mmM+oBQ0fvRD9rpNyYv6CzsBGfSW15wov
         0181jdIyXP49KiFlk1wtq+gDBv53kx3OAJIqwkJrQoZk0S7f0caJPkxCfo6HJnMNHcSa
         vJPpOLuEBsErvVXv9cmtsiZsXOaK4vIilidPD3xY3Y78Z3uxQt6/Zc0JAfkcDuUuzf7B
         zQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783883276; x=1784488076;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+xZg60sAAA06cSnVFm1g3I8u9K5C+cZsTy9v614jrUA=;
        b=CovdsTsUhQIQnWLoAWsbVXRJrWed9tsajlStfAuOOqOdA725JbxfAslDaSlY6GMZuh
         nEieU/LdPodIyyTnVE0Vk1PSYm0Sxh6zEbX0CPH8g66YpV7h9sBCid/zjZPrVDUuVMiO
         Q8TA9lIWQXaDquQ9dK4z9Cmxl4YW/CN08wnqIlG/fpHUzIfI9uXZ18XKiYISUuDmm0x3
         4kyWzlZDxl0ROzFJNzG82jMAzuffrtuf9xKnXI0Zbt55pRQTUMo8uVgksrzmvC+aB4Cv
         MykNN8gv6fSFJzOzAUsEDgbyMbO7raZAs1vTVRJuDZWuT8TKvQHepkQTfcdda3nwh9k2
         DDiA==
X-Forwarded-Encrypted: i=1; AHgh+RqGWHGstfvdvg+vZcbc3DGq5Uq10WtJ11iNpWYOoyfgW8pyBWN5FGpZeEqI05M88/4uNpJJELJ5tl5B@vger.kernel.org
X-Gm-Message-State: AOJu0YwyeMK2faaBnEoURQpFsPGbbsHarq7FhIQHn1zI3cZsziUaI6j+
	9uAdE1FuNB1sb5AfHYC0mlaeHCLY3ohPC/Ua1P3SefzWV9+1fVN1oV2Q
X-Gm-Gg: AfdE7cn4A/yjPUCZylzLwzNksP39yELy5rE0e1ysNHhCoSxUX6/AziQ/UAqr38Twqo2
	hpLSQZGYnWPr2JaHk7pWvt5sZCK6FBGExWg7q1QDyGlxXOiqewqBZ0AvGSytS3QVV/FTWbbF+Sz
	7spK0vaPFnjBE79qOzSbLLOZOkzAwpanDImOLnkKm0TcR/KqZ95k1x8TcY39azaiDia3V+ff+Xb
	4b+IJnW3xbJWX5L04A8KC2UQz3GBVw2Hh1d4NgxtQWkDSEbthyM2oqBdS/bcWGaN+juGFFzoJOG
	rOSxDw319mwpVgO+WGJkHJxsUTLKdFedMOm22ttmeNwLIgc4UJ7ApoOnBao3Wk1O3HvO+YKHOA8
	MZhV6cneHRXGaj+/L9OyvhS/rNJqB3n2WItOUz/x3ldC35ta6IhYzCgKP7n3a4UOup3InvCKsbK
	mYVdBnV1QXn+v9SdN4k68Yma0zusN9TWrM7Lo=
X-Received: by 2002:a5d:64eb:0:b0:474:8aad:2f8 with SMTP id ffacd0b85a97d-47f2dd2bd97mr8223971f8f.41.1783883276216;
        Sun, 12 Jul 2026 12:07:56 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm77422974f8f.34.2026.07.12.12.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 12:07:55 -0700 (PDT)
Message-ID: <24368e1c-171f-4f6b-80f8-58accab1d3be@gmail.com>
Date: Sun, 12 Jul 2026 22:07:53 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/omap: dsi: avoid sending bta sync all the time in
 writes
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Marek Vasut <marex@denx.de>, "H. Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>
References: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
 <4cb964d9-524d-40ec-8cd2-d936fff8eb85@gmail.com>
 <20260707122203.0bbc973e@kemnade.info>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260707122203.0bbc973e@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7.07.26 г. 13:22 ч., Andreas Kemnade wrote:
> On Tue, 30 Jun 2026 08:42:57 +0300
> Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
> 
>> Hi,
>> With this version of the patch I see:
>>
>> [  102.760894] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  303.860321] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  307.071624] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  307.360626] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  307.671142] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  308.660339] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  308.961059] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  313.191314] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  313.700378] DSI: omapdss DSI error: Failed to set dsi_if_enable to 0
>> [  313.980346] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  314.791564] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  315.090362] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  322.850952] DSI: omapdss DSI error: Framedone not received for 250ms!
>> [  323.111175] DSI: omapdss DSI error: Framedone not received for 250ms!
>>
>> while scrolling the (hildon)desktop on droid4, so I would say the change
>> broke command mode.
>>
> so let me summarize:
> - sending initialisation commands to video mode panel: no problem visible in
>    any case, theretical problems (not seen with the tested panels if sending too much data, fixed via v4.
> - command mode display: no picture and error messages without any bta sync (patch version 1).
> - working display with send_nop() replaced by simply sending bta_sync() and not
>    waiting for PACKET_SENT irq for short packets (v2).
> - partly working display (with v4), (always waiting for PACKET_SENT)
> 
> so there are some situations when waiting for a packet completition is harmful.
> In your case these were only siutations when short packets were sent.
> Do you have a more complete log of v4 boott?
> In the log for v1 which is not accessible anymore, there were other
> more informative timeouts visible.
> 
> But maybe as a wild guess also based on Sasikhos AI reviews, maybe
> this helps:
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 3f22929c36e2..eb3cd0d23cae 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -3267,7 +3267,7 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
>   	 * updates stop working. This is probably related to DSI spec stating
>   	 * that the DSI host should transition to LP at least once per frame.
>   	 */
> -	r = dsi_vc_send_bta_sync(dssdev, vc);
> +	r = dsi_vc_send_bta_sync(dssdev, VC_CMD);
>   	if (r < 0) {
>   		DSSWARN("failed to send bta sync between frames: %d\n", r);
>   		goto err;
> 
> 
> 
> Then the call is equal to the original one done via send_nnop.
> 

With that change it seems to work properly, will keep that version of 
the driver for the time being.

> Regards,
> Andreas
