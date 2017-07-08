From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 0/3] Motorola Droid 4 Audio Support
Date: Sat, 8 Jul 2017 13:34:06 +0200
Message-ID: <20170708113405.cgigekmytv7yzzk4@earth>
References: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
 <20170708052753.GM3730@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pnqscodmwlltiwur"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170708052753.GM3730-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--pnqscodmwlltiwur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 07, 2017 at 10:27:53PM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170707 09:43]:
> > I got working sound on Droid 4 with mainline \o/. The codec is
> > currently missing support for detecting if something has been
> > plugged into the 3.5mm connector, since that seems to require
> > some closed source firmware and needs further investigation. I
> > think this can be added later.
>=20
> Hey that's great! I'll give it a try this weekend.. Does that mean
> that 3G voice calls work too now or is something more needed there?

I added some text about that in the 3rd patch. Basically the codec driver
is ready (maybe a few quirks will be needed, though), but the soundcard
driver is not. It currently assumes CPU <-> Voice Codec, but
actually its a network of CPU, Voice Codec, Modem(s?) and Bluetooth.

> For the CPCAP PMIC macro interrupts I think it's best to set up
> a separate driver as it seems separate from the core CPCAP
> functionality. So I think we can just move the unused "cpcap-m2"
> IRQ banks out of motorola-cpcap.c and put them into a separate child
> driver that loads it's firmware on init and provides interrupts for
> the 3.5mm connector.

I also think the macro block fw handling should not be handled in
the driver for the audio codec. IIRC it is also used to provide a
blink feature for the status LEDs. OTOH some of the registers of the
audio-codec are also used for 3.5mm detection. I also did not yet look
into the details of this one.

-- Sebastian

--pnqscodmwlltiwur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllgwysACgkQ2O7X88g7
+pojyBAAjHJelr7wXzaTlHD9jvJXs/ZJsN4gai91XaZTVT0N3lJ4H4UJLMluHu6K
opzcBmfgiuTLffAug7MDoAhRx9Vzs+bw1zH+TihC0L45rtH1DzDICDQtkUNC4QZ7
FyobtZVlmg7TEjdpfJAKQ2Asuu0o4fo+BneRAGMXrXGDVKVJ+zpW3etPllTbkpMM
nzyH+C70cNGxesJ2ZfJoE8sqABKI1Ngf4muNnB/QpNj5qt6xLLgr9u33ThiAm+RJ
tLtHyA/X0LncN5oZTVAkwhP5SzpCSYOEWIiR5PXADiX6E0boRmurfUWJH+RWLBHX
CQGMuGgNDaVDYokyogQT5A78U7mzjyhzqhAjwjNcrDfye1Uw9G5khXrEzi7QtNuu
dBBWh9lOuptpyl6af8I3/CQZUQgKiHJaPbljakFwrSwhCtuMTIooZKJcH7lXbxw0
lxaqYmrN/Oqplf46Ky6khMvEkZ/YgNlYOZlkqvwYQOY1lpDhA9BdcanitFhIfc7c
v6mMXx2ksH0XyFIZbAJoX/pPc3ApvVvZBDXk/fnJSUkep7RqdJCIA9S4J1BkEdLl
UuNAX6TU62ZDE2ZQRsMV+25kP1NST9P7e4QJjQ5u1gioTtdz+fqQtj91pBGmrQch
XHhrFc01ZI1HCW92RWus+ZVGZSin2ul1mgqgU5poHgeYcUJZbGE=
=cmVi
-----END PGP SIGNATURE-----

--pnqscodmwlltiwur--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
