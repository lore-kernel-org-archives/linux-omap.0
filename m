Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2D54768;
	Sun, 10 May 2026 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376148; cv=none; b=ik2MAdJ8lniP6UVMwsBENaodq/LUQQUPlg4xJEPmRuQbx2ltlzeadsFiXE+GQNhFy5BsrM5gsYzQv57wzs2YqOdcst0IcAXAGMxsmr3h1+2FC6f1u7qbfAptkBxu7e0VX9YhUPUFWaZeYb1kC5JEwoDbzHC1C2dZC6F+sAtVwEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376148; c=relaxed/simple;
	bh=5yiWmD6uwkd0Zp5KqmRCJpP+WsbkEivGVu0xC8Lode4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krC2nCIY5s8rTN8VBicMuyezTA5sVx1KvAlVYlTgQhDAc7dbEjzW4lUFgfTef2nlZDcW8vEeBaCAA4dQhMUpbEd7TanPQIKFMwnFMz0gOWcB64vYJGBLrOnzhV16eThd6hZuhXz6iqLG58D4uQb/j9Tf0kZ5lTizilWFVZ5a5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyiAvKa+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyiAvKa+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A433C2BCB2;
	Sun, 10 May 2026 01:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778376148;
	bh=5yiWmD6uwkd0Zp5KqmRCJpP+WsbkEivGVu0xC8Lode4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyiAvKa+3clyz2dycK1F19O6idhR9DqpV1QSK3ArqnfpG1Ed1l5joUZ9QOpaajv/8
	 Ehf/AgeRHm0JPXnSjfl1q/6scQHAW7UxAcMRSQ6hbSb8t0LpPhPzwgDaXqyn7oIiVO
	 NeQBS+G+wisgmGtbKntRobGOseYQy/IaQ8RF4FFepYqGfFjhI9qqRIXKkdrvNIqvp/
	 YXB+PEMZ6HGFmQl78+06WhoZsXly01O+JFJw7tfRov1MnNrYenSeMkJNX1ccyAiKrX
	 PN7UG7KkqMm2Nx4/fOUlA5pGNPGkuxO5h4ywOtCENFDE5ALIrdw/cBJKSq/urUgBTH
	 tpXtAY2+V4VCA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 36C481AC5896; Sun, 10 May 2026 02:22:26 +0100 (BST)
Date: Sun, 10 May 2026 10:22:26 +0900
From: Mark Brown <broonie@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] sound: soc: ti: rx51: remove stale reference to
 machine_is_nokia_rx51()
Message-ID: <af_d0qItJAkYCZIb@sirena.co.uk>
References: <20260509012247.14990-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2sx2LxkdBo0wNpht"
Content-Disposition: inline
In-Reply-To: <20260509012247.14990-1-enelsonmoore@gmail.com>
X-Cookie: Truckers welcome.


--2sx2LxkdBo0wNpht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2026 at 06:22:46PM -0700, Ethan Nelson-Moore wrote:
> The rx51 driver relies on the machine_is_nokia_rx51() macro, which is
> always false since commit 9b7141d01a76 ("ARM: OMAP2+: Drop legacy board
> file for n900"). Its presence prevents the removal of boards no longer
> present in the kernel from arch/arm/tools/mach-types, because the
> machine_is_*() macros are generated from mach-types. Drop this unused
> code.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--2sx2LxkdBo0wNpht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmn/3b8ACgkQJNaLcl1U
h9BAEQf+Igsk51i9EKXmUO6uebIWPChe+g8zimHsx5tF/PsngLjE4TY+G8VDxyjW
JEKZBMih4TBb8NHiAO0AOhWxxKm7YW8Hw7FJgI8tdGr4AW1Ccl5qETyj7dehSlNs
vYpdYqn8VViOxobs6kqXzLg0t/IdWTezZ1vnqG+ImD3FQ7LgM7qi2AWaQMASH2pt
UDZs725pKvL3ybWSJru9KhUIT7nkeCpIDBcTxzB57lDHT43F4aOq3RrYOJWtpc4a
jf4js/Ew5Huqb0dTw+n4OizjKC6BrjYmatpRfwiCLqhb/qZfDXQlS2KMMlYkuWVE
+5pPz/pbPbe9hvg7C+w8JHFzJV4Srg==
=lTn/
-----END PGP SIGNATURE-----

--2sx2LxkdBo0wNpht--
