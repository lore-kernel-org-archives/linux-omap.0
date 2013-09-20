From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 3/9] ARM: OMAP2+: omap-usb-host: Get rid of
 platform_data from struct usbhs_phy_data
Date: Fri, 20 Sep 2013 11:24:19 -0500
Message-ID: <20130920162419.GD18721@radagast>
References: <1376561909-4406-1-git-send-email-rogerq@ti.com>
 <1376561909-4406-4-git-send-email-rogerq@ti.com>
 <20130920154406.GV26101@radagast>
 <20130920161822.GR9994@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1638675644969208939=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130920161822.GR9994@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, bcousson@baylibre.com, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, broonie@kernel.org, p.zabel@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============1638675644969208939==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline

--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2013 at 09:18:22AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130920 08:52]:
> > Hi,
> >=20
> > On Thu, Aug 15, 2013 at 01:18:23PM +0300, Roger Quadros wrote:
> > > The platform data bits can be inferred from the other members of
> > > struct usbhs_phy_data. So get rid of the platform_data member.
> > >=20
> > > Build the platform data for the PHY device in usbhs_init_phys() inste=
ad.
> > >=20
> > > Signed-off-by: Roger Quadros <rogerq@ti.com>
> >=20
> > Tony, do I get your Acked-by here and all following arch/arm/mach-omap2*
> > patches in this series ?
>=20
> If you can merge just this series without the .dts changes
> into an immutable topic branch against let's say v3.12-rc2
> when it comes out, then yes I can ack them:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>
>=20
> That way I can also pull in the topic branch as needed to
> avoid self inflicted merge conflicts ;) And Benoit can
> set up a separate .dts branch based on your branch to make
> sure the dependencies are in place before merging that one
> upstream.

Alright, i'll put this in my todo for next week.

--=20
balbi

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSPHayAAoJEIaOsuA1yqREKegQAKEJWqHhdujbhyZn1F1U8lnZ
Gzg0nKXOok81f8WMEiTaB2apG4D7uIEcjkdl9OfN0TSe9uaaKLSSVP8Wfmto1B7z
6Jx4ekRTXXK6qrfTlUN1VdTx8tboZ4nFKhCrOszB7VmUwnaSJYIVUbW7ziLg5HdH
SXMx6qRPTFgzrDQt5Eg6lPM0JdEvM2SJilHIZgVLBb1UH2Uo0Kt8c3op5rAzu/65
aNG6sjN+YkSSPN2BJtyFloziFFHlL2vjz88+iTMkpiX/2glU4agHAH9w5XZhqjtu
6na9kXOQyCnNYfW/29Hv5Hd6DoYzc5VYJuO1WrjP3z3MOxUKwfa/C5fjraHrqtIb
M5cPfOEl5im2Y0uOQ2/w5RYlbyWndT3oKye/Q2SA41svGB2lnV3f+9cKG9D3JKOg
E78xRlmBT0ENkvcti8/LmNoL9cOLU+RKD9fW0N4uY59+KB3JviCTvK3NxfUkwt/9
eb4SsxamswN1NiKAEXcIyWuMaO5qUHIvxcCXNH13Y2bAhHhrfJQHjFsuAlONyhnE
zwXa4luKNWTduOua5htZP/2eeAdIypMM8IdhbEZ7Aa0gsFUPO70P1Xy5qpOLu2f5
ZokSDiaIpn8hJ8DPwopDDgd0H8o/Y6XP1sfFzDI27eG9cOUa7tOD2cGMDXP1oa3L
QMAAEedR2ROLuzII0W5c
=lLbv
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--


--===============1638675644969208939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1638675644969208939==--
