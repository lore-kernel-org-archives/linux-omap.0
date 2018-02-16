From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv4 1/4] dt-bindings: sound: add motorola,cpcap-audio-codec
Date: Fri, 16 Feb 2018 11:30:08 +0000
Message-ID: <20180216113008.GB5886@sirena.org.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2018 at 11:07:38PM +0100, Sebastian Reichel wrote:

> +&cpcap {
> +	audio-codec {
> +		compatible = "motorola,cpcap-audio-codec";
> +	};

Why are we adding a separate DT node with no content for this?  This is
a single chip, we already know that the CODEC part is there from the DT
telling us that the chip is there and what we decide is part of the
CODEC is going to depend on what the OS running on the system is doing.

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqGwL8ACgkQJNaLcl1U
h9BgmAf/Tnb3DCCX80xhkj7giVa2liDIqU+bdPvhfNNW/WpN2I8BFgDnk0mp3gof
v9WXlB6TxCEVwiTrLI5Y66zkLoaGCHjcLfoE5u4tMTuWSxJjnWMjdQd582+FQNJa
QyjdXQRyxc+TTDhpNXfI+HFZHIWOGFIHzKQViliRPbkgDCLFUcokL/kvZmlaDJFs
hdAqQQSPxXG4ytK/0YZPewoJu1C2U8j6VYjw+/09s2GU4RkpNzX2+ZozTmFvUQ6t
WksPU/RZej3bSqBBtoasgSaCdWm8XZtUE9iypvh8Y6f02UH6Yz9ipB8ivrDnW9qM
eqamkh9uPWDCvuTGiH3rrGt9Y9PBmA==
=ULCD
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
