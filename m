From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 0/5] Add support for Fujitsu USB host controller
Date: Tue, 10 Mar 2015 16:30:23 -0500
Message-ID: <20150310213023.GL25666@saruman.tx.rr.com>
References: <1424579140-30567-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VBq/nvTu32OVLBUP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424579140-30567-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sneeker Yeh <sneeker.yeh@gmail.com>, Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@intel.com>, Grant Likely <grant.likely@linaro.org>, Huang Rui <ray.huang@amd.com>, Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
List-Id: linux-omap@vger.kernel.org

--VBq/nvTu32OVLBUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2015 at 12:25:35PM +0800, Sneeker Yeh wrote:
> These patches add support for XHCI compliant Host controller found
> on Fujitsu Socs, and are based on http://lwn.net/Articles/629162/
> The first patch is to add Fujitsu glue layer of Synopsis DesignWare USB3 =
driver
> and last four patch is about quirk implementation of errata in Synopsis
> DesignWare USB3 IP.
>=20
> Patch 1 introduces a quirk with device disconnection management necessary
> Synopsys Designware USB3 IP with versions < 3.00a and hardware configurat=
ion
> DWC_USB3_SUSPEND_ON_DISCONNECT_EN=3D1. It solves a problem where without =
the
> quirk, that host controller will die after a usb device is disconnected f=
rom
> port of root hub.
>=20
> Patch 2 is to set Synopsis quirk in xhci platform driver based on xhci pl=
atform
> data.
>=20
> Patch 3 is to add a revison number 2.90a and 3.00a of Synopsis DesignWare=
 USB3
> IP core driver.
>=20
> Patch 4 introduces using a quirk based on a errata of Synopsis
> DesignWare USB3 IP which is versions < 3.00a and has hardware configurati=
on
> DWC_USB3_SUSPEND_ON_DISCONNECT_EN=3D1, which cannot be read from software=
=2E As a
> result this quirk has to be enabled via platform data or device tree.
>=20
> Patch 5 introduces Fujitsu Specific Glue layer in Synopsis DesignWare USB=
3 IP
> driver.=20
>=20
> Successfully tested on Fujitsu mb86s7x board.
>=20
> Changes since v4 (RFC):
> [https://lkml.org/lkml/2015/2/17/13]
>  - based on Felipe's comment, rename dwc3-mb86s70.c to dwc3-fujitsu.c whi=
ch is
>    more generic.
>  - based on Mathias's comment, remove unhelpful comment, and change the
>    function name of xhci_try_to_clear_csc() to xhci_late_csc_clear_quirk()
>    which is more appropriate. =20
>=20
> Changes since v3 (RFC):
> [https://lkml.org/lkml/2015/1/25/8]
>  - based on Mathias's comment, fix bug and using xhci_port_state_to_neutr=
al()
>    helper function to mask out some RW1C bits, prevent writing back all t=
he
>    bits read from the PORTSC register.
>=20
> Changes since v2 (RFC):
> [https://lkml.org/lkml/2015/1/19/55]
>  - based on Felipe's comment, re-order patches to avoid breaking bisectab=
ility,
>  - based on Felipe's comment, add comment to structure's member, and sort=
 it
>    alphabetically,
>  - based on Felipe's comment, add another v2.90 revision number in dwc3 I=
P.
>=20
> Changes since v1 (RFC):
> [https://lkml.org/lkml/2014/12/15/929]
>  - based on Arnd's comment, remove entire unnecessary Fujitsu EHCI/OHCI g=
lue,
>  - based on Felipe's comment, fix mis-using of runtime-pm API and setting=
 dma
>    mask, remove unnecessary comment, and refactor suspend/resume handler =
in
>    Fujitsu Specific Glue layer in dwc3,
>  - based on Felipe's comment, add more commit log and comments in Synopsis
>    quirk implementation, and separate it into four patches.
>=20
> Sneeker Yeh (5):
>   xhci: add a quirk for device disconnection errata for Synopsis
>     Designware USB3     core
>   xhci: Platform: Set Synopsis device disconnection quirk based on
>     platform data
>   usb: dwc3: add revision number DWC3_REVISION_290A and
>     DWC3_REVISION_300A
>   usb: dwc3: Add quirk for Synopsis device disconnection errata
>   usb: dwc3: add Fujitsu Specific Glue layer

Mathias, if you want me to take this series I need your Acked-by,
otherwise I can give you mine, just let me know.

--=20
balbi

--VBq/nvTu32OVLBUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/2JvAAoJEIaOsuA1yqREz7EP/3i6fPsRaZg7bwOxL0fDUOGD
JxaZyvQ95ya7eFtY6OQx9KvQGgtOkB5zqkuB/az1kl29DfjUW/pkMy65xAFW4Klk
5hAuhCdPzRzZ3op//zbz7JEfpaDVwunS0QHTZC+iDirzqFGIMCC7loNxiI1PRhUW
W0rfjxoK6sTL3nof+iqBcMU0CmXL01ZsFzljXzP1KNP+FlJSODJuiWcHIgbsUuRS
yn//2ZZZW57HbTsrubochEzX4ttkUZ0qTfDwfMROCsERJbL4Q3Jlaei7p0h+L6Y2
O4+OZ05UgKdmdMDxcmWeqPUlDnqH07ibYnolJBnbQUSkE3EDwkd3QUd0EYQXWJ5S
dlRJ1q6zavh7V4ZweLMDsexKN1kYssd+jG+GtAJPI2OQNQatJPWyJxYZIxvwujYi
pIPsFSsXBMt0pdgUwgEbbpDoiXazY4VwUHmMNDjWwLC9methJ8UfdOGhX0kSlWx/
jNfD1gD4dsfBNL5tTQ7JWP0JJ2MDZahk15QAX1E1MkXhLi/pzhL1aDRmHX+OKaLS
6b1vhmCtX5QWPkqr/FC0Bl9lgMBLRNYtr0os7O2f8p7G5GDlAGaLa8SAgewegtxn
r9IeJWyV2bgcEVuOh2XT2/hnRz24cHU9rxyJxY0j4kFytvV8Lt36c2o8hzHdEUTS
7+teQ2ZiDF4ktf/suSZS
=Qcow
-----END PGP SIGNATURE-----

--VBq/nvTu32OVLBUP--
