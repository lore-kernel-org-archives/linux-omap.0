Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251669;
	b=BCDsyB2f3QjRZKhodnFza7p37sltQ57E9wyTHKh/tdHQajQpHkamdlsCNNxXJ7/DZp2A
	 JaojMTjHg2aQZwoIxUoXFkSGVgB8rUoB83i4ROYjiMnMKNvpNW+Ocu0e5ILpFdDo9N30M
	 LwY6Y6V6RWwzXlf5OyHuclmqq/LgtOHb4xbqw/qjOeRY9sM0Cop16QyPsAsYN6zweD/Eh
	 LGba80xxeR/4JLRcMcWU26jYJTCvC1DpWkck9i20M2k8ktCRkeQF0/dfnyV5izj+bdmMT
	 dHalgE5iylNc0qRK0pcxnTFFn0KCFpELtcx8rysa6Mv0hGkKNv5l0AhN5zBBneqbl+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251669;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=kAhKHKETl+zJXfZu2gmmuq8auBki7oYQy9WKXkPNtfA=;
	b=j+TfQq/TSxXXGnQGW1xfXuVJZzUhXVXeOGubYkD1EZyUCtTASDXcqkfG8IIYFC48ak8c
	 rmB8sM7L/SW7T9VvKWTd02XgobFSv3Ppfvo+Q28/a9T8kTlK1zESkLfOHDWCW9w1LhS7a
	 RLSAEWXuHm1LE9ESdS9gobyxKlHGffdh9sGgNZD1f4bASEGK7ufrFzZ6B9Sc4GVWo4GzE
	 JvylNZZJzMoSlgD2lBflwzm3DN6R9eM6rqD3v31bc1JVl508jv8Qf2B+PHz1alNG/ScGM
	 myG+g37aAZFq3lJfYP/lExvY+U02zxbtivJoYLLJCV43n37ZSHVIc/7x+ZHtAXTZh3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMT21GDa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4A60A2635;
	Mon,  9 Nov 2026 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMT21GDa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C363A1F008AB;
	Mon,  9 Nov 2026 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251669;
	bh=kAhKHKETl+zJXfZu2gmmuq8auBki7oYQy9WKXkPNtfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IMT21GDawexsD07PLJD+1eUXaDfIrDRQNJW+mqYrwTMkYGAKfT+tRe0wCf9KGCYXB
	 hgUZPu9RNtUNJ7nllgxgwCp4qVNnuhgPVVqVsYKU0utoVbtdLdzdcoeUuFn5Dkw2JQ
	 J7t6/m6vjytGeGZ6Y5A4ZpHjaoQCnucrGD8OzwRFhRU94eaU2Z2zkaTSN2EXZGpFP/
	 +UDpcOAzWsjjnRb9HDB13mo6XsYDH/f82rYNXUJnVnaZ/zmY8rtuD1AvHvQbfB+LJ8
	 DLm2q+BpTueELlGPXvAuiPjcjimA56dDdaun+N1KbP95Vqntmfsq1JghABdm4jH+Bq
	 kiQX9FqRINVNQ==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 26CED2FC67C1; Mon, 09 Nov 2026 19:14:13 +0000 (GMT)
Date: Mon, 9 Nov 2026 19:14:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] regulator: convert to subsys_platform_driver()
Message-ID: <1b56983f-f88b-453e-bd8f-8189c3f79d1b@sirena.org.uk>
References: <20261106-regulator-subsys-v1-1-1f91f4204bf5@redhat.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qQ7Yc8PdWfe19cf/"
Content-Disposition: inline
In-Reply-To: <20261106-regulator-subsys-v1-1-1f91f4204bf5@redhat.com>
X-Cookie: Whoever dies with the most toys wins.


--qQ7Yc8PdWfe19cf/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2026 at 07:28:46PM -0500, Brian Masney wrote:
> Reduce boilerplate code in these drivers and convert them over to use
> the macro subsys_platform_driver().

This doesn't apply against current code, please check and resend.

--qQ7Yc8PdWfe19cf/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCavIbhAAKCRAv73Ows9A4
ia+WAP9KaMEfrzp+PPYKAutiN8RCAN7etrlrXBBfqvI0tV4e+QEA80vQvksTu5hR
KQwlfat99OR74T9ZnJ7twdWn0YpxQgI=
=skKD
-----END PGP SIGNATURE-----

--qQ7Yc8PdWfe19cf/--
