Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27B3DA5D9;
	Sun, 26 Jul 2026 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087646; cv=none; b=gP0TzVtrPTnb7UIikZ70xzVvyJx4OXIe3VVEFm5/CO0icIdPkcsMu//U0L1XzO0Lp5GaD5Jb3LlV64oSE+goTekkgOotY7PgiI4yUfbACBe9IuCeudXH9D5Q13DNUrbP80nHW48sk2oLkFbEkYj8a7od3N7XqDeLanqMjM+BvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087646; c=relaxed/simple;
	bh=mRp+rr8cDlLX73SLvdVD4aOSzET7Vj1VhPaDbXGcNW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPGQhsHhIlimgz1zwwnldl79fVtTUHx4lTRfl3sODSpmpgreQZTy2uoEOyLTiCLLmb8Ql1bLhrqzg6Pm+beQB6ec5tEU/0sD59JBgBwt3hrdSrCcAfqfD+FrNwEd8bPUGqzCTYmtlR5J1+jjJX32MQFoinQhXU/gEyENu58OAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=mVe+kSXr; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="mVe+kSXr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bn16P+V0+rY6UCwpY3b6RZ4d9nVrO7WjgdIjHHMOpag=; b=mVe+kSXrgnj/Mhq+4krIGyWqcI
	W59cIK84QmoB1ODDqV+uHVGJ67pDuW0+Ra0N0vwP7r4au6S300TlcFz8HSIvlyZDrj7Zrl/uZWSrc
	VHrzorIEic9uXOkbp/4wv7NcA41mIlpXZCfFXntfWsKdBTq/4VFyYyuRkaMLgjcsEY1XzCkvobu79
	fUnpDAY+LywYzpWjRW7kjwP9kDT6QsgMZU5sNPJiYYNb90q9DKV4LxZqwg5l5klgDNQyD9m2i/KyA
	KVGNLAzAoF83yHfdxzIgq3E/ebSe5k/3uPCklruaKMIXxDJCXvoZsznDCl/JVwxkj0RyT4ZIjIZbm
	8UR1OkmA==;
Received: from [91.159.31.97] (port=40562 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.4)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wo2qB-00000008Phb-1Frl;
	Sun, 26 Jul 2026 20:40:42 +0300
Message-ID: <ca051d01-dddd-493a-acdf-5b92b6d77706@bitmer.com>
Date: Sun, 26 Jul 2026 20:40:41 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] ASoC: ti: rx51: Use dev_err_probe() for error
 handling
To: phucduc.bui@gmail.com, Mark Brown <broonie@kernel.org>,
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20260716103911.77652-1-phucduc.bui@gmail.com>
 <20260716103911.77652-11-phucduc.bui@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260716103911.77652-11-phucduc.bui@gmail.com>
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
> Replace dev_err() with dev_err_probe() when reporting probe
> failures. This preserves the original error code and suppresses
> unnecessary log messages for deferred probe errors.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>
> Changes in v3:
>  - Add the remaining missing parentheses to `snd_soc_register_card()` 
>    (Cezary).
>
>  sound/soc/ti/rx51.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
