From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMP35xx booting issue
Date: Sat, 20 Oct 2012 18:45:58 +0300
Message-ID: <20121020154427.GA7286@arwen.pp.htv.fi>
References: <CAPjKCR8wzfPxuts4_i-P-X+fru2C-QwZcp_g=w_eHi0SJ_PgiA@mail.gmail.com>
 <alpine.DEB.2.00.1210200627180.9865@utopia.booyaka.com>
 <alpine.DEB.2.00.1210200629010.9865@utopia.booyaka.com>
 <CAPjKCR9ymWpkUPvXePu5NkGTxVaE2HFv5wp24aGBocdZ6nJFzg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39452 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab2JTPvh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Oct 2012 11:51:37 -0400
Content-Disposition: inline
In-Reply-To: <CAPjKCR9ymWpkUPvXePu5NkGTxVaE2HFv5wp24aGBocdZ6nJFzg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anil Kumar <anilkumar880@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, tony@atomide.com, linux-omap@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(please don't top-post)

On Sat, Oct 20, 2012 at 12:37:58PM +0530, Anil Kumar wrote:
> devkit8000 is booting with kernel 3.5 and no much diff
> in kernel 3.6/3.5 board files
>=20
> i am suspecting here
>=20
> omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62

you need to enable CONFIG_DMADEVICES, CONFIG_ASYNC_TX_DMA and
CONFIG_DMA_OMAP. That should sort it out.

--=20
balbi

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgsc2AAoJEIaOsuA1yqREl/4QAICuwpYBMGkGXU49FXR0R7Lt
OwYIsGH+GptniltfWgrC/LfF1hp3aszRSrehbkK4dti8cm5G0Zd7p07woPz8kcut
SmEldkj4v0wugfNKhbN+feNVGtoHXjaPop8+CNyKmTmVnvG8cYF7dznx9qfhSNob
FmCNrbId0fNN4mLUmlQU5sUou8KDDgBQn/RxamHoNk5hGSNxKLvEq8ZxO+fz5Vsw
9ibM/guHjQmQYMqI9NKvRnLiGUcG0OeiNuXk8ajYHMsq3DSdSRTwcIQLJk04eX1M
/EOILAwj1SYnA/dYkzsSAgDUqhX7c3zeRBinSzAO6ySopyG/USZPTGFWkYbRZ6S3
GeqlypuBP3Dy4U944YqDpk3nr6NcOPv488n9bnoUpDNAMT9d7Cq9aocL2XDnn00R
HZmlbFecuABY+rj0mmXMLOKnoni8NGYQ2cY0SDooToH4/AnRXCSRmIcURIDfIExX
5wXOl9H/3WxBEKMtCy5PtRoBX3S1RJWBBMqSQMNVTCJyppOZgiEky9KItIypcvAc
Gm3C5oXF+W2JohUJQ2k6Hi+hXNl3PRFW7Ssyvd+yycLD7JF7lrjg7BAWh+MOEqhC
hohj9n/SUZKLAky72IKmFodY31kwbqovRO3S8et936YVdHlIDckfihH9XKst5/ar
ewpE66fUAEixDONyfITI
=RiEe
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
