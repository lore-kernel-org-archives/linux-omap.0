Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8433F788A;
	Mon, 27 Jul 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147817; cv=none; b=al5nO91SueqAaAT8iEkBkpNali7fS1IsnpJQEQu2Rq7XnZGkdlxUq9cu4b+4XESFsyvI8YetzQ97SeDEv1crWoAlIwWeaL4MExuKJ4GZKW1zkjVDw9MoFN33rA91rqRtTNDgGHk8yPxsZj8AvEzwjVsKGd4ehK4H/2MMSvLVtCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147817; c=relaxed/simple;
	bh=Mr6hONHciGB7yKpuan+4grohyhpvj2pPJfNeNLKzX6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCROnasv6IfowcN2qLChAWtFP3PAIvSojI6ocqWfsfRMOb70BM3BqppLw9BWX3sVL8nD7S4XN0jmIk5dSZKY8PoYvLxe9lHubMWvSAcQwlekWVznpkHiXS4xjBEVv6FYa5wPwoOljXHqSYNZgFHlwu9rrKLU/fqQODoeb/2pIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=nafLH+n8; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="nafLH+n8"
Received: from localhost (unknown [95.24.27.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1A64D45F8F4F;
	Mon, 27 Jul 2026 10:16:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1A64D45F8F4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1785147392;
	bh=2Fq5DFW4lNpV/hH914loyGuMmRmv9nTvSzmqPMo8jZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nafLH+n82haSkPsnc6m+toUJym8c2jUekW6jeRNxzNDMjPewZWWVLdgzoPiwS8OXe
	 4ipzlDy4pFoJ1ScS4DfsOMSAHpHmISZW6/GPNx5NlBOoBWrKu+qsLs48i7uKa1dVve
	 9qdH90gHV5gzVqQpMs3cnkkzKhsw8ALDUbJO3t64=
Date: Mon, 27 Jul 2026 13:16:31 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Aleksandrova Alyona <aga@itb.spb.ru>
Cc: Mark Brown <broonie@kernel.org>, lvc-project@linuxtesting.org, 
	Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, 
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v2] regulator: palmas: Check return value of
 palmas_smps_write()
Message-ID: <20260727130320-3c45e38d7dd850065914bd16-pchelkin@ispras>
References: <20260618110338.53004-1-aga@itb.spb.ru>
 <20260727084150.30268-1-aga@itb.spb.ru>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727084150.30268-1-aga@itb.spb.ru>

On Mon, 27. Jul 11:41, Aleksandrova Alyona wrote:
> v2:
> - Update current_reg_mode and enable_val only after a successful register
>   write to keep the cached state consistent with the hardware state.

New versions of the patch are generally recommended to be sent in a
separate email thread, not In-Reply-To.

> @@ -468,12 +469,18 @@ static int palmas_set_mode_smps(struct regulator_dev *dev, unsigned int mode)
>  		return -EINVAL;
>  	}
>  
> -	pmic->current_reg_mode[id] = reg & PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
> -	if (rail_enable)
> -		palmas_smps_write(pmic->palmas, rinfo->ctrl_addr, reg);
> +	new_mode = reg & PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
> +
> +	if (rail_enable) {
> +		ret = palmas_smps_write(pmic->palmas, rinfo->ctrl_addr, reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	pmic->current_reg_mode[id] = new_mode;

pmic->current_reg_mode[] update can be moved after the register write.
Not sure if a new local variable is actually needed.  Sometimes this
only complicates things for no real value.

>  
>  	/* Switch the enable value to ensure this is used for enable */
> -	pmic->desc[id].enable_val = pmic->current_reg_mode[id];
> +	pmic->desc[id].enable_val = new_mode;
>  
>  	return 0;
>  }
> -- 
> 2.26.2
