From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Tue, 31 Jul 2012 10:51:41 +0300
Message-ID: <1343721101.4685.35.camel@lappyti>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
	 <CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-KCU4MooOZB9bXrsZ5SOX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:53699 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752171Ab2GaHvq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 03:51:46 -0400
Received: by lbol5 with SMTP id l5so3455508lbo.6
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 00:51:44 -0700 (PDT)
In-Reply-To: <CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Raphael Assenat <raph@8d.com>, linux-omap@vger.kernel.org, Archit Taneja <a0393947@ti.com>


--=-KCU4MooOZB9bXrsZ5SOX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-07-17 at 21:57 +0530, Jassi Brar wrote:
> [CC'ing OMAPDSS matinainer]
>=20
> On 17 July 2012 19:31, Raphael Assenat <raph@8d.com> wrote:
> > Add timings for ChiMei G121S1-L01/L02 and G121X1-L01 LCD displays.
> >
> Display panels are board specific and there is no limit to the number
> of panels that could be connected to omap dss.
>  Does it make sense to get panel params via DT? Or at least have them
> come from board file? (esp when there is hardly a panel shared by two
> boards, and some panels aren't even used by any board in mainline)

So we have two options, with pros and cons:

1) Have the configuration for countless panels specified in the driver

- Pro: driver for the device is the right place to define hardcoded
device properties
- Pro: panels can be easily used from the board file, just define the
name of the panel
- Pro: the same panel can be easily used from multiple board files,
without duplicating the configs
- Con: Adds lines to the kernel (not really a con, all features add
lines to the kernel. and we can restructure the data to fit fewer
lines.)
- Con: We could have "leftover" panel data, not used by anyone.

2) Have the configuration for countless panels specified in the DT data

- Con: DT data is not the right place to describe device's internal
hardcoded properties. DT data should be about HW connections and
configurable options.
- Con: Adds lines to the DT data

What were the pros for option 2? I didn't really see them in this mail
thread, except moving lines from the kernel to the DT, which I don't
really see as a pro.

 Tomi


--=-KCU4MooOZB9bXrsZ5SOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQF46NAAoJEPo9qoy8lh71g/0P/2NgbewYdlH6AenRfFlRAq2C
+qcNfXJczPaT7vTqzbJO8CxkZif5WPdXpQOKFYswZVfCtlAED0UzNUBTeb+kg6nd
lpVaG0wgFaaYwgR9KjpCww4eFvji/xaXWCdZ9rIWwDGwCn0NtZZVMdGZjkRheZMc
PpY4Y/c0MdSTbqikp8O4H7D/z7jh9JLuLApcICkDV0+EOVFzZTJWm0Lhw8SbUjSY
AhodpgpDhLPhEGzcxZLyt6EmfuluOVZTqUUaLMATYlDldt2Xuaa1AkqlHwea/Cpu
qOnu7uIHK2rAmb9T27WWWLK2+GztmN6orrDzRsDgXRqEpM8ogrEhx3uSzkePea1Q
zlrL2nYUbUsLRaAPiFKy6yMCPdu8CgF0jhcNaZTaZnjyKhs6Q1uyEOyosbkM6XBI
HBm4tP0r0kAvXZnLWBbfMVhdJsRLCUilX80nkDNoJaVm0aPI1xCk7a+lRswVODnb
LD+xH2iIXW8gmK4wCvRpHqIgIzia4cXh4GP/hIEX4Naa9Mznb+WuN6BfYBDeBvsL
fsDoi9LB8yh5TX1wKas/08dd24MIcIopziz7iTDX4ZXDLjNdKU17erzmiI8Se7p8
aZ31cA0/5OcgB5A5fG0e65EBiNHT7U5qHAeRxTGNoXodywi1Xv2h/5bNy14i4Mxj
B+2Mjh/J+xD+XObSOcUL
=invO
-----END PGP SIGNATURE-----

--=-KCU4MooOZB9bXrsZ5SOX--

