Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085642E4247;
	Sat, 18 Apr 2026 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776542845; cv=pass; b=WSwQIId3iOK+u6muvBSUBF/vqfE8iYG9p/vbRruXMKgYdhNYhRRX+aiZZNz6fXgbfjcv7n69XZm14oY6CYvUVHXrBOt+c8WcrLUjWcMfUOYE4yn5XAgn+MKOzKbtrHj1IlscbiL7+O0FDa+WK4XHLA3j6OlI+l6J2Q7ic7LzVH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776542845; c=relaxed/simple;
	bh=22w2I5NLd6Oc4e7UYBpDdZFyx3gOidmynxa+EEOsljE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZaF9PXIu2/o50zPF66UjYLr8VcOU+tIuAcg0WgCa8KzXeCDux1CX5FeqgRfguZGAW8X0PN9t2XuUTU6vCEitRxPgjRM2XKBpWNnXiFF7tnLFnxmKOb6WN+Wkx4tA5ZHJ3GPHlxChtPdRpak6SjoVXlvOScqXA21S7inXSSaJj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Kb/eSYaT; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Kb/eSYaT"
Received: from darkstar.musicnaut.iki.fi (unknown [83.245.248.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fyjTG4pT0z49PyQ;
	Sat, 18 Apr 2026 23:07:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776542836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbLXe4Og5GCtNFoJgU/iohm65MD7uV97LErFdEaEF7E=;
	b=Kb/eSYaTGUs55bvEsMxccKvCe1lUD/sC5KPz52uNr/U8hOF93wi3MJ/ppCQzVraZzFgRSf
	NpbRguOwXxqkeAal1VE5DkM0YUkMeOOSm0b2kbTRx5Wn+bX6swZUBHk4lh29SsSTZk77jQ
	Mzv3ulGDMEVOV5fx744CmMbp0OwNLWupT+/2EXWypmaU20OQXi/cqeD8BhJGXrc7daAZ0O
	3a497Evvq0bC3XQVGjzncJo95Nxp64oByLOahYDQPAjtfkJ4RAxPEUdXH1K6047WHeGFCt
	cTnzSg7cYlVtnN8bqzTZWwbHbuIHQ5JYsjgVx2Ldhh56Sb2FWpuG5/Ew6OVcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776542836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbLXe4Og5GCtNFoJgU/iohm65MD7uV97LErFdEaEF7E=;
	b=OzG0N6MLYgpi1aRsblyHfoGw+pLJtJWCg2i8myzuMiQHgjQpE1b3ERF/7QzQ+DVFBBV98S
	eZFBGjKghztB7FKssj0DxIHoOAq02h1PDRTB4ILQtVrdOa4GfO8HpVjzOveNlPqCvZKjHf
	uUR1QP9Mm7sWsbpbhmzi7ylUWdy79YGZw0NMaA1Pe9OhaoFiBqj6IJxykjbGrw5TTLyACi
	Vef8no+A8Oe1cbnG2sNk40s2M6pefcWSxkk7ohZsWG3wgMkBhdIpY1ovKPCJSwAMu+bgaf
	T/qWkC9ydIY9j3wIvP8ffGOiAGX5n9OAKRiK1pZkS9TlRMdyDH2uvZyI/INq9Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776542836;
	b=eshlC+o2K2l5qT1L/SCjR+WV73Bxk3OnqYzN/ng9ZtWmLTCyGx4qWO0cj+sY3un7wD+DWF
	MIP3JwY4ccDiOSgOBlDBrCiDbsuKg5rQfQRsHgPRr2U6MQ3X8fQhxnqSfdAtPVXB6faeIN
	16RlXbFjoaeE0McGG6MI1iZ2Q3RmknYSgKIffA8i/SDklYeP4I2UHkA5sigaZmBd5Fr02U
	pXCen5Yb7Y2rCQya5YQLIRq3jKAY7ZrLVPIjThjfrC+Zjqn4GNR8QJdgko2rkq9FRWbRBi
	5/rhq39AbpRw5jUl2aGeuR57k23EZq+je5P9F9ullBxU4UZlhJ9erQa5rmyl7Q==
Date: Sat, 18 Apr 2026 23:07:11 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>
Subject: Re: [PATCH v2 1/3] MAINTAINERS: Move Peter De Schrijver to CREDITS
Message-ID: <aePkb1qTEvnMhkDg@darkstar.musicnaut.iki.fi>
References: <20260417131549.3154534-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417131549.3154534-1-thierry.reding@kernel.org>

Hi,

On Fri, Apr 17, 2026 at 03:15:46PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Peter sadly passed away a while back. Paul did a much better job at
> finding the right words to mourn this loss than I ever could, so I will
> leave this link here:
> 
>   https://lore.kernel.org/lkml/alpine.DEB.2.21.999.2407240345480.11116@utopia.booyaka.com/T/#u
> 
> Co-developed-by: Paul Walmsley <pjw@kernel.org>
> Co-developed-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Co-developed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
> Changes in v2:
> - add more missing entries
> 
>  CREDITS     | 10 ++++++++++
>  MAINTAINERS |  1 -
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 885fb05d8816..afd1f70b41cf 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -3645,7 +3645,17 @@ D: Macintosh IDE Driver
>  
>  N: Peter De Schrijver
>  E: stud11@cc4.kuleuven.ac.be
> +E: p2@mind.be
> +E: peter.de-schrijver@nokia.com
> +E: pdeschrijver@nvidia.com
> +E: p2@psychaos.be
> +D: Apollo Domain workstations
> +D: Ariadne and Hydra Amiga Ethernet drivers
> +D: IBM PS/2, Microchannel, and Token Ring support
>  D: Mitsumi CD-ROM driver patches March version
> +D: TWL4030 power management and audio codec driver
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
