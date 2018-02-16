From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCHv4 1/4] dt-bindings: sound: add motorola,cpcap-audio-codec
Date: Fri, 16 Feb 2018 14:25:38 +0100
Message-ID: <20180216132537.lkd4wzfg7uuoyx7k@earth.universe>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
 <20180216113008.GB5886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4wgqgt55vm2fopkt"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180216113008.GB5886-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--4wgqgt55vm2fopkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, Feb 16, 2018 at 11:30:08AM +0000, Mark Brown wrote:
> On Wed, Feb 14, 2018 at 11:07:38PM +0100, Sebastian Reichel wrote:
>=20
> > +&cpcap {
> > +	audio-codec {
> > +		compatible =3D "motorola,cpcap-audio-codec";
> > +	};
>=20
> Why are we adding a separate DT node with no content for this?  This is
> a single chip, we already know that the CODEC part is there from the DT
> telling us that the chip is there and what we decide is part of the
> CODEC is going to depend on what the OS running on the system is doing.

While it looks empty in the DT binding file, it's actually not empty
once some standard properties are added to support audio-graph-card.
A real world example looks like this:

&cpcap {
    audio-codec {
        compatible =3D "motorola,cpcap-audio-codec";
        #sound-dai-cells =3D <1>;

        port@0 {
            cpcap_audio_codec0: endpoint {
                remote-endpoint =3D <&cpu_dai2>;
            };
        };

        port@1 {
            cpcap_audio_codec1: endpoint {
                remote-endpoint =3D <&cpu_dai3>;
            };
       };
    };
};

Having all of this directly in the cpcap node doesn't look like
an improvement for any OS. Once there is a node it makes sense
to add a compatible IMHO. As a side effect this also avoids having
special handling for the audio codec. This is the last missing
sub-component, see arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi

-- Sebastian

--4wgqgt55vm2fopkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqG288ACgkQ2O7X88g7
+pq/YQ/5AeXjVP0rUKWE/VZHRZnyxD1lwAtgMODqFJ93v5TulzMIHghoCHRlngXY
czWjZ/kXQn9Y8ZciuV07005OjBY6mJdC22gtvZuq/Ufk4luGTdAK/P/KFKcoEsLB
yKLph76WcHSUAEXFpN0Hp0jnbOkiXxDPQHW7VJM6AILAQR3u4jKHU923m0ibNjyi
WG3i6C1ykXOpPX0Pdj4XmPeNZA8P2ZHt3Sk60fHG+ePyxXOZB9IJ5Nny98Qxh3gY
ldYOcmIbXWtlf7G7bD/vlXMoc600jYN/CT7seLrWjDrn9e2pxRMrGbbSLJeiL6Km
3unsXXNY99sDBdoHXyESfWF+F/90bz24pU6C+i0PgISv/LlSkx9Z63/6uMNmi6DV
Qm1nelOxDjNlNCgjRU+R90jG3aFEwnJunTywtQNrJcBOgFgmhVag9fGH+HoDX4gB
EbTxruuSfKwMaCV6/sWtLj1LgsZCRC0Q+Zvjx8SOvF9iwi3euzHWrovlZo9Yn6+Z
DPVQ0+Ns6Pq/pWVN7Xl5HLh00AQAR/FQP1eJdsBas60tNmbPRlMPN6MoV31okRcd
uXPhQfIU5vwsRC6fPdzPadbVAnTfS4FhZHLULFjEuWSZyPVVqK9/xlRBQgBkxHvk
K43NPiu7MM6fZkOxpTCkR4PPtADCyz4OdVOhxHdR6fJbmAJt2qo=
=2OjM
-----END PGP SIGNATURE-----

--4wgqgt55vm2fopkt--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
