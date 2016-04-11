From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 07/10] usb: dwc3: gadget: Fix suspend/resume during dual-role mode
Date: Mon, 11 Apr 2016 15:23:34 +0300
Message-ID: <878u0knxkp.fsf@intel.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com> <1460374506-9779-8-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460374506-9779-8-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> Gadget controller might not be always active during suspend/
> resume when we are operating in dual-role/otg mode.
> Check if we're active and only if we are then perform
> necessary actions during suspend/resume.

I don't get this. If we're operating in OTG, we should have a gadget
driver loaded, no ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC5dGAAoJEIaOsuA1yqREY4gP/0EiFkinbXHMun4Zk47F1MIe
NDAGsfG9W4ezVrANSMulaSwHJlANQPyLOknKmEpEYv7x4yw5iTkb8ymcRK0UxuZC
Ml+kCbN9ROTx9etGNCj0jLJNJzBeOhqhhBNpIcazGmO2xzjJzx1ZhjXZKuiKOXkb
5CU91G9fqacK63xLbgSZCRSFD4SjfDXCOb1Qkgxvp42EJYrr6oTbIbIk/lPR/Nx7
6H1WDCkcDm4CKLZoYv98cvL1uxAIf7VkbLXdL838hH4CM4z3CaTGaWobyNj0d9l9
Hdz25X1y68tGqWGlDUuqg4+2matLbjlbdTGHLX9nISqJuewj+67Ja+XhQnqTimv1
orRZcQGS5mF3Vvf/aMd59baBbz+KjJMizfzxegH9Tfb4Ro5rV+fAIyCw8UKID952
eBc+VmqVOXwJvCLEnPKVTRmsUp/LxijvUcvmjmQkazjgJLk1lCy7BsGdlsv6DCXD
G4SAFGCCCth4loi5/egEsCT07Z7qhHDWNd9F99WELdUrmiFkDN4GyiFo7Eqwe61Y
0oPpgtzse2B4amLiVICQrkDC6p+/SIm27RpA/DpEB8DIbgNcceD34EL6MWO7/did
cOeJZg4utbB7KzRxb4iTULwDzYL3mbq4cABYSvlXLIPZk1z6lPyEC9a+fgLFLW6I
yg0MOyjIYGfLakXDn0li
=V+nj
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
