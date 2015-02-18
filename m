From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/5] xhci: add a quirk for device disconnection errata
 for Synopsis Designware USB3 core
Date: Wed, 18 Feb 2015 08:33:45 -0600
Message-ID: <20150218143345.GC3651@saruman.tx.rr.com>
References: <1424151697-2084-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <1424151697-2084-2-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <54E451B1.8020401@intel.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54E451B1.8020401@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Sneeker Yeh <sneeker.yeh@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Huang Rui <ray.huang@amd.com>, Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
List-Id: linux-omap@vger.kernel.org

--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2015 at 10:47:45AM +0200, Mathias Nyman wrote:
> Hi
>=20
> This looks correct, but if you are still going to make a new series fixing
> Felipe's comments then the following tiny nitpicks could be fixed as well=
=2E=20
>=20
> Otherwise
>=20
> Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>=20
> Felipe, Do you want to take this series through your tree?

I can, no issues :-)

> On 17.02.2015 07:41, Sneeker Yeh wrote:
> > =20
> > +static void xhci_try_to_clear_csc(struct usb_hcd *hcd, int dev_port_nu=
m)
>=20
> Either add a function description explaining something like "Late
> clearing of connect status.
> Some quirky hardware will suspend the controller when CSC bit is
> cleared and leave URBs unhandled"
>=20
> Or change the function name to something like
> xhci_late_csc_clear_quirk() or xhci_deferred_csc_clear_quirk()

I have a feeling xhci_late_csc_clear_quirk() is a better name, much more
descriptive than xhci_try_to_clear_csc() :-)

--=20
balbi

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5KLJAAoJEIaOsuA1yqREMCAQAJcicnvUIPUlW6TI5GAR4gge
oWZik9LxPy03BdIEjsQv2bip7a90IZ+7oHERuGq+/+Ef5Nje8krjYsSGEIKoyzNc
qNR0ZeVCEu8Uxahg2IdkS68H1IB61yzBzpHFkCY4CEV1oixqie80QA7F4Spm8jQh
Cr1KaQK8SsQmxahAfraeQIsUmRjxMR3ZhctHobi2Q9lG54GIssqIsJsswmcoRd6w
XXyz0MPLPrmKq6+6U/N5Rb56QYAbh6AATPwn0YK8NZAGxLQM2qF7Q+PYxrH8KEsX
w5zZwGmV6eblOVmcU940OfOUBdC2GJ/ZET0InE1tdlES1NiJ6dPO/MYG7tME1yH2
5MYPugs43iC+4aQx8P3QWEIX4/cexU7gLNCehMAkm0NeGIeoub/T8mSN9R8pMO6H
WjAQxsfVVT+uZojy5MoE8TDsx49aT9HHPxj/ClTpny0/Y/uHegjRNDcjxBCQ8Ggb
tq3efMo5EHShcD0II7Mc7RQCs89OqJm5GLUQ4goUEoDgs7W/RVROAB2QGO0o4S71
TII8CJ+Rt1EttC1gPMIgRRu/KR7hzVjOGu33MQmNPtBaNmcQVQiTACQFr8euZOli
8E3sFlL5njfjotEuOb0jgxM43vt1jDTwfXVwS7huVrvWz8kVIXVE9aLkXDFmkonu
XtAZjRiltBBwPrsLf/rf
=708I
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
