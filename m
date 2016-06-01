From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v9 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Wed, 01 Jun 2016 11:06:44 +0300
Message-ID: <8737oxl4dn.fsf@linux.intel.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com> <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <574E92E8.5080201@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rogerq@ti.com
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
> ---
> v9: rebased on top of balbi/testing/next

breaks dwc3:

[  222.776504] dwc3 dwc3.0.auto: failed to request irq #-6 --> -22

please test

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXTpeVAAoJEIaOsuA1yqRERp4P/i1FnVjsACPMZ+ewF5Qs5TxL
nN5Upz4UuR3CrDiroebztj29Fe1jin0R3anZ5+dd8xWjf3tJBkHPDdb/1sbF/jZ0
7D3qqk8Jmpby4j6ZNIDu1C8yWNAr1R6FHV6oXg6iZxZ2LcDLrsCQ2L3DO1FtfuAP
DkTOOk+mGIUNsgccmUGvQepfz2HL1IoY8apdcH3u3jq7zIo3bUAfWAy/9JymwuAB
cgW3NucOw1fo9tBhDXyMg6GUvNyApyOpDT6yjsryi6nTz03ETEqqDJ5fBVHbT8lh
VKPZQGOnVz98RYxSMiTANNaMRbdTkRSqyrYGLWsiDgXLyRiGZiY8z6Pr2ibQVVBq
PdhTB5UNiVvYjQApXiEo/8tsFSv52u/8CQ/1YJWS33lK5sdq08xIIJ6XLp+jwxyv
dAKNhOoPnEpwvGS7aIFUvrIFP13EOm3t0/cXLW44O6szwbhnO+x+opuVGNIyDXU3
zzkesvzFrZ+aVquSDXNcAST383ZsCEZNLU9ScEVCINqpki/IV+JKdE6V507TqE02
sV/pWRhXIAdfQwLcIJMdGLTbVIOoyvP5uaqSzEsDKYxOuEsHaiFwl9fiyhF4DFRt
uzJQhlS/sb+zGC9Xk77lg+x7n3ox955LkgWHf3fS+8cvOs8balvV0GW67vXbPUq7
MXjBdPRo7bSrEZsWNTA7
=9Ge9
-----END PGP SIGNATURE-----
--=-=-=--
