From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right
	DMA method
Date: Mon, 3 Oct 2011 13:07:05 +0300
Message-ID: <20111003100704.GD3363@legolas.emea.dhcp.ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1546914.88vcgxkfJf@wuerfel>
	<20111002221050.GA25790@legolas.emea.dhcp.ti.com>
	<3529819.LQllWhb43D@wuerfel>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0744031150=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3529819.LQllWhb43D@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0744031150==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 03, 2011 at 11:40:26AM +0200, Arnd Bergmann wrote:
> On Monday 03 October 2011 01:10:51 Felipe Balbi wrote:
> > Anyway, I'll take your patches in, but their too late for this merge
> > window  I already sent my last pull to Greg.
>=20
> No problem. I need the full set of arm-randconfig patches upstream in ord=
er
> to make randconfig work in general, and that's not happening for 3.2
> anyway. Right now, I'm just trying to as many patches as possible into
> maintainer trees.
>=20
> Is your tree part of linux-next, or will it only show up after the merge
> window once Greg has pulled your first set for 3.3?

My tree isn't in linux-next yet so my patches go to Greg and from there
to -next.

--=20
balbi

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOiYlIAAoJEAv8Txj19kN1CDYH/2+3/wYhWXA7fHPdfefo6QDu
mL/EPGzv2Ub7oZ3qjQ48oEYaCUGwqsahjK0DNGtVKaE/y/Hv4twF3WXvK7VqKvMB
0mhiiVp6Sx5/GafgZbmRnc8xEG0gvkb+n63eETlsmbITYJM5sB88WA83QpJOYJ7r
LGAfYDGVZ/SMe1sKco/LC1xgyxlP7+Vrb+OVs+os+An2PaaRaTvfHkPDokoKARDl
CsyMDeWuPoEaihRAuHIkq40KIp4634YfTa/pV7xtu0+ghy1tEyISizQVG5X7cwVC
O+dwHLsIgX4KUbS/WFQsyUPHHNARWRtKD1SvOmp9rpEFCp7lGeKp65W8tm+VzNc=
=2pOE
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--


--===============0744031150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0744031150==--
