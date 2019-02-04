From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Date: Mon, 4 Feb 2019 19:33:11 +0100
Message-ID: <20190204193311.102a60e6@kemnade.info>
References: <20190202055827.12956-1-andreas@kemnade.info>
        <20190204155604.GH5720@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cZTCPF4_0JCD8_K5dVyf4=+"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204155604.GH5720@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux@armlinux.org.uk, khilman@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/cZTCPF4_0JCD8_K5dVyf4=+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Feb 2019 07:56:04 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [190202 06:01]:
> > Enabling off mode was only reachable deeply hidden
> > in the debugfs. As powersaving is an important feature,
> > move the option out of its shady place. =20
>=20
> How about let's enable always if we have the twl4030
> configured to allow it? You can just check if the dts has
> "ti,twl4030-power-idle" or "ti,twl4030-power-idle-osc-off"
> properties set.
>=20
> In order to enable deeper idle states, the user space still
> needs to idle the UARTs and possibly other hardware blocking
> idle. So we should be safe there.
>=20
Let us not mix up runtime pm and system pm. The uarts need
to be idled for runtime suspend, but they are off/ret for
system suspend without userspace intervention, so allowing off mode
will have an influence even without uart runtime suspend,
and also probably for other powerdomains (non-core/per).
So we still need to be sure to handle at least some erratas and
context save/restore correctly.

Your Idea seems to be in pseudocode
if (powersaving_wanted)
	enable_off_mode()

I had something in mind like
if (system_is_trusted_to_handle_offmode()
	enable_off_mode()

Regards,
Andreas

--Sig_/cZTCPF4_0JCD8_K5dVyf4=+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxYhWcACgkQl4jFM1s/
ye+kpxAAtyNv7KqReXE73tqndnZZKlspBriMnP2PreLqcpI8myQPpBCb+aCtP+AS
q1HAXiiMZVF41tdQ8cDXpEQPi537pGz7bmLxh+QLdAMrh6gVweUtBPX3dLIdn8+B
lC+3awFj4B9d4jNCveHh8OeAb7mDYZN9XZDzSBaJztcXGNsY9P4sr57Ird4NzoFc
A2zGUSofbgVKN2JPZT7FaSnv8sgd4khFwAV5FbIVK1R5gFWyj8ZCsnpdVSHYQIEd
yUM9qTtYshGLs/0W19h6SFxlLk+2qCiLKdslXUytkpdcHZ/0zL6rJtHSIhlua+Gc
UH6DoPhRO5Qo9Y63fy60lyRFm5cMeAosghDfzhvEBt58doLJVPwi06coRY/Tdmxn
gK8/YSMTt+S1Sj3FvDODxsOACg1MxzdBwcG/sGQDBzV/8iyiiyA28WWcHFcNiQJ7
wzPPk8FMHRP2oipVIj7gQVz2Q+HvD+stuJhS8SPIiNKmNeZSdF0qh1s7kCrOfK+6
RQUNl2goH2+8ldkWhCdcswfGQyhpr00cdhxoxrKSaat/roLpbyTalGx/cm9lgoPH
UkXzWKVTaqdjrN7/VxWjzamgjy4VMnq99BuF91UaOz0a63KPO6ob6cW+jVdtJ/I9
m/TeKon7/F+zxpuDxk5QWyZlA7YTFhzhCCMGXybBl9nX7m+bovA=
=sAHi
-----END PGP SIGNATURE-----

--Sig_/cZTCPF4_0JCD8_K5dVyf4=+--
