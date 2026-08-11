Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8634D397;
	Tue, 11 Aug 2026 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470974; cv=none; b=G4AHDFYLu98K+EBgud4FmJFKRrtF7p0ktMtfpU91w+iZAyL9zcdZk4snH1OPL9oisxUKxDrvdd/moVfOkiRYmLm+6mr9u4bcxSCtLQtnYERx1CwKNqBw2mN18yDpF96NZIofUc0rl9ZYuOuaztAevN0nQNx/hTJSaPYSevQEqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470974; c=relaxed/simple;
	bh=AQznq2K3XYLYCOMJRpNFcwqHm1elWDRib1IFG7WhGf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzXLJ2lkLoK1wWeW2r4LqA3YtXlEpzDmRhT4JsYO0indvlpdhngX1Ke8cvF2wNR2HjGkJJkxFbng2LIs0dFy5lGcJFedEhSyf1MA3kCHFg/KeOrJiKMcJnZKePTZ6n14G+iK/nurjsvSfIUKjcImg0HIJ8DZqWxGS2geUJcKCOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=g/9fSoAM; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="g/9fSoAM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i/8mMTQxpoQsK6nKLeGGpngLMZdh+lDteEOxQlabjB0=; b=g/9fSoAMSDVRiisJnMKsnOAnKN
	AIiTqVKKeYJ8/Q1fcOThqaRnbWjlQBt1jJbp4PQQBeAIVODJO+ZsjPGTYhLr0jiMhG4xkE54wymuI
	A481YiYZEV5kxAITwh1/2ERuCYMkhn9KOerO6M/vFhYtBWdsesQUaSQVFlHAj/kyWS2acylBq6gYw
	pdb+zkVM2cc5Nh6wohl0+WN+lmVYTq9NihXgt15uOgXNrhcaEJPA6Ozya70wAAArT5x4+FAgCWbsA
	imBk6s6GeQzIlCZySzF/30TxBCBl3kEYI9FjPwrJcpSi/4nx5ByUOL5RJhqgaJ1TBZCzLsfGf+6LU
	Zd8MaNpw==;
Received: from 91-154-201-162.elisa-laajakaista.fi ([91.154.201.162]:43836 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wtpuZ-00000005RK2-1p2s;
	Tue, 11 Aug 2026 20:05:10 +0300
Message-ID: <b0dccc22-5f2a-4b31-a6ae-dbbbc9eb091c@bitmer.com>
Date: Tue, 11 Aug 2026 20:05:05 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: ti: omap-twl4030: Check for missing card name after
 parsing
To: phucduc.bui@gmail.com, Mark Brown <broonie@kernel.org>,
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Andreas Kemnade <andreas@kemnade.info>, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20260805044556.38183-1-phucduc.bui@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260805044556.38183-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - wp23.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bitmer.com
X-Get-Message-Sender-Via: wp23.hostingpalvelu.fi: authenticated_id: jarkko.nikula@bitmer.com
X-Authenticated-Sender: wp23.hostingpalvelu.fi: jarkko.nikula@bitmer.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 05/08/2026 7:45 am, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Return any error from snd_soc_of_parse_card_name() directly. If the
> helper returns successfully but card->name remains unset, report the
> missing card name explicitly before returning -ENODEV.
>
> Suggested-by: Andreas Kemnade <andreas@kemnade.info>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  sound/soc/ti/omap-twl4030.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

