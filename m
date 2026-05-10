Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BDA3FF1;
	Sun, 10 May 2026 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376926; cv=none; b=ARuF0Dj6adbSoIN5/HIZuRbehHdXyiY8w9y1HRSl05lHFpl5XH5zUNIoZ/hm3uKJ15pg3wdiNkurvWqnBaBZe6BmEECpCx7ir+yozkWqoJfYFyNs0455i6EqG9a7BNvYwYOciREsUD6VV6OlOh1ydKXT9tMKvZk12cV0cE5hif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376926; c=relaxed/simple;
	bh=pqRdhnWJuInyEppHOhUjwH6dqb8Uw4F9J30hHwGIV7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0eEuizFdR4UvOhA0binItxcbYE9tOlg4CUA93+baSyhhziEra6gUCeafBQj428eQN7N2qlA03nOAaUL2O/dwHsUbfDWO5PGrrJGu8hXsHBhcqGoJjo0O1U59DVhYvXkt56uZdDMHkGEq2tNTR1UOGOdy121PRea4SYuHjLU4cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI7LmcvX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI7LmcvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800BFC2BCB2;
	Sun, 10 May 2026 01:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778376925;
	bh=pqRdhnWJuInyEppHOhUjwH6dqb8Uw4F9J30hHwGIV7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mI7LmcvXHJobo0CF/iQiID4lXAxhja4jFZR4Q8CqNh0Owjt+ruUx5pup1+g6Wn4RF
	 lwvFervg061CMHg/ZN2MDdJ/nCvi6vRYS11Kkwwm3gXZQd6MQqOo4XprZYJV2pEoNF
	 WsiwD+6FGIyyWcs16zzFQ84s3y1T5d3w36mUJlEtXCAZ+IUpVB4LOlPqi+elT1Waks
	 e6dCK211rrOvxj53arJ+jBwdqo8PiXn3Bx15RVnjCxvnD/E1j6qDDHzJUa9NRl3kQS
	 WD1fN89cuUafiOWWHHdLy6wMUofYg0NjmPUIkLeh0Bp2DuUtoOkUGCoxBA2lobzA9s
	 9ltUZDTxHiJiA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 8AB281AC5897; Sun, 10 May 2026 02:35:23 +0100 (BST)
Date: Sun, 10 May 2026 10:35:23 +0900
From: Mark Brown <broonie@kernel.org>
To: phucduc.bui@gmail.com
Cc: peter.ujfalusi@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, jarkko.nikula@bitmer.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 7/7] ASoC: ti: omap-mcbsp: Simplify lock and resource
 handling
Message-ID: <af_g24kqkm4QhDuU@sirena.co.uk>
References: <20260508103837.138142-1-phucduc.bui@gmail.com>
 <20260508103837.138142-8-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wXAkxSKi4h/BhGBY"
Content-Disposition: inline
In-Reply-To: <20260508103837.138142-8-phucduc.bui@gmail.com>
X-Cookie: Truckers welcome.


--wXAkxSKi4h/BhGBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2026 at 05:38:37PM +0700, phucduc.bui@gmail.com wrote:

> Convert spinlock protected sections to guard()/scoped_guard()
> helpers and simplify the cleanup paths, including the
> reg_cache lifetime handling in omap_mcbsp_request().

>  static int omap_mcbsp_request(struct omap_mcbsp *mcbsp)
>  {
> -	void *reg_cache;
> +	void *reg_cache __free(kfree) = kzalloc(mcbsp->reg_cache_size, GFP_KERNEL);

> +	scoped_guard(spinlock, &mcbsp->lock) {

This function now mixes scoped and goto based cleanup which cleanup.h
warns us not to do - are you sure this is a good idea?

--wXAkxSKi4h/BhGBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmn/4NoACgkQJNaLcl1U
h9Dbngf8DISpCdnB/a2nci9np2cghfwFVi9T0y6+yZDt2/dH8ehUWIzoCNZyY1pN
ix9k+YGaxq1tdT9OBbMJCcWtKbCXtAlq6UnUtOvMZq4rlswqLUDVkGM01cRk9bEy
tk08AWBAsXNx1RH9andbzDs7L2Tz2p4RFu491RpltKv93wnDBRrKm6wp8AvgidX+
yPKlJIYqNlIahgGT5C+CQKL7uIjTdsYf95K8gYdX+mGy8aBR2iksPw/fI2rtbR4W
lI1peM8JMARIcKfvzjvRAoRtnSMv5zaeKxY8B+WPqqvKyjEF4erfGaCLzxd63vDL
7CssSxbOnpQ+xc/LjPl27FJsNZ2AhQ==
=5yd4
-----END PGP SIGNATURE-----

--wXAkxSKi4h/BhGBY--
