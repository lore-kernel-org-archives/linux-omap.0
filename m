Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8412F9D85;
	Thu, 16 Apr 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363251; cv=pass; b=LIB9wzsK2C1wB4aWTf4hD8uZNLszEEPbPeZu+A9mz0Ds4VVdNqX8xagavcfQ+r1Bk/Wl2OAPlNYV8OS3JdP6oVLLkIVJawCkxq95q+vadu5e32yoOJFQwp2O6mEtm9FDJ8jv4GpqgRdtFFgY4wohU0lnpYuF81xkS7VoPk0Kj+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363251; c=relaxed/simple;
	bh=vk40c9ez1h57fVsIzjSyatPkMNUBI72M+RLSobdlgLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCE5EUMYWRmaLUJQfgCRVtT+wubs1ZNMcTNQgAhdfhGrMQAgbBlEsrSZ8tEMiu1zk2KG2GqVjPEQ5/6BR/oSXYT5LgQPCIc2lRetnBuzUjtdZtqdjvJ3Mz2yPSTbxEqNzuEN0r19/QAQ9pA3fTL8sTwl66X1lyD4OBRcqpc4p/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=IL8kKkhP; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="IL8kKkhP"
Received: from darkstar.musicnaut.iki.fi (unknown [83.245.248.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fxR3W6HrSz49PyT;
	Thu, 16 Apr 2026 21:13:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776363242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GpSAM8UFpTnSpjttHs3Wu1kj1RSAFR37k9Z3Icr23N8=;
	b=IL8kKkhPY5rw9Klw91YLNjFh7LbY4UXkayV44c/Eof0pr5E7VWYK85SmNtAs/2+91WyMZ9
	yhgSwHCWhOd1GKBBMPm8PUHiT0qgA8lm+qjNr/AGu2wKMM1YC6a1odohN3Oy/89goSpJ6b
	xOlzMN/NbU5k0RT3PMyty8Pqtnm7CN4Hps6Cs8lveAA7494xSt5ooFFzHe8hwp1IcBqKBx
	dbqM0qUxa+HMvsVS4KyC6JjG2NZnlWTYBhn8sNk5j/6AdExtamfJRaN3PPdfuJn7+M5GYK
	aTbh/2KGmvmiYPhVCeHrYwLNNYkU6utNgeaN9KvcS29jkGB75kkj4hFB8bHFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776363242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GpSAM8UFpTnSpjttHs3Wu1kj1RSAFR37k9Z3Icr23N8=;
	b=SbMRrJqpH+362U0Co7R8NPxZQ1W7zqgeYbepi6cQWqDK0SDY5VNlZAfSexXNx/VkXnsVTX
	ijOhsRSsVjVpLXeLCT0OQYVXL/x9gjKQ1vn0apWrnuCowrou+qjPdXVHRBBHxftLNFQwag
	Ba8suDmWs740/EAhKdc2Hbi1jPiFn+lzL406Y4jO0VHhf5sGdbZPwK57plJBmF75x8JglG
	k3j2HPx6Vmp89IYRGTA4UEcnqPFPdNstA4WQyFnKeX+DGJ3Efh7Ie9u1hWgr2/JAWO+vcW
	GQaigoivDK3roGItAwhXythG8slc2tUWJHYXGcFB6V73ZIsA4uSt/N79PhaFqg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776363242;
	b=rxPaotNNO6Lo1IYlwpf4/d8K30TUYQKrneGwIORu+VDhrF8e+vrpdlU11qjgtxwadyIG8G
	iZcrlfW0SKvEyMpihkdFF67whoUpbPk7pLz/tfpzmPSHLpPbJg46hDmbNzqOEE1PH6PKrz
	SLrVdYONAhWSFbCnLWGJ+FCDTahHhbfMs0Y4CfCkD2QhdII65RlzlGIM7I27TbZFaBOizd
	FYP7ZvvoUILzKiwPZ3D7wMOCk5Edwr+5kVMi05Lg5DGXGFst4h7gb17vQpld9i+C7QcjQf
	lH2zX9LFug/wlfum2/5ORbefxDCbsib23bbgz4tHl7F94T4AJc5xvazbjtg/pw==
Date: Thu, 16 Apr 2026 21:13:56 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] MAINTAINERS: Move Peter De Schrijver to CREDITS
Message-ID: <aeEm5DavehkPmSgl@darkstar.musicnaut.iki.fi>
References: <20260416131810.3116408-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416131810.3116408-1-thierry.reding@kernel.org>

Hello,

On Thu, Apr 16, 2026 at 03:18:10PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Peter sadly passed away a while back. Paul did a much better job at
> finding the right words to mourn this loss than I ever could, so I will
> leave this link here:
> 
>   https://lore.kernel.org/lkml/alpine.DEB.2.21.999.2407240345480.11116@utopia.booyaka.com/T/#u
> 
> Co-developed-by: Paul Walmsley <pjw@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Thanks for doing this. I think also the m68k work should be mentioned?

A.

> ---
>  CREDITS     | 6 ++++++
>  MAINTAINERS | 1 -
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 885fb05d8816..29fcfa679430 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -3645,7 +3645,13 @@ D: Macintosh IDE Driver
>  
>  N: Peter De Schrijver
>  E: stud11@cc4.kuleuven.ac.be
> +E: p2@mind.be
> +E: peter.de-schrijver@nokia.com
> +E: pdeschrijver@nvidia.com
> +E: p2@psychaos.be
>  D: Mitsumi CD-ROM driver patches March version
> +D: OMAP power management
> +D: NVIDIA Tegra clock and BPMP drivers, among many other things
>  S: Molenbaan 29
>  S: B2240 Zandhoven
>  S: Belgium
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef978bfca514..ffe20d770249 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26145,7 +26145,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git
>  N:	[^a-z]tegra
>  
>  TEGRA CLOCK DRIVER
> -M:	Peter De Schrijver <pdeschrijver@nvidia.com>
>  M:	Prashant Gaikwad <pgaikwad@nvidia.com>
>  S:	Supported
>  F:	drivers/clk/tegra/
> -- 
> 2.52.0
> 
> 
