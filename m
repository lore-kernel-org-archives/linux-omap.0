From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 11/12] mfd: twl4030-irq: Return twl6030_mmc_card_detect
 IRQ for board setup
Date: Fri, 2 Mar 2012 20:15:23 +0200
Message-ID: <20120302181522.GC13967@legolas.emea.dhcp.ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-12-git-send-email-b-cousson@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:56735 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757101Ab2CBSPp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 13:15:45 -0500
Received: by mail-lpp01m010-f49.google.com with SMTP id y4so2935375lag.8
        for <linux-omap@vger.kernel.org>; Fri, 02 Mar 2012 10:15:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1330707024-23730-12-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Rajendra Nayak <rnayak@ti.com>


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 02, 2012 at 05:50:23PM +0100, Benoit Cousson wrote:
> Card detect IRQ from the TWL6030 used to be provided to the MMC
> controller code using a statically allocated IRQ scheme:
>=20
>   card_detect_irq =3D TWL6030_IRQ_BASE + MMCDETECT_INTR_OFFSET;
>=20
> This is no longer valid in a SPARSE_IRQ context since there is no more
> pre-defined TWL6030_IRQ_BASE.
>=20
> Return the proper card detect IRQ value in the twl6030_mmc_card_detect_co=
nfig
> that will be called from the MMC controller.
>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/mfd/twl6030-irq.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> index a1c7183..4a63de2 100644
> --- a/drivers/mfd/twl6030-irq.c
> +++ b/drivers/mfd/twl6030-irq.c
> @@ -308,7 +308,8 @@ int twl6030_mmc_card_detect_config(void)
>  									ret);
>  		return ret;
>  	}
> -	return 0;
> +
> +	return twl6030_irq_base + MMCDETECT_INTR_OFFSET;
>  }
>  EXPORT_SYMBOL(twl6030_mmc_card_detect_config);

At some point this twl6030_mmc_card_detect_config() needs to vanish in
favor of a better mechanism. Maybe passing the GPIO number an requiring
the driver to request the GPIO, set its direction and use it as IRQ
line.

the only problem would arise if we end up hooking the Card Detect pin to
a real IRQ line, but then we can use a flag to differentiate.

--=20
balbi

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPUQ45AAoJEIaOsuA1yqRErsoP/1DOAF2D6aIILrLU6sqPgVSz
iuuia+weWAnT461a8PYaVqcmK7dflXfZvRQZgRp/DT7WMetays56qE2x5BU2Rl1E
OqV3m5f9lnvg4pwCaDGoQZ6U+R8XE870eGQVd8nT7AtGeDFYcNULO7RrwLl2AKaC
Ax15FqGKh6NKDRGSkJgmvwZh9kFFtA+BldtQ7Yq90GGfTSVvQQHUkCdg2FQMj+aa
nbiK09o5Jj9RpM2kV97e/59/jP3of2A394eryY4bpO2kLKcRZpTnpizN1U2pjBz7
D0rFa14w7MdMpTEiIV5YkSMRH3p6xUNq/ZnFAG/oiZ2Qoq1yezpjuNGozIb6/Jrm
cYgiRwWCnPUiT+I7hO31qaeibLvygVcI67gTKnbU7ZjM1dEysv2sIR0q9EJLekWE
xN8lw7FkcKmGKezLLZuu8R7xPb06QTExdlXla5neDhNpfHe+Erx5sHJNzaNoZwJL
FvLLRWtDvHWJW9SAKSO7zg1rV1v2+IyMAXfCmzddXMXQ5BYT4xDme+C17+FyM98f
sl6qUk43X9v/nUG3QC/+sMHpWpUxxn+0usY6N8vWjvwinl2IojzQTn5aevX6wUyV
QeE66GDfXhUUoysYlhJgMJj32WafMyNCBtisZaMyAaSpupLdgNjlOapVmEEPLtNm
v2MIxC7oD2Q7VlrI0HVn
=ru9K
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
