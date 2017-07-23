From: Pavel Machek <pavel@ucw.cz>
Subject: Re: bluetooth in v4.13-rc1: lock init missing somewhere?
Date: Sun, 23 Jul 2017 10:26:54 +0200
Message-ID: <20170723082654.GA31857@amd>
References: <20170721085551.GA22993@amd>
 <022531FF-11AA-4D6B-A92B-146F5E6BE31F@holtmann.org>
 <20170721111058.GB9448@amd>
 <D0C772B3-4C90-414C-84E5-1DE14054A40A@holtmann.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9079839778546267664=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <D0C772B3-4C90-414C-84E5-1DE14054A40A@holtmann.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: ivo.g.dimitrov.75@gmail.com, Johan Hedberg <johan.hedberg@gmail.com>, khilman@kernel.org, tony@atomide.com, "Gustavo F. Padovan" <gustavo@padovan.org>, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-bluetooth@vger.kernel.org, abcloriens@gmail.com, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============9079839778546267664==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I guess output just after boot will be more interesting?
> >=20
> > root@n900:/my/modules# insmod hci_nokia.ko
> > root@n900:/my/modules#
> > Message from syslogd@localhost at Jul 19 12:24:00 ...
> > kernel:[  174.363037] BUG: rwlock bad magic on CPU#0,
> > kworker/u3:0/3027, c2665a48
> >=20
> > root@n900:/my/modules# ../bluez-5.26/tools/btmgmt public-addr
> > 01:02:03:04:05:06
> > Set Public Address for hci0 failed with status 0x0b (Rejected)
> > root@n900:/my/modules# ../bluez-5.26/tools/btmgmt power on
> > Set Powered for hci0 failed with status 0x11 (Invalid Index)
> > root@n900:/my/modules#
>=20
> if you manage to get a recent btmon then it will also decode all the
 > the unknown packets. That would be interesting since it tells you
 > exactly what mgmt sends and what also legacy tools do at any given
 > time.

Let me try:

pavel@n900:/my/bluez$ autoconf
configure.ac:4: error: possibly undefined macro: AM_INIT_AUTOMAKE
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
configure.ac:11: error: possibly undefined macro: AM_MAINTAINER_MODE
configure.ac:24: error: possibly undefined macro: AM_PROG_CC_C_O
configure.ac:25: error: possibly undefined macro: AC_PROG_CC_PIE
configure.ac:32: error: possibly undefined macro: AC_DISABLE_STATIC
configure.ac:33: error: possibly undefined macro: AC_PROG_LIBTOOL
configure.ac:41: error: possibly undefined macro: AM_CONDITIONAL
pavel@n900:/my/bluez$ ./configure=20
=2E/configure: line 2189: syntax error near unexpected token `foreign'
=2E/configure: line 2189: `AM_INIT_AUTOMAKE(foreign subdir-objects color-te=
sts silent-rules'
pavel@n900:/my/bluez$=20

automake; autoconf results in less warnings out of autoconf.

In the end I just deleted the offending line.

But then it ends here:

=2E/configure: line 4043: AM_PROG_CC_C_O: command not found
=2E/configure: line 4044: AC_PROG_CC_PIE: command not found
configure: error: cannot find install-sh, install.sh, or shtool in "."
"./.." "./../.."
pavel@n900:/my/bluez$


> > While btmon says:
> >=20
> > ...begining of buffer lost :-(
>=20
> I really need to find my patches for the monitor ring-buffer and
 > replay support so that you can keep these in kernel memory and
 > configure this with a kernel cmdline option. In theory however
 > starting btmon before insmod should be plenty to get the full
 > trace.

That was my fault, not kernel fault. I just relied on scrollback
buffer, and it was not big enough.

>=20
> Actually I just realize that this is special anyway. Since this is Nokia =
manufacture ID, but Broadcom vendor decoding. I think that we need to add s=
ome special handling for this to make sure user space is able to decode thi=
s properly.
>=20

Aha. Ok, I guess I can test out the patches... if I manage to compile
it. Adding a hint how to compile from git (-> configure not present)
would be nice.

> While we do this the btbcm_set_bdaddr might be actually empty.
>=20
> config BT_HCIUART_NOKIA                                                  =
       =20
>         tristate "UART Nokia H4+ protocol support"                       =
       =20
>         depends on BT_HCIUART                                            =
       =20
>         depends on BT_HCIUART_SERDEV                                     =
       =20
>         depends on PM                                                    =
       =20
>         select BT_HCIUART_H4                                             =
       =20
>=20
> This is missing the select BT_BCM like what we have for the hci_bcm.c sup=
port.
>=20
> config BT_HCIUART_BCM                                                    =
       =20
>         bool "Broadcom protocol support"                                 =
       =20
>         depends on BT_HCIUART                                            =
       =20
>         select BT_HCIUART_H4                                             =
       =20
>         select BT_BCM
>=20
> Can you try to enable btbcm.ko module and load that first.

Actually, I guess I can just make it build-in. But I'm not sure how it
is supposed to help: I'd expect undefined symbols on broken
dependency, not silent failure.

Thanks,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAll0Xc4ACgkQMOfwapXb+vISvACfSzthgwxZjHuIh3JK/ZZqJVlr
kHIAnjeX8jWQ13tocGqBu8bq3RrijlrL
=4DGM
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--


--===============9079839778546267664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9079839778546267664==--
