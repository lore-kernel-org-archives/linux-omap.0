Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF34BC02B;
	Tue,  4 Aug 2026 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864456; cv=none; b=mmTqunpe63uoNDx+d4tUTYhoEfdlHnVZg7g9SU1JFUH1ad4OdyU/oYBKYUKNIw3AQUJik9qGFJWnqwWa3h9EWJ9J4wdpHqtoKZhKnCVnSQl5dteE3biiv1HSV3NZsJvPZ5iJ6lAW3Hkr002WKM/Tjbk6KgFfdUNYp5DAwonfsHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864456; c=relaxed/simple;
	bh=qyL/5x3Ox5XUKT5QVUlAMNQIMDxvdyUejXmVLdlCDUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXSIKMRKO1i91vpdl6lNz/REg9eGGCDyEC8gAvJ00HfPPbsUT/JHZ1aXTCfg2Wu+Ub/ekClzjOrnbtSykpP6vQEAIfvzEok/b1icVWx8RUssENjbkt4LtQbSK7cgB/d+zUTtJEHV60aHBgyKvOexLm8QWcx8rxU0uzEXt/bgF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=E997o615; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="E997o615"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=Fq+sDujD4P6pQWOyHjShxqRFFnBlL2GQ+cPVDEnwW/U=; t=1785864453; x=1787074053; 
	b=E997o615uof3Kfdl/PaFJ6EYJojToxNmaX9BBNvM/DSQy/W7W79aRkVlqMJORkMQXIeUbXD99Vn
	KihvZdDqMTEjym5+xs9s01g3EOdKbgO3mPX/Q4+xcIZ9RQ2JYXshjTXg3p5UTrtij+On0dgMynFek
	yUs8h1tos/ZvtRq7X46t6xamGMMQ6zYuWn5iowKspe0pX3KthE1nl7wy8fC8mGNQmwz2cSC+doyEH
	DaVj97jGpeTFYsHlHbJjOwdBWL+mQGPZkKhm+FNTg6/9VMAR5U7T1Ui0S34xBs6Dt2GPU2GQBtdAs
	1sqGtwTZg4HR4v9rjfogNRtBnHwPsad84jbQ==;
Date: Tue, 4 Aug 2026 19:27:16 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: phucduc.bui@gmail.com
Cc: Mark Brown <broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH 09/10] ASoC: ti: omap-twl4030: Use dev_err_probe() for
 error handling
Message-ID: <20260804192716.50d277b4@kemnade.info>
In-Reply-To: <20260714120042.491712-10-phucduc.bui@gmail.com>
References: <20260714120042.491712-1-phucduc.bui@gmail.com>
	<20260714120042.491712-10-phucduc.bui@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 19:00:41 +0700
phucduc.bui@gmail.com wrote:

> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Replace dev_err() with dev_err_probe() when reporting
> devm_snd_soc_register_card() failures. This suppresses
> unnecessary log messages for deferred probe errors.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

> ---
>  sound/soc/ti/omap-twl4030.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/ti/omap-twl4030.c b/sound/soc/ti/omap-twl4030.c
> index 2a80e44035d7..576f4d3615e8 100644
> --- a/sound/soc/ti/omap-twl4030.c
> +++ b/sound/soc/ti/omap-twl4030.c
> @@ -306,11 +306,9 @@ static int omap_twl4030_probe(struct platform_device *pdev)
>  
>  	snd_soc_card_set_drvdata(card, priv);
>  	ret = devm_snd_soc_register_card(&pdev->dev, card);
> -	if (ret) {
> -		dev_err(&pdev->dev, "devm_snd_soc_register_card() failed: %d\n",
> -			ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "devm_snd_soc_register_card() failed\n");
>  
>  	return 0;
>  }

