From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Tue, 31 Jul 2012 11:42:20 +0300
Message-ID: <1343724140.2633.20.camel@deskari>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
	 <CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com>
	 <1343721101.4685.35.camel@lappyti>
	 <CAJe_Zheg_fpnRb+eLt5SQioSUXp=PFcPz-vWC-RL3_Mh35VBdA@mail.gmail.com>
	 <1343722450.4685.37.camel@lappyti>
	 <CAJe_Zhd4ubkfMRmVNt734N0Sc3+7OfXrgSPq-fUSH+uQfQ5RzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-IOc6caoeXyo/PeYRdbQ3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48691 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754826Ab2GaImY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 04:42:24 -0400
Received: by lbbgg6 with SMTP id gg6so4829800lbb.8
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 01:42:21 -0700 (PDT)
In-Reply-To: <CAJe_Zhd4ubkfMRmVNt734N0Sc3+7OfXrgSPq-fUSH+uQfQ5RzA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Raphael Assenat <raph@8d.com>, linux-omap@vger.kernel.org, Archit Taneja <a0393947@ti.com>


--=-IOc6caoeXyo/PeYRdbQ3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-07-31 at 13:57 +0530, Jassi Brar wrote:
> On 31 July 2012 13:44, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Tue, 2012-07-31 at 13:33 +0530, Jassi Brar wrote:
> >> On 31 July 2012 13:21, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >>
> >> > 2) Have the configuration for countless panels specified in the DT d=
ata
> >> >
> >> Why should a DT blob for a board contain more than 1 panel configurati=
on?
> >
> > I meant the DT data generally, for all boards.
> >
> If you mean : Why have the configuration (those 15 integers) of the
> panel on a board specified in board.dtb?
> Well, that is an important purpose of DT - moving board specific
> parameters, on which a generic code works, out of kernel (I am
> refraining from preaching the goodness of that).

Sure. But panel's unconfigurable properties are not board specific
parameters, they are panel's internal stuff. It doesn't matter to which
board I attach Acme Foo-123 panel, the panel timings are still the same.

Okay, agreed, the timing properties are not unconfigurable. But I'd
expect that normally the timings used are the normal timings specified
in the panel's datasheet.

For the cases where the board manufacturer wants to use non-standard
timings, perhaps we could allow overriding with DT data the ones
specified in the kernel. Or have a panel driver that expects to get all
the data from DT.

But I don't see why a panel database in the kernel driver is a bad thing
(presuming it can be used in most cases). The driver should allow using
the panel device without requiring the user to give extra information.
(extra in the sense that the driver should already know about that
info).

 Tomi


--=-IOc6caoeXyo/PeYRdbQ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQF5psAAoJEPo9qoy8lh71xSgP/if9roBcCvgsn7n2eX8YVkSM
nSra7PTv2unOvTExO1co7M0egbPnWEjr+CZ5GorsZO0zwnSGj20tTBLaC4kic+la
0mqro4MwVb8ao7bE60TF23OUccdhlbcuEIrTlyRs7qB3YlnQKZf6XotfqAqrw2RX
kA0/es/qjJVApkjNkIo6eDQmfhjTRQHjw5K4/yzar0Qj404nZA0lrK7d7wgrC/ap
XEpxZwrCdnlPXV2WYSd84f5ohd6Xw6H2La3FCEG3rvlpWXVtPUn9x++IR63HvMmV
TfCZvWCx8xXXkc5sto86GY0Hgaqe9zMBSCqrEnD90D/oHMK5R/B3h5+CdWRKh3us
flb+cbQIEIX4efFGRlCBID18qaNN980m1NC6UYInv3sirKNx6MQm4UNBirTX34Eq
eOKkwTmNY3uwamLgZQcAL3nkLXc7UQ33jChEzwQepVpNmrq0nuBzK1U+7Tn0HvbO
h6fnmY9GRyulXKdQeJ/Cv5SQdlXWJEFc6NGEklEZz2sibT6QCIvZUnzesRs/aLgj
7PsiFXFD9xN71Wh3VMbcYqSNTZAe3xL8JOoFe0kx6s6iUKltJ8bNEAjo6ZWOqvji
iC9GaYCN/KDXVrwAtbHXgKuLYh9n0qMuvixgYMS2Q30lxJ9/rP0NbMvxdEvFyTJz
005rwiuWzaDxFOOP1urO
=7ux+
-----END PGP SIGNATURE-----

--=-IOc6caoeXyo/PeYRdbQ3--

