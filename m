Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0C3DEAF6;
	Sun, 26 Jul 2026 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785088814; cv=none; b=gApCAhOMMDhhjWTtp44H0OjqEN8FLzgYzNciNcgK+rHYy8Vquf0BYuhC5ogqJJRPhbzYMGwXmwL2O52l7AhMjWDeNP9YcGbRmTdQTd29qocaEWoxiJj3XQ2b+UUtWzawNuIwjzRvvGETTP5wtVLOm6u0+GHHkYWxNSkz4YDXTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785088814; c=relaxed/simple;
	bh=tVKBu0gpgDXWfiW+57omA5cAQOKd7XQp02oAulWBFWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVLz76s39in2mYkV5NXZPIyWPbCkstO8QSu2BREWkj2L13H96OyCfMX+mN1GmTgU31olmwuGtF+0NP8/EYRVPAYOibapzSa/Bv6cdyfBvlmNJEdBjXQWihkxUrspzuxr/bDGa6MS27LAQeO+dlOtiRGMnomdIH5Q1nrTyNbquY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=sppqTzIk; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="sppqTzIk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jCDjGDSWHZ8w+rxNCIKGEKBL8u1SAKE5Py/Ctugufng=; b=sppqTzIkEq3n+rd5IRFrMuvZbf
	lNukKLaw2L6/Eksg/qJEhPbDpCl7+KBapufWWQBBQYiSI51P3FUX8Rtsaa/YebcnBmLPsdVSifxsZ
	Ygab1xVlhVk/flg3C0nnLOgs8HHHyp4R8oRdlJP0O0OLnP43WijVcwJ2wdueORmnG3oNLhDZQCUnX
	au4bwwuOQchdtZTrZ5O8qZwk/bCQOFUCfvyJ6WzAP6VElwnQM+FKK5poRD4pJ/VooVpGQc5v2h7qX
	C3aIEm3UaLcMLN0jKCG9ix9SB2bqVHbKQLQCo72iU16590Q9H/UdKIMdD82ULulmqLdVZTEKNZ/2G
	U4Hh0oow==;
Received: from [91.159.31.97] (port=52472 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.4)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wo2oG-00000008P6c-2R1S;
	Sun, 26 Jul 2026 20:38:43 +0300
Message-ID: <ca078c36-1692-4d54-9d21-99adb0abd072@bitmer.com>
Date: Sun, 26 Jul 2026 20:38:38 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] ASoC: ti: omap-abe-twl6040: Preserve error code
 and drop redundant log
To: phucduc.bui@gmail.com, Mark Brown <broonie@kernel.org>,
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20260716103911.77652-1-phucduc.bui@gmail.com>
 <20260716103911.77652-5-phucduc.bui@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260716103911.77652-5-phucduc.bui@gmail.com>
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
> Return the original errors from the OF parsing helpers and remove the
> redundant error messages, as the helpers already report failures.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  sound/soc/ti/omap-abe-twl6040.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
