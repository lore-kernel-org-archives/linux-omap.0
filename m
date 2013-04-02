From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 02/11] USB: dwc3: Adjust runtime pm to allow
 autosuspend
Date: Tue, 2 Apr 2013 11:29:52 +0300
Message-ID: <20130402082952.GG30286@arwen.pp.htv.fi>
References: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
 <1364824448-14732-3-git-send-email-gautam.vivek@samsung.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1364824448-14732-3-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>
Cc: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, rob.herring@calxeda.com, kgene.kim@samsung.com, kishon@ti.com, dianders@chromium.org, t.figa@samsung.com, p.paneri@samsung.com
List-Id: linux-omap@vger.kernel.org

--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2013 at 07:24:01PM +0530, Vivek Gautam wrote:
> The current code in the dwc3 probe effectively disables runtime pm
> from ever working because it calls a get() that was never put() until
> device removal.  Change the runtime pm code to match the standard
> formula and allow runtime pm to function.
>=20
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> CC: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/usb/dwc3/core.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index e2325ad..3a6993c 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -491,6 +491,11 @@ static int dwc3_probe(struct platform_device *pdev)
> =20
>  	dwc->needs_fifo_resize =3D of_property_read_bool(node, "tx-fifo-resize"=
);
> =20
> +	/* Setting device state as 'suspended' initially,

wrong comment style.

> +	 * to make sure we know device state prior to
> +	 * pm_runtime_enable
> +	 */
> +	pm_runtime_set_suspended(dev);

didn't Alan mention this should be done at the Bus level ? In that case,
shouldn't you have call pm_runtime_set_active/suspended() based on
DT's status=3Dokay or status=3Ddisabled ? Or something similar ?

--=20
balbi

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRWpcAAAoJEIaOsuA1yqRE7w8P/0tYBYCbwk6MH2R8R8r27NyU
FJEcTw0DIhca4LZgXE/iVUtHiov+BufaelYt5GMLEkdTFR+0NGz7WPpGtEZdnscH
tFIFlPa+RVED5ug+8emP4i4DQeuuSNChzojGX2+RgkWtbgSB1T5o+Zr+v5g9Q550
2dyESBkcDjI/pArcZMjgXZCaAb/tdRJ9Dv8dzv0Da4+lQWKTb20HRRbB80OhKfnc
EoAywUiMNIbhuEn08C41rnNz7WcYqAQ6IbImiRzc7rfqK7Lhu2lzi38gpCrTRJMR
35q5v4OxRt+3inTAGIdH+d4Sq/HwoX2DVRUTjQ1Pp9V/KeOtTrbtMGDwPvJHnu6h
zOYSZaoNTTCYzJKHrvS7+BnFZxCTe1ogJnbUeF/wlnHm6txRTC4koSS+jTb338Ys
IhjAYxHMFYNxOzZgXfGv5xrbJyYwCxPhuOqQ8LY77vPA2Ri64+QUHW+1BURWYACb
AFBrUBhX++Y3OqrUScZbMwXSzWN0pvHQsMgwe+PhDBEgTvUPtrmm6SXgkcDbP3ni
W0UpylczpwOI5P3osDlwyvm+COY3wyJeomcESgp6FfpLXAG78JHv27HtSVOQilgf
pYsUSSlaClr0X6Ghv3giuatx0+i/hTJgiHPafFlJuTTYUcXfD0i3pNligWc/4z6U
THmn6TxkxNY4nWbzyNeQ
=vauX
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
