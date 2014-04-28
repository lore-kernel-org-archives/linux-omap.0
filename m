From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5] arm: omap2: skip device build from platform code for
 dt.
Date: Mon, 28 Apr 2014 13:39:22 -0500
Message-ID: <20140428183922.GV30292@saruman.home>
References: <1397651532-31456-1-git-send-email-sourav.poddar@ti.com>
 <1397651532-31456-4-git-send-email-sourav.poddar@ti.com>
 <alpine.DEB.2.02.1404281827410.14616@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1653605457561971831=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1404281827410.14616@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: wsa@the-dreams.de, tony@atomide.com, michael.opdenacker@free-electrons.com, balbi@ti.com, bcousson@baylibre.com, zbr@ioremap.net, Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1653605457561971831==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="50RDeE14MEV4qpyy"
Content-Disposition: inline

--50RDeE14MEV4qpyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 06:28:45PM +0000, Paul Walmsley wrote:
> On Wed, 16 Apr 2014, Sourav Poddar wrote:
>=20
> > For SOCs with dt enabled, device should be build through device tree.
> > Prevent device build call from platform code, if device tree is
> > enabled.
> >=20
> > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>=20
> Isn't OMAP2+ only supporting DT device enumeration now?

At least OMAP3 still isn't Dt-only.

--=20
balbi

--50RDeE14MEV4qpyy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTXqBaAAoJEIaOsuA1yqREiesP/2DlaxLGyDA4NjQ60+EIjs0D
h4Qnh6Qso6ikv3CYMn99o3oD5BJqXReW+yY1z6/WXCLTvz7gZNcPEvs2b3FwrE4+
/5y+xfLNtalfVjRVSLeZvepHc1jTsm2GS50hqIfUUFuIBs02X8fU4C7u9qa9T2OE
c5Qc4rX59XLWsbNdaQOs3EuA+3M6G7Ws1wN/WzSV5Pvq5K/xhslh33yxP1eslZ/Y
pUKYI4fCRyIYAw3efKAnqo98wHh6qbgECQAh3bOZ1ufMEr8VBVW9zzZESuIJpn2N
FnJsn9ZIKIRpmJEqM3ZB9B7NLVXNC43zq2fj1bZY9qH+Tky3kzGnOOAjwvbBe0OW
DsSQY+krHTsicfy+cZdyo/Lxa/bkYjwwKPoR3IzTROwrU2R4lEgx4qqYEDs0xIbc
3E91t3jhjuDZVoKiMY24a3coS/GrTTRlLw90P/yyhgQKrWaDwrp+nDdWFR2rWnpQ
QtBYusnn6qSrOgnEmc+yy9hvGh9ULClndh5wYqfhIc2sTSL6L9JAkk6buhNA2mQz
fxeGJBgAN3geEA5Ye9K+MArZaqViECLwSPaemteoSbAgt4qn6RL6UAWvIPRkU4rW
KqTO8P4Vk0TZq+ptGJR7n+a8t08BYt4gzT/7hJc6Kb1UMBG6/Qk6gnhHZTyKo99A
RdP7MlkerR2eYNnCZ692
=agv7
-----END PGP SIGNATURE-----

--50RDeE14MEV4qpyy--


--===============1653605457561971831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1653605457561971831==--
