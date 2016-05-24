From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v8 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Tue, 24 May 2016 12:35:45 +0300
Message-ID: <877feju7bi.fsf@linux.intel.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com> <1462977406-22806-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462977406-22806-6-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> Implementations might use different IRQs for
> host, gadget and OTG so use named interrupt resources
> to allow Device tree to specify the 3 interrupts.
>
> Following are the interrupt names
>
> Peripheral Interrupt - peripheral
> HOST Interrupt - host
> OTG Interrupt - otg
>
> We still maintain backward compatibility for a single named
> interrupt for all 3 interrupts (e.g. for dwc3-pci) and
> single unnamed interrupt for all 3 interrupts (e.g. old DT).
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

fails to apply, unfortunately:

checking file drivers/usb/dwc3/core.c
Hunk #1 succeeded at 845 (offset 31 lines).
checking file drivers/usb/dwc3/core.h
Hunk #1 succeeded at 738 (offset 22 lines).
Hunk #2 FAILED at 818.
1 out of 2 hunks FAILED
checking file drivers/usb/dwc3/gadget.c
Hunk #1 succeeded at 1710 with fuzz 2 (offset 105 lines).
Hunk #2 FAILED at 1728.
Hunk #3 FAILED at 1740.
Hunk #4 succeeded at 2835 (offset 54 lines).
2 out of 4 hunks FAILED
checking file drivers/usb/dwc3/host.c

I'll update my testing/next shortly, if you could rebase the remaining
of these patches on that, I'd be glad.

Thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXRCBxAAoJEIaOsuA1yqRExC8P/jvcdFueXMR/EsfHsFROROXc
BziXp08FRJTVGrVd6pvfXYWh4EB/P75Fl/ufREga/F4vsHm2QgWkGWJVukmkiPie
F2uAL0nnk16yjpiZEyxLB1JCon9QJ+WJOn7YCQTFNs2SjP8OtcahSG6usrxcvgCJ
Sufp5xqqJ2NJHvaWXH2R1idLnBqYdUpMhF/qkgv+9mYY4+X+ZGIC/oNbxPsC/mXj
RxuMV1UHaz8P2h5/QqGaMWctAngBfGLOSEJllYRqLuX1EXWZFqugtG4LCb9ouDKR
ibpbC0tKbokBh79NqKNH8Gvptwvm9rpE+Y3YtHZjisMO7DZIT1U5Efmk9BUcfuty
9NCOeChpvkoBLg/r/3ZiH3mTSQubriyN5/nh62uCIzCTOMex5H2Sgl+bECASuAEU
EFOnt0MXpDIbrrtwk85K4+1NuHtxvtAyPkwGbExbPQPxJEwTS3dM+RVIOobNC9L9
KpIfsheqLhpG4W+6TXV6lJgbThdC/VJ+himjFZNj1h+16v2Xj8rBtvCvPy//y6us
Z6DGZ/MLKHc3Upg6qAHd3ZdXmMfo+CHTS79f2CrinCypNA/E8Hwbsaof3RIVIjg1
NXWuZsG+Rga6+vmY9d8O590icpGL94xao9uimM0uS0P6REgJqyH9aJ4wRxXpj6IK
iF6oPjGe9mojkZeE2Dag
=05yA
-----END PGP SIGNATURE-----
--=-=-=--
