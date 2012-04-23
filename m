From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] arm: omap4: hsmmc: check for null pointer
Date: Mon, 23 Apr 2012 17:43:51 +0300
Message-ID: <20120423144348.GF26302@arwen.pp.htv.fi>
References: <1335192067-3666-1-git-send-email-balajitk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X0vpKvTpCy87tk9a"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:55340 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752090Ab2DWOpG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 10:45:06 -0400
Received: by lbbgh12 with SMTP id gh12so8136274lbb.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 07:45:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1335192067-3666-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--X0vpKvTpCy87tk9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 23, 2012 at 08:11:07PM +0530, Balaji T K wrote:
> +int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
> +{
> +	struct omap2_hsmmc_info *c;
> +
> +	omap_hsmmc_init(controllers);
> +	for (c =3D controllers; c->mmc; c++) {
> +		/* pdev can be null if CONFIG_MMC_OMAP_HS is not set */
> +		if (!c->pdev)
> +			continue;
> +		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
> +	}
> +
> +	return 0;
> +}

why are you even calling this if CONFIG_MMC_OMAP_HS isn't set ? Just
stub it out if you don't have mmc support.

--=20
balbi

--X0vpKvTpCy87tk9a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlWqkAAoJEIaOsuA1yqREkoAP/2f6DGmRNhbp4wqHaUCtdLkP
nLURQoN89fXQ02vy4ckcaU5gLMKeVbtroyHZFcTjcDGhAptdJMe0BHlHRw3TaMvZ
Vul+Hy+j2IeEFjzg01Ky4oTk2NDi0v68fMFHfv4QcrElkQCufGFiJwBU/Nb6DFOj
2gJgwq+YlVGvA217IlgAGWBHD82yc/Z5+7z7keNKVCsPbx7X5Wv+JLfxlK1RtEC0
/l/qjbMUh5RDMnFPYdlZSHe4u8BWXbiISPIm+OO+tmujqJD5BTm8wpZPGzKT17BE
VqbT6c4NN13l0yM/vMjd7rnEzT0OL4N9SRvr83TkiEblCFu14QdMg+zIHKjAVK+d
NvBSHLXviYP2U0pi6wR8SS4TkJvQf6cJ/xdFS6zrKjs4/roXKNoRiQAvTosSEkV+
VaDEZ6F9ephQsN6xpT6lVsdf9GAv+bwCIlzyH/Nr42r6o48HTh1HT4h7RVqc1bL6
8QfDdTZQRHW0nd9+DbMEtbXX7xsV/EPeFrpGMAEa6HPzFlUWVp9265g2hch4NW5T
AJkKrVtybChvD6cZh26PDo0RepMbyJuJ74RrU6BbvJ2GiTB1UWpeGfNMfKA6Ewyd
JZrUZT81b7buhiMVzRVwrP7QLma/pORyCiOjjFHipNOhJuhUcOyg/wdRuzQZHbmG
5jeQ7oytGet1OLzK/rKB
=tlGs
-----END PGP SIGNATURE-----

--X0vpKvTpCy87tk9a--
