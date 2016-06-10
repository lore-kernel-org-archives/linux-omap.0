From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 5/9] ARM: dts: am437x/am33xx/da850: Add new ECAP and
 EPWM bindings
Date: Fri, 10 Jun 2016 14:40:22 +0200
Message-ID: <20160610124022.GD27142@ulmo.ba.sec>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-6-git-send-email-fcooper@ti.com>
 <20160610103423.GT22406@atomide.com>
 <20160610120142.GK22406@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160610120142.GK22406@atomide.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Franklin S Cooper Jr <fcooper@ti.com>, robh+dt@kernel.org, linux@arm.linux.org.uk, paul@pwsan.com, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2016 at 05:01:43AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [160610 03:37]:
> > * Franklin S Cooper Jr <fcooper@ti.com> [160503 08:58]:
> > > Switch to a new ECAP and EPWM bindings that doesn't depend on hwmod to
> > > provide the various required clocks.
> > >=20
> > > For AM437 and AM335x, add the required clocks explicitly to DT. The
> > > hwmod entries for ECAP and EPWM will be removed and this will prevent
> > > anything from breaking.
> >=20
> > I've applying the first patch into omap-for-v4.8/soc, the rest into
> > omap-for-v4.8/dt. Note that this patch did not apply against d850.dtsi
> > so please resend that change as a separate patch to the davinci
> > maintainer.
>=20
> And I did not apply patch "pwms: pwm-ti*: Get the clock from the PWMSS
> parent when using old bindings", Thierry should take that one.

Tony, did you take patches 3 and 4 already? It's fine if yo have, just
wanted to know whether I should pick those up as well.

Thierry

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWrU2AAoJEN0jrNd/PrOhI98P/RJHBVbPrFfmvqn+7CJqbC1H
NKQmnRGbkPhxRbMqFffArWza4wQjEZjfaJTIG6taAroxy3YGcU+MiIiQW5iNn9nF
070sfVXS1t3CHA0MPBue8Bwa7h5ts7Rxq9hvbXskjAgvPnFMBJ0Jjs4ByFOboc/G
A1LkwOGMEbHuvmCwGABfcKHiR7yNykFAOGnYwuNcVLxUBx4X/tLn+dW0lzYgoVZ8
Ezxzrb1gMOhKWlDisigSx2jl0KpzuttUhPKQwB+/QVH9q78q217iBh29AA2IZwc5
kLS8YqpW7/kpV1C6b1L5vtyiweDozsv8kpMJ0Hm7chgiXgmJvyMFpMubBB5KP2nq
W4Hj6EAM1HxHtx+jU6om+DLQkGMBfcpJFzWrzUcGhvtrxz3ShWsPhTIT3nkbDwaR
mZQBtlpUxXXoB27kkBO4kTV+T5LaLmE67oGJ+9GUmCdlnMVLNciweXdWyu6zi8MP
9f62X357uinNppFjWRWce6PhsKIV/nQjmxW9HINBvJtzQ8FLi24D9vNSqA2uOQkw
ImZpf90n9gzig/m6jEnus/bziRR1k5smtR1BtY1OqFl5YjXKCO4lHU+0aZO5GlD3
dgVIUam/GI7VoH9Q+cMLWam/M6Bf7HjGA2KGpinwxLZ4FaoPC6AYSjGKYjYrBEDe
CkGmEJmNU35ys3YLr+ht
=4NxK
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
