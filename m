Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5A3BCD13;
	Sun, 26 Jul 2026 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087554; cv=none; b=Pse6rM7PJdPuwaRuf8DIuvP0kCyfmDEv+4fvRe8Nsu3cGUskwgbKRdB1z5EZq103wXxnJzBfr15OtW1heDLIga0cbxtghSmYcY9o4LZ49By1wFC49Itwq1PAjt2VM9XrpD3dEeDq1833Z/LVjUrIwWD5e4t2lBWdj83Hwlx2VYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087554; c=relaxed/simple;
	bh=QW172QMzNZzvccvmWWHD4aJG4omsUOReZtodhukLK80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GE/cvYq/CyjjSZitwisJ6Ywuu3nQO7GYWt/KHPL4/7tuGIUSWi+y9hHLdFIHqAUXmnMm2lqqutPgxxWtwMp8wKkx04cwrKZ+wEfJnu/8iSr9WeLcLdV104VGNqScQiG95O9GkuGgYP4etnp0t89rdHIlODwAccKUNgubNLkWqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=GuO+rkvF; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="GuO+rkvF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8nORIsoror4FHF7OB09nYl4EgrdzkkWS4ekyqUmbdJA=; b=GuO+rkvFKUgw0iBzxTGIOiXZbY
	U93ToJK81Vhdjiib3J+Dx18si1pkUX4wf07VgDOE2CSyW6Ggqigd++ojPiYp7vkgtevp087KKbZos
	E4HpjZc3Eb1ZcHXHOPizydFBHMm7iiuWpcHd7c3aGqe+iqQfAtHWolTkOM0P8tlxQVcmrtKzl05G5
	Qhhn8qphd2WCprSwOCa4R6uOpdMTpFR/7ArIdFIJ5KDv1CwIK1qxwVq46sAZW5bPyoCS1Lkg6i8oR
	fYhaFgLPvXVmM4dfXSlm3wr/cHt8gEXyE6BvTjYUg3uvlIyc+r5scUBmabtoIfsXfXDUWRs8IdbQA
	AXfkwlgQ==;
Received: from [91.159.31.97] (port=59064 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.4)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wo2oh-00000008PGA-0wqF;
	Sun, 26 Jul 2026 20:39:10 +0300
Message-ID: <3bdcb190-57e6-4143-83d2-e2fd457fe237@bitmer.com>
Date: Sun, 26 Jul 2026 20:39:09 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] ASoC: ti: omap-hdmi: Use dev_err_probe() for
 error handling
To: phucduc.bui@gmail.com, Mark Brown <broonie@kernel.org>,
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20260716103911.77652-1-phucduc.bui@gmail.com>
 <20260716103911.77652-8-phucduc.bui@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260716103911.77652-8-phucduc.bui@gmail.com>
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
>
> Changes in v3:
>  - Add the remaining missing parentheses to `snd_soc_register_card()` 
>    (Cezary).
>
>  sound/soc/ti/omap-hdmi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
