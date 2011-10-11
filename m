From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/6 v3] omap: musb: Adding hwmod data for ti81xx
Date: Tue, 11 Oct 2011 12:43:10 +0300
Message-ID: <20111011094309.GF10155@legolas.emea.dhcp.ti.com>
References: <1315576070-7618-1-git-send-email-ajay.gupta@ti.com>
 <1315576070-7618-2-git-send-email-ajay.gupta@ti.com>
 <19F8576C6E063C45BE387C64729E739404ECA545E3@dbde02.ent.ti.com>
 <20111007085614.GD10910@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECB6B70F@dbde02.ent.ti.com>
 <20111010054435.GA31653@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECCE551F@dbde02.ent.ti.com>
 <20111011091055.GE10155@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECCE5552@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:44241 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753863Ab1JKJnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 05:43:15 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404ECCE5552@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "B, Ravi" <ravibabu@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>


--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 11, 2011 at 03:07:46PM +0530, Gupta, Ajay Kumar wrote:
> Hi,
> > On Tue, Oct 11, 2011 at 02:13:07PM +0530, Gupta, Ajay Kumar wrote:
> > > Hi,
> > > > On Mon, Oct 10, 2011 at 10:40:55AM +0530, Gupta, Ajay Kumar wrote:
> > > > > Hi,
> > > > > > On Mon, Sep 26, 2011 at 03:21:07PM +0530, Gupta, Ajay Kumar
> > wrote:
> > > > > > > > To: linux-omap@vger.kernel.org
> > > > > > > > Cc: linux-usb@vger.kernel.org; Balbi, Felipe;
> > > > > > > > tony@atomide.com; B, Ravi; Cousson, Benoit; Gupta, Ajay
> > > > > > > > Kumar
> > > > > > > > Subject: [PATCH 1/6 v3] omap: musb: Adding hwmod data for
> > > > > > > > ti81xx
> > > > > > >
> > > > > > > Felipe,
> > > > > > > I am planning to send patch 1/6 along with next revision of
> > > > > > > ti81xx hwmod baseport patch from Hemant so that all hwmod data
> > > > > > > gets reviewed at one place.
> > > > > > >
> > > > > > > So now only rest 5 (2/6 to 6/6) patches needs to be queued for
> > > > usb.
> > > > > > >
> > > > > > > I hope this will be fine with you. Let me know if you want me
> > > > > > > to post Same 5 patches separately.
> > > > > >
> > > > > > I guess it's better to queue them separately. I will only take
> > > > > > whatever lies in drivers/usb/musb
> > > > >
> > > > > Ok fine so usb hwmod patch will come from Hemant in his hwmod
> > > > > baseport Series. I will resubmit the one patch fixing your
> > comment.
> > > >
> > > > ok cool, tks.
> > > >
> > > > For you platform_data stuff (if you have any), you can add a header
> > > > to include/linux/platform_data/musb-dsps.h
> > >
> > > I need to access "struct omap_musb_board_data" and so would add
> > > "#include <plat/usb.h>" in new file drivers/usb/musb/musb_dsps.h.
> > >
> > > Any comment ?
> >=20
> > It would be nice to move that platform_data from <plat> to
> > <linux/platform_data>
>=20
> Yes, correct. But that would need change at below files.
>=20
> arch/arm/mach-omap2/board-4430sdp.c:static struct omap_musb_board_data mu=
sb_board_data =3D {
> arch/arm/mach-omap2/board-am3517evm.c:static struct omap_musb_board_data =
musb_board_data =3D {
> arch/arm/mach-omap2/board-omap3evm.c:static struct omap_musb_board_data m=
usb_board_data =3D {
> arch/arm/mach-omap2/board-rx51.c:static struct omap_musb_board_data musb_=
board_data =3D {
> arch/arm/mach-omap2/board-omap4panda.c:static struct omap_musb_board_data=
 musb_board_data =3D {
> arch/arm/mach-omap2/board-ti8168evm.c:static struct omap_musb_board_data =
musb_board_data =3D {
> arch/arm/mach-omap2/board-omap4pcm049.c:static struct omap_musb_board_dat=
a musb_board_data =3D {
> arch/arm/mach-omap2/usb-musb.c:static void usb_musb_mux_init(struct omap_=
musb_board_data *board_data)
> arch/arm/mach-omap2/board-ti8148evm.c:static struct omap_musb_board_data =
musb_board_data =3D {
> arch/arm/mach-omap2/board-am335xevm.c:static struct omap_musb_board_data =
musb_board_data =3D {
> arch/arm/mach-omap2/board-ti8148evm.c.orig:static struct omap_musb_board_=
data musb_board_data =3D {
> arch/arm/mach-omap2/board-omap3evm.c.orig:static struct omap_musb_board_d=
ata musb_board_data =3D {
> drivers/usb/musb/am35x.c:
> drivers/usb/musb/musb_dsps.c
> drivers/usb/musb/omap2430.c:
>=20
> I think this can be done in a separate patch and let the ti81xx 6/6
> Patch to remain same.=20
>=20
> The separate patch will replace "#include <plat/usb.h>" to
> "#include <platform_data/usb.h>"

cool, that can be done with a sed script ;-)

--=20
balbi

--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOlA+tAAoJEIaOsuA1yqREKmcP/i1rcx3wLrYsCTZgFh67EMkX
NI7zusLN0iHiH/oZhNGJyWVZW4WuTF44dCUnCnxpr82ERxQc/ksC5paItDziwLph
5WXJday8U7mX2VfRZV2ZVIyN9rdK9SP+NyRxShe0hV5XiYxeAI4ANqpeApnZiYD/
qExIJKFiQlKR8Mk3JMV/Gmub/ataOBK8kJL1otNvApp7qapK8+a7qB33gL2XA/+c
A8JvOQQIw49NMPavL4RkDdoZX2KGFNzvmw/3F1iVouwss9DvwqxzFMa3nNWSq7wH
ISh9gYKwJNRmc8BSmxtEJef4+/YurPD1WF0J86LWdVCFW3++YcazFMj/e1XHxbTx
UHzEp4zEOCUaBIM0PB3cEoTtfIv+BH1egD018Kn01aS1hvdxAer41GMgw1SM02Aq
sRids33U08F5izjJ7xD3fNQTJbNQZojSEdqMTB05OFMGufgewF2KAMGqZUYEEDef
mV2zux+V+pB2/ZTkmlGNjaV1lofkfmXLEBGvfQ48gCgNd9dxw5gCjyn98vTmcvmO
0XSHUZSPooWWp58nRpfWU0PIkb1ZWNh9UtEyismUGDXk4/yVw+VrkT7ZRR27hr37
YQLjLpGpeldZdIwbhkkU01Kg/tDQ6bQ2wWwaoUUUiACjgexYnbTn4yIyhpbqWJ6a
+ceVVnjMoIzSL7XSCRJf
=yc7O
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--
