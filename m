From: Felipe Balbi <balbi@ti.com>
Subject: Re: Help needed USB hub disconnected at resume
Date: Tue, 4 Mar 2014 17:42:40 -0600
Message-ID: <20140304234240.GB2521@saruman.home>
References: <F690310232FDDF4AB457E8B3EF90DDE0AA85E10B@MARCM-SBS2011.marcmltd.local>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85E1E7@MARCM-SBS2011.marcmltd.local>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85E21F@MARCM-SBS2011.marcmltd.local>
 <53146225.8040403@ti.com>
 <531472B3.1060104@compulab.co.il>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85E7F2@MARCM-SBS2011.marcmltd.local>
 <5315761D.8080103@compulab.co.il>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85FF56@MARCM-SBS2011.marcmltd.local>
 <20140304224427.GA31462@saruman.home>
 <F690310232FDDF4AB457E8B3EF90DDE0AA86001B@MARCM-SBS2011.marcmltd.local>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42035 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbaCDXoS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Mar 2014 18:44:18 -0500
Content-Disposition: inline
In-Reply-To: <F690310232FDDF4AB457E8B3EF90DDE0AA86001B@MARCM-SBS2011.marcmltd.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Murphy <marcmltd@marcm.co.uk>
Cc: "'balbi@ti.com'" <balbi@ti.com>, 'Igor Grinberg' <grinberg@compulab.co.il>, Roger Quadros <rogerq@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2014 at 11:05:58PM +0000, Marc Murphy wrote:
> > -----Original Message-----
> > From: Felipe Balbi [mailto:balbi@ti.com]
> > Sent: 04 March 2014 22:44
> > To: Marc Murphy
> > Cc: 'Igor Grinberg'; Roger Quadros; linux-omap@vger.kernel.org
> > Subject: Re: Help needed USB hub disconnected at resume
> >=20
> > Hi,
> >=20
> > On Tue, Mar 04, 2014 at 10:34:56PM +0000, Marc Murphy wrote:
> > > static __init void tam3517_ehci_init(void) {
> > >     /* Configure GPIO for EHCI port */
> > >     omap_mux_init_gpio(TAM3517_EHCI_RESET, OMAP_PIN_OUTPUT);
> > >
> > >     gpio_request(TAM3517_EHCI_RESET, "USB_RESET");
> > >     gpio_direction_output(TAM3517_EHCI_RESET, 1);
> > >     gpio_export(TAM3517_EHCI_RESET, 0);
> >=20
> > why are you exporting this gpio ?
>=20
>=20
> It makes no difference whether I configure the GPIO or not.

gpio_export() is only to expose the gpio to sysfs. Check if that pin is
active high or active low. Then what you need, most likely, is something
like below:

gpio_direction_output(RESET, HIGH);
usleep_range(50000, 2000000);
gpio_set_value(RESET, LOW);

(assuming active high here)

--=20
balbi

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTFmTwAAoJEIaOsuA1yqRETocP/jdORO+xnCKo0IsIA11OV721
GmABJXuoc/rpXblUNnpMFTwNxHUOC9gsXknYxRcrzzLa2Erx+iFwlLhSykU8orbm
5WNV1bJtWhFEgjqozN9uGlBy5k/7OvJjwkG8SDdIYi7iBKG1qKzvatkyeH3B/E1G
mPBn7KYGU+XLcNuMAG89fC9E2KhXdgTedEQnmcKt5uBDkXquh4x4fb444Zh44gH6
dhe2pa3MbYYRLF4U1Cj60kNxiQyyVfCMaMcmvHEgJND53orWDwvW9eBKQriwthrP
tTNK5XoWwm+Yoj7Tgsa5IHkYHew2gbvcQG9b7ariNnKNTOklWXwdwm2eoTHrsksl
/cdBeitANTFp/AckqDgz9HNHlX7MWFdz4RFisWLnONhwTfjW56lXkFnPuN49tQ7+
aRTsJnoMgqW4olvdcAod92riSvmI0j3TH6qhIZGWBgtKnIix2VtYAJRR8Yp4jeEy
k5erpyRUaRelTzti/AK5w8YxrYkl5f8KI5XcNxaCmupoRp9qeSFP0Io/QwGPrK91
rg/xPJOwqXmT5KuDu0MQzrUXq8gwMnj03f2L5PomrrQnFaHJKLe6ovESwzlXHDNu
jkL84vLV4ZWsVMODKJ/OXparWQK2OjwLMrKpwIKxwtw1eVyiOLeAv5UtNtEDmA5j
lyNOrEYAyR9MOB4l2N+r
=k4zB
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
