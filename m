From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Thu, 9 Jan 2014 17:15:53 -0600
Message-ID: <20140109231513.GA11648@saruman.home>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <52CF12FB.6000602@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34148 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbaAIXRR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 18:17:17 -0500
Content-Disposition: inline
In-Reply-To: <52CF12FB.6000602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 09, 2014 at 03:22:03PM -0600, Nishanth Menon wrote:
> > So, bad luck number release for this, as v12 wasn't sufficient still.
> >=20
> > Changes compared to previous version:
> > - Dropped any changes to generic clock drivers, as it seems impossible
> >   to agree anything in short term, this means the patch set shrank in
> >   size from 49 patches to 40 (first 9 patches were dropped).
> > - Copy pasted implementation for clk-divider and clk-mux from drivers/c=
lk
> >   to drivers/clk/ti, and made the modifications needed to the TI version
> >   of the clock drivers only (based on discussions with Mike, this is fi=
ne)
> > - Changed name of clk_ll_ops to ti_clk_ll_ops so that this doesn't conf=
lict
> >   with any generic implementation we might have at some point, migrating
> >   this to the generic version should be easy enough also.
> > - Fixed trace_clk_div_div_ck for omap4, this node was broken in previous
> >   versions and resulted into an orphan clock node
> > - Fixed compile problem for omap5 only build reported by Felipe
> > - Fixed a couple of sparse warnings
> > - changed the mach-omap2/clock.c to use readl_relaxed / writel_relaxed
> >   instead of __raw_readl / __raw_writel
> >=20
> > Testing done:
> > - omap3-beagle: boot / suspend-resume (RET) / suspend-resume (OFF)
> > - omap4-panda-es: boot / suspend-resume (RET)
> > - omap5-uevm: boot
> > - am335x-bone: boot
> > - dra7-evm: boot
> >=20
> > Maintainer friendly branches also available:
> >=20
> > tree: https://github.com/t-kristo/linux-pm.git
> >=20
> > clk driver only (Mike): clk-next-dt-clks-v13
> > DTS data only (Benoit): dts_for_3.14-dt-clks-v13
> > full-branch (Tony/Paul): 3.13-rc7-dt-clks-v13
> >=20
> > -Tero
> >=20
>=20
> Maintainer branches conflicts (using 3.13-rc7-dt-clks-v13):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Conflict resolution during rebase to maintainer's -14 branches:
>=20
> 1. (trivial) Against mike's clk-next dbdf6ff Merge branch
> 'clk-next-unregister' into clk-next
>=20
> Could not apply 2edf7ad... CLK: TI: add DT alias clock registration
> mechanism
> conflict drivers/clk/Makefile (trivial fix)
>=20
> 2. (manual, but changes are easy) Against Tony's omap-for-v3.14/be
> fc6ca98 ARM: OMAP: debug-leds: raw read and write endian fix
>=20
> ARM: OMAP2+: clock: use driver API instead of direct memory read/write
>=20
> conflicts with be changes on Tony's be branch.
> commit 80f304dd2360cf5d50953c4eb4e902536f6a1263
>     ARM: OMAP2+: raw read and write endian fix
>=20
> Conflict:
> arch/arm/mach-omap2/clkt_clksel.c
> arch/arm/mach-omap2/clkt_dpll.c
> arch/arm/mach-omap2/clkt_iclk.c
> arch/arm/mach-omap2/clock.c
> arch/arm/mach-omap2/clock36xx.c
> arch/arm/mach-omap2/dpll3xxx.c
> arch/arm/mach-omap2/dpll44xx.c
>=20
> Both change raw_readls -> should now be just clk api instead which
> already does readl_relaxed etc.. If Tony feels like, then we should
> probably post a branch based on 'be' branch for easy merge.
>=20
> 3. I could not detect any merge conflict against Benoit's queued up
> series (but maybe he has'nt pushed everything to remote tree)..
>=20
>=20
> Patch verification report:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> Report: http://pastebin.mozilla.org/3976492
>=20
>=20
> * sparse warning added in [PATCH 06/40] CLK: ti: add support for ti
> divider-clock, [PATCH 10/40] clk: ti: add support for basic mux clock
> +drivers/clk/ti/divider.c: warning: context imbalance in
> 'ti_clk_divider_set_rate' - different lock contexts for basic block
> +drivers/clk/ti/mux.c: warning: context imbalance in
> 'ti_clk_mux_set_parent' - different lock contexts for basic block
>=20
> * checkpatch warning [PATCH 16/40] CLK: TI: add am33xx clock init
> file, [PATCH 18/40] CLK: TI: add omap3 clock init file
> WARNING: static const char * array should probably be static const
> char * const
>=20
>=20
> Boot reports:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - previous orphan clocks seem solved.
> - All available platforms seem to boot fine and no regression could be
> seen on initial view
>=20
> OMAP2430:
>   1. SDP2430
>     before: http://pastebin.mozilla.org/3976359
>     after: http://pastebin.mozilla.org/3976467
>=20
> AM335x:
>   2. am335x-evm
>     before: http://pastebin.mozilla.org/3976284
>     after: http://pastebin.mozilla.org/3976374
>   3. am335x-sk
>     before: http://pastebin.mozilla.org/3976295
>     after: http://pastebin.mozilla.org/3976375
>   4. BeagleBone Black:
>     before: http://pastebin.mozilla.org/3976321
>     after: http://pastebin.mozilla.org/3976441
>=20
> AM3517:
>   5. am3517-evm
>     before: http://pastebin.mozilla.org/3976297
>     after: http://pastebin.mozilla.org/3976397
>   6. craneboard
>     before: http://pastebin.mozilla.org/3976322
>     after: http://pastebin.mozilla.org/3976452
>=20
> OMAP3430:
>   7. ldp
>     before: http://pastebin.mozilla.org/3976356
>     after: http://pastebin.mozilla.org/3976455
>   8. sdp3430
>     before: http://pastebin.mozilla.org/3976360
>     after: http://pastebin.mozilla.org/3976468
>=20
> OMAP3630/DM3730:
>   9. am37x-evm
>     before: http://pastebin.mozilla.org/3976300
>     after: http://pastebin.mozilla.org/3976398
>   10. beagle-XM
>     before: http://pastebin.mozilla.org/3976319
>     after: http://pastebin.mozilla.org/3976440
>=20
> OMAP4430:
>   11. SDP4430
>     before: http://pastebin.mozilla.org/3976361
>     after: http://pastebin.mozilla.org/3976470
>=20
> OMAP4460:
>   12. PandaBoard-ES
>     before: http://pastebin.mozilla.org/3976358
>     after: http://pastebin.mozilla.org/3976456
>=20
> OMAP5432:
>   13. OMAP5uEVM
>     before: http://pastebin.mozilla.org/3976362 (no boot)
>     after: http://pastebin.mozilla.org/3976471 (boot)
>=20
> DRA7:
>   14. dra7evm
>     before: http://pastebin.mozilla.org/3976354 (no boot)
>     after: http://pastebin.mozilla.org/3976453 (boot)
>=20
> AM437x:
>   15. am43xx-epos + out-of-tree patches for engineering samples
>     before: http://pastebin.mozilla.org/3976306 (no boot)
>     after: http://pastebin.mozilla.org/3976399 (boot)

to add here, I ran 70 different randconfigs, all seeds are available on
pastebin (took RMK's 4430sdp seed as a starting point):

am33xx-only.config	http://pastebin.com/nVA3xSwb
am43xx-only.config	http://pastebin.com/RbUdKuUh
dra7xx-only.config	http://pastebin.com/ribnaSzS
omap2-only.config	http://pastebin.com/QPUG0wqe
omap3-only.config	http://pastebin.com/B8ctX8yM
omap4-only.config	http://pastebin.com/3D8NAExm
omap5-only.config	http://pastebin.com/3mtQN38Z

Had a total of 16 failing builds, all .configs were also published on
pastebin:

config-am33xx-only.config-1	http://pastebin.com/5xhXZpev
config-am33xx-only.config-2	http://pastebin.com/NsrruJcQ
config-am33xx-only.config-3	http://pastebin.com/CGbB3qb8
config-am33xx-only.config-4	http://pastebin.com/86cu0uZ1
config-am43xx-only.config-1	http://pastebin.com/MCBCAd4X
config-am43xx-only.config-3	http://pastebin.com/hVpCgwSn
config-am43xx-only.config-4	http://pastebin.com/8SXAKHed
config-am43xx-only.config-6	http://pastebin.com/59riPMfw
config-am43xx-only.config-8	http://pastebin.com/03bt2VEZ
config-am43xx-only.config-9	http://pastebin.com/tePGwtWA
config-am43xx-only.config-10	http://pastebin.com/nrtXPqrF
config-omap2-only.config-2	http://pastebin.com/AKyvMqQU
config-omap2-only.config-4	http://paste.debian.net/75329
config-omap2-only.config-5	http://paste.debian.net/75330/
config-omap2-only.config-7	http://paste.debian.net/75332/
config-omap2-only.config-10	http://paste.debian.net/75333/

Failing configs all build fine on v3.13-rc7 except for
config-omap2-only.config-10, which fails due to a broken staging driver.

--=20
balbi

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzy2pAAoJEIaOsuA1yqREUbYP/jgKq9di0s47M5YX9auVDYee
9sJPev6v6DCBuksQGrCkDKjTi3zePGu+X72LKa1VzUcTfa7aeCYeKv/gOlF1rLR6
uamX/upCoJwXgtYbxtoR0w1qZGKG3TCJ+NSKNihBGk7UhPsVRTvwAWKjAIDAoDKK
moT7kez8aQZiBOam0TJsvoDunHY2kJG006gOGKnTkioImHGqLKe3z4Id4NtQNSrZ
J1dCO2QetWdgfg5SfP/lA/D8obF012sG/7eQcwSG43znjHAKAI06Osy68160YFHl
Hrx1H35Dw3GyaCzDfcssCr9cmZnW/6dDspvVaSVrog0ESq91t9b58f6zjr6Ww0kE
Xq/IUF6ZoEdV+vx2EYeanTrgsAlzrR+lYMu+jKydthmxvpvxfEMndLt2U3w7whDc
3akqUtoGbvmLcGNgrlZ8wShgu4r6wsowSXFMfDFPkwYKRTdkOXGWHjcWHaRo45+U
Aqf/dloRH2LiM+O2JM9tCi2aydIu4EKvpX8psPkxwqXOJ5esmDRtsZQL/NLSV6xD
d+F1Tu/Mwg4Z0knlzlKofoobkc6AKIwH8jh43Nc2pa7/RDLR8oVqCRt6Umw7i3TJ
9HlFqM088tQK0h9P9ZQWUvwRMB8x87tYqXPU1s5iJ/+diLl7pERgBJwpRZfZyZJ5
tN6UCaAS+EZRrELT9B9m
=3p1i
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
