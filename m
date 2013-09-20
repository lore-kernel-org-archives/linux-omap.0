From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/1] ARM: dts: am335x-bone-common: correct mux mode for
 mmc1_cmd
Date: Fri, 20 Sep 2013 12:44:33 -0500
Message-ID: <20130920174433.GL18721@radagast>
References: <1379698696-21945-1-git-send-email-balajitk@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1379698696-21945-1-git-send-email-balajitk-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2013 at 11:08:16PM +0530, Balaji T K wrote:
> correct mux mode for mmc1_cmd to detect eMMC on bone-black
>=20
> Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>

Tested on my BBB, I see that after this patch eMMC gets detected just
fine:

Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

--=20
balbi

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSPImBAAoJEIaOsuA1yqREnAYQAIh3EJTX2p7IEr/DoCtzibKk
UqTIOsXnWiXskBg8cSzp6NOty08moEkFvqwwAKaLa5YkwGjOwAsNWh00Xnoa0Q8T
Ofvv0I9s0ons7nHRBVoHWUXtwp9ecHLvYIrx4QbpGAWWeklnVgxuaxa7H0ubPghH
Iq6PV3wzbStuj9/T3y8ZT+KyNQUOdD4TGYj2xAx35nSSKbWLhdVacXvdyR3klqMw
bGuRABFYFK73wcIfasd3Brno/yrtexKWgErweCsdszbMdbZGfp8nG0jP9sh/JsKQ
5Bj5fxjg0P1vdaX56IebuGfNZt+XYqtViYOw8DCDm6wS4DGQMCenjxDI4dUwjv8v
L598jHaOG92F9EY0lyiLYvHHQtowCx4Pwh66lIz3547IkpC2TgXzpZdSa2JFgzn2
vIhpIQy+AbDZjeVri8UxxOsaPJytKMWzk5UWNTxS/jCRIeMUdYCWgj2U+TekLNF8
SckCjM7ZRzZz2rO49otBfBS3qlETkaw+WHWXa0faqaPr38W1GEn3SZY8/W+9fgHg
D8Uoks8Z7tN8rDIycAMkjgDhqJBPHg1xHBnewqOJRCNtuocDsp/Cw1WpGV86Wwq9
yJC3gCJGH20gO3voi0XfLXlIl/29sRjuKd+YfDsuVegMNCip76NjrekVfu354aoo
8aGpoT0Rnv1mD7QkkSA3
=N8O0
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
