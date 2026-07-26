Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9673C1977;
	Sun, 26 Jul 2026 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087548; cv=none; b=OwgjD4ZoRoC8f8HmQTNW8jlsty9M8w5Zn1s7+XD9HugFLJMV245jTae9ZbDYsB/5AGMTFHxF2GSKTqvl8Alo+rA5oRHjV8CPn1/IREuwcEzFne+wZMcI1XqnDU8u70Qo6SBFbeLV3dcGLmS5w7F2TVsdNKlFJxXIjQvWHRnrtrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087548; c=relaxed/simple;
	bh=aU0ldi0qILBIA6+Acm+AUk207Hs5OsHN83NAZEgRJZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ig75CUH17YcpJ1enZmteH8GKXKISb3JuGCTQ8QLG3r+pnWhx8cIt6UeqKxShzzZxziT/S5Aa1JA7QirusBI8v4scz1gOZ3EiUhUfXqCSZUMplnxZQn+J7z2SBeVNch2GY5+yEgE4O0A2hCJzzC3XMqjgSFq0dFDIxXkw7Lz3oXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=d4AKRVOF; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="d4AKRVOF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RpKGK8icvYdW1jEab8T7eH6GBRuQy9he7BMgTv5bpAY=; b=d4AKRVOFif053VL1ZgceXFBS39
	WswXwujxWOQ219pIEBHGlR+L+ZffVmdhwfOIGXNtecJh6ImTSB0LeZUog0IKywPEH896u2X8GLg59
	dyG96mr1FZJN+LvlaF918fF98eowLk0F09MXlei3f5HyWOJckSa7hwE6msgsVZ1G1KV3WCRC72DVJ
	JFl+0eT/nqQWPFUuP2a2Sj/ofdKFbi9JLYNtfYpEfiZopRwWS2QIxwJRQ81pH/bm23qxnAg1S3xax
	bY+MUz6snJPl97IUZHw76QAf41hc/ePtIPNKBGsy9IZoeqbpbmQAfphIBLlTu76HGEyJ140dGl/lW
	atMDO25Q==;
Received: from [91.159.31.97] (port=59062 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.4)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wo2oa-00000008PDl-0c7l;
	Sun, 26 Jul 2026 20:39:03 +0300
Message-ID: <63d31e83-43ec-4eb3-b963-f70221c2edc2@bitmer.com>
Date: Sun, 26 Jul 2026 20:39:02 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] ASoC: ti: omap-dmic: Use dev_err_probe() for
 error handling
To: phucduc.bui@gmail.com, Mark Brown <broonie@kernel.org>,
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20260716103911.77652-1-phucduc.bui@gmail.com>
 <20260716103911.77652-7-phucduc.bui@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260716103911.77652-7-phucduc.bui@gmail.com>
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
> Replace dev_err() with dev_err_probe() when handling clock lookup
> failures. This preserves the original error code and suppresses
> unnecessary deferred probe error messages.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  sound/soc/ti/omap-dmic.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
