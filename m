Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B140315E;
	Tue, 19 May 2026 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181334; cv=none; b=QnvticBV99wMqhrgvuI9e5pgHVCRJ+ce0xqgSWw8e6DTLzYRDx4D9Sq6A45Lsd0mFysaBzq6ReVN695QoA2u61r/T11CA03xFkdB0ygGawdWwmBzjVPjBxJ4NFBFoj+YnvvrRyB6gIbKWC++iBZcWE74HBsTwVcJhAD93PTtlHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181334; c=relaxed/simple;
	bh=mPEptvOyR7WgDZVN1gwcEGA/JK+W8VxWTRuOcfaF5Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUJwUs255I3ve7GmTqn6Bu/aw8fA0U67EwTJbfTJxkdD1eup6EmyujkkacCfmZgutmrGZlJLmPSjKCNYfNGLU4R+TvoI05aZPfL+aGXY2Uzbei+xbecfBNYTtSmAYcuT1Kx30bc+DZSRCVBhK57Fu4R8MMErVRhJ1FbWXh0ztWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHOzkY7s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHOzkY7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD7CC2BCB3;
	Tue, 19 May 2026 09:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779181334;
	bh=mPEptvOyR7WgDZVN1gwcEGA/JK+W8VxWTRuOcfaF5Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHOzkY7sRr0n399jZmuCztrnBd3N+2ZsYhKUe3+L2evzsoAh6WEPF7xggATG+QDrF
	 yjkjR2Pw05qWc3K4hYRSEi5VEySVircFp/4BaaaigO2KyEks8HyzAtTBCPVpnZRGhA
	 gMgzURwonviE0ZeJi69mGiO92LZtlPUBMkySQTNqU0EcetqZO/KwH5NBLdS6Y/W5jj
	 XzfKrU6WEGk5u6m85OFJSdanHmfNozFgVd0H4I5SF9Bvx5SFoWP2D9H/3bKngfP5aV
	 EXAWcTtQCIsUEg9nAOnPKxZZvCIfZ/ndsfmRdLPooAR8DmH04C8pKMOXsqK76hFGHy
	 qjtnKZcqz+f5Q==
Date: Tue, 19 May 2026 10:02:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v3] ASoC: ti: omap3pandora: update board check to use DT
 compatible
Message-ID: <edc020fe-1615-4a11-b414-c6d4e8b7dd1f@sirena.org.uk>
References: <20260517023723.92731-3-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D+RprFDLBmMQK02r"
Content-Disposition: inline
In-Reply-To: <20260517023723.92731-3-enelsonmoore@gmail.com>
X-Cookie: If it ain't baroque, don't phiques it.


--D+RprFDLBmMQK02r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 16, 2026 at 07:37:22PM -0700, Ethan Nelson-Moore wrote:
> The omap3pandora driver contains a check for the ARM machine ID via the
> machine_is_omap3_pandora() macro. The board concerned now supports
> only FDT booting, which does not use machine IDs, and therefore the

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--D+RprFDLBmMQK02r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoMJxEACgkQJNaLcl1U
h9AqawgAhcRrYXX6dut523TH7BMnHvW6onT/mX47R8iOwt1qvsDAKH87/Ff+VDR4
hxV1bbBTd9NqDApXLBTUuESn1kQwUgwOs2P90qW/6vEIRSy/dYH1vJceYJ1AoNDk
qTB6epFwcyIe0U6ymKg6u4efFKxAMH9xIKJDjYHH0DZVx2qBpxKnPbI3w/6pa+On
qacBnuEupeMOJ8ldVwcMa/jEGoU1kUIyAy5B8UAY9K479H5eN3adNDMdg48mZEoN
sLeTQRO0W3RG5w6H+i4rZ6V2tzU3TJJ/BiLo6C84oGa5t1TL73aS/N5wKP15d5ej
29a0/VufZvlKX9r0o7HlD0tmvoBLZA==
=SN/l
-----END PGP SIGNATURE-----

--D+RprFDLBmMQK02r--
