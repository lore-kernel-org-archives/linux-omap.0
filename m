From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] musb: musb: dsps: determine the number of instances
 at runtime
Date: Tue, 18 Jun 2013 12:52:44 +0300
Message-ID: <20130618095244.GA5461@arwen.pp.htv.fi>
References: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de>
 <1371482014-5244-3-git-send-email-bigeasy@linutronix.de>
 <20130618083108.GH5461@arwen.pp.htv.fi>
 <51C01DCB.3030501@linutronix.de>
 <20130618085409.GO5461@arwen.pp.htv.fi>
 <51C02758.70501@linutronix.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/qNnUp0NPtZJWkzn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43494 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536Ab3FRJyQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jun 2013 05:54:16 -0400
Content-Disposition: inline
In-Reply-To: <51C02758.70501@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

--/qNnUp0NPtZJWkzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2013 at 11:24:40AM +0200, Sebastian Andrzej Siewior wrote:
> On 06/18/2013 10:54 AM, Felipe Balbi wrote:
> > Hi,
>=20
> Hi Felipe,
>=20
> >> This isn't exactly a child node, is it? There is
> >> of_get_child_count() but this isn't a child, it is one property.
> >=20
> > is it because we haven't added DTS support for musb core ?
> > Eventually we can/should add and convert this to
> > of_get_child_count() then. For now, we can go ahead with your
> > approach.
>=20
>  mother {
>   	 child1 {
> 	 };
> 	 child1 {
> 	 };
>  };
>=20
> That would be a child imho.
> For counting of phandles (for the number of assigned gpios for instance)
> you would use
>   of_count_phandle_with_args(node, "gpios", "#gpio-cell-size");
>=20
> We don't have an equivalent for "#gpio-cell-size". In our case it would
> be the sum of "#address-cells" and "#size-cells" minus 1 because we
> don't have a phandle and abuse a function :)
> Counting the number of "addresses" is special since bother its
> members (address and size) can be either 32bit or 64bit in size.
>=20
> > We have such a large amount of function pointers to sort out anyway
> > :-(
>=20
> If you want get the while() loop replaced by something else I have a
> few suggestions:
> - check for iomem(2). If it is there we have two instances. If not,
>   just 1. This includes also the hope that we don't get a third port.
>=20
> - loop over of_address_to_resource(). This is what of_device_alloc() is
>   doing:
>    if (of_can_translate_address(np))
>          while (of_address_to_resource(np, num_reg, &temp_res) =3D=3D 0)
>                     num_reg++;
>   So it is different.

let's keep it as it is, I think once we convert musb-core to dt, all
those issues will vanish and we will be able to use of_get_child_count()
anyway. Forget my noise :-)

--=20
balbi

--/qNnUp0NPtZJWkzn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwC3sAAoJEIaOsuA1yqREG0EP/iuW00+kmpox1F9OPLHBM7Qt
fJcKj//GdMnln8ZhgTLSJxhn+69RTJ9EOCPvHFbcKpv4uCY40Jojp+5/rG7HzmOC
VTibOTd1HnjP7kNs//cDV8Qr771mrZd4P2wAklrmO3kRc9Kup9KfyJS1SGDG6HK4
ajlydGBP9nax50NaSaqBSefjRLRnWl5gmPpIfIQs57VrmYMwxw2fvv6zt0+aq3I7
v2o6xhfo+IXDUsACIzPqlKSw38VkR6KnToXUSX+cJDX77CjU0qk7Qs5VGsd0MTAL
bmlSoXdt6oqIJpuNUft03xEHxLGVzz83jOTbVH6Zy6axGfZ+VZqgil05YLvaBnVW
5FjbATaVCdqx+PubFEiBmrZq0GVPK26iTLq6nWa+ahYwZe57sGWr4FPR3GUqdrBX
xaPgtJf4qcmqQtqqfFKV2UFLyIX/L23ZCLAyNpjzZIaatykNitfS6ZQrezJfsI4O
DlpGB6i+kFdKlWEN1RDA317vdsK9uZCe1/N4dCIsD2s9a/eTpW3MoSlU2tDzalk2
XSv/XMXs9Eut+YcHWpZGG3+8L5gQwmSErsiP+cmV8WvyMS4rbX5bmz93SqcTQES5
gPBdtN1EhYHF7ILEnvV7PjA9fqEkUMpyeOu1ZQP9UI5pXAAULtoIE9a04vRdss3h
dZM+0HwiLOHfnNpMf5gj
=wD2Z
-----END PGP SIGNATURE-----

--/qNnUp0NPtZJWkzn--
