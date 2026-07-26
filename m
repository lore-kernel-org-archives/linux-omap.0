Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4D3DA7D9;
	Sun, 26 Jul 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087636; cv=none; b=Wp1XgT9ROPgSW6px+Ewk3CWrZ70RC13F7ESJEvWOUrI4XE5nRVFvhuSCewqzSIMH+SETsKgUwgwlRCr+9J38PEctzgL8VwVVmyvajrq+KW4Eh/6Ywqfg4Di2v0sDITF0uNtYFcumS+c4JHKzqBe7ZD5DtEnu7lYPJ6AI32lsrRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087636; c=relaxed/simple;
	bh=W5/mOebr/n12Vg4epmIbpMLOytPTgS54wLt+iEqyJE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nt8W7h3MPfx8IEJT1mPtCN83JRKN3ABkLT8FmmC2CfS0fAu1LUMKcUnOmENf7YPyZ3rvDVLvRMMAXw2Vs73alTRNzZVPcXG8W1H9aeDJP6WRVca+fHnV+fXisbDTxttLwT/mqWpgeWuiopA+2d6Vn6f268k7LSi+f6pXdBm3now=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=br7b8sW1; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="br7b8sW1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d77xb8oU6RiC5GmOnKwBPb2u2ezWvvsgeVnAinBTMS4=; b=br7b8sW16692IL4GCESoDA3Hdj
	gdeVgkn5/5I4mpm5ZDCEYW0d7cgz7LeY3tlq+GOEE+ka3UN3u5mLTnCYEa0RQc0o7pta2AvGqHiHd
	Pz0w94y8pLaGtKR8guMWoTKebwct6HmqKr2ExjvM9qZpZRFMwD3Z/O0UCqn79xEN2dvojPhUa7F0i
	9MpzzJkHxsM6X5X59L7PXAEoDbtnKztheTAJpTWex3S/qHfSfnD9s3P3tkZwVqNM2WRq0rcDmn6ck
	p8cxD7w8WqX9HkQqJbrwviDdN8AYEbBaaWvNjlrxGP4+kh2rHF4510okc63BclWeb0UF4dnGQIOaF
	WhMHltig==;
Received: from [91.159.31.97] (port=51530 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.4)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wo2q1-00000008Pf3-1sb7;
	Sun, 26 Jul 2026 20:40:32 +0300
Message-ID: <5b8e9f9f-7e8c-43ab-a554-e1b5b9b5884e@bitmer.com>
Date: Sun, 26 Jul 2026 20:40:31 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] ASoC: ti: omap-twl4030: Use dev_err_probe() for
 error handling
To: phucduc.bui@gmail.com, Mark Brown <broonie@kernel.org>,
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20260716103911.77652-1-phucduc.bui@gmail.com>
 <20260716103911.77652-10-phucduc.bui@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260716103911.77652-10-phucduc.bui@gmail.com>
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
>  sound/soc/ti/omap-twl4030.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
