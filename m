From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv7 01/18] I2C: OMAP: make omap_i2c_unidle/idle functions
 depend on CONFIG_PM_RUNTIME
Date: Wed, 11 Apr 2012 15:00:43 +0300
Message-ID: <20120411120042.GI12064@arwen.pp.htv.fi>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
 <1334142776-10583-2-git-send-email-shubhrajyoti@ti.com>
 <20120411113254.GE12064@arwen.pp.htv.fi>
 <CAM=Q2csMkvbVwSav8d4KCXkcNS=oQGpPY2R-hiVzZvVPEngrog@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xcivb/T/gnJQjo5J"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:52638 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752872Ab2DKMBh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 08:01:37 -0400
Received: by lbao2 with SMTP id o2so823597lba.14
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 05:01:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAM=Q2csMkvbVwSav8d4KCXkcNS=oQGpPY2R-hiVzZvVPEngrog@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: balbi@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de


--xcivb/T/gnJQjo5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2012 at 05:29:07PM +0530, Shubhrajyoti Datta wrote:
> Hi Felipe,
>=20
> On Wed, Apr 11, 2012 at 5:02 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Wed, Apr 11, 2012 at 04:42:39PM +0530, Shubhrajyoti D wrote:
> >> The functions omap_i2c_unidle/idle are called from omap_i2c_runtime_re=
sume
> >> and omap_i2c_runtime_suspend which is compiled for CONFIG_PM_RUNTIME.
> >> This patch removes the omap_i2c_unidle/idle functions and folds them
> >> into the runtime callbacks.
> >>
> >> This fixes the below warn when CONFIG_PM_RUNTIME is not defined
> >>
> >> =A0CC =A0 =A0 =A0arch/arm/mach-omap2/board-ti8168evm.o
> >> drivers/i2c/busses/i2c-omap.c:272: warning: 'omap_i2c_unidle' defined =
but not used
> >> drivers/i2c/busses/i2c-omap.c:293: warning: 'omap_i2c_idle' defined bu=
t not used
> >> =A0 CC =A0 =A0 =A0net/ipv4/ip_forward.o
> >>
> >> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> >
> > how about just moving them into the #ifdef ? /me thinks it's easier to
> > read with the function. Matter of taste though, it's not that much code.
>=20
> Kevin preferred folding into the  runtime functions.
>=20
> http://www.spinics.net/lists/linux-omap/msg62764.html
>=20
> Don't feel strongly though.

ok, I stand corrected ;-) No need to change your patch again ;-)

--=20
balbi

--xcivb/T/gnJQjo5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhXJqAAoJEIaOsuA1yqREN7UQAKvbANAA3AifPJxG2HdsMkxL
jA5EH04JntZ6bHiHpfEsYmXDHjB4UudRjfDSpzyZRanY1yuZjxzvO8xWr4tf8wk2
j4WU6yACOFZSJ/6CqgGc4p7vwwXCkiKez1dMXoE7nO9AUeBhc0klJnRXJ7eL354b
BWWCNl74SUozIiqQTb6HelvmXWy0jILFSb8Teb71gKgpSdFaaj5IrBBO41BROlP5
nNvhZ5WznWbk84fLAjbYEH8mwC4z0TukKD6hqZ8g2a32ADskABMjIcJzmgAevvH1
+Vh6N266pDpsox3qpOjJRJ8PDnOeLXT+AH4S204jJaBA12qf3GUO2djqivJe8pyK
Qxks460KSARWrwGeq303Kqms0f6udQhrQKJpgUQeitTq1QRjRa7mveJ8CmUqb80M
ZsFEG38cH1/PN0UxMsGrMC05LVBl4pO+c8O17geetgak0rnbEDN+NB3uzHmoTP5u
NV9BmkCCD/dDrA2WTBxw1ySmb9U48ZRCBJ7+WxQADhfzs8bCNy3Ah4RPM6W3M4mf
rVk3s7Z5r5h3VqAa1hRot6nWAEbN/CcYSz7KMdun/lfIpkUpjAAooJwikKlAVVCG
wpWAR7IIRo25OKMIjvEjzCnG6G5i27kuFVApozJw9mBMBH6c28Hu9VwybfpZKul+
jfkp81nusrTBCENB4h72
=R4zg
-----END PGP SIGNATURE-----

--xcivb/T/gnJQjo5J--
