From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 4/4] musb: omap2430: avoid pm_runtime_disable()
Date: Tue, 20 Dec 2011 13:57:04 +0200
Message-ID: <20111220115702.GM31842@legolas.emea.dhcp.ti.com>
References: <1324325871-15137-1-git-send-email-felipe.contreras@nokia.com>
 <1324325871-15137-5-git-send-email-felipe.contreras@nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oiL9LJXJsdjS5rzq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:49378 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750809Ab1LTL5K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 06:57:10 -0500
Content-Disposition: inline
In-Reply-To: <1324325871-15137-5-git-send-email-felipe.contreras@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-usb@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <trivial@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>


--oiL9LJXJsdjS5rzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 19, 2011 at 10:17:51PM +0200, Felipe Contreras wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>=20
> These are handled by drivers core, and in a way that doesn't wake up the
> devices.
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

applied, thanks

--=20
balbi

--oiL9LJXJsdjS5rzq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO8HgOAAoJEIaOsuA1yqREEOgP/0Il9p8FGm+DlhDVFDJKeOvG
fkaB1XgYE/lMpIuwzkb+2b7dgx+aNNnDqLW7rVno3qrrYflJ4PW/hXk8IWlcFEDl
NkAlrSCST5etPyXYztcrgY1pF9nfOUuVZ43n0tj2otOiYV+lQD8ayD+P8+XlItf0
WZIf0r9U/l1HKzIjV8bX28WWCMqOef6Ivgyp/nODJ4h9qfSrXT+ja35AEDWzbTRE
BlUDi30xt/q/W8x+a5JpkHs1eEIKxdK+cDDl1bL7Q42upGhPQt9Aq13a8q1jkmSD
Hvl4pl2jxjVGgSAn3BZUjts8GVUbutBYwbd1c0CcpsE3b2t6mQ5sGi9CE0Opy8qT
trzm0k98h2NhSf2yDln0P0EEqIQhtw88ejzkERsQFXJbDb2HK/7/fL0oIdzVSE6K
ckdcSZ8I/UqIk/ek0K6d6vTisbOAn3cBybK7H19gX/AYh4PGlE99U//2MPjnC8EN
CDIrRTHAyh0OKPFHMnKk7tVnySVWDuIE6qCO5dIIGlnRiQg/WmYFkTb1nFlBnVXU
dHc6QdCxIDGvuf3lsTkROs132GnMC4rjNEVhC591WT4rl3FJLCBLVVLiiadGzznE
6SyBx+TnmwMfN/RNnYif4QeiyAfkottkS8J4ZIZg5j/COU4UKZ38q2Rw1ZRPxPdd
PTg4LCH9WT78pmOS540O
=ff9N
-----END PGP SIGNATURE-----

--oiL9LJXJsdjS5rzq--
