Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8E367F3A;
	Sun, 26 Jul 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087539; cv=none; b=JbZA8z3W4mvHM1Zs3XpgtTn0n6K5D94xhtHeyimPugVVRKPgjxefz/3eQK0xZ71t70bxpqtYc1SihfoUY+dm4VjJwWomhuyWJRgTTx/m/PkugMObN/caqHSgIyE1Pii/jO2fuxughI1X3wffRxtbFG17i5d4DnJgfESiSof7vBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087539; c=relaxed/simple;
	bh=MXq3s6VJ9sBeiJj7GhM/ueov4grKJHzvgG7S52n4NXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiacOPPRIKs5CE1AiC9+jn+uAjpzUO3SZmsuwYLuXxCpL9KyvckTulSKaISj5i6dsZDvf3g2OspRohDD11vaixaO3x6rx3bYZEyyQ/91GUZcbT20+2loLlyTdVIpDHEtc6yaQ0lvKvjpsKrEgx3H1wo5BQVxwE4+xlQXnQ2t424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=o7q3q/zN; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="o7q3q/zN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ayt1hpyTmKcZuBtLSjNcdkvNU84O6raRJ5f8Zr6LCV4=; b=o7q3q/zNRh+R5SLsnx++UdVeMM
	5dvhiRLkHlRle8AJsK4OZMfqYbLBAZMLqYnFZxzLOOIt+/NSnW7ozFGcDGiYKEW2XtjQkGkz/vmNA
	uPtkZCYC0WFUypKxMM/k1N+yAth1tWpYzrpbfoMyipZZ52iJRINCP2pAAGOIE26Mwwv75FrGxyum0
	FpgP649fGinvRsCw8XdfLNFxOQ0FUfJKuJGpVKbVNkMYlONodET48F4otQ41RR+qhi2tUspKb7YJl
	lN+uqkMILWg/v/+UpNe9/SV2aBX+xw4bnKbFUqWnuTfDgLdpbgIKITIdbiY75mSvHP/In4O06u9Qa
	yfYmFETA==;
Received: from [91.159.31.97] (port=33992 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.4)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wo2oP-00000008P9j-3edu;
	Sun, 26 Jul 2026 20:38:53 +0300
Message-ID: <987efe58-3867-4271-8356-e75ea2872511@bitmer.com>
Date: Sun, 26 Jul 2026 20:38:52 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] ASoC: ti: omap-abe-twl6040: Use dev_err_probe()
 for error handling
To: phucduc.bui@gmail.com, Mark Brown <broonie@kernel.org>,
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20260716103911.77652-1-phucduc.bui@gmail.com>
 <20260716103911.77652-6-phucduc.bui@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260716103911.77652-6-phucduc.bui@gmail.com>
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

On 16/07/2026 1:39 pm, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Replace dev_err() with dev_err_probe() when reporting
> devm_snd_soc_register_card() failures. This suppresses
> unnecessary log messages for deferred probe errors.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  sound/soc/ti/omap-abe-twl6040.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
