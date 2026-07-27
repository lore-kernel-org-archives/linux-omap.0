Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881337E5D1;
	Mon, 27 Jul 2026 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174398; cv=none; b=DKOiVh1I2D7JX/40qtVc8o/p14fY53fFTVXTtyHD4lou6bQWJv51Lk7etEZ3iqNxZluV5E/HPGm8hCPIvXG43I3RSMMyAnzejmk/eZYanvZcMzYGHTxxreOxUGZukyZriwi8fhOjns96sHXXRO+XG9divIpiF5KWGROcIQDVni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174398; c=relaxed/simple;
	bh=4GQf9zII4xWZeNKUiKhHcWYgjmrUK7MYlNNtb+Ih4ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h124X85HlLCPuq424g429CqTEIYJ+diKnI+HtTm6w+2yGUYYcXve3UzKRrhG2xRXkVDX/vxrTW77bHss2+jpkmVDPFoLl0MCTm92Tgd3XSjlmsuPtLtm9Ggrwnk5oggmcMAqrUyb9gIZmWUqyj8Ev6ygoSJwRsyGlnfvYbM+QtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=ruDEN9jX; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="ruDEN9jX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=POHBCccZTg7uK+mTMz18wgBj6jw0NwyuFmsp1gecDn4=; b=ruDEN9jXmO6kUKKNwGhz07rtH7
	uT0wIZ4JJMT9g1hHCi6UBRxth8Xhq1uKEyXWvaVxfz0gbLjH2vvQ88JSHjCjGkZE8QpTLJrVz7ijW
	/BwatjIEMidoUj2YlWeEmMmkFNiaQ9+Tn7ZZuPyZUcRgisR/lWJ/vKqxJLGp+Hp9HN70sQgwlFyEo
	CWzfimmQyoX8dOdLDKbZmyMRDAFPNPMSOey3/XpqVSMQ+8zuOiRoHuGh8NLSrPGWNM4NuzKp01rJ+
	u7xosQ3B4lHPVMWdd2/qIf5qq1SXEohO6+iFFO+s4DZgSz/4OA0LDigOzCbMXcqntr0oqc0xFmvXd
	g8V3pBUw==;
Received: from 91-159-18-144.elisa-laajakaista.fi ([91.159.18.144]:45308 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.4)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1woPPB-0000000EPYy-3a7M;
	Mon, 27 Jul 2026 20:46:20 +0300
Message-ID: <682769a7-887e-4afd-a61e-54348955ceb7@bitmer.com>
Date: Mon, 27 Jul 2026 20:46:20 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: ti: omap-twl4030: use per-device instance of
 headset jack gpio
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sen Wang <sen@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724233432.31325-1-dmitry.torokhov@gmail.com>
 <20260724233432.31325-2-dmitry.torokhov@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260724233432.31325-2-dmitry.torokhov@gmail.com>
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

On 25/07/2026 2:34 am, Dmitry Torokhov wrote:
> hs_jack_gpios is being potentially shared among several instances of the
> same device, and is being modified. This is not the best approach to
> structuring the code (even if the device is in fact a singleton).
> Change it to allocate a per-device instance.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  sound/soc/ti/omap-twl4030.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
