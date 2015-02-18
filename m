From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/5] xhci: add a quirk for device disconnection errata
 for Synopsis Designware USB3 core
Date: Wed, 18 Feb 2015 08:42:35 -0600
Message-ID: <20150218144235.GF3651@saruman.tx.rr.com>
References: <1424151697-2084-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <1424151697-2084-2-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <54E451B1.8020401@intel.com>
 <20150218143345.GC3651@saruman.tx.rr.com>
 <CAJ1gpc3CT8RBZaXDbFz67mG5RcKOEfoxLjh8PEMq1Cme1QW1Vg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Y7d0dPL928TPQbc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34555 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715AbbBROnQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Feb 2015 09:43:16 -0500
Content-Disposition: inline
In-Reply-To: <CAJ1gpc3CT8RBZaXDbFz67mG5RcKOEfoxLjh8PEMq1Cme1QW1Vg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sneeker Yeh <sneeker.yeh@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Kumar Gala <galak@codeaurora.org>, linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>, Andy Green <andy.green@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>

--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2015 at 10:39:53PM +0800, Sneeker Yeh wrote:
> Hi,
> 2015/2/18 =E4=B8=8B=E5=8D=8810:34 =E6=96=BC "Felipe Balbi" <balbi@ti.com>=
 =E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Wed, Feb 18, 2015 at 10:47:45AM +0200, Mathias Nyman wrote:
> > > Hi
> > >
> > > This looks correct, but if you are still going to make a new series
> fixing
> > > Felipe's comments then the following tiny nitpicks could be fixed as
> well.
> > >
> > > Otherwise
> > >
> > > Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> > >
> > > Felipe, Do you want to take this series through your tree?
> >
> > I can, no issues :-)
> >
> > > On 17.02.2015 07:41, Sneeker Yeh wrote:
> > > >
> > > > +static void xhci_try_to_clear_csc(struct usb_hcd *hcd, int
> dev_port_num)
> > >
> > > Either add a function description explaining something like "Late
> > > clearing of connect status.
> > > Some quirky hardware will suspend the controller when CSC bit is
> > > cleared and leave URBs unhandled"
> > >
> > > Or change the function name to something like
> > > xhci_late_csc_clear_quirk() or xhci_deferred_csc_clear_quirk()
> >
> > I have a feeling xhci_late_csc_clear_quirk() is a better name, much more
> > descriptive than xhci_try_to_clear_csc() :-)
>=20
> Hmm, I'll use this one, ^^
> Thanks for comment it.

alright, either one is fine :-)

--=20
balbi

--1Y7d0dPL928TPQbc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5KTbAAoJEIaOsuA1yqRESYsP/jZqFSnGie39njr3pQ7y3stc
a4LxroQSFPgy3udrL42dU/GSCOA8EzBiI1YMUPcTTCVtTfn1hzCn/iDS8c7k4kjG
qPzZmqpgdvfF0HMpmZCrGy467veicky67hMAp6HGqQrDaz77vQhqy78pEvwGx7+o
gkPcVDybhk0bzlo0TbVnCCecXy+1olN8n63xmfnAv3cdITvINVJV/fpFg0aTHWfu
b2b6lbFNUwVL4qF3yigJMoBNdIBSBMwZe9AK3iVjJGEjyqO+gBhH3XON/VmSP1m7
9ACK6J1Grj2FbKnTIJWwTFc5GpHSmLBMSSgSYBfWtWqObSd13P8xeAKzGA93EfKK
ynbhsC+QJfKjxz5dG5McTEQxxkPrVrm/0IVmMKf+g2O9+jCjCK/9/BxdfRR3mjMO
7s/kk2BMNlm5TZlxgJMX8nvoVdH6PS4VHpISBQGOUIECSRye4OQTmYPKMC+ktsKY
uwTZXg3WuPN11yspBq7coVpaj4V37xZgMNOIKzXXXw9ub6tai9ZSZ7jAvhUjLIdh
2yvvLzLQTuPlWYlidpiEKaIoc4jVaE3tj0EWuexJc0HSNclJ6A7V/mJuwV1ueyGz
GhRO3xyen5zHnlVpH6K0PXPcfCDmLVAYAFNdOlkMDsnZQh5uRClYx7mteQViut+e
h+0bV3UC66Gi0bSjr6pN
=rvaB
-----END PGP SIGNATURE-----

--1Y7d0dPL928TPQbc--
