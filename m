Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224D459AC6;
	Tue,  4 Aug 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864948; cv=none; b=RCFK2oUKw0aTq0JLdIyNZQmvX+ORniskXJV+jv2AWrrcloB4qxrtZKlCkzs8RWWgSRlDdv7TrYhxN856vng/gHlRNf3JHWjI4z1qgkvPsQHc7ICI4dyLksQrEjHmMNb1VeF4mjgwpgTmWFFo0MdkAUsTZHh6pEfR+8NvOxTS2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864948; c=relaxed/simple;
	bh=C0H58rqW+NSgxQmrENxcl7tvy1wGdmaMFIn7L2uZrig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHCjK9LhKoMR8zdRdN2mX6lru30g1382uNXb7SXJTCFfJZCCNRKD6rxIcIcgrGZkJIFHIETNybecylEonPS6nudynYe1X+fGbQCU6JZMyRMDK5fnU37+TJS1YTxVrCh66OPaQ1Ztjkf6Jf5buIZ/rkZEeUPAxQir1XkWUHNVlkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=a49zBhs0; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="a49zBhs0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=UPUBmQlv5teqhxKd0ZQtI7v5rLM99/5ueqGNHI0o2x4=; t=1785864946; x=1787074546; 
	b=a49zBhs0Xthjj2va1H/xnBx5V/afXWskQnOL5odordNhPPAAraEjMrJtzIxpp0rIOdtvheoWcgI
	p1uSY82bBbUQb+NIYpDGVcEKs79NLyWy93V/iixMFKUZWzEd+leoxS1Ay3+HdwYnDeB3FLlw3BFv5
	MsyW4L/5FHs+bqXEDPzZoqZWMa9YaAJhb3io+bcWhjMcNs7/OiWwzQL/RUMKiDuYHPTcnBXsKIFFB
	WayXU1dAm/FxDQ4vmqU/0TLCpXzHTFH8IkbHKK3lzl9JW+r4GhqLJzqybzV9k8xXz7dW53Li7JYG5
	HqZuwoboXzqcKBAJs22XI8G5xXf664ahsVKw==;
Date: Tue, 4 Aug 2026 19:35:42 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: phucduc.bui@gmail.com
Cc: Mark Brown <broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH 08/10] ASoC: ti: omap-twl4030: Return the original error
 code
Message-ID: <20260804193542.3a83d4c3@kemnade.info>
In-Reply-To: <20260714120042.491712-9-phucduc.bui@gmail.com>
References: <20260714120042.491712-1-phucduc.bui@gmail.com>
	<20260714120042.491712-9-phucduc.bui@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 19:00:40 +0700
phucduc.bui@gmail.com wrote:

> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Return the error from snd_soc_of_parse_card_name() directly and drop
> the redundant error message since the helper already logs the failure.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  sound/soc/ti/omap-twl4030.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/ti/omap-twl4030.c b/sound/soc/ti/omap-twl4030.c
> index 4d80f8a7a947..2a80e44035d7 100644
> --- a/sound/soc/ti/omap-twl4030.c
> +++ b/sound/soc/ti/omap-twl4030.c
> @@ -253,10 +253,9 @@ static int omap_twl4030_probe(struct platform_device *pdev)
>  		struct device_node *dai_node;
>  		struct property *prop;
>  
> -		if (snd_soc_of_parse_card_name(card, "ti,model")) {
> -			dev_err(&pdev->dev, "Card name is not provided\n");
> -			return -ENODEV;
> -		}
> +		ret = snd_soc_of_parse_card_name(card, "ti,model");
> +		if (ret)
> +			return ret;
>
The error message seems that is wants to catch a non-existant property. 
snd_soc_of_parse_card_name() seems to ignore that error. Which is then
really catched by devm_snd_soc_register_card(). It would be good to
point out the error explicitely, so probably printing that error message
on if (!card->name)

Regards,
Andreas
