Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A64640683E;
	Tue,  9 Jun 2026 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022870; cv=none; b=l0nwPnMcM8tjcGOLChcTROtQPTuYdUpik2AkritXisso11lnz1lXHrK1UVhtrPd0UPoJftV7C+3SrqLwvmJ8bOzi2yi11+C5oFeT2xGqLU4dc0mlkGBWhaIgFwUQYJKzf6aK1CD0ydRibzjeoMPODVtm6B9ahnTCey0O8lB5FLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022870; c=relaxed/simple;
	bh=TE0JVkVZrrj0DYaTmlnaaMVVZ3bum6caTUwXERfVn5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF9xBxn4ic7C832oIOro/LiFlEatu+CVn3WQo4MRDTKSIxtdE13uDcuCBFff68OOUisb6MZ1PjiUbVVXIBhRoQvDfN4IO+3TKcxCl5MWLny0cqER/HWJLBbElg0DOPOWjiuwWILZqIYuTEWsZ3bFF3+9qg39n9oz+5YwkhWukAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBKUl9B3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBKUl9B3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70781F00893;
	Tue,  9 Jun 2026 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781022868;
	bh=TE0JVkVZrrj0DYaTmlnaaMVVZ3bum6caTUwXERfVn5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MBKUl9B3Hw8cHltz45RL1oqLl0KnwJX+t4Su1K7RyigUJAdgC+3SupRx4IKE5orMO
	 BnC89sm8cuNX6gmuZ+0aWaWl2G583n8bLV4qqloTseQYPSCmZHQo9Sm8AH70+pv497
	 L3WYYjc5tdNTfdYcB3SZQdReouellKPywO+D3ggeBNAvb4M/4JzXzTlan7HHlDdLk4
	 n9zVCZvrX7Ya9pzSrgCFhSawrvPNiCyoWKio3Fl5F4Dl0R21/JMl+j8aK1kflPi3aI
	 bE6/HrtKeJC1wWSbTubnaZCx6CCjn+B60XYNN73JJaOLaEo4Ju9eKRam3NP+xIbxx8
	 pFKnKGP/bY4Dg==
Date: Tue, 9 Jun 2026 17:34:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM: dts: ti: Add specific compatibles for SCM
 conf nodes
Message-ID: <20260609-riverbank-buffalo-ae12ae1317c6@spud>
References: <20260608-n-dt-bindings-simple-bus-syscon-v3-0-4eba9ec1212a@oss.qualcomm.com>
 <20260608-n-dt-bindings-simple-bus-syscon-v3-3-4eba9ec1212a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qQ5L5UMcTh/jjl/e"
Content-Disposition: inline
In-Reply-To: <20260608-n-dt-bindings-simple-bus-syscon-v3-3-4eba9ec1212a@oss.qualcomm.com>


--qQ5L5UMcTh/jjl/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


--qQ5L5UMcTh/jjl/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaihAjQAKCRB4tDGHoIJi
0hzzAP9IgmdOgnqiwiYVQ2g4qdVGTjE27anCdxGOJk/6ywkmjgD+JWKwOZ6gm9aJ
GYmHT/Qbuljwrlk++nV9KotKQ5dCGgI=
=3af6
-----END PGP SIGNATURE-----

--qQ5L5UMcTh/jjl/e--
