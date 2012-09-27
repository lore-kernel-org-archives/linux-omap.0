From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2 0/2] OMAPDSS: Enable dynamic debug printing
Date: Thu, 27 Sep 2012 14:01:12 +0300
Message-ID: <1348743672.2913.6.camel@deskari>
References: <1348552998-6596-1-git-send-email-cmahapatra@ti.com>
	 <cover.1348636132.git.cmahapatra@ti.com> <1348669792.2376.51.camel@deskari>
	 <CAF0AtAvT-NnsREJWpRtYAGpYCS06O32tzQwWTDoFp+xepHyX8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-EmPLWrbZBML73VpnjsVt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45231 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756240Ab2I0LB2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 07:01:28 -0400
Received: by bkcjk13 with SMTP id jk13so1544037bkc.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 04:01:16 -0700 (PDT)
In-Reply-To: <CAF0AtAvT-NnsREJWpRtYAGpYCS06O32tzQwWTDoFp+xepHyX8w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-EmPLWrbZBML73VpnjsVt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-27 at 16:20 +0530, Mahapatra, Chandrabhanu wrote:
> On Wed, Sep 26, 2012 at 7:59 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
>=20
> > This doesn't work quite correctly. The problem is in dss.h, where we
> > define DEBUG if CONFIG_OMAP2_DSS_DEBUG_SUPPORT is set. The thing is,
> > DEBUG should be defined before including the kernel headers where the
> > pr_debug etc are defined.
> >
> > So if you try the patches without dynamic debugging enabled, you won't
> > get any debug outputs at all, even if CONFIG_OMAP2_DSS_DEBUG_SUPPORT is
> > set.
> >
> > And for dynamic debug, the Kconfig help says:
> >
> > If a source file is compiled with DEBUG flag set, any
> > pr_debug() calls in it are enabled by default, but can be
> > disabled at runtime as below.  Note that DEBUG flag is
> > turned on by many CONFIG_*DEBUG* options.
> >
> > So if we have CONFIG_OMAP2_DSS_DEBUG_SUPPORT set, all the pr_debugs
> > should be enabled by default, which is not the case, again because DEBU=
G
> > is defined too late.
> >
> > I think setting DEBUG in dss.h should be removed, and instead DEBUG
> > should be set in the makefile if CONFIG_OMAP2_DSS_DEBUG_SUPPORT is set.
> >
> >  Tomi
> >
>=20
> Well the documentation lags in describing about the DEBUG flag. I
> should have checked DYNAMIC_DEBUG in Kconfig and pr_debug definition
> in printk.h file.
>=20
> #if defined(CONFIG_DYNAMIC_DEBUG)
> /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here *=
/
> #define pr_debug(fmt, ...) \
>         dynamic_pr_debug(fmt, ##__VA_ARGS__)
> #elif defined(DEBUG)
> #define pr_debug(fmt, ...) \
>         printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> #else
> #define pr_debug(fmt, ...) \
>         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> #endif
>=20
> As per the definition above pr_debug is dynamic with
> CONFIG_DYNAMIC_DEBUG set or else with DEBUG set it is just a normal
> kernel debug printk as you have mentioned.
> I still don't get how even if DEBUG is set before DSSDBG() is defined
> in dss.c pr_debug() fails to enable.

Because printk.h is included without DEBUG, thus pr_debug is defined as
no_printk.

> Well anyways, how to do the same in the Makefile? I tried adding
> ccflags-$(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) +=3D -DEBUG
> to makefile in dss directory but of no use.

-D option for the compiler is used to set defines. So it should be
-DDEBUG

 Tomi


--=-EmPLWrbZBML73VpnjsVt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQZDH4AAoJEPo9qoy8lh718aUP/AlcB4lWglCxUwzpBX9KHw1j
KneFLapNGGQOEAGunj0bjUuy6f222YxSUj19DhH+QFcATZaIVpTWRHXf1Ysqvyvv
S59Uun6vF/Dy1TNPZK3MD3a+6vHs+uQQ0ex4wrOcM15tL/j/zKeyUPvHri892iqB
Nv7rEXAX6nxJb9Mh2ooAentZowyr2bbfXhwNsd+eKXTpBfQO5ATjTfoghoqb+7YS
mGcby0dJE2k5jDKmtME5gH04qb9apvzt8oW6xVw5YtzQWjK3Bh7EPjasiHINmZGu
VLGpxAtJiRrv7GC4EYm1bEpGDiByJRVHCQmHDhcd+1E4N1jWAvbcsyCLU6X+sR8u
/Y1DAe8bMhc30haa1jVRaIP2Lp+9I+zhNQk4UuPZRkwZG8polFaTrb5L0/Vn2Dry
mTuOucyOcogDN0XyUZqbt+nyx9bWDnTw+TjW6RwnSTt10d7Jgkn7qzwv2U4D72QK
hqCA6mSp/CQCXuR0vqlYh/o+8XfOxPyk3zte8bjl+xGkXjV2WgW/ZfBjajakrye1
LQqKQb3cMJCd+xKn7A0pN57Vw4GcvofL7P5ynEMoM/PW6KpBpUGxhg0gqssX4moy
lBoFCDqEH7/Tw1EDAmPmosiE1psOsDsqQSGUnqleYPtc7P+KpEnXIKOUtPgJSaxq
B2EPUMga4xlKO/W09phP
=ZaV2
-----END PGP SIGNATURE-----

--=-EmPLWrbZBML73VpnjsVt--

