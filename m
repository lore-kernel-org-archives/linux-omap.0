From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND v2 1/1] usb: musb: implement (un)map_urb_for_dma
 hooks
Date: Wed, 27 Mar 2013 15:17:11 +0200
Message-ID: <20130327131711.GG4626@arwen.pp.htv.fi>
References: <1363284729-24228-1-git-send-email-ruslan.bilovol@ti.com>
 <1363284729-24228-2-git-send-email-ruslan.bilovol@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RwGu8mu1E+uYXPWP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49692 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab3C0NRP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 09:17:15 -0400
Content-Disposition: inline
In-Reply-To: <1363284729-24228-2-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--RwGu8mu1E+uYXPWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 14, 2013 at 08:12:09PM +0200, Ruslan Bilovol wrote:
> MUSB controller cannot work in DMA mode with misaligned buffers,
> switching in PIO mode.
>=20
> HCD core has hooks that allow to override the default DMA
> mapping and unmapping routines for host controllers that have
> special DMA requirements, such as alignment contraints.
>=20
> It is observed that work in PIO mode is slow and it's better
> to align buffers properly before passing them to MUSB
>=20
> This increased throughput 80->120 MBits/s over musb@omap4 with
> USB Gigabit ethernet adapter attached.
>=20
> Some ideas taken from ehci-tegra.c
>=20
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> ---
>  drivers/usb/musb/musb_core.c |   14 ++++++
>  drivers/usb/musb/musb_host.c |  102 ++++++++++++++++++++++++++++++++++++=
+++++-
>  drivers/usb/musb/musb_host.h |    2 +-
>  3 files changed, 116 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 60b41cc..91ac166 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1431,6 +1431,20 @@ static int musb_core_init(u16 musb_type, struct mu=
sb *musb)
> =20
>  	/* log release info */
>  	musb->hwvers =3D musb_read_hwvers(mbase);
> +
> +#ifndef CONFIG_MUSB_PIO_ONLY
> +	/*
> +	 * The DMA engine in RTL1.8 and above cannot handle
> +	 * DMA addresses that are not aligned to a 4 byte boundary.
> +	 * For such engine implemented (un)map_urb_for_dma hooks.
> +	 * Do not use these hooks for RTL<1.8
> +	 */
> +	if (musb->hwvers < MUSB_HWVERS_1800) {

if you move this check to map/unmap and always return error if this is
true, you can avoid removing 'const' from our struct hc_driver. Would
that work ?

--=20
balbi

--RwGu8mu1E+uYXPWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUvFXAAoJEIaOsuA1yqRE0j0P/3PMaRIJL3OLFdwFt5pk120j
xxPhTPBc37zPNvCfRpTz8Zjh1lwdcmDpL5nqnECAxF1Rew0w5VOOUr7wy2vxRXl+
NtkCu5Hv34ehXcViMnzVYQo2Xjm6pqmP8kLHhNhKo0EwCw6/TLHpLB/xQcF/vNnA
JgVj+Tr6dSqEoDGtT5K4jyexFiPJD01KUyNsDY1ZBUSwyPSKSRDaCN5W/S6WGfTH
PqxaLlQqr8dFqrizsmrIwhd77bBTcy9gVWwwfLgTp5xGWnD6gwxzxH0rLEIAT8KC
6XAst6Q6yoXlwjPedI7m58ttk0dWxsdRkPneQH4cG9ApqzBQyOhaZT4UJdYlxBZ9
Uvwa9PyHL/04SfRx711G+qLIc/jKY0e2pOyFD5uIc1up4m7rigmet+6UzIvmhNHu
Ex5HHFVar3cSd6TUmZCuME7vSwi/Mkmb/cPN8IY/MDaO+ko52W9K0Ma1BhS6jTws
k3Og/awztIq4ZjoKiC/JX+nMswvYGTv1T3PwAD2Mygglq7O0wb0TMO6+a5D3hDs+
7X9iWx8Db+tvDTGt6YtIsB4xYElmgkXPadmXXJDdi2Gd8PLU2qcVaUOoGzvvjd7H
1+CgFJlsBryPFjbd0w/nyKYCX45VP640yZZLBUUpRD7lkXkqX5Oq3NF/KwPtwrH1
R0E0V00uMBUxd+WXW2lo
=XcKq
-----END PGP SIGNATURE-----

--RwGu8mu1E+uYXPWP--
