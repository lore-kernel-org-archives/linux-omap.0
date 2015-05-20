From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 00/10] ARM: DRA7: add display support
Date: Wed, 20 May 2015 11:24:15 +0300
Message-ID: <555C44AF.2040800@ti.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N9BMC54CJqu2wgr0nsDViTnlrRvNEgRan"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54373 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbbETIYo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2015 04:24:44 -0400
In-Reply-To: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>

--N9BMC54CJqu2wgr0nsDViTnlrRvNEgRan
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/05/15 13:08, Tomi Valkeinen wrote:
> Hi,
>=20
> This series adds the arch/arm/ side of the display support for DRA7 (DR=
A72x,
> DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 EVM=
 boards
> is added.
>=20
> This series is v3, and is based on v4.1-rc2. There are no differences t=
o v2,
> except rebased and tested.
>=20
>  Tomi
>=20
> Tomi Valkeinen (10):
>   arm/dts: dra7xx: add 'ti,set-rate-parent' for dss_dss_clk
>   ARM: DRA7: hwmod: add DMM hwmod description
>   ARM: DRA7: hwmod: set DSS submodule parent hwmods
>   ARM: OMAP: display: change compat names to array
>   ARM: OMAP2+: display: detect DRA7 DSS
>   arm/dts: dra7.dtsi: add DSS support
>   arm/dts: dra72-evm.dts: add HDMI
>   arm/dts: am57xx-beagle-x15.dts: add HDMI
>   arm: dra7: add DESHDCP clock
>   CLK: TI: always enable DESHDCP clock
>=20
>  arch/arm/boot/dts/am57xx-beagle-x15.dts   |  81 ++++++++++++++++++++++=

>  arch/arm/boot/dts/dra7.dtsi               |  43 ++++++++++++
>  arch/arm/boot/dts/dra72-evm.dts           | 110 ++++++++++++++++++++++=
++++++++
>  arch/arm/boot/dts/dra72x.dtsi             |  11 +++
>  arch/arm/boot/dts/dra74x.dtsi             |  15 ++++
>  arch/arm/boot/dts/dra7xx-clocks.dtsi      |  11 +++
>  arch/arm/mach-omap2/display.c             |  32 +++++----
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  33 +++++++++
>  drivers/clk/ti/clk-7xx.c                  |   8 ++-
>  9 files changed, 328 insertions(+), 16 deletions(-)

Ping. Any comments? Can we get this into the next merge window?

 Tomi


--N9BMC54CJqu2wgr0nsDViTnlrRvNEgRan
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVXESvAAoJEPo9qoy8lh71bTcP/Rz4W4Gj8NnIB36M9QAIqMQE
wIcp8KgpopJGC//lyOvgeHOPl+ZdQ1KWjP3ApWu9P4uMGm6LnUlGV28TzTnMC6fK
34/zQ3Gx6VP2OdAoe7CbNGLrYJItA37J9t6Ejtqx12HvCKxbCBehAFVxvuweFzle
7iMdwpJGNN52EQKJv4k2bKlR/VBqkpQZbXcwAD9+DpeHQOnWqw/my5ul2fHbTIGx
iZ+hYk6qZIiqbGG3FSLNUUNKZl1T/eD6WHNP3wXsZ87SJYUFf6L+UO/St55DqaVe
K1RgwTGxaMXleP1rJJdlMtS+igEKhyvu1OlPwvi3UCquKb0L2VbMtaM0F1ksQkb5
oxgpij1rOrl0l2F1u5pKVtiIlNtVGLOz7HyQXsrxcUOAGSHwPEm0C7L/EZFT0aG9
4XcmVLpr60njKD4IWmLaup+bqkn5lLLo71+CDsF7ymyjH6NInZlf241y6Iuc/5F4
G67c6Nnl0ytsEEBTSRd3ZR1ux3MkSaWX5qEv50mzpwI9r25td+NjEMfDdkNT0aYF
enNgT2SycLCGsgAOyhbSHgrbLyBN0Kgd77UdF6nRaZET1BEhao0S0XHcpU8HL1ls
VV7CmbxsDNHglGRGqvUJGct2IunIEu/Ro+095m7KFShNAQ/7TWRg6TNRKwu2Bs2T
72pMqqqrhcOj0Wf4iKrp
=Bdw5
-----END PGP SIGNATURE-----

--N9BMC54CJqu2wgr0nsDViTnlrRvNEgRan--
