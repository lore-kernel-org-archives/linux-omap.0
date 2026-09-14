Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197435E92B;
	Mon, 14 Sep 2026 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412107; cv=none; b=bcJmuhh63USiuT00MEzGIY9kq+XddQXzw0Aip5pThy2rIIqJuMu9NHRep3M6oc4l2R/8N2d27gKMDhye7akf6FUt5b8WhYFYDfxaSENeaubL//9cK0pUbKYu/hiSlWK6YGHyq/+Z0HL0696i7zdS+PWbGIdoY2x5ME9ReXYuqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412107; c=relaxed/simple;
	bh=3wGE2FU4Opzet8RW/Vid3LE9SnZJEsoS+rjcCWTTi/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjJ4K8T1M+TaXV11EBgHO2BgedpvzzEcnL2/+q1ajJBG6Q10pBHBihrqtYbKiRYVsXxy01rmjZIr8A4Jxdp+rCdUZp7tUMc7cp9Owx8KqLN+uV7WKlrOW7MQJqeTNKuRKxcG74EEZIabFp9dJu0IIKNRDVECcfjGskwGb9E8Q34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avwicQJn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avwicQJn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615D61F000FF;
	Mon, 14 Sep 2026 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789412106;
	bh=Dt5w1Pn+88+/6QbLVYWGwITkkmR85KAahvz0h2yQbyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=avwicQJnNlv4NY+cCLzYzlQzvtXGDzbl0SG7/oFzAQKdUDlB8xcYXpO3FmXdq9VIe
	 zA3CmeKjc9Jdf5PEjbDCLE7bCZlIs2inTwCFif0kJic+F0O9hiUyISjRU+uelz1xYz
	 /dbsbWPxfkYVe5v/6m7mgo5+dy2XDTGTW9C+VdEWOd3OWsozb7A3kNlueXPo9UNoOS
	 4FP0ZIeq2WeYGUuuuCe76ybcZB/6lgLvwODHPefhsCpKQir+H3kp0xyZwY9O5pgem5
	 Aaq93jDqfXzQQZeW39jKcA0i+G2ukQo8j423D+NNHqdlHROAuxLeWWcsOWwTIxhD6T
	 GMYpdgv3oV6uQ==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 6BA11FF4DAC; Mon, 14 Sep 2026 19:54:39 +0100 (BST)
Date: Mon, 14 Sep 2026 19:54:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrei Simion <andrei.simion@microchip.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Srinivas Kandagatla <srini@kernel.org>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] ASoC: fix typos in comments
Message-ID: <aqhC72HtZg6vZwlb@sirena.org.uk>
References: <20260904110315.11650-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+R8ajydSb1j5T0kw"
Content-Disposition: inline
In-Reply-To: <20260904110315.11650-1-hemanth.selam@gmail.com>
X-Cookie: Orders subject to approval.


--+R8ajydSb1j5T0kw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2026 at 04:33:01PM +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.

This doesn't apply against current code, please check and resend.

--+R8ajydSb1j5T0kw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqoQu4ACgkQJNaLcl1U
h9BQngf+NrKbIDQswDCVtp+p2+16s8VA4komgI1mJwvGX/l3TCUsL9LCubDyEiJT
MFMcRlrtytBdb0B5Im6RKBIWJZaH+traqJYXu2n9J/Og95j4v42wm4LoXkXG+52n
hMDKyEctBPWrG9zn+kKJ1r5azQYZ+ZpyMVbJE2KO7wWOpHEXpBu1/x9nZMVl4JK1
ACL5+4S4QJlPc9rY0c3BhOi7nIHmBD67gjYbv3aQ2yTskcZrbwwRySAJgXXVEkuK
t/ekOauEuhMj3Kj4rslRddyVgJaulJSlC9TvCRdHsKUlVZ/a1+Zymt/MbzJWQNcb
FYQj7jL/7dJkHDDVC1Ah1qRWVbr/ow==
=ob1K
-----END PGP SIGNATURE-----

--+R8ajydSb1j5T0kw--
