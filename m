From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v3 0/3] mach-omap2: handle autoidle denial
Date: Sat, 9 Feb 2019 19:53:39 +0100
Message-ID: <20190209195105.74bb9085@aktux>
References: <20190116220429.9136-1-andreas@kemnade.info>
        <20190121195803.GH5544@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/65=PCPS8TYCcaoYbPhBie0B"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121195803.GH5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/65=PCPS8TYCcaoYbPhBie0B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Jan 2019 11:58:03 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [190116 14:04]:
> > On the gta04 with a dm3730 omap_hdq does not work properly when the
> > device enters lower power states. Idling uart1 and 2 is enough
> > to show up that problem, if there are no other things enabled.
> > Further research reveals that hdq iclk must not be turned off during
> > transfers, also according to the TRM. That fact is also correctly descr=
ibed
> > in the flags but the code to handle that is incomplete.
> >=20
> > To handle multiple users of a single ick, autoidle is disabled
> > when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))
> >=20
> > Changes v3:
> > - replace CLK_IS_BASIC
> >=20
> > Changes v2:
> > - uses spinlocks instead of mutexes
> > - invert counter logic
> > - check whether clock type is basic =20
>=20
> For this series it's best to merge it all via the
> clock tree along with the related clock patches:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>
>=20
hmm, this is stalled. Have I missed any new objections?

Regards,
Andreas

--Sig_/65=PCPS8TYCcaoYbPhBie0B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxfIbMACgkQfb1qx03i
kyTzzA/+OHsIwacb/G1qQhvkuTCOcU9XvIV82zhtLWKSzN/JCUJCTcYHaRzC1sHq
6SkA7Tyc9fDeXrpgZFhI62C0eIuIYjkZ/894LxJkkKrJvEepezJbpU7FWaHohJSe
vqWUUnjvh5ElSt+/4cjk2xukWiET0P2PwRvkZPLMEeFNr2n1z7zBqsbjG3tfuHln
IgstegDhHVUj/m1h8wI76V9cbAOavlH9pU5eG5qd5fa+fg1QYUlYlKRUkohWYczJ
mF7P1GXpEFoFTr+QNIcOTSWXXPrbt4iKfDfNn16oRCpApFs8RCYZw7zpB1T7PEEu
uOApIJm8sntuSmA8+JLEwNcDZOD8ZbJu8f/3Le6nH47qe20ViiecptQmcxYFR4CJ
AE96FYpVk0BPZNu52r4IUsdTv/l//tH5okj06VmkwB59ovICpGFAICMwlIOl6Wn6
eOV+F2c/C+07aRTbQ2sYaHOuwxn1xOKaWg5+NfbIL3BYT1VgdHF4woWfapzhsO6w
2rNwMH6e65/X00oNirC2e3ykP8FAcQZQKRXWPGBOT0ypjdbYfsBGk7Ojs6HIFk0W
h8/uAOJbnGlMTLO+eN+4+3Wfdsmbc9K1Knl3tQHg8T8gXgaehpyuNvAj+iaFFXXr
tpiokpKPJUC/ZQ1+bAzZHraVRqJ3EhK+tvbbp0bMm6aV6TKnyWc=
=uXmU
-----END PGP SIGNATURE-----

--Sig_/65=PCPS8TYCcaoYbPhBie0B--
