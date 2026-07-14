Received: from smtp.smtpout.orange.fr (smtp-80.smtpout.orange.fr [80.12.242.80])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978839A047
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032273; cv=none; b=Vnbd1H+C1Da6doC+dDtFAn7nlWOP73azUdsb9Navumzw5xeKxdL49bk7GPxkNAYgEfRklNer5cEsDHNpSjhQ29Ak5MhHy9fgrlX89StxnWTf1I3JWXSE2EfNHnQHdTC2y7XCbpSLSZhPbJXtEqqj9p29Y++GTeA7Ar7Gpy8Vuvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032273; c=relaxed/simple;
	bh=RW6wPWUi1st4s1WXtM0CJgTGwGSA8+EL3pQTtLAGaOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPopl2epgcABHn8z16I/WMW2VsjiaTS8pHu9FKejdD4Usj7ZFq/EfZBo3bGhqhWeizDkMKQFbVfiUxuzl0ZhZdQzzBUpGHIT6act/IdCyW5agOFX6piF8QJJQVGVbgAS0RH+hu35I5d0ApmPa13PdDOIgaUE/zngJG9edzzTVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=KLGDzOjT; arc=none smtp.client-ip=80.12.242.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="KLGDzOjT"
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e] ([10.65.86.59])
	by smtp.orange.fr with ESMTP
	id jcGmwueSDaEKtjcGmwsrpv; Tue, 14 Jul 2026 14:29:52 +0200
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id jcGcwWiKeZpwkjcGcwzLtF; Tue, 14 Jul 2026 14:29:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1784032185;
	bh=NpIdg/yQDq97LyCwXqHSx/Kw6b7bYOqxqyYKlRjQ1p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=KLGDzOjTGpEL39la857yBMC+ZfuoY0X1HZ1z3tgFzlpTP/R9emr95inucnhcxzS4Z
	 BaATfiFMWuVcn5hz6ogTtftlkvdp2q2O1bLO4U1S2p1w+YW1MHLtquHXht3/qEPj8j
	 j4wf8YGdz3qQt+xULKIDyQtMYo9ufjVjPnkbcF7tMNlgp/KHmEb/PMwkRDpq+rOv9B
	 xpP5sLxHh43CCPZmqNTOctYBNMsnWsfamHMHlwwosrq1qQrPMP0iZuqDnQcE+8eCF1
	 PI0163RESUKANRk0mZRZjISztKpHXbw/5EyeLZJlEDLMXCLQEbRg33z6yOGcs8KRuo
	 FtHak9VLlf+YA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Jul 2026 14:29:45 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
Message-ID: <08dc1142-0ca0-4bd6-b59f-12a167216c03@wanadoo.fr>
Date: Tue, 14 Jul 2026 14:29:41 +0200
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

>   	if (ret) {
> -		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> +		dev_err_probe(&pdev->dev, ret, "snd_soc_register_card failed\n");

Nitpick: Could be snd_soc_register_card()

>   		goto err_put;
>   	}
>   

CJ
