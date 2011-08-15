From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC/PATCH 0/4] Add support for DesignWare Core USB3 IP
Date: Mon, 15 Aug 2011 21:41:33 +0300
Message-ID: <20110815184132.GE2876@legolas.emea.dhcp.ti.com>
References: <1313423845-2288-1-git-send-email-balbi@ti.com>
 <20110815161631.GA14830@kroah.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110815161631.GA14830-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 15, 2011 at 09:16:31AM -0700, Greg KH wrote:
> On Mon, Aug 15, 2011 at 06:57:21PM +0300, Felipe Balbi wrote:
> > The driver is usable and we have tested many transfers
> > with g_zero and mass storage. Nevertheless, it's not
> > finished and we'd like more time to test it before
> > accepting it in mainline. Still, we think it's good
> > to show to the community the design decisions we have
> > made on the way and we'd like to hear from the rest of
> > the community any comments/criticisms wrt this driver.
>=20
> Why wait?  I have no problems taking drivers that are barely working, or
> not quite there, if it makes development and testing by others easier.

That's very good to hear. So, I can send you a pull request by friday if
you like ;-) Will add a patch on MAINTAINERS too so people have a
contact point.

--=20
balbi

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOSWhcAAoJEAv8Txj19kN1vcMH/jHC+JLMR7yg1Kg6kml9BXX5
tCHMB5g9YaG+Do0TMONLW9Ab7b1sM6JMIo/3iJhqNL38cDRYWKSquLixLlZWfpiL
8M1nyh7xhjHq0/XJ9wVXV27F5u7efCcoHTAgk9Ijns1jb8mQ1SeYRwC4TiiaX1k0
6WZ74FEFtn4xfMCD6hJNylKmQJFCyzAeq098Z/cwWqjNDmnLJH9/AcgROoEHZ3h4
ZOFp/jrs6o3YQ0VNYji7qpSw1rgSeJdRO46NzrDTHBFytuojspqY12AKzwB/zgCM
RtKDvSdXyo685met2pJPYf3fg4yiV14fbx+fVaknI5NVx+bZaCRGgbTbIIl+Its=
=qNsu
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
