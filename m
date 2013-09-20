From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 3/9] ARM: OMAP2+: omap-usb-host: Get rid of
 platform_data from struct usbhs_phy_data
Date: Fri, 20 Sep 2013 10:44:06 -0500
Message-ID: <20130920154406.GV26101@radagast>
References: <1376561909-4406-1-git-send-email-rogerq@ti.com>
 <1376561909-4406-4-git-send-email-rogerq@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7453431264100311825=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376561909-4406-4-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, linux-usb@vger.kernel.org, balbi@ti.com, broonie@kernel.org, p.zabel@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============7453431264100311825==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XaepPZQT0uxAV0NY"
Content-Disposition: inline

--XaepPZQT0uxAV0NY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 15, 2013 at 01:18:23PM +0300, Roger Quadros wrote:
> The platform data bits can be inferred from the other members of
> struct usbhs_phy_data. So get rid of the platform_data member.
>=20
> Build the platform data for the PHY device in usbhs_init_phys() instead.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Tony, do I get your Acked-by here and all following arch/arm/mach-omap2*
patches in this series ?

--=20
balbi

--XaepPZQT0uxAV0NY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSPG1GAAoJEIaOsuA1yqREw54P/3ayz4TIUD3gFjF99oq4+D/F
Lic490TzLVqTRG67ElaOvT8wBGnzhbraPRK3udigtoFR2VnGVXit6s/m6hNP9uf6
WrABQjhGUIl8taaLkC1EIf9/+L7w8lOMuL6MZDV0NndOPDeJOEACLECfFMAEqjKx
37YWwv4YUi3KluqAcKjWvGNsjdUEbbxASUsUkTSvfIwcwhjjAPVw0TFMwGRFclAL
LhRPnY4RJyj3sarOWv2ELOGNB/ay3aQO0wr9BPbCuGfGU3cvX5I5d1mScMMLPXeE
5jxSkx8S8mOOaT5RsyhLn7T0kvS7XInmIxLlpKWAeZ1qHssXBDwHcyY8MiKr1NDJ
wAdkCN+7RYwBxuEC/w/W4QqIffatAHSSluuppKE6ufnpd3u/Axg4/0MvSBwidS/U
LnRlou98jUPgHXrfgqIL0V9g2ATfu97+i7zgO1qn6+UHNUbr8bY6AAjHZAK6xYie
REmhahDQn5+rYdZz9kPBTgDz5nJAr+une5WnQUPDvjr/NuveMk120T/1YVp2EztT
vodKhuLTSubeUkupkuCAa8bpzbaFiu6y7HZANDW/UQkXdRM91U3+kXEC/0wvhqiV
gABB7RhShxJWPvF0xXYj3deCc9xSoYnutNI8ZQ/XaBn/gCPOcjDO3hbJo5D3YtM7
IGOH2a7nRp+zum0ebJ2n
=prHi
-----END PGP SIGNATURE-----

--XaepPZQT0uxAV0NY--


--===============7453431264100311825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7453431264100311825==--
