Received: from smtp.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1DB44A72C;
	Tue, 14 Jul 2026 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032074; cv=none; b=eh5L6LhyP9BOKn8eQHu1xLTt/JThOum8bkC+ZbtCh1MW57YjslKSoZh+pQ3NNR/+VPr4wfQ3Diinp2qJT858HBqYU9jKUEV/CVCX+ZWowk22dXdGrzSc7PiHHiRJvBvo8YEILCit8UqzIvgm4Rh15AY6EMvqPj91EJhM0tOwpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032074; c=relaxed/simple;
	bh=t+ppmdY7BNl01Py+5OGAOByO44CnY3ef46K6IyKA/iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obiSVGYlZhVQ1z6kvmSgIBe9d3y1f1DkJTsXu8/0ulTnoQK/a+4+KfbJ7OJdOJwIFiiWOqc1DXAMj0U9y+xBOTXihmUfQmHAljjj2e1HH2Di4Eoo0tjJNvsX9BkeSpmCttjJ3HYVnthy6aW5TiH6I/ijixqI2C+bl2gIM+/3ong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=GB9euRps; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="GB9euRps"
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id jcEhwhm4KSEACjcEhwdl9D; Tue, 14 Jul 2026 14:27:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1784032065;
	bh=vPJGEdX+EPICgyBC5ofByQY+OsR+xNxvYCsOAgcdNYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=GB9euRpsYFNIi19uGd1Zf576XE59mwN4oB4iIuoh7tpHbJu50TlCWf0P1HVJfqAmx
	 neiEuVk5PQ2m30ZfCtRDnGxY/08msXCG8/+fLMRhhAL0ZwIwNxH0X8nlfNujwuE1Lz
	 outm7X7OSSsQFSE9Sx8Dbo8xKz6aGFoLGOC1MjutU3XFrg0WBSTlFOZKIDFwHqmTcD
	 pmOJMrhwzL6Bn2PNOSFJ4CmjC4h2eJuoSqW7pUgOIyJ2OdR2JwZNb3bzWb9xTRwDs+
	 4BYREyknhNKmppsmckak3dmW4Zf2QDAYUmeabInX+IHoJeFmMp8W3wm4HSZWA3YsCK
	 Y5qfpQ5UPm3AQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Jul 2026 14:27:45 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
Message-ID: <7732c2ae-b4a4-477f-a6bb-1368ee278629@wanadoo.fr>
Date: Tue, 14 Jul 2026 14:27:43 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] ASoC: ti: davinci-evm: Use dev_err_probe() for
 error handling
To: phucduc.bui@gmail.com, Mark Brown <broonie@kernel.org>,
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20260714120042.491712-1-phucduc.bui@gmail.com>
 <20260714120042.491712-3-phucduc.bui@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20260714120042.491712-3-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/07/2026 à 14:00, phucduc.bui@gmail.com a écrit :
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Replace dev_err() with dev_err_probe() when reporting
> devm_snd_soc_register_card() failures. This suppresses
> unnecessary log messages for deferred probe errors.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>   sound/soc/ti/davinci-evm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
> index ad514c2e5a25..7bcbb0067e25 100644
> --- a/sound/soc/ti/davinci-evm.c
> +++ b/sound/soc/ti/davinci-evm.c
> @@ -247,7 +247,7 @@ static int davinci_evm_probe(struct platform_device *pdev)
>   	ret = devm_snd_soc_register_card(&pdev->dev, &evm_soc_card);
>   

Nitpick: this blank new line could be removed.

CJ

>   	if (ret) {
> -		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> +		dev_err_probe(&pdev->dev, ret, "snd_soc_register_card failed\n");
>   		goto err_put;
>   	}
>   

