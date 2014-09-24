From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 1/2] usb: rename phy to usb_phy in HCD
Date: Wed, 24 Sep 2014 14:28:06 -0500
Message-ID: <20140924192806.GO17997@saruman>
References: <37148636.BU5lT4M4eC@wasted.cogentembedded.com>
 <2300651.HNvMzB0aUB@wasted.cogentembedded.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H83aLI5Lttn3Hg7B"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2300651.HNvMzB0aUB-gHKXc3Y1Z8zGSmamagVegGFoWSdPRAKMAL8bYrjMMd8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--H83aLI5Lttn3Hg7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2014 at 11:05:50PM +0400, Sergei Shtylyov wrote:
> From: Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>=20
> The USB PHY member of the HCD structure is renamed to 'usb_phy' and
> modifications are done in all drivers accessing it.
> This is in preparation to adding the generic PHY support.
>=20
> Signed-off-by: Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> [Sergei: added missing 'drivers/usb/misc/lvstest.c' file, resolved reject=
s,
> updated changelog.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
> Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

--=20
balbi

--H83aLI5Lttn3Hg7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUIxtGAAoJEIaOsuA1yqRE3k0QAJm0kzZBA3turOgqXHaVRLwm
VgpTmkv1S4cVxdnJ3BW2PvJ2TwogYn+wjTn+68TFFrMzZbATUvHx6Mkkeih9nFWS
98EkzNorTJsJq9zn7G0Quw4Tsr8jEZPlYinoIxFN2E/yvtn+Z5s9D0IV3AMzpnqA
2AW/3KKOevVbnE1gGU5AIZCworl8FfuIczwVw7jwaeLkAnpc6Dohn4IWDk/j9ceK
1vXEuijlw/cRh4nA2BgTggFxeWPyUW6PQWDe2ZQ1aBJxbDK3mLkqMkKtMQ9O7P+b
mJXqxQKPK8x/8tSEmS1CMKjEbUScllxzsjtt8+M/XwAyzkW5dqwRBoCc6fg+J9bJ
f/k1hEkT/ZdQ+IdEV6PuwchgknLKE5Ry77ajV1MnkH5RgVBpTkNR2JgrRMH/YZWg
U8bEVoy/0+jO39zznCmqls0krr0TV1/zMiYhA+WdPO3JsT5nQpPf/B6w8nuOiH5p
JC5PVEi44yizJIC+BCL3dn3g3TazNMigXlY8KSFDPhr76yVdg9Xbrv5rRZ70EL+u
0UvGsVlzqt7mA7a3zqP/92y2BtIiACTJ+UeDBmeBWXqepl5XkmUshlU45P1v0Oom
NpxQHpEV/cXe8w8yv51VvaaGi4jnLJQ40/c/TXTz5oMX6B6V2EQ/Clm8KwaCwRn2
ONCHIuCusgjX1LUfmin3
=YfsG
-----END PGP SIGNATURE-----

--H83aLI5Lttn3Hg7B--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
