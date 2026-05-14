Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C231A053;
	Thu, 14 May 2026 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722521; cv=none; b=dwbOrhu/X+flHhn/q53EKLzqhkJWEg5sX6pYa04wyk1AGmcsAezMuPt3tqNCZE3qvRDafjLcOKFIIMWHjFU2RbE37Dzhykp7g2xqhNYEklODeFTwHF/1iQwkt3EKLNZjlKiitUsSKngcuwdwHb3kSYEh9At/2OTaDoJDyh6+LI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722521; c=relaxed/simple;
	bh=NapVsa99RbO9sdmhf+tgsyBXsulP9KcK1OsJq8GWuaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8A1TGHyrXVqRGazuFJAxoz9qdqMzmx3MdlwWwb1Rt9WcomBXXYlnxziKkF8S4Wh4px1lBoEvuHvwn2u9ybtS0x1FwwwElxjkQ/ZBFa8cWziuE+Hw1y3s0twPQPeMDBIx3zb6Xs5k0aGYXQBViCdmqfDMz8d+MuuQltqnd7wxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEW1D519; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEW1D519"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEB4C19425;
	Thu, 14 May 2026 01:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778722521;
	bh=NapVsa99RbO9sdmhf+tgsyBXsulP9KcK1OsJq8GWuaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEW1D519Si7Mif1110fpWCzeMJwtrWeL+wIzW8V/vK/GmkJsUklq6Q8d4zpQVJaHV
	 o7SjKg3Xf74mqoIGUBO8uF62geYOtxQFfSEQD2DBJLzBAyJWNMeYtVn17gszan20mF
	 3JrUtHHYzPlJrpIJY06qKl8BOdd8gCWRwYGdoZytr3vATQmZO4dPx1o/fTxZaxZSAC
	 RngCY6M3f8I1WURuSuH/ecqFlYT/WSIyjPQGlM2Pkuw6yxctOz7b75PiaZKcsVSKcO
	 oPZ0nLZTkKU1TC9o2IN3wVOudMcqaoC4GEOunMk+97ZhQxgkkgPCSZDLmGmaIScyFN
	 seSYrLHJL8nrw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 4C5A31AC58CE; Thu, 14 May 2026 02:35:19 +0100 (BST)
Date: Thu, 14 May 2026 10:35:19 +0900
From: Mark Brown <broonie@kernel.org>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: peter.ujfalusi@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, jarkko.nikula@bitmer.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 7/7] ASoC: ti: omap-mcbsp: Simplify lock and resource
 handling
Message-ID: <agUm188qDiaSbeqc@sirena.co.uk>
References: <20260508103837.138142-1-phucduc.bui@gmail.com>
 <20260508103837.138142-8-phucduc.bui@gmail.com>
 <af_g24kqkm4QhDuU@sirena.co.uk>
 <CAABR9nH62K5qqujXzr_HwT6F0V1ezzENAVnjqqu3zrMvmCYWbA@mail.gmail.com>
 <CAABR9nGHO+q5BUmUtER_tcC1drz3bBap-+=pew2+JBKYsg_6Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Dqov5AbO3R+Aajw"
Content-Disposition: inline
In-Reply-To: <CAABR9nGHO+q5BUmUtER_tcC1drz3bBap-+=pew2+JBKYsg_6Pw@mail.gmail.com>
X-Cookie: Truckers welcome.


--+Dqov5AbO3R+Aajw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2026 at 10:14:42AM +0700, Bui Duc Phuc wrote:

> >> This function now mixes scoped and goto based cleanup which cleanup.h
> >> warns us not to do - are you sure this is a good idea?

> If you'd prefer to remove all goto jumps from the function,
> I can prepare an additional patch for that as well.

That's probably a useful idea.

--+Dqov5AbO3R+Aajw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoFJtYACgkQJNaLcl1U
h9DXCgf9G+YWUsJs9GiG/F6rSTE1X99HrklRfrVnBbHmx/WMx0lLL9NYjH+GbttD
LsknZ3R+OySZRhDM/RXE4z1NGaypnSKdoOm5J/h7k6Ws21zFa0fIC00SocJaXidO
sUpRdwQx+rsxT7QYiaH+KfP1B3TtkQUsTCbZGHN9oLcz2bm26FBdB/Lob/XFYmDI
W1N4Ig5noDPeRpUjjfiNXs+R0ml7MNGaarDp/ZeCMbx9irx9/uXMtv6wreic2dkp
L9ruCmIWXjqMYdYf/zWf092Gu/lw1ug0mnn9L/+6+YlEa8M+M7PFZZbAkLiAl55z
XkJI3XKxhF3aTJYbLXq30f4cDfUHow==
=ohPT
-----END PGP SIGNATURE-----

--+Dqov5AbO3R+Aajw--
