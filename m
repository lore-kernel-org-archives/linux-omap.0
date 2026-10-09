Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A8340A57;
	Fri,  9 Oct 2026 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560532; cv=none; b=YYal1oarN3G12CsSvRSpvemUK3Cd1AikIMnl/NFfRxdwwBAP83xy7hyqFttNp3+f+SSzO8oJOJsEm+o/50EWzw5aUFGF6mjfjrIdMPTtQOckSa+o2+qe+bTimIXDWK2u/FaIJG9g7rTh45hPTygST5BKNJNjnqHE3pff4v2bi3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560532; c=relaxed/simple;
	bh=HW59q6Yn0OslPF3Els2Dkx+G+MOVrvpGDU0AOpiMs5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjVKzyq3zIFCJOi9ygPaBMISwj+aGRoQ7o1ufWN2JEQ58Ge0+IieWr8BgX+eGlfAJD+swrR/6SuTKOqS4swU0xEOy/by3+SXGe2f1hpwXuHF4SKWjRVP7e8khcwty9D9dApFVvWWe6WbdDJb4cnD1WETyHZH772+xG/BqWxapdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP8RuDRh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP8RuDRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65251F000FF;
	Fri,  9 Oct 2026 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560530;
	bh=HW59q6Yn0OslPF3Els2Dkx+G+MOVrvpGDU0AOpiMs5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TP8RuDRhfHpTVUdPOYlk0cIai3NHcEJgnKN6+dQM5aM4V2sN0c1RJn+LEudiFDrkx
	 dxScbsVCXK/W/4tJ088RvzIyIV4tcX65/nuH9IbLVfzP1O0w/fPilJaufUYPI5Fg5C
	 OeGTmYEozM6KgPwCKm1yctQX089jK86OD+Q6445gfjut+OH+ojDM0OJ9+2wQdQttII
	 ea4mSor3ZZPSpSlPWNsGESj4hSjJ+7W/nhqBdJXGVeYuAY49DAOltFhqV0oMpSh0p4
	 aNrSJHhvyLXiCcTuidBjxn3JMDSlIw3uS5sa/2sm7OfmUhh7PfK5uelxDHP4XYiGk2
	 3dTzg8vgb7Q7A==
Date: Fri, 9 Oct 2026 16:42:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Quchaosheng <quchaosheng000406@163.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ti,tpd12s015: Convert to DT
 schema
Message-ID: <20261009-db35f1d74028d0d0a34f1106@squawk>
References: <20261009105601.301891-1-quchaosheng000406@163.com>
 <20261009105601.301891-2-quchaosheng000406@163.com>
 <20261009-2f34bbada2c463c78b2c05a7@squawk>
 <20261009144434.GD622105@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+lGluAYOQ0yvN+I2"
Content-Disposition: inline
In-Reply-To: <20261009144434.GD622105@killaraus.ideasonboard.com>

--+lGluAYOQ0yvN+I2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 04:44:34PM +0200, Laurent Pinchart wrote:
> On Fri, Oct 09, 2026 at 03:25:49PM +0100, Conor Dooley wrote:
> > On Fri, Oct 09, 2026 at 06:55:59PM +0800, Quchaosheng wrote:
> > > From: Chaosheng Qu <quchaosheng000406@163.com>
> > >=20
> > > Convert the TPD12S015 HDMI level shifter binding to DT schema.
> > >=20
> > > The TI TPD12S015 is an HDMI companion chip that combines a level shif=
ter
> > > and ESD protection circuitry. Document the two ports it exposes betwe=
en
> > > the HDMI transmitter and the connector.
> > >=20
> > > The tpd12s016 is software compatible with the tpd12s015 and is listed=
 as
> > > a fallback compatible by am57xx-idk-common.dtsi, so accept it as a
> > > fallback of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only=
, so
> > > a board using the tpd12s016 must list both compatibles.
> > >=20
> > > Assisted-by: LLM
> > > Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
> >=20
> > No idea if the sashiko reply is valid, because I have no clue if
> > providing a subset of the gpios is functional. Really this should have
> > multiple different gpios properties,
>=20
> Definitely.
>=20
> > but this binding is really old and
> > not worth changing IMO.
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > pw-bot: not-applicable
>=20
> I'm getting annoyed be the LLM-assisted individual conversions. Can we
> start requiring people who convert text bindings to YAML to at least
> handle whole groups in one go ? If they're going to do a bad job, I'd
> rather have to review it once only.

Or do one, and take the learnings into all the remaining patches - but
with LLM conversions I don't think there's really much learning going on
at all.

I guess bunching them is fine, provided it is for one subsystem. I
definitely don't want to see a set of 15 patches across 9 subsystems,
at least with one subsystem it's likely to be the same common problems
across the bunch.


--+lGluAYOQ0yvN+I2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaskLSQAKCRB4tDGHoIJi
0oOqAP9/cjJoHwDyuvhTJ9sGUQQFM7+QGVx4YCXrySUHlraVRgD/awI23g7lMVjK
P89dAe3GuVNwufd8hjuhcHxiA7qK/g4=
=bjaF
-----END PGP SIGNATURE-----

--+lGluAYOQ0yvN+I2--
