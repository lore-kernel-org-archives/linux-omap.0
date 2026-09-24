Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F642E435
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2026 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244724; cv=none; b=TfhsBoPN/vQWlHQtoJJDYHfMAfGdCluuYHUZ1bVw+Zx7B4xkinzaF5nBQHGqQhefKEZY8Zopx6o4vJElcIcbSQy9fpBkHZlDGZTdLPtZowxSTI7FHg1j4pk6h4MHn7u0rXWpf2y1B9aL++yxhfCedWXnWOab567EzOxrPFQYbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244724; c=relaxed/simple;
	bh=okQkGFFiFGo2+bcfn/1mnbfxo9xuP8mMhLAma4LpIno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ampV+0XeVsF3Zmv5Ar1bcABe5Hzfa/EwjJVgY0qVduaqwnraTSWGjorCKQu5ARMbwlevIy13RI3t/F9KPSAaKDetbl7vu0HEUUQiZ37eCpyQ5A6hnGUCzNjFOJX001gtbE/98HcVvP2k6US8v1JNrWUjuX4JReIRaL2WUVJaOsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mdN7Laig; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mdN7Laig"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so14381385e9.3
        for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2026 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790244710; x=1790849510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56SKaqZ0iXHf7acYt1UYQ55V03EGjf3BULjEnLjAl04=;
        b=mdN7LaigXaw5w13N0yHVuCvHSzJnd+TjSfxsrLqs5RfSfchnjpK+sKgieoS6SfLqcI
         cOrvh3RbFYJr7yp8EimDiDkGCPXvhnWiT7OSWe0qIeEbTzWexhziPBPtkcHU3e8Rb5+O
         /tlgILY1cCkR/oTb5Fer+MSi1wa3okdP3WxqUTKgg/gOOBLm5TK4nNdOcKXAB65ch5aP
         GGd9TchcnOhFzrRZQZogsnVKBuglVx2Uait8cdhIkUNXjuu0h3l7HEhI5o8D2DOPKK1F
         R7GWs7X/Dn/npBTUfkgOdXlC5rYhpGtLDfEkL8QyoHHIDRBSu/wiSymMPca5nUy5lvjw
         xPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244710; x=1790849510;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56SKaqZ0iXHf7acYt1UYQ55V03EGjf3BULjEnLjAl04=;
        b=n12+bBDf3u2fqnIiCNb5FYOvxbF+IUH/5hORI6cnwodvyT+Acdx2/IM8lz9bestQdL
         iLm01TjuBwrhYRNk321Jbg0anCEIheRvppSLKmc3KJV6xUbzYGnOZhNf8LcYgNCsIZae
         amYHyeF+XQR4/JAK7KbYqE3auyh2tAL8b8ENx/gcrYWJ97utrq2sfVwgpFre/20BeHzh
         MGZ2u/2lV6Wzeq6oAKc9okut/w0pKinjhl6Sm7DlngVFGlT/76gq6vk8cM5RazV0Uazy
         +iirEWtb0+P6HrwC+vOuk0emhnGdoX0IWCfrucy6LUlfMcM5WumwQDO3HuxVi36VKHE6
         uKqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwE6rEoyMdqP6gAqB/x5ZB1pf6EaevtDCz/u4G+MWl+kK37Eeb266pZUo4qqwTfUEeRE1GOyPuR0gJ+@vger.kernel.org
X-Gm-Message-State: AFuF++lKWUbY7UbmgKS8NPjp/TDXptAIdz7AaC9UG5IzNZULNESlPu6N
	2ERwFsKCEpn6xK+rtgz78gUQovqPPSBKQtzA6VNAi2qie2ocmJR6FWg9lVeP6c9nwCM=
X-Gm-Gg: AYBFou0YrQmwkgoFN4MoxgaC79y/3n6XDASOZiLlW12gX8o8KjvFASuphjIMoKDPpZA
	il5JJsZG4qp9PEjDq7OCdC+I9VWKD7m6rmzNil+/G+t3nB2WSgr2LFGVwvZ1ngpNXkEM0jCWkYm
	ne3A0YiACRSnbB0SylZLIh21IoSOm3SeRf5ECIJsWKv7FwwnGM1RkWoFZUPG4VMyi4t6JrqEELl
	2B2ZjkyL2CFCjxX/3KjatS4ecIjTsTPoQHrJe1nQ6hqTTM3yKaYcNg+9QeZ+6VKwjMxsj+znAXu
	NXkoM1ETCRRcYecF+I0MWJH3a5HIZjit40gHmWoPWCj8vdjLsLrsFsVwcqAfDQeKSM8w73Z3tSB
	xEAZ2aR4E3SOAQcW6/mIz/dQQ7pl81Azw//vD6AY1idO6Q3oKBmk3uujo2gDFV5qjCHfQ5Ht1Ft
	OeA/jKcetYK2ZzRVGjLcncgRki5HisrK0co+tJOyaq6ABpgzaHgQJA6srZwE+T1g3v1Nz1A8Oil
	au9/9RcKmX/Y5kl1Vp/5Ou4X0WJWu5kJ46i//I3iazocTtA38lhI6C1Q/1RIh0LHihLdAEOAhpt
	mw+Ij1lTL8q2xh3JWkCwTJoCNixnObI=
X-Received: by 2002:a05:600c:6090:b0:49e:6e94:7cae with SMTP id 5b1f17b1804b1-49fe670424cmr28420905e9.28.1790244709782;
        Thu, 24 Sep 2026 03:11:49 -0700 (PDT)
Received: from ?IPV6:2a02:842a:161:af01:6a31:4b53:f1b7:80e9? (2a02-842a-0161-af01-6a31-4b53-f1b7-80e9.rev.sfr.net. [2a02:842a:161:af01:6a31:4b53:f1b7:80e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5e07bdcsm50921975e9.15.2026.09.24.03.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 03:11:49 -0700 (PDT)
Message-ID: <f5314ab6-e29e-4f92-8006-3679b1b28f5c@baylibre.com>
Date: Thu, 24 Sep 2026 12:11:47 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: ti-ecap-capture: use regmap_assign_bits() for
 conditional set/clear
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 William Breathitt Gray <wbg@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
 linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
References: <20260924083448.461792-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20260924083448.461792-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 10:34, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Replace if/else block using regmap_set_bits()/regmap_clear_bits() with
> the simpler regmap_assign_bits() call.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/counter/ti-ecap-capture.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
> index d77a256f0ed31..1b79031544646 100644
> --- a/drivers/counter/ti-ecap-capture.c
> +++ b/drivers/counter/ti-ecap-capture.c
> @@ -254,10 +254,8 @@ static int ecap_cnt_pol_write(struct counter_device *counter,
>   	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>   
>   	pm_runtime_get_sync(counter->parent);
> -	if (pol == COUNTER_SIGNAL_POLARITY_NEGATIVE)
> -		regmap_set_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx));
> -	else
> -		regmap_clear_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx));
> +	regmap_assign_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx),
> +			   pol == COUNTER_SIGNAL_POLARITY_NEGATIVE);
>   	pm_runtime_put_sync(counter->parent);
>   
>   	return 0;

Acked-by: Julien Panis <jpanis@baylibre.com>

