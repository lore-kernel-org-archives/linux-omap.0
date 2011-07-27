From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Wed, 27 Jul 2011 14:30:08 +0300
Message-ID: <20110727113006.GJ5134@legolas.emea.dhcp.ti.com>
References: <1311138718-5072-1-git-send-email-vikram.pandita@ti.com>
 <CABb+yY3E69J6vbHNP92k-b6ScFMcU2LY71rqEZMY_9+E+vx=fA@mail.gmail.com>
 <CAFm5wm3zZyMgScH6OqmVVW32mLUJ6OGcmDy+Wz9Gc7EBjsswJQ@mail.gmail.com>
 <CABb+yY0QsO-rh6Q9nffmPp=4sYi=6Csor1VPdhLvAXd5LJVeRg@mail.gmail.com>
 <CAFm5wm2ng-fs0OgUG+h1JaF3_LBp93fHw2Vap2oD_j7Ok0NNnw@mail.gmail.com>
 <20110726150655.GK32582@legolas.emea.dhcp.ti.com>
 <CABb+yY30bYN=c+oAdt1-bufLq2g2RtgCUefDzNTfW33Wu-wE1g@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFUYW7mPOLJ+Jd2A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:52267 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752848Ab1G0LaL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jul 2011 07:30:11 -0400
Content-Disposition: inline
In-Reply-To: <CABb+yY30bYN=c+oAdt1-bufLq2g2RtgCUefDzNTfW33Wu-wE1g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: balbi@ti.com, "Pandita, Vikram" <vikram.pandita@ti.com>, Anand Gadiyar <gadiyar@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Moiz Sonasath <m-sonasath@ti.com>


--bFUYW7mPOLJ+Jd2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 27, 2011 at 09:20:02AM +0530, Jassi Brar wrote:
> On Tue, Jul 26, 2011 at 8:36 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Wed, Jul 20, 2011 at 09:48:53AM -0700, Pandita, Vikram wrote:
> >> > This *today happens to be only UMS* is my exact point here.
> >> > Can you guarantee no other function driver will ever expect only
> >> > full packet xfers and treat short as errors ?
> >> >
> >>
> >> We are trying to test if short_not_ok may not be needed at all. But
> >> all gadgets need to be tested on MUSB for that.
> >> We will need wider help from MUSB maintainer/author(anand g) to
> >> determine if removing short_not_ok is fine on MUSB for _all_ gadgets.
> >>
> >> To be safe we only enable for UMS use case today that is definitely
> >> working fine.
> >>
> >> Time for Maintainer/author to pitch in !!
> >
> > I'm thinking on allowing this patch to go in if nobody has really strong
> > arguments against it. The real fix, though, would need a bigger re-write
> > of the endpoint IRQ handling and that would need more time to write and
> > stabilize. Together with the huge amount of HW issues MUSB has, it's
> > quite a task (been there, done that).
>=20
> Please note that I never objected to the _code_.
>=20
> I just think if the _comments_ could be made UMS agnostic... for ex if it=
 works
> for other protocols just fine(quite possible) in future the reader
> might wonder what
> is UMS specific about the code snippet.

for sure, makes sense to me. Vikram, do you want to update the comment
to remove UMS mentions ? Most likely UASP will have the same deal, btw.

--=20
balbi

--bFUYW7mPOLJ+Jd2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOL/a+AAoJEAv8Txj19kN1RKIH/3Iu+eelP11TVQloQkCtaAZ6
Vx9gFSiYNCuLm6flhpv76VzeRbpJcIOaCkES3SO/WFibaduOEPqbzjURf37ictvW
OZPGDbZdTPsgZkULxDOSj+ZnTyexnw61bBr2YK54RSEsBz5J7MHS2gwNPrBeIFED
AXohtO8CSVKSS6KnL0/ksXoamjkCGgRvlXZ0VnfpDsDI/79LPWZ5UuUx0vaNdQSk
Xyq5kSXhe3w/tpefYaIsb3kjjFa9eKFtCLG90TOGXMloOKljmIjWi8X/0JLNdbqC
lUDckOXC2/rawdotU3AXHYD+Nkj6dD4yZhMdcE3QPPjWlm4LBiW+2zzcPwiISfo=
=SBxI
-----END PGP SIGNATURE-----

--bFUYW7mPOLJ+Jd2A--
