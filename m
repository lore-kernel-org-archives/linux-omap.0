From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND v2 1/1] usb: musb: implement (un)map_urb_for_dma
 hooks
Date: Thu, 28 Mar 2013 15:57:06 +0200
Message-ID: <20130328135706.GF16298@arwen.pp.htv.fi>
References: <1363284729-24228-1-git-send-email-ruslan.bilovol@ti.com>
 <1363284729-24228-2-git-send-email-ruslan.bilovol@ti.com>
 <20130327131711.GG4626@arwen.pp.htv.fi>
 <CAB=otbS2C3pmLhuOOHau4=_7G0VBp-Y-aDi3YOpHkq+=YR+x_Q@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33767 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733Ab3C1N5L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 09:57:11 -0400
Content-Disposition: inline
In-Reply-To: <CAB=otbS2C3pmLhuOOHau4=_7G0VBp-Y-aDi3YOpHkq+=YR+x_Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2013 at 03:44:50PM +0200, Ruslan Bilovol wrote:
> Hi Felipe,
>=20
> On Wed, Mar 27, 2013 at 3:17 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Thu, Mar 14, 2013 at 08:12:09PM +0200, Ruslan Bilovol wrote:
> >> MUSB controller cannot work in DMA mode with misaligned buffers,
> >> switching in PIO mode.
> >>
> >> HCD core has hooks that allow to override the default DMA
> >> mapping and unmapping routines for host controllers that have
> >> special DMA requirements, such as alignment contraints.
> >>
> >> It is observed that work in PIO mode is slow and it's better
> >> to align buffers properly before passing them to MUSB
> >>
> >> This increased throughput 80->120 MBits/s over musb@omap4 with
> >> USB Gigabit ethernet adapter attached.
> >>
> >> Some ideas taken from ehci-tegra.c
> >>
> >> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> >> ---
> >>  drivers/usb/musb/musb_core.c |   14 ++++++
> >>  drivers/usb/musb/musb_host.c |  102 +++++++++++++++++++++++++++++++++=
++++++++-
> >>  drivers/usb/musb/musb_host.h |    2 +-
> >>  3 files changed, 116 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core=
=2Ec
> >> index 60b41cc..91ac166 100644
> >> --- a/drivers/usb/musb/musb_core.c
> >> +++ b/drivers/usb/musb/musb_core.c
> >> @@ -1431,6 +1431,20 @@ static int musb_core_init(u16 musb_type, struct=
 musb *musb)
> >>
> >>       /* log release info */
> >>       musb->hwvers =3D musb_read_hwvers(mbase);
> >> +
> >> +#ifndef CONFIG_MUSB_PIO_ONLY
> >> +     /*
> >> +      * The DMA engine in RTL1.8 and above cannot handle
> >> +      * DMA addresses that are not aligned to a 4 byte boundary.
> >> +      * For such engine implemented (un)map_urb_for_dma hooks.
> >> +      * Do not use these hooks for RTL<1.8
> >> +      */
> >> +     if (musb->hwvers < MUSB_HWVERS_1800) {
> >
> > if you move this check to map/unmap and always return error if this is
> > true, you can avoid removing 'const' from our struct hc_driver. Would
> > that work ?
>=20
> If we return an error in map/unmap callbacks, this will break urb transfe=
rring,
> however I can call core function usb_hcd_(un)map_urb_for_dma() instead of
> returning the error (and that is default behavior if we do not have
> map/unmap callbacks
> set for the hc driver) so I can avoid removing 'const' from our struct
> hc_driver and this will work.
> The side effect will be only in small overhead for this path.
>=20
> So, will be this OK for you? I will send v3 in this case.

should be alright. Thanks

--=20
balbi

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRVEwyAAoJEIaOsuA1yqRECW0P/ih6YLoNsLXoflZYf4tPrAEQ
5Nf6t9Tt2HNGCqf1pYsa4EywYCcdX1xVc9ltGkQ5sDoGbL3yWOjeKSY708kmf/XT
jMnkU9GnDaIo2Da0tFlMAu2UfrDMKagsjvSE9xZs1HUITv02RFEgglO3YHJhN/lM
t/zLqP4H463Mj6iSXD/Z/EgoFEPk9/VVb6ZwHXpmKYYO0xOkclioQCrnAcUZU/ln
Pnw5DCnbS5lOf39++RuarjUKW2wlWvyoBMTxfZ40G7H2FbAUivm/jedAy7yk0EmB
xVRJE+qDyOIPDGcRvvQHWsSdrLOVD3Jw5A4wTQbMclXZS3oPJuxmjv4eC9aUdzBz
uCYemA4n5Wz53mOJm5XyTkPymugg9rd0EJaGKq5IIrBigF4YtTX42XARUXPphLUW
ZD8K4EB4MX9xwxpj3Tlqfs5X8wnGi4dIe8rNBrPOg8ZHkFq5w6V/eNk0cQAannm1
yXmp+sbZogMh9wHu+y2XnOv/lFN0lNpGbAnXJIwd470+xa+rOI3qh3zA5b+5ydpJ
GvppBHcz0MpwdmXftAnoWr//aeKdXCC4M+n3avPGnzPUuDqUqn8dQde/PrnhlPbN
1VMMWqI38OyN60Lc60YyaX2ly1/tJgW+uRWUlZ84csovvE/zM5GLd7Er7mrmSnvx
gX6l+NWwd32tIFUUa4yU
=Unjn
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
