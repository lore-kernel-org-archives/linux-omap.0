Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886316;
	b=vf6k++6FeZ0swMAYcwvxDej1vj32rdnBS9hF9glNNhJgFNH73JOxrnTfgO1fPyf/c8W/
	 vqUlfwXbnrO3CxKe6lgoSNiunp8a2qarAdeYyKWpKlp3PxFX3EbMKR45iS94tTlbKcPnQ
	 nN8tOIU2l33EypC16YWQ9PjPkCNTlZVz+dOBPZQxbGBfVDhxDxk428Ja15X82uBY17Okq
	 R4HN4ljTjvHw2ike2hgSYN/8SBpQ0+DzN4pdS/XIOFza8DvtQMq1o1j8leCJW+v7O8F77
	 cegH39wYnrZPd19VzWt4b3AcuiKv2/agSDXt6PV/sXU8QYaUJeAJjQl6zAj84B61CPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4SSzib5VWeur1UFjzFHifegpVxu2wOnePo4bxIewHVU=;
	b=qvepcbor6foezvZwkr6zkUDQeksznIyUWZYm7BOE925ycVQxMxh9j7CTbnF1DTYhzNAU
	 tNZdojcNEZHpvVtK2hmKH8Bz0yiPNCxzBttuy+ZrkjCypOfrJ9uzGcR7PY2A+2PxzYPki
	 F2oxNGtJkPMPhOT9qwZOIR/rQjyAJ8oU9IYkklvN+TqoDuve7m3ylM3HpkvX9nqG2IDFA
	 9USbiajpllx59rzlj9+UyjuuBShw3CS6+G4bZrOI0ikVw1pF255HOqgvrsi2k9C+0kudd
	 EnR1S7tVdRAUH6Caz1fBIazjX5PYlfb99FVC7KyMqtyJ/lT3Cl0cXuVv33o8GMmQ40g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EmqlH7ni;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41926606A329
	for <linux-omap@vger.kernel.org>; Thu,  5 Nov 2026 13:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41926606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EmqlH7ni
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so14938815e9.3
        for <linux-omap@vger.kernel.org>; Thu, 05 Nov 2026 05:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793886315; x=1794491115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4SSzib5VWeur1UFjzFHifegpVxu2wOnePo4bxIewHVU=;
        b=EmqlH7nikgIUs4lABse+RVCI39H2DzVmBvEa9v/whwmVP1aJYm6K+0hXifFOneR2xf
         AJTZxNfW0Z/lzWGZJOK9CCJ+55az25Q6zozJmr7wV1IJubS5nRy22RUQiWU8qXJtP6uz
         RNnpwtepATRAe6Hk6MW4amrYTwZ6Pr9a1tdYk1CoZEWqLR2ZHO4nQhWXdg+Gi+yOAWJq
         k7oY8OMOwFXCS6sXu7+q7/49+ivOCZe8EqNqTeJWGwPekbDPNutVUTiDfvK8EDsVrmj+
         hhb+6HpZk3eoEWgN+6sr6NO2+3pU6+f2FvxJfxLoRgcsNEd+reWWaHpq+jcg9bcdxQsE
         d9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793886315; x=1794491115;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4SSzib5VWeur1UFjzFHifegpVxu2wOnePo4bxIewHVU=;
        b=udiFioNJp/x5lLyN+aFyuACtBU/XUx5qp8V47t8TtoVgxJXbqml8PEBjCpgjq4I8ih
         rOUh5lDvpF75HtJuneH7+FC//cfgMP+RMdYs12hhUf9bL1yld/PduG5B/7YhMxTJ8bQb
         6QhuIzuBiAzUoIxWSVfeV6yrdUMkY1lcKrwRPuOvt3zIITJYUxfhC8xwUC5+zh/Qy1+z
         m5NTz+6VHgpLK/78b4D4NxPQ4rH8EZwBk7avqVTypDjTDJo1a1w4vadz8+9u0+YHyFF1
         0zHeXU6G7+1ENlRTtcbpVIKmVsw5n2nJwM3DNHPyXrIf+S+1jtawPGlP3wy2pj1tvKi3
         HF4A==
X-Gm-Message-State: APuU4Z8T4wnuCbhp99G9XDmUlszsDlDqheMnfzst3qsaVQWyHqcK3GtD
	eNvtyQMjU4DGsRpVtJayLYX6o0zglkXt+AZ8Al7ezCtUGtR1RzeTV7Qx
X-Gm-Gg: AYBFou2voa5wT7duki4zhSNjm1WJqTyuPFzHE7ZsPAIt11BdIUGEsCmbOtd0jcjgHdT
	NHdl7PMCV+bquPNw35u5wscfbMo48UCRhN8n+tPU8P4HUSe1jhVuAOLWejkGikgTeNUEqJuknvn
	nkYpXcuNS1qDKqdT7nZf5JQQWCrVfgo/tI9VsWsajrwrZfGjXcYI+YuzBw8GH0xwAwYls0Egly7
	DQwKsoaspw0dz8yjtmjGizG2gTtvg7PbJsNXnk7Ad7+fLP82r6zzix0wMOo7bc7B26TzdNc2v1F
	alLT1AEpjzwXEBnOTj4njSaMiRjdDIqhHkMjeN5EnMuv89DIwhztCnpi7uURMcCAgmRHzJLHmFc
	uJ2Zd/+l8iI1POYcG4QGBCa3TRvtqNAti6tkeIs0nmSWPEc2am9Uplczo1AIaG2FT69zC3+OBYH
	p4MGW5o/tHh8Fp9wVt+HWidQH8VczOGZXHuN9va9meVeWpJNfAP6n7WH4HNPSXECZ3Xo0c1WlOn
	0zpMjO2cQpZrYLnfbBHsV0PIrVXEc830PTuIoxFmad3iPTxJS/cXGMYOC3Brh2TGG0k9bNThhWY
	VH5bbVIaA02aaEiqzsXvG1gk/GS9u9+qhBpgOVb9fhsvQJsdg96t+dAD5OpyGWzKXHdGcw==
X-Received: by 2002:a05:600c:4714:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4ac180f1c7amr420433645e9.12.1793886314348;
        Thu, 05 Nov 2026 05:45:14 -0800 (PST)
Received: from [192.168.2.178] (109-252-159-107.dynamic.spd-mgts.ru. [109.252.159.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56eb4da1esm110800005e9.6.2026.11.05.05.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 05:45:13 -0800 (PST)
Message-ID: <3018a4cb-d986-4c77-a472-ca4d1b83c3b4@gmail.com>
Date: Thu, 5 Nov 2026 16:45:11 +0300
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
Subject: Re: [PATCH v2 0/2] mfd: tps65910: Use modern API for poweroff and
 restart
To: Svyatoslav Ryhel <clamor95@gmail.com>, Lee Jones <lee@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261027152423.194794-1-clamor95@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Content-Language: en-US
In-Reply-To: <20261027152423.194794-1-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

27.10.2026 18:24, Svyatoslav Ryhel пишет:
> Switch to modern way of registering poweroff call and add restart call.
> 
> ---
> Changes in v2:
> - swapped to use dev_err_probe
> - ddata is passed directly into handler
> ---
> 
> Dmitry Osipenko (2):
>   mfd: tps65910: Use devm_register_power_off_handler()
>   mfd: tps65910: Add restart handler
> 
>  drivers/mfd/tps65910.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 

Thanks for sending the patches :)
