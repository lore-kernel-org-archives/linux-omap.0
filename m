From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv4 2/4] ASoC: codec: cpcap: new codec
Date: Fri, 16 Feb 2018 14:51:13 +0100
Message-ID: <20180216135113.akicejkodhbjpp2w@earth.universe>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
 <20180216113901.GC5886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qnpszhyifoopthl6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180216113901.GC5886@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--qnpszhyifoopthl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, Feb 16, 2018 at 11:39:01AM +0000, Mark Brown wrote:
> On Wed, Feb 14, 2018 at 11:07:39PM +0100, Sebastian Reichel wrote:
>=20
> > +config SND_SOC_CPCAP
> > +	tristate "Motorola CPCAP codec"
> > +	depends on MFD_CPCAP
> > +	default MFD_CPCAP
> > +
>=20
> We don't have default lines like this for other MFDs...

Is there a reason not to add them? It looks very useful to me:

99% of people are not interested in the MFD. They don't enable
it and are not affected at all. They do not even see extra
configuration entry due to the dependency.

0.9% of people have the MFD in their system and want their
hardware to 'just work'. With this line it's enough to enable
the MFD and the audio subsystem, so less knowledge and configuration
is required.

0.1% of people have special requirements and want the MFD
and generic audio support, but no support for the MFD audio
codec. There is a high chance, that they know how to configure
it properly :)

> > +	SOC_ENUM("Hifi Left Phase Playback Switch",
> > +		cpcap_hifi_l_phase_inv_enum),
> > +	SOC_ENUM("Ext Left Phase Playback Switch",
> > +		cpcap_ext_l_phase_inv_enum),
>=20
> If this is a Switch control it should be a simple on/off binary control.
> If it's an enumeration it shouldn't have Switch at the end of the name
> since that's a keyword interpreted by userspace.  Either option seems
> fine in this case, if it's a switch it should be "Foo Invert Switch" or
> similar.

Ok.

-- Sebastian

--qnpszhyifoopthl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqG4c8ACgkQ2O7X88g7
+prytxAApQfU9evuavpOT0hbpERznCy64y2UYXCdwCBq8vG900eNN/Cxcepl5Sln
eq9HNjceGrYgLb83ynHNL9I4enp7Rf7wMIAu6NLPRYzuNgoABLWWOlLoiEf+dWzE
kojXaxu9uFdi50+kGy723cxXFzXGddUhEHic5L9GOKt/BawV76ZWX7DkGa5HKgO3
L2UPSv68U1GdOV1zYYFvAa5TBu+klr8OHwG1v/EQ4H3F+8R59QiFRhotfRjah8d6
+z+xRA1wLlyh+h8nbVRM5Q1V9964n79zkE67U3LsZ9j8xdeO8njW2L0Fwdkcl+G4
+7o7VZSRTWP5FftXacvFQ9LqxYLi7G84CG/1XU0+630kdfdNUpYz7rIBlhjBU52u
qJJkVIHsSCeJwMoRGhkrlsIxjiYQa6JgNS9cqdEWerJv33q6wyhMcRWC79VIcYB8
Y5nSPjym8Ph+brG0B5TApUtm/2/yMTZLp0rG8s8x+7BjSAXqF19SVhVux6XzE6BG
haStiWk9V+lpWaxM3gcyVcPYgcsRn2FDmjw9jRHQ5LCFUlAwEw9nB+V8qnJhDHo2
lpTas0MFwOs5yM2tUerhivD7MttWNXfdrvlE6A4SDOlFBy0u3kwGTcu3T0mjgCyt
aAuSo828I/3GLQY3I6EwdS+e0LrjRls6vtBP70s+pwa9JgnA8qo=
=Swer
-----END PGP SIGNATURE-----

--qnpszhyifoopthl6--
