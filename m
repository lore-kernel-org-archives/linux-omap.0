From: Felipe Balbi <balbi@ti.com>
Subject: Re: back-door musb USB host support
Date: Mon, 6 Jun 2011 12:30:08 +0300
Message-ID: <20110606093007.GJ18731@legolas.emea.dhcp.ti.com>
References: <1303869133-27976-1-git-send-email-green@linuxhacker.ru>
 <1303869133-27976-3-git-send-email-green@linuxhacker.ru>
 <4DB7D89D.7090707@compulab.co.il>
 <1A637068-3F89-4B73-8A36-5278EB69C8CD@linuxhacker.ru>
 <4DB905CC.7030907@compulab.co.il>
 <5E4912CA-9E7A-423B-A8FA-DF16C0A4D242@linuxhacker.ru>
 <20110429092139.GB2529@legolas.emea.dhcp.ti.com>
 <AA3DA96D-E0E1-4620-8998-88FAB2D7BD7D@linuxhacker.ru>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fU0UwhtRbpo05rnG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:54690 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754126Ab1FFJaM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 05:30:12 -0400
Received: by mail-bw0-f52.google.com with SMTP id 24so3277569bwj.25
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 02:30:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AA3DA96D-E0E1-4620-8998-88FAB2D7BD7D@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: balbi@ti.com, linux-omap@vger.kernel.org


--fU0UwhtRbpo05rnG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 05, 2011 at 04:05:55PM -0400, Oleg Drokin wrote:
> On Apr 29, 2011, at 5:21 AM, Felipe Balbi wrote:
> >> On Apr 28, 2011, at 2:14 AM, Mike Rapoport wrote:
> >>>>>> +static struct omap_musb_board_data musb_board_data =3D {
> >>>>>> +	.interface_type		=3D MUSB_INTERFACE_ULPI,
> >>>>>> +#ifdef CONFIG_USB_MUSB_OTG
> >>>>>> +	.mode			=3D MUSB_OTG,
> >>>>>> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> >>>>>> +	.mode			=3D MUSB_HOST,
> >>>>>> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> >>>>>> +	.mode			=3D MUSB_PERIPHERAL,
> >>>>>> +#endif
> >>>>> This kind of ifdefery is handled inside the musb driver. I'd set th=
e mode to
> >>>>> MUSB_OTG unless you want to explicitly limit it to HOST or PERIPHER=
AL
> >>>> Actually it's not.
> >>>> If I set MUSB_OTG here and then I choose PERIPHERAL mode in the kern=
el config,
> >>>> the musb transceiver code will complain about board file and kernel =
config mismatch.
> >>>> The Nook Color is advertised as peripheral device, but OTG must be w=
orking too
> >>>> (not totally working at this point) I think there is value to be abl=
e to configure it
> >>>> in two different modes.
> >>> Frankly, I haven't tried choosing different modes in the kernel confi=
g and in
> >>> the board data. Still, I believe that board data should define desire=
d operation
> >>> mode and the driver should do the best effort to enable the controlle=
r in the
> >>> desired mode.
> >> The desired operation mode is dependent on musb configuration.
> >> E.g. see n8x0 board file for the example of the same thing.
> > Only development platforms should have that ifdef trickery. The idea of
> > that field is to tell the driver how the board is wired.
> > Host/Peripheral/OTG support is hardwired by the circuitry around the
> > USB receptacle you have on your board.
>=20
> I am raising this again, I guess.
> So what is the plan with boards that are not advertised as having USB
> host support, but it's still possible to enable it with some trickery?
> Say on the Nook Color it's possible and I recently managed to do it,
> but it seems current drivers/usb/otg/twl4030-usb.c does not have any
> code to enable vbus (well, easy to overcome with a patch, I guess).
> Additional hacks are likely needed since ID pin is not connected in
> the usb receptacle, so no way to have real OTG, manual switch via
> sysfs is needed.
>=20
> Additionally a particularly popular request from user community seems
> to be to allow external source to drive vbus (and perhaps allow
> battery charging at the same time), I am not exactly sure how that
> would fit into the current driver picture.
>=20
> Any ideas on how it would be best to start tackling this for eventual
> inclusion into mainline?

Before we can add this trickery, we need to fix what's already in
mainline. To be fair and straight, although it's kinda fun to allow any
board to become USB Host by modifying cables and the like, we shouldn't
be focusing on that.

Before even thinking about such things, we need to see the problems we
have today and one of them is that we don't have a real PHY layer,
another is that MUSB driver is still quite buggy in several situations,
specially for host mode. There's still some coupling between the glue
layer and the core IP driver, which shouldn't exist.

In short, no I will not take patches adding hacker-only features until
the whole thing is in good shape and passes USB Certification without
add on hacks done by product manufacturers. Let's first have a
Certifiable USB Stack with a certifiable MUSB driver, then we play with
hacker-only features.

--=20
balbi

--fU0UwhtRbpo05rnG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN7J4fAAoJEAv8Txj19kN1Pf4H/RzlKXPB71NAAmrKKiYo/Dmw
8NxRbIfMpYDgvVh+K1Mr+hUNG+MCf2GcWWyAfG/yTW3qRtCdZtuvJiyU0wia/j2x
s96lfOHhN7+izXZIpkWJf/XJD5/LwbCz2+o6jE67+XuKv9NDHaN5Rr9Mdyld8Ejs
rTakKHHKUme65/i6iKOYW+48J7MV2XOKmqidszcYjDn1PPxv1F1nuAOCxvAahvtn
c4cMWOkJpSDysdci8UkyjmbNs+Te/SIOS2Dc2467fdNif4X8oixL94o4IhJP8kPb
JScfmn9XNdSPt/duye+oldDb9lQ4p21+xzoMuIH0jg1jbZ9tcEs9i+4SvrAjpYw=
=W++W
-----END PGP SIGNATURE-----

--fU0UwhtRbpo05rnG--
