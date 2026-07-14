Received: from smtp.smtpout.orange.fr (smtp-73.smtpout.orange.fr [80.12.242.73])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7944A72C
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032111; cv=none; b=UdJQfQ8J2Ob31H5Dl+txufQfkWt1f/QSuYnKUyI41Cqar4t57r+CeRlabpzWtKrhbPEKIGMqUPwyT7POfd7oniGfDQ8KdmYRW8jNB+CdA0Xm1eESWBkp4ZJa23SPtDVzgLyVUxOkCj73cww+xK6PpKPsnW59Jvog7HGF7jXeZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032111; c=relaxed/simple;
	bh=SoU2KTkpNJ0SDFn/Ppb0Jypp+YC1dzti29F3AZJ74gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUHIWPBmcoXdrV4IYm1jcWXh6WPk5KTa3qr/1MvMVfWrn2er93Bt4yFHkZjyuIOPqzwKFIA4KqLc7urp7HRRWbmddragx7xgPCYglMh/xa+kgYvvrce3dqmusbO1V4TuRIXxsXjaR1TqTGnliy7VUzHwxqjZYkccejXMlWkTzgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=htCQ0+Jo; arc=none smtp.client-ip=80.12.242.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="htCQ0+Jo"
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e] ([10.65.86.56])
	by smtp.orange.fr with ESMTP
	id jcEEwBivn4RenjcEEw4yYj; Tue, 14 Jul 2026 14:27:14 +0200
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id jcE4wWjQP6x0mjcE4wMXwR; Tue, 14 Jul 2026 14:27:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1784032026;
	bh=89LKsGNpMkXz1ZIYfQGA+kcsLuEAevP+wd5aF2sNHGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=htCQ0+JogoGuID0nv2pXxcf522egfBR4YdDEd5EQX/H/byEy81cMnCD5Up/AZqtAH
	 ff9RPYCDTQeNAR0Nz44A1zS4d3JUDKEO491/Y8Gtkm64ZNXEhLHufUiMSexclR1z3L
	 WRJZMUcQmUSIappr4n2+Nw2V1i/PX8/HiyDVf9WMTD1rZW+Bnrb4N3dZZXDTr7FIv1
	 7r4ms2DJsodkZTr8pKUNBDY0zfj1klfhFf5539fZROIBpoliyTd1x4xJIFUNkvcc7i
	 JzFN1oRvVzrfN8LXiTtXi3oUAz3bbwNOWhhM2IhT6LZouDGE5YH/8TBJtOFhOjn+ZX
	 qfZtHxJClXsgQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Jul 2026 14:27:06 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
Message-ID: <8fff715a-1386-4f2f-b21e-2f5e6a5b97c6@wanadoo.fr>
Date: Tue, 14 Jul 2026 14:27:03 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ASoC: ti: ams-delta: Use dev_err_probe() for error
 handling
To: phucduc.bui@gmail.com, Mark Brown <broonie@kernel.org>,
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20260714120042.491712-1-phucduc.bui@gmail.com>
 <20260714120042.491712-2-phucduc.bui@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20260714120042.491712-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/07/2026 à 14:00, phucduc.bui@gmail.com a écrit :
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Use dev_err_probe() to replace dev_err() followed by returning
> the error code. This keeps the error handling concise and
> suppresses log messages for deferred probe errors.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>   sound/soc/ti/ams-delta.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
> index 61252359d5cb..1c9342ceaf56 100644
> --- a/sound/soc/ti/ams-delta.c
> +++ b/sound/soc/ti/ams-delta.c
> @@ -574,9 +574,8 @@ static int ams_delta_probe(struct platform_device *pdev)
>   
>   	ret = snd_soc_register_card(card);
>   	if (ret) {
> -		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
>   		card->dev = NULL;
> -		return ret;
> +		return dev_err_probe(&pdev->dev, ret, "snd_soc_register_card failed\n");

Nitpick: could add some () (i.e. snd_soc_register_card()) to match patch 
9/10.

CJ

>   	}
>   	return 0;
>   }

