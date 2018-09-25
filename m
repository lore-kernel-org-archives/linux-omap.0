From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] ARM: dts: gta04: add serial console wakeup irq
Date: Tue, 25 Sep 2018 07:26:36 +0200
Message-ID: <20180925072550.424e82e7@kemnade.info>
References: <20180923150719.8211-1-andreas@kemnade.info>
        <20180924220345.GG5662@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/U736Hjz4msrhS5TIRMcCICx"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924220345.GG5662@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/U736Hjz4msrhS5TIRMcCICx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Mon, 24 Sep 2018 15:03:45 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [180923 08:12]:
> > This enables the possibility to have more aggressive runtime pm
> > by providing proper wakeup irq for the serial console. =20
>=20
> Thanks applying to omap-for-v4.20/dt.
>=20
> FYI, you can now grep wake /proc/interrupts and see the
> wakeirq counts increase when they trigger. Might be handy
> for debugging PM stuff.
>=20
thanks for that information, you also had a patch for checking
pm which was explicitely marked as not-to-merge. Is there
any up-to-date version of it?

Well, for debugging I check first average currents via bq27000
attached to omap_hdq. omap_hdq gets stuck after first transaction
after idling uarts which does not happen when CM_AUTOIDLE1_CORE.AUTO_HDQ
is cleared. Reloading the omap_hdq module to try to fix things
makes w1 really freak out (patch already sent for that).
Well, will do some rtfm and hopefully come back with a patch.
afaicr there was something special...
The result are power management problem in /dev/brain ;-)

Regards,
Andreas

--Sig_/U736Hjz4msrhS5TIRMcCICx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlupxwwACgkQfb1qx03i
kySfrhAAl4iNzNHtUh9FwtewvuB/4HVtX5zn/mbujKtPE3pQnKPLtpn4UNkLJQZU
OaymyjkUnbPl6Y2ZO7G1ASZ6kBy7xC2FXaSgkrITTe8Sc7V1HsNxUX84OKiAo1QC
EMliiQNZwY3KT0+hHVrA9JboV4J5bM6LJ/OwUbsfuBHZzffZOx4KtrebSj/5Rljy
Emip5N3mbsa/k2tAPsRAOFovMSWt0t2IeXpKHomoRP353Nzkz3B4a/LFTZeci8sO
f8gOJvKbZ+7+AItXhrRHnIrSqmSCqZW1ugz9Z1M9F6S1DQpWmfhX0ra/QyLPNQ40
2gRD7kp5wum99lhs1AzXuwtOvA9nWSxMd69WiSQlYWam2usDdi30bLDLufQGhD0f
CWWIFEcfV/sakACkaePh9C6Q2gWUVxPZuTj1PwVoy6gLk/vDC+v7/YgZCaQKEYSY
vlcwKfvALa9baYtmUl87j046A6WbrA5A20GAfz1BUCIbLfY7n7SnA032OzLzlbZK
r78UdX+vXkMCBvzZAUK5qUzmlWxS0jv6RkW0xY/o/I3YCpVLPJlGLdTIMDYQ+MEH
oI430AMe6DbDKGjczeaMldunNcmrBj9Lw/nWx1bP0jKQNVHVdeoGRmcQKNBS0q4w
8D8lhwE2JLy27c5Fc/Ch4LWTEjaQ6ExVs4Gk4IPq+9cZ7T0Y46U=
=px2V
-----END PGP SIGNATURE-----

--Sig_/U736Hjz4msrhS5TIRMcCICx--
