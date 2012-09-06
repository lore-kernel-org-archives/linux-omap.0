From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] musb: Kill __init from function that are called at other
 times as well.
Date: Thu, 6 Sep 2012 16:04:27 +0300
Message-ID: <20120906130425.GF29202@arwen.pp.htv.fi>
References: <1346940106-20269-1-git-send-email-panto@antoniou-consulting.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:44280 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753974Ab2IFNIv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 09:08:51 -0400
Received: by lagy9 with SMTP id y9so1075880lag.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 06:08:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346940106-20269-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2012 at 05:01:46PM +0300, Pantelis Antoniou wrote:
> Marking functions as __init or __devinit and calling them at other times
> leads to predictable crashes (if you're lucky).
>=20
> Remove them for now.
>=20
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> ---
>  drivers/usb/musb/musb_core.c    | 16 ++++++++--------
>  drivers/usb/musb/musb_debugfs.c |  2 +-
>  drivers/usb/musb/musb_dma.h     |  2 +-
>  drivers/usb/musb/musb_gadget.c  |  6 +++---
>  drivers/usb/musb/musbhsdma.c    |  2 +-
>  drivers/usb/musb/omap2430.c     |  2 +-
>  6 files changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 26f1bef..215d2d5 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1160,7 +1160,7 @@ static struct musb_fifo_cfg __devinitdata mode_5_cf=
g[] =3D {
>   *
>   * returns negative errno or offset for next fifo.
>   */
> -static int __devinit
> +static int
>  fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
>  		const struct musb_fifo_cfg *cfg, u16 offset)

Are you sure all these functions are called from outside .init.text ? At
least fifo_setup(), ep_config_from_table() and musb_core_init() are only
during probe(), which sits in .init.text too.

--=20
balbi

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSJ9ZAAoJEIaOsuA1yqREmRkQAI5rvvGeo689IkhrMZsl6rr3
98oldkP2UEKrJ6UIzZZr7kr5b3GHOPbWJnv3NQ1aDEA+5DBndaTwGGPZBwQsg8xo
6V/1z7Qpj5nySxwpth816pd6/DPTPI/QWXrokEcWVsZS4aB6MDiNeP23EfJ+PUOo
A3F7RnLP/8ABLRvATsRotz26meqz2k8x5ukoR1YWkfRQDOwMkA4UtSwqWJf731Pz
+Ph+sJVk8Bc9YHsvMSzTHpzUDB2F9UHy35J/IdXyiPvpuWqeXFZzdJFkejnr7sKo
5DesXfx3uIxlKG+M5KNUXep+t1unmUe26ICxiWLJo4mAq9wZZpWPfG3IwGo2b/eq
hmzvdNv8otvgyfoSpaA7QLgvt4jixtKuy5RdOG1xCZsZKL/nQBhH3JfU7oUtFd+U
NkrD9udsH/g38m2K3rIklaGic+8J+tiNuPjE+ExHeTUEhmq8g4lQBAsFl1hfrrpT
WnHdWQpirWLuaK1+Q2jvDIixoZ77QU0rtB4KL/v8lYQjDMLAFmumjIBdsLcpKAjn
o+YxL3yxpSo+NGXN6KpOJEwnAgLw1ZLBXZIFBpIv70gYhiUgtpasH+xJG0UczIRp
wPs+odPipEILnM/IuGSso8dRMgSdl52ql/522BfxCYN4nF3foS0YqfNFb/lN4Cad
sCZ/F5UA3No8mIEYXN2I
=LBOj
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--
