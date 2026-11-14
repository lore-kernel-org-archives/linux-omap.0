Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794666003;
	b=RIRDjtvTh+mg/oPD9pe5qkVrvI3ywx+1hMfDe36uY38a7m56j/bGrT+5iqmz4PxwBO79
	 9nJ8bwO5xbt2qh2pgOk1639sWrB1XMrcOo8v9dBcB7bCFwoKL8o41LNCiSnBt0CDxiJ7w
	 9ks30R1nUtyCxLupdBtgSzoAVTd7/C/Z6WeTfDiJhpWsFyaRb/PJ+OyusCn0d+puq2Zww
	 U3outdxnEvn+yz7drD6StWmvwOXTh/XkzpVdwOJAVw5S7TKfO/7NrVaYdYMlmSzJPMSdV
	 uMIZ1OruLSiawFV0joIk1H8JIIxpiEF41d5cc2XsmTDJ80wa0bcAvkwbnwTNuEZ/d7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794666003;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=GxhZTjvsMJxcg4iPJ8p2SPBamkZcuiYbrKcc+lfyNeY=;
	b=VRW+o3PNHNCTOY8Rk2A5jnM+nIuqp17qy65yszihI/6cMNdHlMPlnA26ZO4X/AGqtWdz
	 CC3+JQ0ib4slMW7LcRTXZ6v6Jn8fJlrDZETYq9kRXmq6eKu39kFSOYlkrix6N/bz/bkHQ
	 G8LKFo7hfJYtpz3guVnSBDXcEOd/a/YY5dfL7SoW/J/3oyJ+P0jn+z35X8C8IEOq7N/f8
	 /FgEYEa/fehY6VNvzZdfW+bG/Q3Z+qLVO0tpVsqiNsLWgxdHEYmJ0YdXn1mqxKG3LzwHj
	 82KyzWsFRtpgrDLJp7ZU0usPVLQCnOxwN806mqZpSlhVHTVYbLWxW+rleL4ZzgBW+cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbXhkhqN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF09D606A323;
	Sat, 14 Nov 2026 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbXhkhqN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9901F000C4;
	Sat, 14 Nov 2026 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794666003;
	bh=GxhZTjvsMJxcg4iPJ8p2SPBamkZcuiYbrKcc+lfyNeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jbXhkhqN9/y7CZOJSkoHGg1kF3FTw9QmpKBe+i9E4bq3oTN11gPKEWRpR9vu7RLOk
	 H0Pv0UZtQPe9wcs7RqTKiQuKrxUr5C5taa5ao2nBDK9Vf6ws0q+eSYZmZ26lJ4seIR
	 Sljnqw2J0yW42IfEUsr4J8W57F3HOPUDfl5qjeOrzRAOujA504e+29+1N4nN5GuRR1
	 B76vnJeaYvh5yIkYpiLlmpX27z2s+CSgRtjW3Id1kqKCRnIMWh1gDqOn9Hodlr0HaV
	 w+StmbtHbfxNoSAjRP4r0cmBSPpgUHmvM3RsPG+nphW15jxuh0HRa0S9VmtNvd4qOB
	 bwMMnBuaJLd2A==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 53E5932DB3E3; Sat, 14 Nov 2026 14:20:01 +0000 (GMT)
Date: Sat, 14 Nov 2026 14:20:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Chrispine Tinega <dev@chrispinetinega.com>
Cc: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Jerome Neanne <jerome.neanne@baylibre.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH 2/3] regulator: dt-bindings: ti,tps65219: Add
 ti,no-warm-shutdown
Message-ID: <cedb08d0-cfa0-452d-b4cd-511d6c852eed@sirena.org.uk>
References: <20261114032457.3434248-1-dev@chrispinetinega.com>
 <20261114032457.3434248-3-dev@chrispinetinega.com>
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
	protocol="application/pgp-signature"; boundary="/DK5X7DFqIxlcSv/"
Content-Disposition: inline
In-Reply-To: <20261114032457.3434248-3-dev@chrispinetinega.com>
X-Cookie: A watched clock never boils.


--/DK5X7DFqIxlcSv/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 06:24:55AM +0300, Chrispine Tinega wrote:
> The TPS65219 has four die temperature sensors, each with a warm and a
> hot threshold. A sensor whose warm warning is not masked makes the PMIC
> sequence all its outputs down at the warm threshold, 110 to 130 C.
> Masked, the warning is only reported, and the PMIC powers off at the hot
> threshold, 130 to 150 C. Whether a board can run past the warm threshold
> depends on its thermal design, so the board's devicetree has to say so.
>=20
> Add ti,no-warm-shutdown for that. It is allowed on the TPS65219 only:
> the masks are not described here for the TPS65214 and TPS65215.

Reviewed-by: Mark Brown <broonie@kernel.org>

though we might still want a runtime override for when the user is more
cautious.

--/DK5X7DFqIxlcSv/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCavhuEQAKCRAv73Ows9A4
iZqSAP0eRQHN381xhc0NGI/6Y9SxV2C2n4RH0bBJUFkzmZBROAEA0yw2EzkrME0v
wzS2oDz9JuAgGTbB3meXzCrjLu8wAQQ=
=IsLC
-----END PGP SIGNATURE-----

--/DK5X7DFqIxlcSv/--
