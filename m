From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Date: Fri, 18 Jan 2019 20:38:47 +0100
Message-ID: <20190118203832.3be7975e@aktux>
References: <20190116220429.9136-1-andreas@kemnade.info>
        <20190116220429.9136-4-andreas@kemnade.info>
        <20190118154807.GV5544@atomide.com>
        <20190118181827.7163bee4@aktux>
        <20190118183630.GX5544@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zoeBvEPg.zuoTfvj4MUKxts"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118183630.GX5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/zoeBvEPg.zuoTfvj4MUKxts
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 18 Jan 2019 10:36:30 -0800
Tony Lindgren <tony@atomide.com> wrote:

[...]
> til the next workaround.
>=20
> > That flags also causes the iclk being enabled/disabled
> > manually. =20
>=20
> Yes but SWSUP_IDLE for the interface clock to me currently
> just means:
>=20
> "manually enable and disable ocp interface clock"
>=20
well, if we want to manually disable it and not automatically,
we have to disable autoidle or it will be automatically disabled.

Disabling it manually when it is already auto-disabled (by autoidle) is
just practically a no-op towards the clock.

> and with your changes it becomes:
>=20
> "manually enable and disable ocp interface clock and block
>  autoidle while in use".
>=20
> So aren't we now changing the way things behave in general
> for SWSUP_IDLE?
>=20
Yes, we are, so proper testing is needed. But If I read those comments
it was always intended this way but not fully implemented because it
appeared to be more work like needing a usecounter (which my patchset
also adds) for that autoidle flag.

Regards,
Andreas

--Sig_/zoeBvEPg.zuoTfvj4MUKxts
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxCK0cACgkQfb1qx03i
kyRmeA//Q32OMXJrBz0h85xgjrdhARhbFnIPSR+K9/kxtLwakGqCC5/ufBdJsKJz
XMRpfQAhOURtCGkQlFNWNCKG/Mi38qw97TQ+iIXOKMpwpgGk6oMcC49qV98rjeKW
AX4EkQxeSD4mdV6keCxScvQbdvByiDRHEP4Yk85ZoFNdWQMUNga1FiHll2fqKuo3
FjzoNpJNi+MeQhTKUMVr6QwMJ7uk7SuLLFM/BsSxeKBDJl4qnrmCozlGVTG0Iz8Z
VXF12FLOic64yzqgqNNDVUiAxflM1mbBKC/uLbVEXyE9HgqannMgEgbtyGdfjMEZ
FGFdExXSTnpb8Q/XDAtJrVTR9b8XGGxdExZHYd6XQQgUPHDfd7VEXMgyVR1Vv4ao
+gU8sJIsZdwYc4dXkpCHFy0Kyk/XFVLMvMT5d/GQEX9ro5RVnxw7czNeWTPk81bJ
LRdAx7kMo4Ci1RPAmOL9AHYGJBSTScYOl5ACnxGYC4ThIjaobMqd8erdO8O4utpq
yEq0HApADR4SO7oaoMBCJn/8R0mIlb2aGYvOjdfmURoVEnPxTYilP6Njwh9qMAkO
89cN7il/HI5i6JQ02VJhiqed67qAPK3D9u/AsehM39LDjjiO8AXVLRaLOsgIDLe1
aGoxEaURw9FhEHgjm99YD/kw6Sxt6HA8OHBxsefX2fr0WJyM18Y=
=Du9n
-----END PGP SIGNATURE-----

--Sig_/zoeBvEPg.zuoTfvj4MUKxts--
