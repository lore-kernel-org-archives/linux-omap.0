Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794C3D411D;
	Tue, 15 Sep 2026 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475434; cv=none; b=sK6HTcGmwdd9dxPkg9dGSKqux/NLPqIYmU84IhVeOyHGkYyITFCKUIFhWpSglJed1v7q7mwZOZBnQ0ctPizqnjTA+L89y+HV2xgoxTPRDVvaN1jb6Nnp/5sutCI34UmOa85Kvq+f2zWNLV+LX3Hsvs3Vyq2LBEODrp2G4bSakng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475434; c=relaxed/simple;
	bh=gCBuP+2Evjh4veQE3BW3pdqF9G7KNExs6hM05mou+nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdci1KXKwqzpoL7b5s/1K2o8hkQ+EGXgTLazo31T1TFaeLXQETlgmCSMgcTF93+p8nbVWLSTf9ZO86EZpqVlvD+ODcHUUIPyy7vR86iWSTOm3wMJ068cjjRHpOUEcAaffqNtOGTO641MGZZGk06Tsp0nArNLvxCwgmLFDAXvheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPT/trEt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPT/trEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1401F000FF;
	Tue, 15 Sep 2026 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789475432;
	bh=TVtfbg9cLJPxe8CeCcpFkHFABq+D56AX0qqaWOp7cYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dPT/trEtgWSwmvf4ssrot2pTPi+3EgP+7jA5SMylqsftSnb6kmNLGGkazcWzOosXn
	 2Vp9dIoTa0CGeivRWiRZ4hlOD2VqdxKcxSudldG/8P1XhIg97wh2pz23M9uJVMvEB7
	 ASJYBRFUgN1fzdHQpipXRRI5/LEKdxCMM0gEA/uGWM9OG0a4D8fU7Y+7+ZeYq2acLE
	 dOVIfk/G4mTIw4oiTQUQXmInZ7vyMxnafJMjD4hTtYqzoq2ZNKZlPvKZsSSKOaznzY
	 XI51RrUsrUic4xhyZKAv6MhvYZ5ItT2guPS0QlC0bSUhNYjVFAHqqoGLYCVM/6qLjS
	 mOs6uFUo48N2w==
Date: Tue, 15 Sep 2026 13:30:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
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
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fix typos in comments
Message-ID: <63334ddf-5ddc-4a90-8244-98e38a0ea174@sirena.org.uk>
References: <20260904110315.11650-1-hemanth.selam@gmail.com>
 <20260915063206.519683-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GiDgBwWwOzEOdFcQ"
Content-Disposition: inline
In-Reply-To: <20260915063206.519683-1-hemanth.selam@gmail.com>
X-Cookie: Void where prohibited by law.


--GiDgBwWwOzEOdFcQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2026 at 12:02:00PM +0530, Hemanth Selam wrote:

> v2:
>  - Rebased onto asoc/for-next; v1 no longer applied against current code
>    (Mark Brown).

It's still not applying against my tree?

--GiDgBwWwOzEOdFcQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqpOl4ACgkQJNaLcl1U
h9Cpfgf/Q7YrQXQeaROc/u9unXenwWJLaxVPhJGgdjoufaOEw/YeQHHnC66FhF/H
n2skcounXBkPPvmeFnkoCeV+3ammQ+wWQv6HVL9CWdEYOKJYiesoS+u5WI9KNae1
hJyBQw0prpFKvyxuJKhv8aewBYknoowABWc/15HK8DjqQZPEw8gMzyCgZTJrb0IY
JxTznbOUKHxMr0U6Mi6HS0zVX1HIYkuzKJ3VlKK6IYUGpxtP8+ceFa9UXjg2p9oU
SrNghGQ8TeBx5GJ2h9Wkyv6bvXkX8ru2TV6WYgGo66bTvBCgV+1gAk3wrIWKPrdM
vkfSCtaDDZQT0SRZ7QrFHs8WOQJtaQ==
=0/I9
-----END PGP SIGNATURE-----

--GiDgBwWwOzEOdFcQ--
